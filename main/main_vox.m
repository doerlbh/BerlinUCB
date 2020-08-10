% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)


addpath matlab
addpath mfcc
run vl_setupnn
run vl_compilenn

rng(666)

% % the feature is MFCC if useNN is set to 0, a VGG embedding if set to 1.
% opts.useNN = 1;
% 
% % the number of speakers appearing in an online learning scenario.
% opts.nOptions = 5;
% 
% % the episodicality of the reward: the frequency of feedback revealing.
% opts.epiReward = 0.1;
% 
% % the full length of separate segments of individual talking
% opts.nPiece = 10;
% 
% % if the full participants are given, set it to 1; else 0.
% opts.oracle = 0;
% 
% opts.modelPath = '' ;
% opts.dataDir = './data'; 
% % opts.gpu = 1;
% 
% data = minivox(opts);
% save('test.mat','data','opts');

load('processed/oracle0/nn_c5_p20/data.mat')
opts.oracle = 0;

x = data.rec;
y = data.y;
fy = data.full_y;
x = x(:,1:10:data.t);
y = y(1:10:data.t);
fy = fy(1:10:data.t);
data.rec = x;
data.y = y;
data.full_y = fy;
data.t = size(x,2);

[data,opts] = sparsefeedback(data,opts,0.01);

res_a = berlinucbkmeans(data,opts);
res_b = berlinucbknn(data,opts);
res_c = berlinucbgmm(data,opts);
res_d = linucb(data,opts);
res_e = kmeansclf(data,opts);
res_f = knnclf(data,opts);
res_g = gmmclf(data,opts);
res_h = randagent(data,opts);
res_i = berlinucb(data,opts);

ws = 10;

cm = colormap(lines);

figure
plot(1:data.t,movmean(res_i.r,ws),'.-','lineWidth',2,'Color',cm(1,:)); hold on
plot(1:data.t,movmean(res_d.r,ws),'lineWidth',2,'Color',cm(2,:)); hold on
plot(1:data.t,movmean(res_a.r,ws),'--','lineWidth',2,'Color',cm(3,:)); hold on
plot(1:data.t,movmean(res_b.r,ws),'--','lineWidth',2,'Color',cm(4,:)); hold on
plot(1:data.t,movmean(res_c.r,ws),'--','lineWidth',2,'Color',cm(5,:)); hold on
plot(1:data.t,movmean(res_e.r,ws),'lineWidth',2,'Color',cm(3,:)); hold on
plot(1:data.t,movmean(res_f.r,ws),'lineWidth',2,'Color',cm(4,:)); hold on
plot(1:data.t,movmean(res_g.r,ws),'lineWidth',2,'Color',cm(5,:)); hold on
plot(1:data.t,movmean(res_h.r,ws),'lineWidth',2,'Color','k'); hold on
legend('berlinucb','linucb','b-kmeans','b-knn','b-gmm','kmeans','knn','gmm','random')
xlabel('t')
ylabel('r')
xlim([0,data.t])

figure
plot(1:data.t,movmean(res_i.a,ws),'.-','lineWidth',2,'Color',cm(1,:)); hold on
plot(1:data.t,movmean(res_d.a,ws),'lineWidth',2,'Color',cm(2,:)); hold on
plot(1:data.t,movmean(res_a.a,ws),'--','lineWidth',2,'Color',cm(3,:)); hold on
plot(1:data.t,movmean(res_b.a,ws),'--','lineWidth',2,'Color',cm(4,:)); hold on
plot(1:data.t,movmean(res_c.a,ws),'--','lineWidth',2,'Color',cm(5,:)); hold on
plot(1:data.t,movmean(res_e.a,ws),'lineWidth',2,'Color',cm(3,:)); hold on
plot(1:data.t,movmean(res_f.a,ws),'lineWidth',2,'Color',cm(4,:)); hold on
plot(1:data.t,movmean(res_g.a,ws),'lineWidth',2,'Color',cm(5,:)); hold on
plot(1:data.t,movmean(res_h.a,ws),'lineWidth',2,'Color','k'); hold on
legend('berlinucb','linucb','b-kmeans','b-knn','b-gmm','kmeans','knn','gmm','random')
xlabel('t')
ylabel('acc')
ylim([0,1])
xlim([0,data.t])
