clear;close all;clc;
% % load mask of ROI
direct = 'sVox2ROI';
workpath = ['.\session1\ROI1\GCA_paired\',direct,'\'];
maskfile = dir(['E:\Nottingham\zForOpenAccess\mask\mask_result\',direct,'\*_mask.nii']);
scorenamefull = {'Mean DSST','Disorganization','GAF','Hit rate','Psychomotor Poverty','Reality Distortion','SOFAS','Total SSPI'};
for ii = 1:length(maskfile)
    S = regexp(maskfile(ii).name, '\_', 'split');
    [mask,~] = y_Read(['E:\Nottingham\zForOpenAccess\mask\mask_result\',direct,'\',maskfile(ii).name]);
    %  sum(mask(:));
    path1 = [workpath,'task\Pat\'];
    path2 = [workpath,'task\Nor\'];
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
    scorename = dir('E:\Nottingham\zForOpenAccess\covariates\P29*.txt');
    
    % % calculate pavalue of T test
    DependentVariable = [val_Pat;val_Nor];
    GroupLabel = [ones(nPat,1);zeros(nNor,1)];
    Covariate = dlmread('E:\Nottingham\zForOpenAccess\covariates\covs_age_gender_headmotion_S60.txt');
    [p,~] = ttest2_cov(DependentVariable, GroupLabel, Covariate);
    
    for jj = 1:length(scorename)
        %   disp(scorename(jj).name)
        score = dlmread(['E:\Nottingham\zForOpenAccess\covariates\',scorename(jj).name]);
        covs = dlmread('E:\Nottingham\zForOpenAccess\covariates\covs_age_gender_headmotion_P29.txt');
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% For outlier or not %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (ii==3)&&(jj==3)
            %                     idx = find(score==0);
            idx = find(val_Pat>0.3);
            X = [score,val_Pat,covs];
            X(idx,:) = [];
            [rho,pval] = corr(X(:,1),X(:,2),'type','pearson');
            %[rho,pval] = partialcorr(X(:,1),X(:,2),X(:,3:end),'type','pearson');%
            %             size(X)
            disp(pval)
        else
            X = [score,val_Pat,covs];
            [rho,pval] = corr(X(:,1),X(:,2),'type','spearman');
            %[rho,pval] = partialcorr(X(:,1),X(:,2),X(:,3:end),'type','spearman');%
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if pval<0.05
            % % display
            disp([num2str([ii,jj]),'   ',maskfile(ii).name,'    ',scorename(jj).name,'  ',num2str(pval),'  ',num2str(p)]);
            figure
            [hh,~,~,~] = p_regress(X(:,1),X(:,2),5);
            set(hh,'linewidth',2)
            xlabel(['Score: ',scorenamefull{jj}],'fontsize',16);
            ylabel(['PC (from ',S{1},' to rAI)'],'fontsize',16);
            % ylabel(['CPC (from rAI to ',S{1},')'],'fontsize',16);
            title(['P value = ',num2str(round(pval*10000)/10000),'   CorrCoef = ',num2str(round(rho*1000)/1000)]);
            set(gca,'fontsize',16)
            temp = scorename(jj).name;
            temp = temp(5:end-4);
            % saveas(gcf,['E:\Nottingham\figure\correlation\',direct,'\outlier_pearson_',S{1},'_',temp,'.jpeg']);
        end
    end
    %     figure
    %     boxplot(result)
    %     set(gca,'xtick',[1,2],'xticklabel',{'SCZ','HC'},'fontsize',16)
    %     ylabel(['CPC (from ',S{1},' to rAI)'],'fontsize',16);
    %     title(['P value = ',num2str(p)]);
    %     set(gca,'fontsize',16)
    %     saveas(gcf,['E:\Nottingham\figure\correlation\Diff_CPC_x2y.jpeg'])
end
% close all
disp('Bye bye ... ...')