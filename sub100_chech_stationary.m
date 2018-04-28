clear;close all;clc;
%% for rest data
workpath = './fMRIdata/rest/';
subpath1 = [workpath,'Normal/'];
dir1 = dir(subpath1);
dir1(1:2) = [];
nSub1 = length(dir1);
for i = 1:nSub1
    disp([num2str(i), '   ', dir1(i).name]);
    data1 = y_Read([subpath1,dir1(i).name,'/UnitRoot.nii']);
    disp(sum(data1(:)));
end
disp('Normal group of rest is ok')

subpath2 = [workpath,'Patient/'];
dir2 = dir(subpath2);
dir2(1:2) = [];
nSub2 = length(dir2);
for i = 1:nSub2
    disp([num2str(i), '   ', dir2(i).name]);
    data2 = y_Read([subpath2,dir2(i).name,'/UnitRoot.nii']);
    disp(sum(data2(:)));
end
disp('Patient group of rest is ok ... ...')

%% for task data
workpath = './fMRIdata/task/';
dir3 = dir(workpath);
dir3(1:2) = [];
nSub3 = length(dir3);
for i = 1:nSub3
    disp([num2str(i), '   ', dir3(i).name]);
    data3 = y_Read([workpath,dir3(i).name,filesep,'session1/UnitRoot.nii']);
    disp(sum(data3(:)));
end
disp('Task group is ok');