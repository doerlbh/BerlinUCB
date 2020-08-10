% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)


% 
% [chosen_x, chosen_y, left_x, left_y] = K_pickout(x,y,chosen_size)

function [chosen_x, chosen_y, left_x, left_y] = K_pickout(x,y,chosen_size)

chosen_x = x(1:chosen_size,:);
chosen_y = y(1:chosen_size,:);
left_x = x(chosen_size+1:end,:);
left_y = y(chosen_size+1:end,:);

end
