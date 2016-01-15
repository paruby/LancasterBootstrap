numexps = 10;

num_rejects_HSIC = 0;
num_rejects_Lancaster = 0;
for i=1:numexps;
    if mod(i,1)==0;
        fprintf(num2str(i))
        fprintf(', ')
    end
    if mod(i,10)==0;
        fprintf('\n')
    end
    [X,Y,Z] = example9(2000,0.3);
    [T,results] = evalc('all_tests(X,Y,Z,1,250,0.05);');
    if results.reject_factorisation_HSIC ==1;
        num_rejects_HSIC = num_rejects_HSIC+1;
    end
    if results.reject_lancaster_null_naive ==1;
        num_rejects_Lancaster = num_rejects_Lancaster+1;
    end
end

