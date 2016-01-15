%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%autoregressive thing with Z dependent on X but indep of Y
%separately
function [X,Y,Z] = example11(len)
X = zeros(1,len);
Y = zeros(1,len);
Z = zeros(1,len);

X(1) = randn;
Y(1) = randn;
Z(1) = randn;
for i = 2:len;
    X(i) = 0.5*X(i-1) + randn;
    Y(i) = 0.5*Y(i-1) + randn;
    
    %Z is dependent only on X
    Z(i) = 0.5*Z(i-1) + 0.5*X(i) + rand;
end