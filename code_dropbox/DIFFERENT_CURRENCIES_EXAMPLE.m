load('Different_currencies_forex_data.mat')
audeur = different_currencies_forex_data{1};
chfgbp = different_currencies_forex_data{2};
cadjpy = different_currencies_forex_data{3};

x=audeur(1:1000);
y=chfgbp(1:1000);
z=cadjpy(1:1000);

xreturn = x(2:1000)-x(1:999);
yreturn = y(2:1000)-y(1:999);
zreturn = z(2:1000)-z(1:999);

plot(xreturn)

xreturn_sd = xreturn/sqrt(var(xreturn));
yreturn_sd = yreturn/sqrt(var(yreturn));
zreturn_sd = zreturn/sqrt(var(zreturn));

all_tests(abs(xreturn_sd'),abs(yreturn_sd'),abs(zreturn_sd'),1,1000,0.05)

all_tests(sign(xreturn_sd'),sign(yreturn_sd'),sign(zreturn_sd'),1,1000,0.05)



