% Define vector of linear constraints
bc_Sol = logical(ones(1,nx_Sol));
bc_MG = logical(ones(1,nx_MG));
bc_LG = logical(ones(1,nx_LG));
if BC==1 % for analytic solutions
    bcInd=xlocANCF_3363(1,[1:3,4,6,7,8]);
    BC_c='red';
else % for ANSYS (but many elements required)
    bcInd=xlocANCF_3363(1,1:18);
    BC_c='full';
end
% number of degrees of freedom of system after linear constraints
if bcInd~=0
    bc_Sol(bcInd)=0;  
    bc_MG(bcInd)=0;
    bc_LG(bcInd)=0;
end
bc=[bc_Sol bc_MG bc_LG];
%bc=bc_Sol;
% Number of unconstrained DOFs
ndof_Sol = sum(bc_Sol);     
ndof_MG = sum(bc_MG);
ndof_LG = sum(bc_LG);
ndof = ndof_Sol + ndof_MG + ndof_LG;% Number of unconstrained DOFs   

     