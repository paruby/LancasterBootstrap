clear all
len=8000;
[X,Y,Z] = example8(len);
results = all_tests(X,Y,Z,0.5,100,0.05);