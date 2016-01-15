%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%rewrites the (unsummed) test statistic as a matrix
%in the form that can be wild-bootstrapped to test for
%independence of x from (y,z)
function [test_matrix] = HSIC_matrix(K,L)
Ktilde = empirically_centre(K);
Ltilde = empirically_centre(L);

test_matrix = Ktilde.*Ltilde;
end