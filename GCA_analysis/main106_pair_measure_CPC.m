clear;close all;clc;

workpath = './session1/ROI1/GCA_paired/';
outpath1 = [workpath,'sROI2Vox/paired/'];
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 = [workpath,'sVox2ROI/paired/'];
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end


dir1 = dir([workpath,'sROI2Vox/rest/*.nii']) ;
dir2 = dir([workpath,'sROI2Vox/task/*.nii']) ;
nSub = length(dir1);
for i = 1:nSub
    [data1,hdr1] = y_Read([workpath,'sROI2Vox/rest/',dir1(i).name]) ;
    [data2,hdr2] = y_Read([workpath,'sROI2Vox/task/',dir2(i).name]) ;
    data = data2-data1;
    y_Write(data,hdr1,[outpath1,dir1(i).name])
end
disp('ROI2Vox is ok');

dir1 = dir([workpath,'sVox2ROI/rest/*.nii']) ;
dir2 = dir([workpath,'sVox2ROI/task/*.nii']) ;
nSub = length(dir1);
for i = 1:nSub
    [data1,hdr1] = y_Read([workpath,'sVox2ROI/rest/',dir1(i).name]) ;
    [data2,hdr2] = y_Read([workpath,'sVox2ROI/task/',dir2(i).name]) ;
    data = data2-data1;
    y_Write(data,hdr1,[outpath2,dir1(i).name])
end
disp('Vox2ROI is ok');