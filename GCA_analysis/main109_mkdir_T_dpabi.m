clear;close all;clc;
% % -------------------------- % %
rootpath = './session1/ROI1/';

workpath = [rootpath,'GCA_paired/sROI2Vox/paired/T_value/'];
path1 = [workpath,'T1_dpabi/T_Pat/'];
if ~exist(path1,'dir')
    mkdir(path1)
end
path1 = [workpath,'T1_dpabi/T_Nor/'];
if ~exist(path1,'dir')
    mkdir(path1)
end
path1 = [workpath,'T1_dpabi/T_All/'];
if ~exist(path1,'dir')
    mkdir(path1)
end
path1 = [workpath,'T2_dpabi/'];
if ~exist(path1,'dir')
    mkdir(path1)
end
% % -------------------------- % %
workpath = [rootpath,'GCA_paired/sVox2ROI/paired/T_value/'];
path1 = [workpath,'T1_dpabi/T_Pat/'];
if ~exist(path1,'dir')
    mkdir(path1)
end
path1 = [workpath,'T1_dpabi/T_Nor/'];
if ~exist(path1,'dir')
    mkdir(path1)
end
path1 = [workpath,'T1_dpabi/T_All/'];
if ~exist(path1,'dir')
    mkdir(path1)
end
path1 = [workpath,'T2_dpabi/'];
if ~exist(path1,'dir')
    mkdir(path1)
end
disp('ok ... ...')