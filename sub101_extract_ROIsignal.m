% clear;close all;clc;
mask = y_Read('./mask/mask_ROI/ROI101.nii');
my_dir = dir('./fMRIdata/task/conn004/session1/conn*.img');
nVol = length(my_dir);
%%
%  Check the volume number is natural order
vol_NO = zeros(nVol,1);
for i  =1:nVol
s = regexp(my_dir(i).name,'_', 'split');
vol_NO(i) = str2double(s{3}(1:3));
end
dif = diff(vol_NO);
flag = intersect(dif,dif);
if length(flag)>1
    error('Please chech the volume order!')
else
    disp('The order of volume is ok')
end
%%
MaskBold = zeros(nVol,1);
for i  =1:nVol
    data = y_Read(['.\fMRIdata\task\conn004\session1\',my_dir(i).name]);
    temp = data.*mask;
    MaskBold(i) = sum(temp(:))/sum(mask(:));
end
hold on
plot(MaskBold-mean(MaskBold),'o-')