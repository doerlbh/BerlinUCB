% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)



function [learn_x,learn_y,prior_x] = K_readmatv73(filename)

m = matfile([filename '.mat']);
learn_x = m.learn_x;
learn_y = m.learn_y;
prior_x = m.prior_x;

end
