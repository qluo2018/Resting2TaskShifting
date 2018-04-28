%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % Step 1: data preprocessing
% % %
% % %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;clc;

% % Read brain mask data;
[mask_data,~] = y_Read('./mask/mask_template/BrainMask_05_61x73x61.img');
mask_ind = find(mask_data>0.5 & mask_data<1.5);
[mask_dim1, mask_dim2, mask_dim3] = ind2sub(size(mask_data),mask_ind);
mask_dim_all = [mask_dim1, mask_dim2, mask_dim3];
mask_size = length(mask_dim1);

% %  Main loop
datapath = './fMRIdata/task/';         % direction of subject fMRI data
datadir = dir(datapath);
datadir(1:2) = [];
nSub = length(datadir);                % number of subjects
TP = zeros(nSub,1);                    % number of time points
for i = 1:nSub
    tic
    UnitRoot = zeros(61,73,61);
    count = 0;
    workpath = [datapath,datadir(i).name,'/session1/'];
    disp([num2str(i),'   ',datadir(i).name])
    Vols = dir([workpath,'conn*.img']);
    TP(i) = length(Vols);
    
    BOLD = zeros(61,73,61,TP(i));
    ResInfo  =  zeros(61,73,61,TP(i));
    % Read volume data into 4D matrix BOLD
    for j = 1:TP(i)
        [BOLD(:,:,:,j),hdr] = y_Read([workpath,Vols(j).name]);
    end
    hdr.dt = [16,0];
    load([datapath,datadir(i).name,'/Stats_Session1/SPM.mat'])
    regressors = SPM.xX.X(:,[1:3,5:14]);
    LL = zeros(mask_size,1);
    for j = 1:mask_size
        y = squeeze(BOLD(mask_dim1(j), mask_dim2(j), mask_dim3(j), :));        
        LL(j) = length(intersect(y,y));
        if LL(j)<10
            continue
        end
        count = count + 1;
        % %  storage of residual by regreesors
        [~,~,r] = regress(y,regressors);
        for k = 1:TP(i)
            ResInfo(mask_dim1(j), mask_dim2(j), mask_dim3(j),k) = r(k);
        end
    end
    % save residual info as 4D matrix ResInfo
    hdr.varibility = count;
    y_Write(ResInfo,hdr,[workpath,'Res_',datadir(i).name,'.nii']);
    toc
end
%%
disp('Bye bey ... ...')
