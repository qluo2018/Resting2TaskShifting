clear; close all; clc;


% % read header
% [~,header] = y_Read('E:\Nottingham\fMRIdata\z_ROI1\GCA_paired\ROI2Vox\paired\corr_result\R.nii');
% % read covariates
Covariates = dlmread('E:\Nottingham\zForOpenAccess\covariates\covs_age_gender_headmotion_P29.txt');

workpath = 'E:\Nottingham\zForOpenAccess\GCA_analysis\session1\ROI1\GCA_paired\sROI2Vox\';

% % read mask
[mask_data,header] = y_Read([workpath,'cluster_mask\all_clusters_mask.nii']);
mask1_ind = find(mask_data>0.5 & mask_data<1.5);
[mask1_dim1, mask1_dim2, mask1_dim3] = ind2sub(size(mask_data),mask1_ind);
mask_dim_all = [mask1_dim1, mask1_dim2, mask1_dim3];
mask1_size = length(mask1_dim1);



% % Read image data
ImagePath = [workpath,'paired\Pat\'];
dir1 = dir(ImagePath);
dir1(1:2) = [];

nSamp = length(dir1);
ImageData = cell(nSamp,1);
for i = 1:nSamp
    %     disp(i+1000)
    ImageData{i,1}  = y_Read([ImagePath,dir1(i).name]);
end

AllImageSeq = zeros(nSamp,mask1_size);
for i = 1:mask1_size
    idx =  mask_dim_all(i,:);
    for j = 1:nSamp
        AllImageSeq(j,i) = ImageData{j,1}(idx(1),idx(2),idx(3));
    end
end

ScoreName = dir('E:\Nottingham\zForOpenAccess\covariates\P29_Hit*.txt');
% % read behavior score
for iii = 1:length(ScoreName)
    disp(iii)
    SeedSeries = dlmread(['E:\Nottingham\zForOpenAccess\covariates\',ScoreName(iii).name]);
    %[rho,pval] = partialcorr(AllImageSeq,SeedSeries,Covariates,'type','pearson');
    [rho,pval] = corr(AllImageSeq,SeedSeries);
    % % write the correlation coefficient map
    RhoMap = zeros(size(mask_data));
    for i = 1:mask1_size
        idx =  mask_dim_all(i,:);
        RhoMap(idx(1),idx(2),idx(3)) =  rho(i);
    end
    Df = nSamp-2-size(Covariates,2);
    header.dt = [16,0];
    header.descrip = ['DPABI{R_[',num2str(Df),']}{dLh_0.042655}{FWHMx_6FWHMy_6FWHMz_6mm}'];
    y_Write(RhoMap,header,[workpath,'paired\corr_result\pearson\corr_',ScoreName(iii).name(1:end-4),'.nii']);
end
disp('ok ... ...')
