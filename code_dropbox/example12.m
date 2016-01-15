%example 12

X = csvread('BHD-ALL_formatted.csv');
Y = csvread('BHD-MUR_formatted.csv');
Z = csvread('MUR-ALL_formatted.csv');

X = log(X);
Y = log(Y);
Z = log(Z);

X = -X;

len = min([length(X),length(Y),length(Z)]);

X = X(1:len);
Y = Y(1:len);
Z = Z(1:len);

%now should have that X+Y+Z =0

Xs = smooth(X);
Ys = smooth(Y);
Zs = smooth(Z);

Xfluc = X - Xs;
Yfluc = Y - Ys;
Zfluc = Z - Zs;

Xflux = Xfluc / sqrt(var(Xfluc));
Yflux = Yfluc / sqrt(var(Yfluc));
Zflux = Zfluc / sqrt(var(Zfluc));