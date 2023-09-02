%% Storage arrays
Case1=[];
%% Contact characteristics
% pn=1e9;
% ns=4; % number of integration segments
pn=1e8; % ns=4 max 3e9 for BC=0
ns=1; % number of integration segments
if ns~=1 
   [zzz,ttt]=gauleg2(-1,1,ns);
else % we put the only one point at the edge
    zzz=1;ttt=1;
end
ns_s={ns,zzz,ttt}; % ns structure array 
%% Loading
%F_max=1;
%Fx_Sol=[5,7.5,10,15,20,25,30,40,50:10:100]; 
%Fx_Sol=100:100:1000; 
%Fx_Sol=10;
%Fx_Sol=[10:10:40,45,60,80,100,150,200]; 
Fx_Sol=[10:10:40,45,60,80,90,100,150,200:100:400]; % main
steps=length(Fx_Sol);
%Fx_MG=[1 Fx_Sol(2:end)/2];
%Fx_LG=[1 Fx_Sol(2:end)/4];
Fx_MG=zeros(1,steps);
Fx_LG=zeros(1,steps);
% bending 1
Fy_Sol=zeros(1,steps);
Fz_Sol=zeros(1,steps);
% bending 2
Fy_MG=zeros(1,steps);
Fz_MG=zeros(1,steps);
% bending 3
Fy_LG=zeros(1,steps);
Fz_LG=zeros(1,steps);
% load assemblance
F_Sol=[Fx_Sol' Fy_Sol' Fz_Sol'];
F_MG =[Fx_MG' Fy_MG' Fz_MG'];
F_LG =[Fx_LG' Fy_LG' Fz_LG'];
%% Boundary cond.
BC=1; % 1 -reduced, 0 - full 
%% Physical data
if Material==1
   MatName='Neo'; 
   const_Sol=103.1e6; Phi_Sol=0;
   const_MG=143.2e6; Phi_MG=0;
   const_LG=226.7e6; Phi_LG=0;
elseif Material==0
    MatName='GOH';
    Phi_Sol=0; % inner twist of Sol
    c10_Sol = 0.0306e6; k1_Sol=3.7859e6; k2_Sol=7.8085;  kappa_Sol = 0; a0_Sol = [1 0 0]; 
    const_Sol=[c10_Sol, k1_Sol, k2_Sol, kappa_Sol, a0_Sol];
    Phi_MG=0; % inner twist of MG
    c10_MG = 0.0306e6; k1_MG=3.7859e6; k2_MG=7.8085;  kappa_MG = 0; a0_MG = [1 0 0];  
    const_MG=[c10_MG, k1_MG, k2_MG, kappa_MG, a0_MG];
    Phi_LG=0; % inner twist of MG
    c10_LG = 0.0306e6; k1_LG=3.7859e6; k2_LG=7.8085;  kappa_LG = 0; a0_LG = [1 0 0];  
    const_LG=[c10_LG, k1_LG, k2_LG, kappa_LG, a0_LG];
end
%% Geometry
L=0.07;
L_Sol=L/n_Sol;
L_MG=L/n_MG;
L_LG=L/n_LG;
% cross-sections
scale=1/3000*0.0536;
if Approximation==0
    disp('****** This area type is suitable only for  nonstandart approximation ******');   
elseif Approximation~=0
    Apr='Gre_'+string(Approximation)+'_Sol';
    [H_Sol,W_Sol,detF0_Sol,pcirc_Sol,wcirc_Sol,Xi_Sol,R_Sol,cen_Sol]=PoiGen(Approximation,Fig_points,scale,1);
    [H_MG,W_MG,detF0_MG,pcirc_MG,wcirc_MG,Xi_MG,R_MG,cen_MG]=PoiGen(Approximation,Fig_points,scale,2);
    [H_LG,W_LG,detF0_LG,pcirc_LG,wcirc_LG,Xi_LG,R_LG,cen_LG]=PoiGen(Approximation,Fig_points,scale,3);
end 
% example of the mass center 
%cen_x=sum(pcirc_Sol(:,1).*wcirc_Sol)/sum(wcirc_Sol);
%cen_y=sum(pcirc_Sol(:,2).*wcirc_Sol)/sum(wcirc_Sol);
Area_Sol=detF0_Sol*sum(wcirc_Sol);
Area_MG=detF0_MG*sum(wcirc_MG);
Area_LG=detF0_LG*sum(wcirc_LG);
Total_Area=Area_Sol+Area_MG+Area_LG;
%% find common center
cen_ten=intersect(intersect(R_Sol,R_MG,'rows'),R_LG,'rows');
%% CS figure
if Fig_cs~=0
    figure();
    center_type={'*r','*g','*b'};
    list={'--r','--g','--b'};
    Data_p={R_Sol,R_MG,R_LG};
    centers={cen_Sol,cen_MG,cen_LG};
    for i=1:3
        plot(Data_p{i}(:,1),Data_p{i}(:,2),list{i})
        grid on
        hold on
        plot(centers{i}(:,1),centers{i}(:,2))
    end
    plot(cen_ten(:,1),cen_ten(:,2),'*k')
    legend('Soleus','Medial','Lateral')
end 
%% removing repetitions
R_Sol=unique(R_Sol,'stable','rows');  Xi_Sol=unique(Xi_Sol,'stable','rows');
R_MG=unique(R_MG,'stable','rows');    Xi_MG=unique(Xi_MG,'stable','rows');  
R_LG=unique(R_LG,'stable','rows');    Xi_LG=unique(Xi_LG,'stable','rows');    
%% finding related angels (axis of outer twist)
cen_Sol1=cen_Sol-cen_ten;  ro_Sol=norm(cen_Sol1);  phi_add_Sol=atan2d(cen_Sol1(2),cen_Sol1(1));
cen_MG1=cen_MG-cen_ten;    ro_MG=norm(cen_MG1);    phi_add_MG=atan2d(cen_MG1(2),cen_MG1(1));
cen_LG1=cen_LG-cen_ten;    ro_LG=norm(cen_LG1);    phi_add_LG=atan2d(cen_LG1(2),cen_LG1(1));
%% intersection points for contact
% Sol and MG
[~,ind1,ind2] = intersect(R_Sol,R_MG,'rows');
R_Sol_MG=R_Sol(ind1,:); Xi_Sol_MG=Xi_Sol(ind1,:);
R_MG_Sol=R_MG(ind2,:);  Xi_MG_Sol=Xi_MG(ind2,:);
% Sol and LG
[~,ind1,ind2] = intersect(R_Sol,R_LG,'rows');
R_Sol_LG=R_Sol(ind1,:); Xi_Sol_LG=Xi_Sol(ind1,:);
R_LG_Sol=R_LG(ind2,:); Xi_LG_Sol=Xi_LG(ind2,:);
% MG and LG
[~,ind1,ind2] = intersect(R_LG,R_MG,'rows');
R_LG_MG=R_LG(ind1,:); Xi_LG_MG=Xi_LG(ind1,:);
R_MG_LG=R_MG(ind2,:); Xi_MG_LG=Xi_MG(ind2,:);
%% Xi
Point_inter{1}{2}=Xi_Sol_MG; Point_inter{1}{3}=Xi_Sol_LG; Point_inter{2}{3}=Xi_MG_LG;
Point_inter{2}{1}=Xi_MG_Sol; Point_inter{3}{1}=Xi_LG_Sol; Point_inter{3}{2}=Xi_LG_MG;
%% Xi (for slave beams)
% Point_inter1{1}{2}=Xi_Sol_MG(2:3,:);Point_inter1{1}{3}=Xi_Sol_LG(2:3,:);
% Point_inter1{2}{1}=Xi_MG_Sol(2:3,:);Point_inter1{2}{3}=Xi_MG_LG(2:3,:);
% Point_inter1{3}{1}=Xi_LG_Sol(2:3,:);Point_inter1{3}{2}=Xi_LG_MG(2:3,:);
Point_inter1=Point_inter;