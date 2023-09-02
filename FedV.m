function Fe_dV = FedV(ee,ee_pos,L,H,W,xi,eta,zeta,Material,const,phi,Phi)
n=length(ee); 
phi=phi'; 
Phi=Phi';
F=FF_3363_axes(ee,ee_pos,phi,L,H,W,xi,eta,zeta);
dEEde=dEde_3363_axes(ee,ee_pos,phi,L,H,W,xi,eta,zeta); 
%2nd Piola Kirchhoff stress tensor
if Material==1
    SS=Neo(F,const);    
elseif Material==0
    a00=const(5:7)'; % change the direction of fibres, because of twist  
    a0=a0_fib_3363_axes(ee_pos,phi,a00,Phi,L,H,W,xi,eta,zeta);
    SS=GOH(F,const,a0);    
end
Fe_dV=zeros(1,n);
for kk=1:n  
    for ii=1:3
        for jj=1:3           
            Fe_dV(kk)=Fe_dV(kk)+SS(ii,jj)*dEEde(ii,jj,kk);           
        end
   end
end
 

