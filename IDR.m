function [mlim,mtc]=IDR(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
eps=1e-8;
x1=V-13;
x2=V-23;
k=find(x1==0);
x1(k)=eps;
k=find(x2==0);
x2(k)=eps;
a=-0.018*x1./(-1+exp(x1./(-25)));
b=0.0054*x2./(-1+exp(x2./(12.0)));
mtc=1./(a+b);
mlim=mtc.*a;
