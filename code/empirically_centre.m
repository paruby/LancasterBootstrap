%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%Center gram matrix
function [centred_matrix] = empirically_centre(gram_matrix)
n = size(gram_matrix);
n = n(1);
centred_matrix = gram_matrix - (1/n)*rowsum(gram_matrix) - (1/n)*colsum(gram_matrix) + (1/n^2)*sumsum(gram_matrix);
end