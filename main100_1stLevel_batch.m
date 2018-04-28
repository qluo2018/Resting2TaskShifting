% List of open inputs
clear;close all;clc;
global ss
datapath = './fMRIdata/task/';
mydir = dir(datapath);
mydir(1:2) = [];
nSub = length(mydir);
for ss = 1:nSub
    disp([num2str(ss),'    ',mydir(ss).name]);
    nrun = 1; % enter the number of runs here
    jobfile = {'./main100_1stLevel_batch_job.m'};
    jobs = repmat(jobfile, 1, nrun);
    inputs = cell(0, nrun);
    for crun = 1:nrun
    end
    spm('defaults', 'FMRI');
    spm_jobman('serial', jobs, '', inputs{:});
end
