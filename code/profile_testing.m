%profile testing
len = 8000;
[X,Y,Z] = example4(len);
X=X(len/2:end);
Y=Y(len/2:end);
Z=Z(len/2:end);
results = all_tests(X,Y,Z,0.5,500,0.05);
results{1}
results{2}
results{3}
results{4}