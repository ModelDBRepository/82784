function [mlim,mtc]=IHVA_a(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
mlim=1./(1+exp((V+24.6)./(-11.3)));
mtc=1.25*sech(-0.031*(V+37.1));
