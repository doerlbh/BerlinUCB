% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)



function x = F_halfshuffle(x_all,z_all, v, batch)

train_index = [];
for t = 1:length(v)
    pos_o = find(z_all(:) == v(t));
    train_index = [train_index;pos_o];
end

train_index = shuffle(train_index);
x = x_all(train_index,:);

end
