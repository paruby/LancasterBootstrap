%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%rewrites the (unsummed) test statistic as a matrix
%in the form that can be wild-bootstrapped to test for
%independence of y from (x,z)
function [test_matrix] = y_indep_matrix(K,L,M)
Ktilde = empirically_centre(K);
Ltilde = empirically_centre(L);
Mtilde = empirically_centre(M);

test_matrix = Ltilde.*empirically_centre(Ktilde.*Mtilde);
end