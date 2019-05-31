function [mlim,mtc]=IKS_a(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
mlim=1./(1+exp((V+34)./(-6.5)));
mtc=6.0;
