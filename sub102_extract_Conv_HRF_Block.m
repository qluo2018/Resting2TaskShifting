clear;close all;clc;
fs = 9;
load('./fMRIdata/task/conn008/Stats_Session1/SPM.mat')
regressors = SPM.xX.X;
Conv_HRF_Block1 = regressors(1:410,[1:3]);

figure
plot(Conv_HRF_Block1)
xlim([0,410]);
xlabel('Time points','fontsize',fs);
set(gca,'position',[0.07,0.17,0.89,0.75],'fontsize',fs);

% filename='./figure/conv_HRF_Block';
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperPosition', [0 0 15 6]);         % size of picture
% print('-r900',gcf,'-djpeg',filename);          % jpg format
% close all

%%
figure
bf = SPM.xBF.bf;
plot(bf(:,1),'o-','markersize',3);
title('HRF')
% filename='./figure/HRF';
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperPosition', [0 0 8.5 6]);         % size of picture
% print('-r900',gcf,'-djpeg',filename);          % jpg format
% close all


% save('Conv_HRF_Block','Conv_HRF_Block');
% Conv_HRF_Block2 = regressors(411:end,[16 18 20]);
% figure
% plot(Conv_HRF_Block2)



