function [mlim,mtc]=INaPDA_i(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
eps=1e-8;
x1=V+42.8477;
x2=V-413.9284;
a=0.28e-4./exp(x1./(4.0248));
b=0.02./(1+exp(x2./(-148.2589)));
mtc=1./(a+b);
mlim=mtc.*a;
mtc=2*mtc;