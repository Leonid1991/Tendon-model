% Creates mesh for an intially straight beam structure
[P0_Sol,nloc_Sol,phim_Sol,Phim_Sol] = linemesh_3363(n_Sol,L,phi,Phi_Sol,ro_Sol,phi_add_Sol,cen_ten); 
[P0_MG,nloc_MG,phim_MG,Phim_MG] = linemesh_3363(n_MG,L,phi,Phi_MG,ro_MG,phi_add_MG,cen_ten);
[P0_LG,nloc_LG,phim_LG,Phim_LG] = linemesh_3363(n_LG,L,phi,Phi_LG,ro_LG,phi_add_LG,cen_ten);    
xloc_Sol=xlocAllANCF_3363(nloc_Sol);
xloc_MG=xlocAllANCF_3363(nloc_MG);
xloc_LG=xlocAllANCF_3363(nloc_LG);
% get number of nodes (nn), number of elements (nl) and total number of DOFs (nx)
[nn_Sol,~] = size(P0_Sol);
[nl_Sol,~] = size(nloc_Sol);
[nn_MG,~] = size(P0_MG);
[nl_MG,~] = size(nloc_MG);
[nn_LG,~] = size(P0_LG);
[nl_LG,~] = size(nloc_LG);
% dofs (no constraints) 
nx_Sol= DofsAtNode*nn_Sol;
nx_MG = DofsAtNode*nn_MG;
nx_LG = DofsAtNode*nn_LG;
% draw system
u0 = zeros(nx_Sol+nx_MG+nx_LG,1);
uu = u0;
% create global vector of nodal coordinates
for jj=1:nn_Sol
    ee_Sol((jj-1)*DofsAtNode+1:(jj-1)*DofsAtNode+DofsAtNode)=P0_Sol(jj,:); 
end
for jj=1:nn_MG
    ee_MG((jj-1)*DofsAtNode+1:(jj-1)*DofsAtNode+DofsAtNode)=P0_MG(jj,:); 
end  
for jj=1:nn_LG
    ee_LG((jj-1)*DofsAtNode+1:(jj-1)*DofsAtNode+DofsAtNode)=P0_LG(jj,:); 
end  
% Define initial position
ee_Sol=ee_Sol(:);
ee_MG=ee_MG(:);
ee_LG=ee_LG(:);
ee0=[ee_Sol;ee_MG;ee_LG];
ee=ee0;