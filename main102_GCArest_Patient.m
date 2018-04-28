%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % step 2: Granger causality analysis between voxels and ROI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;clc;

% % Read brain mask data;
[mask_data,~] = y_Read('./mask/mask_template/BrainMask_05_61x73x61.img');
mask_ind = find(mask_data>0.5 & mask_data<1.5);
[mask_dim1, mask_dim2, mask_dim3] = ind2sub(size(mask_data),mask_ind);
mask_size = length(mask_dim1);
[seed_mask,~] = y_Read('./mask/mask_ROI/ROI101.nii');

% %  Main loop
datapath = './fMRIdata/rest/Patient/';     % direction of subject fMRI data
datadir = dir(datapath);
datadir(1:2) = [];
nSub = length(datadir);                   % number of subjects

fig_path ='./fMRIdata/figure_rest_ROI_BOLD_signal/ROI1/';
if ~exist(fig_path,'dir')
    mkdir(fig_path)
end

for i = 1:nSub
    tic
    count = 0;
    UnitRoot = zeros(61,73,61);
    path_ROI2Vox = zeros(61,73,61);
    path_Vox2ROI = zeros(61,73,61);
  
    workpath = [datapath,datadir(i).name,'/'];
    disp([num2str(i),'   ',datadir(i).name])
    Vols = dir([workpath,'*.img']);
    nTP = length(Vols);
    BOLD = zeros(61,73,61,nTP);
    
    % Read volume data into 4D matrix BOLD
    for j = 1:nTP
        [BOLD(:,:,:,j),hdr] = y_Read([workpath,Vols(j).name]);
    end
    
    SeedInfo = zeros(nTP,1);
    for j = 1:nTP
        temp = squeeze(BOLD(:,:,:,j)).*seed_mask;
        SeedInfo(j) = sum(temp(:))/sum(seed_mask(:));
    end
    N = nTP-1;
    LL = zeros(mask_size,1);
    for j = 1:mask_size
        VoxInfo = squeeze(BOLD(mask_dim1(j), mask_dim2(j), mask_dim3(j),:));
        LL(j) = length(intersect(VoxInfo,VoxInfo));
        if LL(j)<8
            continue
        end
        count = count +1;
        UnitRoot(mask_dim1(j), mask_dim2(j), mask_dim3(j)) = cca_check_cov_stat(VoxInfo',2);
        x = [SeedInfo,VoxInfo];
        [b1,~] = regress(x(2:N+1,1),[x(1:N,1),x(1:N,2)]);
        [b2,~] = regress(x(2:N+1,2),[x(1:N,1),x(1:N,2)]);
        path1 = b1(2);
        path2 = b2(1);
        path_Vox2ROI(mask_dim1(j),mask_dim2(j),mask_dim3(j))= path1;
        path_ROI2Vox(mask_dim1(j),mask_dim2(j),mask_dim3(j))= path2;
    end
    hdr.varibility = count;
    % % % % save GCA result
    y_Write(path_ROI2Vox,hdr,[workpath,'path_ROI1_ROI2Vox.nii']);
    y_Write(path_Vox2ROI,hdr,[workpath,'path_ROI1_Vox2ROI.nii']);
    y_Write(UnitRoot,hdr,[workpath,'UnitRoot.nii']);
    toc
end

disp('Bye bey ... ...')