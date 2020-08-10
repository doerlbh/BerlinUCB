% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)



function [data,opts] = nonstationary(data,opts,batchsize,nstype,p)

y = double(data.full_y);
x = data.rec;

N = size(x,2);
x = x(:,1:batchsize*floor(floor(N/batchsize)));
y = y(1:batchsize*floor(floor(N/batchsize)),1);

N = size(x,2);

switch nstype
    case 'cluster'
        ncluster = 5;
        unselected = ones(N,1);
        indices = 1:N;
        clusters = kmeans(x',ncluster,'MaxIter',50);
        new_x = ones(size(x));
        new_y = ones(size(y));
        
        for i = 1:floor(N/batchsize)
            disp(i)
            batch_x = zeros(size(x,1),batchsize);
            batch_y = zeros(batchsize,1);
            
            dom = randsample(ncluster,1);
            dom_cls = x(:, unselected & clusters == dom);
            dom_idx = indices(unselected & clusters == dom);
            if  isempty(dom_cls)
                unselected(clusters == dom) = 0;
                count = 0;
            elseif size(dom_cls,2) < batchsize / 2
                batch_x(:,1:size(dom_cls,2)) = dom_cls;
                batch_y(1:size(dom_cls,2),1) = y(unselected & clusters == dom,1);
                unselected(clusters == dom) = 0;
                count = size(dom_cls,2);
            else
                batch_x(:,1:batchsize/2) = dom_cls(:,1:batchsize/2);
                batch_y(1:batchsize/2,1) = y(dom_idx(1:batchsize/2),1);
                unselected(dom_idx(1:batchsize/2)) = 0;
                count = batchsize/2;
            end
            
            otr_cls = x(:, unselected & clusters ~= dom);
            otr_idx = indices(unselected & clusters ~= dom);
            
            new_idx = randperm(size(otr_cls,2));
            otr_cls = otr_cls(:,new_idx);
            otr_idx = otr_idx(new_idx);
            
%             disp(batchsize-count)
%             disp(size(otr_cls))
            batch_x(:,count+1:end) = otr_cls(:,1:batchsize-count);
            batch_y(count+1:end,1) = y(otr_idx(1:batchsize-count),1);
            unselected(otr_idx(1:batchsize-count)) = 0;
            
            new_x(:,(i-1)*batchsize+1:i*batchsize) = batch_x;
            new_y((i-1)*batchsize+1:i*batchsize,:) = batch_y;
        end
        
    case 'negative'
        
        new_x = ones(size(x));
        new_y = ones(size(y));
        
        for i = 1:floor(N/batchsize)
            
            batch_x = x(:,(i-1)*batchsize+1:i*batchsize);
            batch_y = y((i-1)*batchsize+1:i*batchsize,:);
            
            neg_idx = 1:batchsize;
            new_idx = randperm(batchsize);
            neg_idx = neg_idx(new_idx);
            
            if p == -1
                pt = rand;
            else
                pt = p;
            end
            neg_num = floor(batchsize*pt);
            
            if size(x,1) == 784
                batch_x(:,neg_idx(1:neg_num)) = 255 - batch_x(:,neg_idx(1:neg_num));
            else
                batch_x(:,neg_idx(1:neg_num)) = 1 - batch_x(:,neg_idx(1:neg_num));
            end
            
            new_x(:,(i-1)*batchsize+1:i*batchsize) = batch_x;
            new_y((i-1)*batchsize+1:i*batchsize,:) = batch_y;
            
        end
        
    case 'reward'
        
        
        new_x = ones(size(x));
        new_y = ones(size(y));
        
        for i = 1:floor(N/batchsize)
            
            batch_x = x(:,(i-1)*batchsize+1:i*batchsize);
            batch_y = zeros(batchsize,1);
            yt = y((i-1)*batchsize+1:i*batchsize,:);
            
            new_lbl = randperm(opts.nOptions);
            for l = 1:opts.nOptions
                batch_y(yt == l) = new_lbl(l);
            end
            
            new_x(:,(i-1)*batchsize+1:i*batchsize) = batch_x;
            new_y((i-1)*batchsize+1:i*batchsize,:) = batch_y;
            
        end
        
end

data.rec = new_x;
data.y = string(new_y);
data.t = batchsize*floor(N/batchsize);

end
