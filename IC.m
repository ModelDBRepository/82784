function [mlim,mtc]=IC(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
eps=1e-8;
V=V+40*log10(Ca);
x1=V+18;
x2=V+152;
k=find(x1==0);
x1(k)=eps;
a=(-0.00642*x1)./(-1+exp(x1./(-12)));
b=1.7*exp(x2./(-30.0));
mtc=1./(a+b);
mlim=mtc.*a;
