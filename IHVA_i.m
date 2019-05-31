function [mlim,mtc]=IHVA_i(V,Ca)
% from Durstewitz & Gabriel (2006), Cerebral Cortex
mlim=1./(1+exp((V+12.6)./18.9));
mtc=140;
