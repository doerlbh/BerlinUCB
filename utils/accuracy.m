% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)



function acc = accuracy(isGPU,predict,expectmat)

P = size(expectmat,2);
expect = mat2vec(isGPU,expectmat,P);

acc = [submatch(isGPU, predict, expect, P) sum(predict == expect)/length(predict)];

end
