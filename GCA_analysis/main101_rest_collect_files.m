clear;close all;clc;

outpath1 = './session1/ROI1/GCA_rest/sROI2Vox/';
if ~exist(outpath1,'dir')
    mkdir(outpath1)
end
outpath2 = './session1/ROI1/GCA_rest/sVox2ROI/';
if ~exist(outpath2,'dir')
    mkdir(outpath2)
end

mydir = dir('../fMRIdata/rest/Normal/');
mydir(1:2) = [];
nSub = length(mydir);
for i = 1:nSub
    disp([num2str(i),'  ',mydir(i).name]);
    filename1 = ['../fMRIdata/rest/Normal/',mydir(i).name,'/path_ROI1_Vox2ROI.nii'];
    filename2 = ['../fMRIdata/rest/Normal/',mydir(i).name,'/path_ROI1_ROI2Vox.nii']; 
    copyfile(filename1,[outpath2,'/Nor_',mydir(i).name,'_Vox2ROI.nii']);   
    copyfile(filename2,[outpath1,'/Nor_',mydir(i).name,'_ROI2Vox.nii']);
end
disp('Normal is ok')
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
mydir = dir('../fMRIdata/rest/Patient/');
mydir(1:2) = [];
nSub = length(mydir);
for i = 1:nSub
    disp([num2str(i),'  ',mydir(i).name]);
    filename1 = ['../fMRIdata/rest/Patient/',mydir(i).name,'/path_ROI1_Vox2ROI.nii'];
    filename2 = ['../fMRIdata/rest/Patient/',mydir(i).name,'/path_ROI1_ROI2Vox.nii']; 
    copyfile(filename1,[outpath2,'/Pat_',mydir(i).name,'_Vox2ROI.nii']);   
    copyfile(filename2,[outpath1,'/Pat_',mydir(i).name,'_ROI2Vox.nii']);
end
disp('Patient is ok')
disp('Bye bye ... ...');
