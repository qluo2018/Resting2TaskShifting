%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % step 2: Granger causality analysis between voxels and ROI
% % Begin with 2 back block onset time, and constant number of volumes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% set global parameters
clear;clc;close all
nBlock = 7;
nL = 12;
N = nL - 1;
TR = 2.5;
order = 1;

%% Load template and ROI mask
[mask_data,~] = y_Read('./mask/mask_template/BrainMask_05_61x73x61.img');
mask_ind = find(mask_data>0.5 & mask_data<1.5);
[mask_dim1,mask_dim2,mask_dim3] = ind2sub(size(mask_data),mask_ind);
mask_size = length(mask_dim1);
[seed_mask,~] = y_Read('./mask/mask_ROI/ROI101.nii');

%%  Main loop in all Subjects
datapath = './fMRIdata/task/';  % direction of subject fMRI data
datadir = dir(datapath);
datadir(1:2) = [];
nSub = length(datadir);                              % number of subjects
for i = 1:nSub
    tic
    count = 0;
    disp([num2str(i),'   ',datadir(i).name]);
    path_ROI2Vox = nan(61,73,61);
    path_Vox2ROI = nan(61,73,61);
    workpath = [datapath,datadir(i).name,'/session1/'];
    
    % % % ---Load block onset -------% % % %
    load([datapath,datadir(i).name,'/session1/',datadir(i).name,'_sess1_onsets.mat']);
    firstVol = ceil(twoBlockOnsets/TR)+1;
    
    %  % % % ------ Extract ROI signal ------ % % % % % %
    [Res_BOLD,hdr] = y_Read([workpath,'Res_',datadir(i).name,'.nii']);
    hdr.dt = [16,0];
    nTP = size(Res_BOLD,4);
    SeedInfo = zeros(nTP,1);
    for j = 1:nTP
        temp = squeeze(Res_BOLD(:,:,:,j)).*seed_mask;
        SeedInfo(j) = sum(temp(:))/sum(seed_mask(:));
    end
    
    % % % Loop in every voxels % %
    for j = 1:mask_size
 
        % % % ------ Extract Time series of voxel ------- % % % % % %
        VoxInfo = squeeze(Res_BOLD(mask_dim1(j), mask_dim2(j), mask_dim3(j),:));

        % % % ------ Check variability of fMRI signal ------- % % % % % %
        LL = length(intersect(VoxInfo,VoxInfo));
        if LL<8
            count = count+1;
            continue
        end
        
        path1 = nan(nBlock,1);
        path2 = nan(nBlock,1);
        for kk = 1:nBlock
            seq = firstVol(kk):firstVol(kk)+nL-1;
            y = [SeedInfo(seq),VoxInfo(seq)];
            
            % % % % % % % % % % % detrend and discard mean
            x0 = ones(nL,1);
            x1 = 1:nL;
            regressors = [x0,x1'];
            beta1 = regressors\y(:,1);
            beta2 = regressors\y(:,2);
            x(:,1) = y(:,1) - regressors*beta1;
            x(:,2) = y(:,2) - regressors*beta2;
            
            % % % % % % % % % % % calculate path coefficient
            b1 = [x(1:N,1),x(1:N,2)]\x(2:N+1,1);
            b2 = [x(1:N,1),x(1:N,2)]\x(2:N+1,2);
            path1(kk) = b1(2);
            path2(kk) = b2(1);
        end
        
        path_Vox2ROI(mask_dim1(j),mask_dim2(j),mask_dim3(j)) = mean(path1);
        path_ROI2Vox(mask_dim1(j),mask_dim2(j),mask_dim3(j)) = mean(path2);
    end
    % save GCA result
    hdr.badvoxel  = count;
    y_Write(path_ROI2Vox,hdr,[workpath,'path_ROI1_11vol_2back_ROI2Vox.nii']);
    y_Write(path_Vox2ROI,hdr,[workpath,'path_ROI1_11vol_2back_Vox2ROI.nii']);
    toc
end
disp('Bye bey ... ...')