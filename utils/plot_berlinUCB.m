% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)

clear all;close all;clc;

% resultfile = fullfile('output/result0_1_none_0_1.mat');
% resultfile = fullfile('output/result1_1_none_0_1.mat');
% resultfile = fullfile('output/result0_1_cluster_0_1.mat');
% resultfile = fullfile('output/result1_1_cluster_0_1.mat');
% resultfile = fullfile('output/result0_1_negative_0_1.mat');
% resultfile = fullfile('output/result1_1_negative_0_1.mat');
% resultfile = fullfile('output/result0_1_reward_0_1.mat');
% resultfile = fullfile('output/result1_1_reward_0_1.mat');
% 
% resultfile = fullfile('output/result0_2_none_0_1.mat');
% resultfile = fullfile('output/result1_2_none_0_1.mat');
% resultfile = fullfile('output/result0_2_cluster_0_1.mat');
% resultfile = fullfile('output/result1_2_cluster_0_1.mat');
% resultfile = fullfile('output/result0_2_negative_0_1.mat');
% resultfile = fullfile('output/result1_2_negative_0_1.mat');
% resultfile = fullfile('output/result0_2_reward_0_1.mat');
% resultfile = fullfile('output/result1_2_reward_0_1.mat');
% 
% resultfile = fullfile('output/result0_3_none_0_1.mat');
% resultfile = fullfile('output/result1_3_none_0_1.mat');

% resultfile = fullfile('output/result0_1_none_0.1_1.mat');
% resultfile = fullfile('output/result1_1_none_0.1_1.mat');
% resultfile = fullfile('output/result0_1_none_0.01_1.mat');
% resultfile = fullfile('output/result1_1_none_0.01_1.mat');
% resultfile = fullfile('output/result0_1_none_0.5_1.mat');
% resultfile = fullfile('output/result1_1_none_0.5_1.mat');

% resultfile = fullfile('output/result0_1_cluster_0.1_1.mat');
% resultfile = fullfile('output/result1_1_cluster_0.1_1.mat');
% resultfile = fullfile('output/result0_1_cluster_0.01_1.mat');
% resultfile = fullfile('output/result1_1_cluster_0.01_1.mat');
resultfile = fullfile('output/result0_1_cluster_0.5_1.mat');
% resultfile = fullfile('output/result1_1_cluster_0.5_1.mat');

% resultfile = fullfile('output/result0_1_negative_0.1_1.mat');
% resultfile = fullfile('output/result1_1_negative_0.1_1.mat');
% resultfile = fullfile('output/result0_1_negative_0.01_1.mat');
% resultfile = fullfile('output/result1_1_negative_0.01_1.mat');
% resultfile = fullfile('output/result0_1_negative_0.5_1.mat');
% resultfile = fullfile('output/result1_1_negative_0.5_1.mat');

% resultfile = fullfile('output/result0_1_reward_0.1_1.mat');
% resultfile = fullfile('output/result1_1_reward_0.1_1.mat');
% resultfile = fullfile('output/result0_1_reward_0.01_1.mat');
% resultfile = fullfile('output/result1_1_reward_0.01_1.mat');
% resultfile = fullfile('output/result0_1_reward_0.5_1.mat');
% resultfile = fullfile('output/result1_1_reward_0.5_1.mat');

% resultfile = fullfile(strcat('output/result0_',num2str(datafile),'_',nstype,'_',num2str(p),'_',num2str(s),'.mat'));

fig1name = strrep(strrep(strrep(resultfile,'output','figures'),'.mat','_rew.png'),'0.','0p');
fig2name = strrep(strrep(strrep(resultfile,'output','figures'),'.mat','_acc.png'),'0.','0p');

load(resultfile);
data.t = size(res_a.r,1);

amp = 1;
ws = 100;
fs = 14;

