%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%creates dataset with Z weakly dependent on X and Y pairwise
function [X,Y,Z] = example6(len)
lag = 10;
rx = rand(1,len+lag);
ry = rand(1,len+lag);

X=zeros(1,len);
Y=zeros(1,len);
for i=1:lag;
    X = X + rx(i:(end-(lag+1)+i));
    Y = Y + ry(i:(end-(lag+1)+i));
end

% Z = (X>Y);
% Z = double(Z); %makes X,Z dependent, YZ dependent

Z = rx(1:len).^2+ry(1:len).^2;

end