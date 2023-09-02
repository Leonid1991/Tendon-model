function [K,ff,Fext]=Kt(ee,ee0,F_Sol,F_MG,F_LG,xloc_Sol,xloc_MG,xloc_LG,nloc_Sol,nloc_MG,nloc_LG,...
                          nx_Sol,nx_MG,nx_LG,nl_Sol,nl_MG,nl_LG,nn_Sol,nn_MG,nn_LG,L_Sol,L_MG,L_LG,...
                          Material,const_Sol,const_MG,const_LG,...
                          phim_Sol,Phim_Sol,phim_MG,Phim_MG,phim_LG,Phim_LG,...
                          H_Sol,W_Sol,detF0_Sol,pcirc_Sol,wcirc_Sol,...
                          H_MG,W_MG,detF0_MG,pcirc_MG,wcirc_MG,...
                          H_LG,W_LG,detF0_LG,pcirc_LG,wcirc_LG,...
                          ns_s,pn,ElemDofs,Point_inter,Point_inter1)
h=10^(-9);
%% External part
Fext_Sol=Fext_ANCF(nn_Sol,nx_Sol,F_Sol(1),F_Sol(2),F_Sol(3));
Fext_MG =Fext_ANCF(nn_MG, nx_MG, F_MG(1), F_MG(2), F_MG(3));
Fext_LG =Fext_ANCF(nn_LG, nx_LG, F_LG(1), F_LG(2), F_LG(3));
Fext = [Fext_Sol;Fext_MG;Fext_LG];% Forms force equation ff=Fe-Fext  (elastic forces - external forces)
%% Elastic part
% Separations of the variables associtated with Elasticity 
ee_Sol=ee(1:nx_Sol);              ee0_Sol=ee0(1:nx_Sol);
ee_MG=ee(nx_Sol+1:nx_Sol+nx_MG);  ee0_MG=ee0(nx_Sol+1:nx_Sol+nx_MG); 
ee_LG=ee(nx_Sol+nx_MG+1:end);     ee0_LG=ee0(nx_Sol+nx_MG+1:end);

Elast_info{1}={ElemDofs,Material,const_Sol,L_Sol,H_Sol,W_Sol,detF0_Sol,pcirc_Sol,wcirc_Sol,phim_Sol,Phim_Sol,nx_Sol,nl_Sol,nn_Sol,ee_Sol,ee0_Sol,xloc_Sol,h};
Elast_info{2}={ElemDofs,Material, const_MG, L_MG, H_MG, W_MG, detF0_MG, pcirc_MG, wcirc_MG, phim_MG, Phim_MG, nx_MG, nl_MG, nn_MG, ee_MG, ee0_MG, xloc_MG,h};
Elast_info{3}={ElemDofs,Material, const_LG, L_LG, H_LG, W_LG, detF0_LG, pcirc_LG, wcirc_LG, phim_LG, Phim_LG, nx_LG, nl_LG, nn_LG, ee_LG, ee0_LG, xloc_LG,h};

[Fe_Sol,K_Sol]=Fe_Elastic(Elast_info{1}); 
[Fe_MG,K_MG]  =Fe_Elastic(Elast_info{2});
[Fe_LG,K_LG]  =Fe_Elastic(Elast_info{3});
Fe = [Fe_Sol;Fe_MG;Fe_LG];
%% Contact part

Kc=zeros(nx_Sol+nx_MG+nx_LG,nx_Sol+nx_MG+nx_LG); % Stiffness contact matrix

Fc=Fc_3363(ee,xloc_Sol,xloc_MG,xloc_LG,nloc_Sol,nloc_MG,nloc_LG,nx_Sol,nx_MG,nx_LG,nl_Sol,nl_MG,nl_LG,...
             nn_Sol,nn_MG,nn_LG,L_Sol,L_MG,L_LG,H_Sol,W_Sol,detF0_Sol,H_MG,W_MG,detF0_MG,H_LG,W_LG,detF0_LG,...
             ns_s,pn,Point_inter,Point_inter1);
for ii = 1:nx_Sol+nx_MG+nx_LG
    I_vec=zeros(nx_Sol+nx_MG+nx_LG,1);
    I_vec(ii)=1;  
    eeh=ee-h*I_vec; % positions for contact variations
    Fch=Fc_3363(eeh,xloc_Sol,xloc_MG,xloc_LG,nloc_Sol,nloc_MG,nloc_LG,nx_Sol,nx_MG,nx_LG,nl_Sol,nl_MG,nl_LG,...
             nn_Sol,nn_MG,nn_LG,L_Sol,L_MG,L_LG,H_Sol,W_Sol,detF0_Sol,H_MG,W_MG,detF0_MG,H_LG,W_LG,detF0_LG,...
             ns_s,pn,Point_inter,Point_inter1); 
    Kc(:,ii)=(Fc-Fch)/h;
end
%% All body assemblance       
KK=[             K_Sol   zeros(nx_Sol,nx_MG) zeros(nx_Sol,nx_LG); 
    zeros(nx_MG,nx_Sol)                K_MG   zeros(nx_MG,nx_LG);
    zeros(nx_LG,nx_Sol)   zeros(nx_LG,nx_MG)               K_LG];
K=KK+Kc;
ff=Fe-Fext+Fc;
ff=ff(:);

