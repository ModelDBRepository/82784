function [T,V]=PC2cpm_NMDA(Tend,SglCellPar)
% ************************************************************************
% Single cell simulations with constant dendritic NMDA input
% from Durstewitz & Gabriel (2006), "Dynamical basis of irregular spiking
% in NMDA-driven prefrontal cortex neurons", Cerebral Cortex
% ************************************************************************

Nvar=[13 13];
Nv=cumsum(Nvar);
Vstart=-65;
V0([1 Nvar(1)+1])=Vstart;
V0(Nv-1)=50e-3;
V0(Nv)=3.82;
gate={@INa_a,@INa_i,@IDR,@INaP_a,@INaPDA_i,@IKS_a,@IKS_i, ...
    @IHVA_a,@IHVA_i,@IC};
for i=2:Nvar(1)-2
    [mlim,mtc]=feval(gate{i-1},V0(1),V0(Nvar(1)-1));
    V0(i)=mlim;
end;
for i=Nvar(1)+2:Nv(2)-2
    [mlim,mtc]=feval(gate{i-Nvar(1)-1},V0(Nvar(1)+1),V0(Nv(2)-1));
    V0(i)=mlim;
end;

opt=odeset('RelTol',1e-8,'AbsTol',1e-10,'MaxStep',1.0);
[T,V]=ode15s(@PC,[0 Tend],V0,opt,SglCellPar);
V=V(:,[1 14]);


function dV=PC(t,V,SglCellPar)

V=V';
Nvar=[13 13];
d=[SglCellPar(2) SglCellPar(8)];
l=[SglCellPar(1) SglCellPar(7)];
A=(d.*l)*pi;
Cm=[1.2e-5 2.304e-5].*A;
Rm=[0.3e7 0.15625e7]./A;
gNamax=[117e-5 20e-5].*A;
gDRmax=[50e-5 14e-5].*A;
gNaPmax=[SglCellPar(3) SglCellPar(10)].*A;
gKSmax=[SglCellPar(4) SglCellPar(11)].*A;
gHVAmax=[SglCellPar(5) SglCellPar(12)].*A;
gCmax=[SglCellPar(6) SglCellPar(13)].*A;
gNMDAmax=[0 SglCellPar(9)].*A;

CAF=[600 600];
KAF=[2e6 2e6];
tcCa=[250 120];
tcK=[7 7];
Ri=1.5;
Eleak=[-70 -70];
ENa=[55 55];
ENMDA=[0 0];
F=96487;
Ca_o=2000;
Ca_rest=50e-3;
dshellCa=2e-4;
K_i=140;
K_rest=3.82;
dshellK=70e-3;
Iinj=SglCellPar(14);

Nv=cumsum(Nvar);
Ca_i=V(Nv-1);
K_o=V(Nv);
VshellCa=pi*dshellCa*l.*(d-dshellCa);
VshellK=pi*dshellK*l.*(d+dshellK);
ECa=12.5*log(Ca_o./Ca_i);
k=find(ECa>500); ECa(k)=500;
EK=25*log(K_o./K_i);
r_i=Ri*4*l./(pi*d.^2);
Ra=sum(r_i)/2;

k=[2 Nvar(1)+2];
Erev=[Eleak;ENa;EK;ENa;EK;ECa;EK;ENMDA];
G(1,:)=1./Rm;
G(2,:)=gNamax.*V(k).^3.*V(k+1);
G(3,:)=gDRmax.*V(k+2).^4;
G(4,:)=gNaPmax.*V(k+3).*V(k+4);
G(5,:)=gKSmax.*V(k+5).*V(k+6);
G(6,:)=gHVAmax.*V(k+7).^2.*V(k+8);
G(7,:)=gCmax.*V(k+9).^2;
G(8,:)=gNMDAmax.*1.50265./(1+0.33*exp(V(k-1)./(-16)));
Vdrive=Erev-ones(size(Erev,1),1)*V(k-1);
dV(1)=(G(:,1)'*Vdrive(:,1)+diff(V(k-1))/Ra+Iinj)/Cm(1);
dV(k(2)-1)=(G(:,2)'*Vdrive(:,2)-diff(V(k-1))/Ra)/Cm(2);
gate={@INa_a,@INa_i,@IDR,@INaP_a,@INaPDA_i,@IKS_a,@IKS_i, ...
    @IHVA_a,@IHVA_i,@IC};
for i=2:Nvar(1)-2
    dV(i)=dmdt(gate{i-1},V(i),V(1),Ca_i(1));
end;
for i=Nvar(1)+2:Nv(2)-2
    dV(i)=dmdt(gate{i-Nvar(1)-1},V(i),V(Nvar(1)+1),Ca_i(2));
end;
Ihva=G(6,:).*Vdrive(6,:);
Ik=(G(3,:)+G(5,:)+G(7,:)).*Vdrive(3,:);
dV(Nv-1)=CAF.*Ihva./(F*VshellCa)+(Ca_rest-Ca_i)./tcCa;
dV(Nv)=-KAF.*Ik./(F*VshellK)+(K_rest-K_o)./tcK;

dV=dV';


% (c) 2004 Daniel Durstewitz