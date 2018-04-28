clear;close all;clc;

workpath = './session1/ROI1/GCA_paired/';
outpath1 = [workpath,'sVox2ROI/paired/Pat/'];
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 = [workpath,'sVox2ROI/paired/Nor/'];
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end
outpath3 = [workpath,'sVox2ROI/paired/Pat_Nor/'];
if ~exist(outpath3,'dir')
    mkdir(outpath3)
end
dir1 = dir([workpath,'sVox2ROI/paired/*.nii']);
nSub = length(dir1);
for i = 1:nSub
    id = str2double(dir1(i).name(4:7));
    if id>2000
        copyfile([workpath,'sVox2ROI/paired/',dir1(i).name],[outpath2,dir1(i).name])
    else
        copyfile([workpath,'sVox2ROI/paired/',dir1(i).name],[outpath1,dir1(i).name])
    end
    movefile([workpath,'sVox2ROI/paired/',dir1(i).name],[outpath3,dir1(i).name])
end
disp('Vox2ROI is ok');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
outpath1 = [workpath,'sROI2Vox/paired/Pat/'];
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 = [workpath,'sROI2Vox/paired/Nor/'];
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end
outpath3 = [workpath,'sROI2Vox/paired/Pat_Nor/'];
if ~exist(outpath3,'dir')
    mkdir(outpath3)
end
dir1 = dir([workpath,'sROI2Vox/paired/*.nii']);
nSub = length(dir1);
for i = 1:nSub
    id = str2double(dir1(i).name(4:7));
    if id>2000
        copyfile([workpath,'sROI2Vox/paired/',dir1(i).name],[outpath2,dir1(i).name])
    else
        copyfile([workpath,'sROI2Vox/paired/',dir1(i).name],[outpath1,dir1(i).name])
    end
    movefile([workpath,'sROI2Vox/paired/',dir1(i).name],[outpath3,dir1(i).name])
end
disp('ROI2Vox is ok');