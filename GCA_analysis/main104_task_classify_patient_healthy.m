clear;close all;clc;
load('..\phenotype_data\Score.mat');
ID = mod(score(:,1),1000);
datapath = '.\session1\ROI1\GCA_task\';
workpath = [datapath,'sVox2ROI\'];
outpath1 =[workpath,'Pat\'];
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 =[workpath,'Nor\'];
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end
outpath3 = [workpath,'Pat_Nor\'];
if ~exist(outpath3,'dir')
    mkdir(outpath3)
end
dir1 = dir([workpath,'*.nii']);
nSub = length(dir1);
for i = 1:nSub
    id = str2double(dir1(i).name(5:7));
    loc = find(ID==id);
    if score(loc,1)>2000
        copyfile([workpath,dir1(i).name],[outpath2,dir1(i).name])
    else
        copyfile([workpath,dir1(i).name],[outpath1,dir1(i).name])
    end
    movefile([workpath,dir1(i).name],[outpath3,dir1(i).name])
end
disp('Vox2ROI is ok');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
workpath = [datapath,'sROI2Vox\'];
outpath1 = [workpath,'Pat\'];
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 =[workpath,'Nor\'];
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end
outpath3 = [workpath,'Pat_Nor\'];
if ~exist(outpath3,'dir')
    mkdir(outpath3)
end
dir1 = dir([workpath,'*.nii']);
nSub = length(dir1);
for i = 1:nSub
    id = str2double(dir1(i).name(5:7));
    loc = find(ID==id);
    if score(loc,1)>2000
        copyfile([workpath,dir1(i).name],[outpath2,dir1(i).name])
    else
        copyfile([workpath,dir1(i).name],[outpath1,dir1(i).name])
    end
    movefile([workpath,dir1(i).name],[outpath3,dir1(i).name])
end
disp('ROI2Vox is ok');