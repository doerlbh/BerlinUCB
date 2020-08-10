% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)

function run_oracle0(datafile,nstype,s,p)

rng(s)

switch datafile
    case 1
        folder = 'processed/mnists.mat';
    case 2
        folder = 'processed/warfarin.mat';
    case 3
        folder = 'processed/mnistwarfarin.mat';
    otherwise
        disp('incorrect arg')
end

load(folder);
resultfile = fullfile(strcat('output/result0_',num2str(datafile),'_',nstype,'_',num2str(p),'_',num2str(s),'.mat'));

opts.oracle = 0;

batchsize = 100;
if nstype ~= "none"
    [data,opts] = nonstationary(data,opts,batchsize,nstype,-1);
end
if p == 0
    [data,opts] = episparsify(data,opts,batchsize);
else
    [data,opts] = sparsefeedback(data,opts,p);
end

res_a = berlinucbkmeans(data,opts);
save(resultfile,'res_a')
res_b = berlinucbknn(data,opts);
save(resultfile,'res_a','res_b')
res_c = berlinucbgmm(data,opts);
save(resultfile,'res_a','res_b','res_c')
res_d = linucb(data,opts);
save(resultfile,'res_a','res_b','res_c','res_d')
res_i = berlinucb(data,opts);
save(resultfile,'res_a','res_b','res_c','res_d','res_i')
% res_e = kmeansclf(data,opts);
% save(resultfile,'res_a','res_b','res_c','res_d','res_i','res_e')
% res_f = knnclf(data,opts);
% save(resultfile,'res_a','res_b','res_c','res_d','res_i','res_e','res_f')
% res_g = gmmclf(data,opts);
% save(resultfile,'res_a','res_b','res_c','res_d','res_i','res_e','res_f','res_g')
% res_h = randagent(data,opts);
% save(resultfile,'res_a','res_b','res_c','res_d','res_i','res_e','res_f','res_g','res_h')
