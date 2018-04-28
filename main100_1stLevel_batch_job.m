%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
global ss
datapath = 'E:/Nottingham/zForOpenAccess/fMRIdata/task/';
mydir = dir(datapath);
mydir(1:2) = [];
workpath = [datapath,mydir(ss).name,'/'];
outpath =[workpath,'Stats_Session1/'];
if ~exist(outpath,'dir')
    mkdir(outpath)
end
volpath = [workpath,'session1/'];
temp_name = dir([volpath,'conn*.img']);
vols = cell(length(temp_name),1);
for i = 1:length(temp_name)
    vols{i,1}=[volpath,temp_name(i).name,',1'];
end
clear temp_name
OnSetfile = dir([volpath,'*_onsets.mat']);
load([volpath,OnSetfile(1).name]);
RestOnSets = [0;RestOnsets(3:3:21)];
%% -----------------------1st level specify------------------------- %%
matlabbatch{1}.spm.stats.fmri_spec.dir = {outpath};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2.5;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = vols;
%% -----------------------condition seting------------------------- %%
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'zeroBack';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = zeroBlockOnsets;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = 28.5;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'oneBack';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = oneBlockOnsets;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = 28.5;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).name = 'twoBack';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).onset = twoBlockOnsets;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).duration = 28.5;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).name = 'Resting';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).onset = RestOnSets;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).duration = 28.5;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});

%% ---------------------Set covariates as regressors-----------------%%
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {[volpath,'AllRegressors_Mov_WM_CSF_GS_.txt']};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% -----------------------Estimation----------------------- %%
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tname = 'Select SPM.mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(1).value = 'mat';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1).sname = 'fMRI model specification: SPM.mat File';
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
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Activity';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [0 0 1 -1];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;

