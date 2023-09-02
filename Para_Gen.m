function Para_Gen(L,phi,Phim,Material,const,ee,ee0,phim,xloc,nl,num)
if num==1
    TenName='Sol';
    COORD_Sol;
    ELIST_Sol;
elseif num==2
    TenName='MG';
    COORD_MG;
    ELIST_MG;
elseif num==3
    TenName='LG';
    COORD_LG;
    ELIST_LG;
end    
Nnode=length(COORD);
COORD_2=[COORD(:,3) COORD(:,1) COORD(:,2)];
max_y=max(COORD_2(:,2));min_y=min(COORD_2(:,2)); % range for eta identification
max_z=max(COORD_2(:,3));min_z=min(COORD_2(:,3)); % range for zeta identification
H=max_y-min_y;
W=max_z-min_z;
el_x=geospace(0,L,nl+1,1)'; % elements' boundaries
Lk=L/nl; % length of the element
%% nodes positions in bi-lin system
Nodes_xi=[]; 
for i=1:Nnode
    vec3=COORD_2(i,:);x=vec3(1);
    [~,ind]=sort(abs(el_x-x));   
    b_r=max(ind(2),ind(1)); % right boundary of the element with x 
    b_l=min(ind(2),ind(1)); % left boundary of the element with x 
    el_n=b_r-1;  % element number 
    Nodes_xi=[Nodes_xi; el_n change(vec3(1),el_x(b_l),el_x(b_r)) change(vec3(2),min_y,max_y) change(vec3(3),min_z,max_z)];
end
disp_x=[];disp_y=[];disp_z=[];disp_xy=[];disp_yz=[];disp_xz=[];
stress_VM=[];stress_x=[];stress_y=[];stress_z=[];stress_xy=[];stress_yz=[];stress_xz=[];
Nodes_r=[];
for i = 1:Nnode
    ii=Nodes_xi(i,1);
    xi=Nodes_xi(i,2);eta=Nodes_xi(i,3);zeta=Nodes_xi(i,4);
    eek=ee(xloc(ii,:));
    eek0=ee0(xloc(ii,:));
    ee0_pos=eek0([1:3,19:21,37:39]);
    phik=phim(ii,:)';
    Phik=Phim(ii,:)'; 
    r =N_3363_axes(Lk,H,W,xi,eta,zeta)*eek;
    r0=N_3363_axes(Lk,H,W,xi,eta,zeta)*eek0;
    Nodes_r=[Nodes_r; r'];
    F=FF_3363_axes(eek,ee0_pos,phik,Lk,H,W,xi,eta,zeta);  
    if Material==1
        MatName='Neo'; 
        SS=Neo(F,const);    
    elseif Material==0
        MatName='GOH';
        a00=const(5:7)'; % change the direction of fibres, because of twist  
        a0=a0_fib_3363_axes(ee0_pos,phik,a00,Phik,Lk,H,W,xi,eta,zeta);
        SS=GOH(F,const,a0);
    end
    disp_x=[disp_x; r(1)-r0(1)];
    disp_y=[disp_y; r(2)-r0(2)];
    disp_z=[disp_z; r(3)-r0(3)];
    Stress=(1/det(F))*F*SS*F';  Vol_srt=trace(Stress)/3;
    VM_str=0;
    for ii=1:3
        for jj=1:3
        	VM_str=VM_str+(Stress(ii,jj)-Vol_srt*delt(ii,jj))*(Stress(ii,jj)-Vol_srt*delt(ii,jj));
        end
    end    
    stress_VM=[stress_VM; sqrt(3/2*VM_str)];
    stress_x=[stress_x; Stress(1,1)];
    stress_y=[stress_y; Stress(2,2)];
    stress_z=[stress_z; Stress(3,3)];
	stress_xy=[stress_xy; Stress(1,2)];
    stress_yz=[stress_yz; Stress(2,3)];
    stress_xz=[stress_xz; Stress(1,3)];
end
para_ANCFv3;



