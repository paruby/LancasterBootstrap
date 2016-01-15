%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%creates example dataset with (x,y) indep of z
%based on markov chains
function [X,Y,Z] = example2(len)
states = 1:100;
transition = zeros(length(states));
%fill transition matrix
for i=1:length(states);
    transition(i,mod(i-3,length(states))+1)=0.1;
    transition(i,mod(i-2,length(states))+1)=0.1;
    transition(i,mod(i-1,length(states))+1)=0.4;
    transition(i,mod(i,length(states))+1)=0.2;
    transition(i,mod(i+1,length(states))+1)=0.2;
end



X = hmmgenerate(len,transition,eye(length(states)));
Z = hmmgenerate(len,transition,eye(length(states)));

yerrors = [-1,0,1];
Y = X + yerrors(randi(3,1,len));
Y = mod(Y-1,length(states))+1;
end