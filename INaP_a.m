function [mlim,mtc]=INaP_a(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
eps=1e-8;
x1=V+12;
x2=V-15;
k=find(x1==0);
x1(k)=eps;
k=find(x2==0);
x2(k)=eps;
a=-0.2816*x1./(-1+exp(x1./(-9.3)));
b=0.2464*x2./(-1+exp(x2./(6.0)));
mtc=1./(a+b);
mlim=mtc.*a;
