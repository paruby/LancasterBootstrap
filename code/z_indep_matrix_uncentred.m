%Paul Rubenstein, 2015
%Code for Lancaster interaction with timeseries
%rewrites the (unsummed) test statistic as a matrix
%in the form that can be wild-bootstrapped to test for
%independence of z from (x,y)
function [test_matrix] = z_indep_matrix_uncentred(K,L,M)
Ktilde = K;%empirically_centre(K);
Ltilde = L;%empirically_centre(L);
Mtilde = empirically_centre(M);

test_matrix = empirically_centre(Ktilde.*Ltilde).*Mtilde;
end