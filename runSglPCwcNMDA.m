function Tstop=runSglPCwcNMDA(CellNo) 
% ************************************************************************
% Single cell simulations with constant dendritic NMDA input
% from Durstewitz & Gabriel (2006), "Dynamical basis of irregular spiking
% in NMDA-driven prefrontal cortex neurons", Cerebral Cortex
% ************************************************************************

% Runs simulations for the cell# 'CellNo' with parameters retrieved from
% the network-configuration 'NetPar0.par'.
% The model cell used in Fig. 9 corresponds to CellNo=56 from NetPar0.par.
% For drawing 10 cells at random from this parameter file, we used:
% Nprobe=10; rand('state',0); CellNos=randsample(100,Nprobe)-1;
% This yielded the numbers CellNos=[48 60 89 1 45 23 95 82 44 76] on our
% 64bit-machine.

gNMDA=(0.05:0.003:0.25)*1e-3;
pat='./';
Vdatf=[pat 'out/PCsgl0'];
netw=[pat 'runSglCell'];
fn=[pat 'NetPar0.par'];
Iinj=[0 -0.025 -0.05 -0.1];
Vini=-65;
Tstop=2e5;
TstartV=1.5e5;
    
% read cell parameters from NetPar0.par
fid=fopen(fn,'r');
for k=1:2*CellNo
    L=fgets(fid);
end;
a=[]; a=str2num(fgets(fid));
SglCellPar(1:6)=a(2:7);
a=[]; a=str2num(fgets(fid));
SglCellPar(7:13)=a(2:8);
fclose(fid);

for r=1:length(Iinj)
    SglCellPar(14)=Iinj(r);
    for j=1:length(gNMDA)
        SglCellPar(9)=gNMDA(j);
        ParVec=[Vini Tstop SglCellPar]';
        save([pat 'SglCellPar.par'],'ParVec','-ascii');
        unix(['./x86_64/special ' netw '.hoc']);
        X=load([pat 'out/PCsgl0.dat']);
        T=X(:,1); V=X(:,2);
        k=find(T>TstartV); T=T(k); V=V(k);
        ST=load([pat 'out/PCsgl0.st']);
        fout=[Vdatf '_' num2str(CellNo) '_' num2str(r) '_' num2str(j)];
        save(fout,'SglCellPar','T','V','ST');
        [r j]
    end;
end;


% % ML-based simulations of single model cells
% 
% gNMDA=(0.05:0.003:0.25)*1e-3;
% Vth=-20;
% pat='./';
% Vdatf=[pat 'out/MLsgl0'];
% fn=[pat 'NetPar0.par'];
% Iinj=[0 -0.025 -0.05 -0.1];
% Vini=-65;
% Tstop=2e5;
% TstartV=1.5e5;
% 
% % read cell parameters from NetPar0.par
% fid=fopen(fn,'r');
% for k=1:2*CellNo
%     L=fgets(fid);
% end;
% a=[]; a=str2num(fgets(fid));
% SglCellPar(1:6)=a(2:7);
% a=[]; a=str2num(fgets(fid));
% SglCellPar(7:13)=a(2:8);
% fclose(fid);
% SglCellPar([3:6 9:13])=SglCellPar([3:6 9:13])./100;
% 
% for r=1:length(Iinj)
%     SglCellPar(14)=Iinj(r);
%     for j=1:length(gNMDA)
%         SglCellPar(9)=gNMDA(j)/100;
%         [T,V]=PC2cpm_NMDA(Tstop,SglCellPar);
%         k=find(T>TstartV); T1=T(k); V1=V(k,1);
%         k=find(V1(2:end)>=Vth & V1(1:end-1)<Vth);
%         ST=T1(k)+(T1(k+1)-T1(k)).*(Vth-V1(k))./(V1(k+1)-V1(k));
%         fout=[Vdatf '_' num2str(CellNo) '_' num2str(r) '_' num2str(j)];
%         save(fout,'SglCellPar','T','V','ST');
%         [r j]
%     end;
% end;
