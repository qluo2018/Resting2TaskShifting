clear;close all;clc;
mydir = dir('../fMRIdata/task/');
mydir(1:2) = [];
nSub = length(mydir);

outpath1 = './session1/ROI1/GCA_task/sROI2Vox/';
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 = './session1/ROI1/GCA_task/sVox2ROI/';
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end

for i = 1:nSub
    disp([num2str(i),'  ',mydir(i).name]);
    filename1 = ['../fMRIdata/task/',mydir(i).name,'/session1/path_ROI1_11vol_2back_ROI2Vox.nii'];
    filename2 = ['../fMRIdata/task/',mydir(i).name,'/session1/path_ROI1_11vol_2back_Vox2ROI.nii']; 
    copyfile(filename1,[outpath1,mydir(i).name,'.nii']);
    copyfile(filename2,[outpath2,mydir(i).name,'.nii']);
end
disp('Bye bye ... ...')
