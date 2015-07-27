%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%creates example dataset with (x,y) indep of z
%based on markov chains. z drawn from different chain
function [X,Y,Z] = example3(len)
states = 1:100;
transitionx = zeros(length(states));
%fill transition matrix
for i=1:length(states);
    transitionx(i,mod(i-3,length(states))+1)=0.1;
    transitionx(i,mod(i-2,length(states))+1)=0.1;
    transitionx(i,mod(i-1,length(states))+1)=0.4;
    transitionx(i,mod(i,length(states))+1)=0.2;
    transitionx(i,mod(i+1,length(states))+1)=0.2;
end

transitionz = zeros(length(states));
%fill transition matrix
for i=1:length(states);
    transitionz(i,mod(i-3,length(states))+1)=0.2;
    transitionz(i,mod(i-2,length(states))+1)=0.2;
    transitionz(i,mod(i-1,length(states))+1)=0.3;
    transitionz(i,mod(i,length(states))+1)=0.2;
    transitionz(i,mod(i+1,length(states))+1)=0.1;
end


X = hmmgenerate(len,transitionx,eye(length(states)));
Z = hmmgenerate(len,transitionz,eye(length(states)));

yerrors = [-1,0,1];
Y = X + yerrors(randi(3,1,len));
Y = mod(Y-1,length(states))+1;

%zerrors = [-1,0,1];
%Z = X + zerrors(randi(3,1,len));
%Z = mod(Z-1,length(states))+1;
end