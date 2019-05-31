function dm=dmdt(gate,m,V,Ca)
[mlim,mtc]=feval(gate,V,Ca);
dm=(mlim-m)./mtc;
