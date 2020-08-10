% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)



function new_m =shuffle(m)

if size(m,1) == 1;
    m = m';
end
seq = randperm(size(m,1));
new_m = m(seq,:);

% parfor t = 1:size(m,1)
%    new_m(t,:) = m(seq(t),:);
% end

end
