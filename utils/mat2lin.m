% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)



function l = mat2lin(m, r, c)

l = zeros(1,r*c);
t = 1;

for R = 1:r
    for C = 1:c
        l(t) = m(R,C);
        t = t + 1;
    end
end

end
