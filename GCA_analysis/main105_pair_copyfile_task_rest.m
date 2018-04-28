clear;close all;clc;
load('../phenotype_data/ID_collection/ID_final.mat');
IDset  = mod(ID,1000);

workpath = './session1/ROI1/';
outpath1 = [workpath,'GCA_paired/sROI2Vox/rest/'];
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 = [workpath,'GCA_paired/sVox2ROI/rest/'];
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end
outpath1 = [workpath,'GCA_paired/sROI2Vox/task/'];
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 = [workpath,'GCA_paired/sVox2ROI/task/'];
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end

%%
dir1 = dir([workpath,'GCA_rest/sROI2Vox/Pat_Nor/*.nii']);
nR = length(dir1);
ID_rest= zeros(nR,1);
for i = 1:nR
    disp([num2str(i),'   ',dir1(i).name])
    ID_rest(i) = str2double(dir1(i).name(9:11));
    if ismember(ID_rest(i),IDset) 
        idx = find(IDset==ID_rest(i));
        newID = ID(idx);
        copyfile([workpath,'GCA_rest/sROI2Vox/Pat_Nor/',dir1(i).name],...
            [workpath,'GCA_paired/sROI2Vox/rest/Sub',num2str(newID),'.nii'])       
    end
end

dir2 = dir([workpath,'GCA_task/sROI2Vox/Pat_Nor/*.nii']);
nT = length(dir2);
ID_task= zeros(nT,1);
for i = 1:nT
    disp([num2str(i),'   ',dir2(i).name])
    ID_task(i) = str2double(dir2(i).name(5:7));
    if ismember(ID_task(i),IDset)
        idx = find(IDset==ID_task(i));
        newID = ID(idx);
        copyfile([workpath,'GCA_task/sROI2Vox/Pat_Nor/',dir2(i).name],...
            [workpath,'GCA_paired/sROI2Vox/task/Sub',num2str(newID),'.nii']);
    end
end

% % % --------------------------Vox2ROI----------------------% % %
dir1 = dir([workpath,'GCA_rest/sVox2ROI/Pat_Nor/*.nii']);
nR = length(dir1);
ID_rest= zeros(nR,1);
for i = 1:nR
    disp([num2str(i),'   ',dir1(i).name])
    ID_rest(i) = str2double(dir1(i).name(9:11));
    if ismember(ID_rest(i),IDset) 
        idx = find(IDset==ID_rest(i));
        newID = ID(idx);
        copyfile([workpath,'GCA_rest/sVox2ROI/Pat_Nor/',dir1(i).name],...
            [workpath,'GCA_paired/sVox2ROI/rest/Sub',num2str(newID),'.nii']);       
    end
end

dir2 = dir([workpath,'GCA_task/sVox2ROI/Pat_Nor/*.nii']);
nT = length(dir2);
ID_task= zeros(nT,1);
for i = 1:nT
    disp([num2str(i),'   ',dir2(i).name])
    ID_task(i) = str2double(dir2(i).name(5:7));
    if ismember(ID_task(i),IDset)
        idx = find(IDset==ID_task(i));
        newID = ID(idx);
        copyfile([workpath,'GCA_task/sVox2ROI/Pat_Nor/',dir2(i).name],...
            [workpath,'GCA_paired/sVox2ROI/task/Sub',num2str(newID),'.nii']);
    end
end
disp('Bye bye ... ...')