%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%creates dataset with Z weakly dependent on X and Y pairwise
% but strongly on (X,Y) jointly. not timeseries
function [X,Y,Z] = example7(len)
X = rand(1,len);
X = (X>0.8);

Y = rand(1,len);
Y = (Y>0.8);

rz = rand(1,len);
Z = or(and(X,Y),(rz>0.9));

X = double(X);
Y = double(Y);
Z = double(Z);

end