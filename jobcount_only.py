#!/usr/bin/env python
# jobcount_only
import math
import numpy as np
from mpi4py import MPI

def zeropad(number, finallen):
    if not number == 0:
        numlen = int(math.log10(number)) + 1
    else:
        numlen = 1
    zeros = "0" * (finallen - numlen)
    return zeros + str(number)

def job_filename(filenum):
    jobdata_dir = "/users/bcoomes/job_events/"
    strnum = zeropad(filenum, 5)
    return jobdata_dir + "part-" + strnum + "-of-00500.csv"

#note - relies on global variables N, size, and rank!
def get_range():
    rem = N%size
    bpp = int(N/size) #base per processor amount
    if rank < rem:
        # rank is eqivilant to displacement
        return range(rank*bpp + rank, (rank +1) * bpp + rank + 1)
    if rank >= rem:
        return range(rank*bpp + rem, (rank+1)*bpp + rem)

    
# for a sorted array of datatypes with field JobID, combine nodes with matching jobids into a single node with
# complete information (one node has starttime, the other has endtime)
# return a newly created array with the combined nodes
# note: this method assumes that nodes are sorted in order of jobID, starttime, endtime, and that missing
# information is indicated by a -1 value.
def merge_by_jobID(jobs, datatype):
    compjobs = np.zeros(jobs.size, dtype=datatype)
    mergecount = 0
    index = 0
    for i in range(0,jobs.size):        
        if i < jobs.size -1 and jobs[i]['jobID'] == jobs[i+1]["jobID"]:
            mergecount += 1
            # do merge, add merge to list: see above comments for assumptions used below
            merged_job = np.zeros(1, dtype=datatype)
            merged_job[0] =(jobs[i]["jobID"], 
                            jobs[i+1]["starttime"], 
                            jobs[i]["endtime"], 
                            jobs[i]["status"],
                            jobs[i]["taskcount"],
                            jobs[i]["cpuusage"])
            compjobs[index] = merged_job[0]
            index += 1
           
            
        else:
            consecmerges = 0
            # add jobs[i] to compjobs if jobs[i]["jobID"] != compjobs[index-1]["jobID"]
            #if this expression is true, then jobs[i] was merged and should not be readded. 
            if index == 0 or compjobs[index-1]["jobID"] != jobs[i]["jobID"]:
                compjobs[index] = jobs[i]
                index += 1
 
    compjobs = compjobs[0:index:1]

    return compjobs
    
    
def remove_invalid_jobs(jobarr, datatype):
    cleanjobs = np.zeros(jobarr.size, dtype=datatype)
    index = 0
    for i in range(0, jobarr.size):
        if not (jobarr[i]["endtime"] == -1 or jobarr[i]["starttime"] == -1):
            cleanjobs[index] = jobarr[i]
            index += 1
            
    return cleanjobs[0:index:1]

#print all info for parts 1 - 4 here.   
def print_final_stats(jobs, datatype):
    status_lookup = {2:"EVICT", 3:"FAIL", 4:"FINISH", 5:"KILL", 6:"LOST"}
    jobcount = jobs.size  
    
    print("-" * 80)
    print("Results for test with", size, "compute nodes.")
    print("Unique Jobs Submitted and Ran:", jobcount)
    
# depends on N, size, job dtype, sortorder
def create_local_jobs():
    arrsize = 1024 #arbitrary power of 2 starting size
    local_jobs = np.zeros(arrsize, dtype=job)
    local_range = get_range()
    end_events = ["2", "3", "4", "5", "6"] # evict, fail, finsih, kill, lost
    index = 0
    schedule_count = np.array([0], dtype= np.int32)
    for i in local_range:
        with open(job_filename(i), "r", 1) as file:
            for line in file:
                entry = line.split(',')
                newjob = np.zeros(1, dtype=job)

                if entry[3] == "1": # and entry[1] == "": # job was scheduled and there is no missing info
                    newjob[0] =(entry[2], entry[0], -1, -1, 0, 0)
                    local_jobs[index] = newjob[0]
                    schedule_count[0] += 1
                    index += 1
                elif entry[3] in end_events: # and entry[1] == "": # job finished and there is no missing info
                    newjob[0] = (entry[2], -1, entry[0], entry[3], 0, 0)
                    local_jobs[index] = newjob[0]
                    index += 1

                #double size of array if necessary
                if(index == arrsize):
                    extra_room = np.zeros(arrsize, dtype=job)
                    local_jobs = np.concatenate((local_jobs, extra_room))
                    arrsize = arrsize * 2

    local_jobs = local_jobs[0:index:1]
    local_jobs = np.sort(local_jobs, order=sortorder)
    local_jobs = merge_by_jobID(local_jobs, job)
    
    return local_jobs

    

# start main routine
comm = MPI.COMM_WORLD; rank = comm.Get_rank(); size = comm.Get_size()
N = 500
sortorder = ["jobID", "starttime", "endtime", "status", "taskcount", "cpuusage"]
job = np.dtype([('jobID', np.int64, 1), 
                ('starttime', np.int64, 1), 
                ('endtime', np.int64, 1),
                ('status', np.int64, 1), # could make this a single char
                ('taskcount', np.int64, 1),
                ('cpuusage', np.float64, 1)]) # could make this 32 bit probably

local_jobs = create_local_jobs()


structsize = local_jobs.nbytes // local_jobs.size
jobstruct = MPI.Datatype.Create_struct([1,1,1,1,1,1], 
                                       [0,8,16,24,32,40], 
                                       [MPI.INT64_T, MPI.INT64_T, MPI.INT64_T, 
                                        MPI.INT64_T, MPI.INT64_T, MPI.DOUBLE])
jobstruct = jobstruct.Create_resized(0, structsize)
jobstruct.Commit()

# make sure everyone cathes up
comm.Barrier()

# combine lists (has unused option for nodes to do processing as arrays are combined, 
# but this is slower in my tests. It may improve performance in some cases)
for i in range(0, int(math.log2(size))):
    dist = int(math.pow(2, i))
    select = int(math.pow(2, i+1))
    #senders
    if rank%select - dist == 0:
        recvrank= rank - dist
        comm.send(local_jobs.size, recvrank)
        comm.Send([local_jobs, jobstruct], dest=recvrank)

    #recievers
    elif rank%select == 0:
        sendrank = rank + dist
        recvsize = comm.recv(source = sendrank)
        recv_jobs = np.zeros(recvsize, dtype=job)
        comm.Recv([recv_jobs, jobstruct], source = sendrank)
        local_jobs = np.concatenate((local_jobs, recv_jobs))


if rank == 0:
    local_jobs = np.sort(local_jobs, order = sortorder)
    local_jobs = merge_by_jobID(local_jobs, job)
    local_jobs = remove_invalid_jobs(local_jobs, job)
    print_final_stats(local_jobs, job)