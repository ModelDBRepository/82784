function [mlim,mtc]=IKS_i(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
mlim=1./(1+exp((V+65)./6.6));
mtc=200+220./(1+exp((V+71.6)./(-6.85)));
