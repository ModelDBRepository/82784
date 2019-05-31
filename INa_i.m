function [mlim,mtc]=INa_i(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
eps=1e-8;
x1=V+43.1;
x2=V+13.1;
a=0.098./exp(x1./(20));
b=1.4./(1+exp(x2./(-10)));
mtc=1./(a+b);
mlim=mtc.*a;
