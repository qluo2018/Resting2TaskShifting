clear;close all;clc;
% % load mask of ROI
workpath = 'E:\Nottingham\zForOpenAccess\GCA_analysis\session1\ROI1\GCA_paired\sROI2Vox\';
maskfile = dir('E:\Nottingham\zForOpenAccess\mask\mask_result\sROI2Vox\*_mask.nii');

scorenamefull = {'Hit rate'};
disp('Cluster                 Score           p value of corr       p value of t-test')
for ii = 1:length(maskfile)
    %     S = regexp(maskfile(ii).name, '_', 'split');
    [mask,~] = y_Read(['E:\Nottingham\zForOpenAccess\mask\mask_result\sROI2Vox\',maskfile(ii).name]);
    S = regexp(maskfile(ii).name, '\_', 'split');
    %     sum(mask(:));
    
    path1 = [workpath,'paired\Pat\'];
    path2 = [workpath,'paired\Nor\'];
    dir1 = dir([path1,'*.nii']);
    dir2 = dir([path2,'*.nii']);
    nPat = length(dir1);
    nNor = length(dir2);
    val_Pat = zeros(nPat,1);
    for i = 1:nPat
        [data,hdr] = y_Read([path1,dir1(i).name]);
        xxx = isnan(data);
        identify = ~xxx;
        new_mask = mask.*identify;
        data(xxx) = 0;
        val_Pat(i) = sum(sum(sum(data.*new_mask)))/sum(new_mask(:));
    end
    
    val_Nor = zeros(nNor,1);
    for i = 1:nNor
        [data,hdr] = y_Read([path2,dir2(i).name]);
        xxx = isnan(data);
        identify = ~xxx;
        new_mask = mask.*identify;
        data(xxx) = 0;
        val_Nor(i) = sum(sum(sum(data.*new_mask)))/sum(new_mask(:));
    end
    nSub = max([nNor,nPat]);
    result = NaN(nSub,2);
    result(1:nPat,1) = val_Pat;
    result(1:nNor,2) = val_Nor;
    scorename = dir('E:\Nottingham\zForOpenAccess\covariates\N31_HitRate.txt');
    
    % % calculate pavalue of T test
    DependentVariable = [val_Pat;val_Nor];
    GroupLabel = [ones(nPat,1);zeros(nNor,1)];
    Covariate = dlmread('E:\Nottingham\zForOpenAccess\covariates\covs_age_gender_headmotion_S60.txt');
    Covariate(:,1) = [];
    [p,~] = ttest2_cov(DependentVariable, GroupLabel, Covariate);
    for jj = 1:length(scorename)
        %  disp(scorename(jj).name)
        score = dlmread(['E:\Nottingham\zForOpenAccess\covariates\',scorename(jj).name]);
        covs = dlmread('E:\Nottingham\zForOpenAccess\covariates\covs_age_gender_headmotion_N31.txt');
        [~,idx] = max(val_Nor);
        covs(idx,:) = [];
        score(idx,:) = [];
        val_Nor(idx,:) = [];
       %[rho,pval] = partialcorr(score,val_Nor,covs,'type','spearman');%
       [rho,pval] = corr(score,val_Nor,'type','spearman');
        % if pval<0.05
        % % ------------------------display--------------------% % %
        disp([maskfile(ii).name,'    ',scorename(jj).name,'         ',num2str(pval),'           ',num2str(p)]);
        figure
        [hh,~,~,~] = p_regress(score,val_Nor,5);
        set(hh,'linewidth',2)
        xlabel(['Score: ',scorenamefull{jj}],'fontsize',16);
        ylabel(['CPC (from rAI to ',S{1},')'],'fontsize',16);
        title(['P value = ',num2str(round(pval*10000)/10000),'   CorrCoef = ',num2str(round(rho*1000)/1000)]);
        set(gca,'fontsize',16)
        temp = scorename(jj).name;
        temp = temp(5:end-4);
        %saveas(gcf,['E:\Nottingham\figure\correlation\SpearmanCorr_',S{1},'_',temp,'.jpeg']);
        %end
    end
    % %     figure
    % %     boxplot(result)
    % %     set(gca,'xtick',[1,2],'xticklabel',{'SCZ','HC'},'fontsize',16)
    % %     ylabel('CPC (from rMOG to rAI)','fontsize',16);
    % %     title(['P value = ',num2str(p)]);
    % %     set(gca,'fontsize',16)
    % %     %   saveas(gcf,[workpath,'paired\corr_result\Diff_CPC_x2y.jpeg'])
    % %     %   close all
end
disp('Bye bye ... ...')