% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)



function [data,opts] = sparsefeedback(data,opts,p)

opts.epiReward = p;
y_epi = data.full_y;

if p ~= 1
    yidx = randperm(length(data.full_y));
    yidx = yidx(1:floor(length(data.full_y)*(1-p)));
    y_epi(yidx) = -1;
end

data.y = y_epi;

end
