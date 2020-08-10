% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)



function sub_accuracy = submatch(isGPU,labels, expected, P)

if isGPU == 1
    sub_accuracy = zeros(1, P, 'gpuArray');
    
    parfor t = 1:P
        exp_total = sum(expected == t);
        v_lab = (labels == t);
        v_exp = (expected == t);
        err =  sum((v_exp - v_lab) > 0);
        sub_accuracy(t) = (exp_total - err) / exp_total;
    end
else
    sub_accuracy = zeros(1, P);
    
    parfor t = 1:P
        exp_total = sum(expected == t);
        v_lab = double(labels == t);
        v_exp = double(expected == t);
        err =  sum((v_exp - v_lab) > 0);
        sub_accuracy(t) = (exp_total - err) / exp_total;
        
    end
end

end
