clc, clear, close all
Element=3363;
DIM=3;
NODEs=3;
DOFs=54;
POLYNOMs=DOFs/DIM;
% Geometrical variables
syms L H W real % element dimensions 
syms ro real % a palace of the rotation axis
syms dEde real
% vector for fibres
a = sym('a', [1 3],'real').'; 
% inner twist, related to the fiber vector (additional twist)
Phi = sym('Phi', [1 3],'real').';
% outer twist
phi = sym('phi', [1 3],'real').';
% reference coordinates
syms xi eta zeta real
% initial coordinates
syms x y z real
xiv=[xi,eta,zeta].';
xv=[x,y,z].';
%% Obtaining shape functions 
% [Node1,Node2,Node3]
nx=[0,L/2,L].';
ny=[0,0,0];
nz=[0,0,0];
% set of base functions   
basis=[1,x,y,z,x*y,x*z,x^2,x^2*y,x^2*z,y^2,x*y^2,x^2*y^2,z^2,x*z^2,x^2*z^2,y*z,x*y*z,x^2*y*z];  
for jj_pol=1:POLYNOMs
       basis_y(jj_pol)=diff(basis(jj_pol),y);
       basis_z(jj_pol)=diff(basis(jj_pol),z);
       basis_yz(jj_pol)=diff(basis_y(jj_pol),z);       
       basis_yy(jj_pol)=diff(basis_y(jj_pol),y);
       basis_zz(jj_pol)=diff(basis_z(jj_pol),z);          
end
for ii_node=1:NODEs   
    for jj_pol=1:POLYNOMs
        ii2=(ii_node-1)*6+1;
        % substitution      
        AAA(ii2,jj_pol)=subs(basis(jj_pol),[x,y,z],[nx(ii_node),ny(ii_node),nz(ii_node)]);
        AAA(ii2+1,jj_pol)=subs(basis_y(jj_pol),[x,y,z],[nx(ii_node),ny(ii_node),nz(ii_node)]);
        AAA(ii2+2,jj_pol)=subs(basis_z(jj_pol),[x,y,z],[nx(ii_node),ny(ii_node),nz(ii_node)]);
        AAA(ii2+3,jj_pol)=subs(basis_yz(jj_pol),[x,y,z],[nx(ii_node),ny(ii_node),nz(ii_node)]);
        AAA(ii2+4,jj_pol)=subs(basis_yy(jj_pol),[x,y,z],[nx(ii_node),ny(ii_node),nz(ii_node)]);
        AAA(ii2+5,jj_pol)=subs(basis_zz(jj_pol),[x,y,z],[nx(ii_node),ny(ii_node),nz(ii_node)]);
    end
end
Svec=basis*AAA^-1;      % Shape functions in x coordinatesd
% Mapping x -> xi 
% x=xi*L/2
% y=eta*H/2
% z=zeta*W/2
for ii=1:POLYNOMs
    Svecxi(ii)=simplify(subs(Svec(ii),[x,y,z],[(L/2)*(xi+1),(H/2)*eta, (W/2)*zeta]));
end
% Shape function matrix in xi coordinate system
for ii=1:3
    for jj=1:POLYNOMs
        jj2=(ii-1)+(jj-1)*3+1;
        Smxi(ii,jj2)=Svecxi(jj);
    end
end
% nodal coordinates in initial and actual systems
ee = sym('ee', [1 54],'real').';
ee0_pos = sym('ee0_pos', [1 9],'real').';
%ee0_pos=[0,0,0,L/2,0,0,L,0,0].';
% if we use ee0=sym('ee0', [1 54],'real').'; it would to too much time to
% create matlabfunctions
dr1dy=[0 1 0]';
dr1dz=[0 0 1]';
HighOrder=[0,0,0,0,0,0,0,0,0].';  % slopes of higher order
ee0=[];
for i=1:NODEs
    % form a rotation matrix around x axís
    A = [1 0 0;
         0 cosd(phi(i)) -sind(phi(i));
         0 sind(phi(i))  cosd(phi(i))];
    % counterclockwise rotation 
    dr1dyk=A*dr1dy;
    dr1dzk=A*dr1dz;
    ee0=[ee0; ee0_pos(3*(i-1)+1:3*(i-1)+3); dr1dyk; dr1dzk; HighOrder];
end    
% position vectors at initial and current configurations
r0=Smxi*ee0;
r=Smxi*ee;
% deformation gradient
F0=jacobian(r0,xiv);
F1=jacobian(r,xiv);
F=F1*F0^-1;
% Green strain
II=eye(3);
EE=0.5*(F.'*F-II);
for ii=1:DIM
    for jj=1:DIM
        for kk=1:DOFs         
            dEde(ii,jj,kk)=diff(EE(ii,jj),ee(kk));
        end
    end
end
%% Inner twist for the fiber vector
ee00=[  0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,...
      L/2,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,...
        L,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0].';
r00=Smxi*ee00; 
F00=jacobian(r00,xiv);
ee0_f=ee0; 
for i=1:3 
        A = [1 0 0;
             0 cosd(Phi(i)) -sind(Phi(i));
             0 sind(Phi(i)) cosd(Phi(i))]; 
        ry_f0=ee0(18*(i-1)+4:18*(i-1)+6);
        rz_f0=ee0(18*(i-1)+7:18*(i-1)+9);
        ry_f=A*ry_f0;
        rz_f=A*rz_f0;
        % such as node in in the center, then the inner twist goes around it, 
        % therefore, it is still neutral  
        ee0_f(18*(i-1)+4:18*(i-1)+6)=ry_f;
        ee0_f(18*(i-1)+7:18*(i-1)+9)=rz_f;
end
r0_f=Smxi*ee0_f; 
F0_f=jacobian(r0_f,xiv);
F_inner=F0_f*F0^-1; % rotation around axis of the beam
F_axis=F0*F00^-1; 
F_fiber=F0_f*F00^-1; % F_inner*(F_axis)=F0_f*(F0^-1*F0)*F00^-1
a0_fib=F_fiber*a;
a0_fib=a0_fib/norm(a0_fib);
%% Function creation
fprintf('creation of functions \n')
matlabFunction(Smxi,'file','N_3363_axes','vars',{L,H,W,xi,eta,zeta});
matlabFunction(F,'file','FF_3363_axes','vars',{ee,ee0_pos,phi,L,H,W,xi,eta,zeta});
matlabFunction(dEde,'file','dEde_3363_axes','vars',{ee,ee0_pos,phi,L,H,W,xi,eta,zeta}); 
matlabFunction(a0_fib,'file','a0_fib_3363_axes','vars',{ee0_pos,phi,a,Phi,L,H,W,xi,eta,zeta});
fprintf('main functions have been created\n')

