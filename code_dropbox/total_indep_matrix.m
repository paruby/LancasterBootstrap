%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%rewrites the (unsummed) test statistic as a matrix
%in the form that can be wild-bootstrapped to test for
%total factorisation of the join
function [test_matrix] = total_indep_matrix(K,L,M)
Ktilde = empirically_centre(K);
Ltilde = empirically_centre(L);
Mtilde = empirically_centre(M);

test_matrix = Ktilde.*Ltilde.*Mtilde;
end