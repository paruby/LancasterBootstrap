%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%creates dataset with Z weakly dependent on X and Y pairwise
% but strongly on (X,Y) jointly. timeseries version of example7
function [X,Y,Z] = example8(len)
lag = 10;
rx = rand(1,len+lag);
ry = rand(1,len+lag);
rz = rand(1,len+lag);

X=zeros(1,len);
Y=zeros(1,len);
Zrand = zeros(1,len);
for i=1:lag;
    X = X + rx(i:(end-(lag+1)+i));
    Y = Y + ry(i:(end-(lag+1)+i));
    Zrand = Zrand + rz(i:(end-(lag+1)+i));
end

X = (X>0.6*lag);
Y = (Y>0.6*lag);


Z = or(and(X,Y),(Zrand>0.65*lag));

X = double(X);
Y = double(Y);
Z = double(Z);

X=[X;rand(4,len)];
Y=[Y;rand(4,len)];
Z=[Z;rand(4,len)];


end