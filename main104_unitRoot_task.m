
clear;close all;clc;
% % Read brain mask data;
[mask_data,~] = y_Read('./mask/mask_template/BrainMask_05_61x73x61.img');
mask_ind = find(mask_data>0.5 & mask_data<1.5);
[mask_dim1,mask_dim2,mask_dim3] = ind2sub(size(mask_data),mask_ind);
mask_dim_all = [mask_dim1,mask_dim2,mask_dim3];
mask_size = length(mask_dim1);
% %  Main loop
datapath = './fMRIdata/task/';             % direction of subject fMRI data
datadir = dir(datapath);
datadir(1:2) = [];
nSub = length(datadir);                    % number of subjects
nBadVox = zeros(nSub,1);
for i = 1:nSub
    tic
    count = 0;
    disp([num2str(i),'   ',datadir(i).name]);
    UnitRoot = zeros(61,73,61);
    workpath = [datapath,datadir(i).name,'/session1/'];
    [Res_BOLD,hdr] = y_Read([workpath,'Res_',datadir(i).name,'.nii']);
    hdr.dt = [16,0];
    LL = zeros(mask_size,1);
    for j = 1:mask_size
        VoxInfo = squeeze(Res_BOLD(mask_dim1(j), mask_dim2(j), mask_dim3(j),:));
        LL(j) = length(intersect(VoxInfo,VoxInfo));
        if LL(j)<8
            continue
        end
        count = count +1;
        UnitRoot(mask_dim1(j), mask_dim2(j), mask_dim3(j)) = cca_check_cov_stat(VoxInfo',2);
    end
    nBadVox(i) = count;
    % save stability test result
    hdr.varibility = count;
    y_Write(UnitRoot,hdr,[workpath,'UnitRoot.nii']);
    toc
end
disp('Bye bey ... ...')

