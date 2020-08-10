% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)


function [data,opts] = episparsify(data,opts,batchsize)

y = data.full_y;
x = data.rec;
N = size(x,2);

x = x(:,1:batchsize*floor(N/batchsize));
data.full_y = y(1:batchsize*floor(N/batchsize),1);
y = y(1:batchsize*floor(N/batchsize),1);
N = size(x,2);


for i = 1:floor(N/batchsize)
    batch_y = y((i-1)*batchsize+1:i*batchsize,:);
    
    p = rand;
    yidx = randperm(batchsize);
    batch_y(yidx(1:floor(batchsize*p))) = -1;
    
    y((i-1)*batchsize+1:i*batchsize,:) = batch_y;
    
end

data.rec = x;
data.y = y;
data.t = batchsize*floor(N/batchsize);

end
