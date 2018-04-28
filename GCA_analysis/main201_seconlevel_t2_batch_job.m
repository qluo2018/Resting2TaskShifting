%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
workpath = 'E:\Nottingham\zForOpenAccess\GCA_analysis\session1\ROI1\GCA_paired\sVox2ROI\paired\';
outpath =[workpath,'T_value\T2_spm\'];
if ~exist(outpath,'dir')
    mkdir(outpath)
end
matlabbatch{1}.spm.stats.factorial_design.dir = {outpath};
%% Read volume data for t test
volpath1 = [workpath,'Pat\'];
temp_name = dir([volpath1,'*.nii']);
vols1 = cell(length(temp_name),1);
for i = 1:length(temp_name)
    vols1{i,1}=[volpath1,temp_name(i).name,',1'];
end

volpath2 = [workpath,'Nor\'];
temp_name = dir([volpath2,'*.nii']);
vols2 = cell(length(temp_name),1);
for i = 1:length(temp_name)
    vols2{i,1}=[volpath2,temp_name(i).name,',1'];
end
clear temp_name
%% load covariates
cov_data = dlmread('E:\Nottingham\zForOpenAccess\covariates\covs_age_gender_headmotion_S60.txt');
%% 
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = vols1;
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = vols2;
%%
matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 0;
%% set covariates data
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
matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {'E:\Nottingham\zForOpenAccess\mask\mask_template\BrainMask_05_61x73x61.img,1'};
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
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'T2_a2b';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 -1];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;