fig1 = figure;
cm = colormap(lines);
plot([0:data.t-1]*amp,amp*movmean(res_d.r,ws),'lineWidth',2,'Color',cm(2,:)); hold on
plot([0:data.t-1]*amp,amp*movmean(res_i.r,ws),'lineWidth',2,'Color',cm(1,:)); hold on
plot([0:data.t-1]*amp,amp*movmean(res_a.r,ws),'lineWidth',2,'Color',cm(3,:)); hold on
plot([0:data.t-1]*amp,amp*movmean(res_b.r,ws),'lineWidth',2,'Color',cm(4,:)); hold on
plot([0:data.t-1]*amp,amp*movmean(res_c.r,ws),'lineWidth',2,'Color',cm(5,:)); hold on
% plot([0:data.t-1]*amp,amp*movmean(res_a.r,ws),'--','lineWidth',2,'Color',cm(3,:)); hold on
% plot([0:data.t-1]*amp,amp*movmean(res_b.r,ws),'--','lineWidth',2,'Color',cm(4,:)); hold on
% plot([0:data.t-1]*amp,amp*movmean(res_c.r,ws),'--','lineWidth',2,'Color',cm(5,:)); hold on
% plot([0:data.t-1]*amp,amp*movmean(res_e.r,ws),'lineWidth',2,'Color',cm(3,:)); hold on
% plot([0:data.t-1]*amp,amp*movmean(res_f.r,ws),'lineWidth',2,'Color',cm(4,:)); hold on
% plot([0:data.t-1]*amp,amp*movmean(res_g.r,ws),'lineWidth',2,'Color',cm(5,:)); hold on
% plot([0:data.t-1]*amp,amp*movmean(res_h.r,ws),'lineWidth',2,'Color','k'); hold on
% legend({'BerlinUCB','LinUCB','B-Kmeans','B-KNN','B-GMM','Kmeans','KNN','GMM','random'},'Location','northwest')
legend({'LinUCB','BerlinUCB','B-Kmeans','B-KNN','B-GMM'},'Location','northwest')
xlabel('t')
ylabel('r')
xlim([0,data.t-1]*amp)
set(gca,'FontSize',fs)
saveas(fig1, fig1name)

fig2 = figure;
plot([0:data.t-1]*amp,movmean(res_d.a,ws),'lineWidth',2,'Color',cm(2,:)); hold on
plot([0:data.t-1]*amp,movmean(res_i.a,ws),'lineWidth',2,'Color',cm(1,:)); hold on
plot([0:data.t-1]*amp,movmean(res_a.a,ws),'lineWidth',2,'Color',cm(3,:)); hold on
plot([0:data.t-1]*amp,movmean(res_b.a,ws),'lineWidth',2,'Color',cm(4,:)); hold on
plot([0:data.t-1]*amp,movmean(res_c.a,ws),'lineWidth',2,'Color',cm(5,:)); hold on
% plot([0:data.t-1]*amp,movmean(res_a.a,ws),'--','lineWidth',2,'Color',cm(3,:)); hold on
% plot([0:data.t-1]*amp,movmean(res_b.a,ws),'--','lineWidth',2,'Color',cm(4,:)); hold on
% plot([0:data.t-1]*amp,movmean(res_c.a,ws),'--','lineWidth',2,'Color',cm(5,:)); hold on
% plot([0:data.t-1]*amp,movmean(res_e.a,ws),'lineWidth',2,'Color',cm(3,:)); hold on
% plot([0:data.t-1]*amp,movmean(res_f.a,ws),'lineWidth',2,'Color',cm(4,:)); hold on
% plot([0:data.t-1]*amp,movmean(res_g.a,ws),'lineWidth',2,'Color',cm(5,:)); hold on
% plot([0:data.t-1]*amp,movmean(res_h.a,ws),'lineWidth',2,'Color','k'); hold on
% legend({'BerlinUCB','LinUCB','B-Kmeans','B-KNN','B-GMM','Kmeans','KNN','GMM','random'},'Location','northwest')
legend({'LinUCB','BerlinUCB','B-Kmeans','B-KNN','B-GMM'},'Location','northwest')
xlabel('t')
ylabel('acc')
% ylim([0,1])
xlim([0,data.t-1]*amp)
set(gca,'FontSize',fs)
saveas(fig2, fig2name)

% disp([res_i.rew,res_d.rew,res_a.rew,res_b.rew,res_c.rew,res_e.rew,res_f.rew,res_g.rew,res_h.rew]*amp)
% disp([res_i.acc,res_d.acc,res_a.acc,res_b.acc,res_c.acc,res_e.acc,res_f.acc,res_g.acc,res_h.acc]')

disp([res_d.rew,res_i.rew,res_a.rew,res_b.rew,res_c.rew]*amp)
disp([res_d.acc,res_i.acc,res_a.acc,res_b.acc,res_c.acc])
