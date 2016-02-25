load('forexdata.mat')
gbpusd = gbpusdhrkdata{1};
usdhrk = gbpusdhrkdata{2};
gbphrk = gbpusdhrkdata{3};

%only run on part of data to speed things up

x=gbpusd(1:1000);
y=usdhrk(1:1000);
z=gbphrk(1:1000);

xreturn = x(2:1000)-x(1:999);
yreturn = y(2:1000)-y(1:999);
zreturn = z(2:1000)-z(1:999);

xreturn_sd = xreturn/sqrt(var(xreturn));
yreturn_sd = yreturn/sqrt(var(yreturn));
zreturn_sd = zreturn/sqrt(var(zreturn));

all_tests(abs(xreturn_sd'),abs(yreturn_sd'),abs(zreturn_sd'),1,1000,0.05)

all_tests(sign(xreturn_sd'),sign(yreturn_sd'),sign(zreturn_sd'),1,1000,0.05)





% SANITY CHECK - run the above but with the subsets of data chosen so that
% they are all definitely independent


%only run on part of data to speed things up

x=gbpusd(1:1000);
y=usdhrk(1001:2000);
z=gbphrk(2001:3000);

xreturn = x(2:1000)-x(1:999);
yreturn = y(2:1000)-y(1:999);
zreturn = z(2:1000)-z(1:999);

xreturn_sd = xreturn/sqrt(var(xreturn));
yreturn_sd = yreturn/sqrt(var(yreturn));
zreturn_sd = zreturn/sqrt(var(zreturn));

all_tests(abs(xreturn_sd'),abs(yreturn_sd'),abs(zreturn_sd'),1,1000,0.05)

all_tests(sign(xreturn_sd'),sign(yreturn_sd'),sign(zreturn_sd'),1,1000,0.05)