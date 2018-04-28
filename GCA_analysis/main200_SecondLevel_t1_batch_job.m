%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
%% Set output path
workpath = 'E:\Nottingham\GCA_analysis\session1\ROI1\GCA_paired\sROI2Vox\';
outpath =[workpath,'paired\T_value\T1_spm\T_Nor\'];
if ~exist(outpath,'dir')
    mkdir(outpath)
end
matlabbatch{1}.spm.stats.factorial_design.dir = {outpath};

%% Read volume data for t test
volpath1 = [workpath,'paired\Nor\'];
temp_name = dir([volpath1,'*.nii']);
vols1 = cell(length(temp_name),1);
for i = 1:length(temp_name)
    vols1{i,1}=[volpath1,temp_name(i).name,',1'];
end
clear temp_name

%% load covariates
cov_data = dlmread('E:\Nottingham\zForOpenAccess\covariates\covs_age_gender_headmotion_N31.txt');
%% Load volume data
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = vols1;

%% Set covariates data
matlabbatch{1}.spm.stats.factorial_design.cov(1).c = cov_data(:,1);
matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'age';
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;

matlabbatch{1}.spm.stats.factorial_design.cov(2).c = cov_data(:,2);
matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'gender';
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;

matlabbatch{1}.spm.stats.factorial_design.cov(3).c = cov_data(:,3);
matlabbatch{1}.spm.stats.factorial_design.cov(3).cname = 'head1';
matlabbatch{1}.spm.stats.factorial_design.cov(3).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(3).iCC = 1;

matlabbatch{1}.spm.stats.factorial_design.cov(4).c = cov_data(:,4);
matlabbatch{1}.spm.stats.factorial_design.cov(4).cname = 'head2';
matlabbatch{1}.spm.stats.factorial_design.cov(4).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(4).iCC = 1;
%%
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {'E:\Nottingham\zForOpenAccess\mask\mask_template\aal_NoCereb.nii,1'};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).sname = 'Factorial design specification: SPM.mat File';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).src_output = substruct('.','spmmat');
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep;
matlabbatch{3}.spm.stats.con.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.stats.con.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.stats.con.spmmat(1).sname = 'Model estimation: SPM.mat File';
matlabbatch{3}.spm.stats.con.spmmat(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.stats.con.spmmat(1).src_output = substruct('.','spmmat');
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'OneSample';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = 1;
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;
