clc,clear,close all
format long
phi=30; % outer twist
% ########### Material model ############################################
Material=1; % Materials. There are Neo-Hookean (1), GOH (0)
Element=3363;
%########## Reads element's data ###############################
ElementData;
%########## Postprocessor parameters ###############################
Fig_points=0;
Fig_cs=0;
Vis_proc_full=0;
Penet=1;
para=0;
% Element numbers
n_Sol=2; %4
n_MG=2;  %2
n_LG=2;  %1
%######### Choose the area ################################
Approximation=1; % 0 - standart, 1 and higher - via Green's formula (n is number of appr.) % for tendon the best solution is n=1
%########## Reads problem's data ################################
ProblemData;
%% ########### Start the program ###########################
%########## Creates finite element mesh for a simple beam-type structure #############  
CreateFEMesh; 
%########## Creates boundary conditions bc #############  
CreateBC;                      
titertot=0;   
%START NEWTON'S METHOD   
for i=1:steps
    F_Sol_ap=F_Sol(i,:);
    F_MG_ap=F_MG(i,:);
    F_LG_ap=F_LG(i,:);
    % Parameters for Newton's iteration          
    Re=10^(-4);         % Stopping criterion for residual
    imax=20; % Maximum number of iterations for Newton's method 
    for ii=1:imax    
        tic;
        [K,ff,Fext] = Kt(ee,ee0,F_Sol_ap,F_MG_ap,F_LG_ap,xloc_Sol,xloc_MG,xloc_LG,nloc_Sol,nloc_MG,nloc_LG,...
                          nx_Sol,nx_MG,nx_LG,nl_Sol,nl_MG,nl_LG,nn_Sol,nn_MG,nn_LG,L_Sol,L_MG,L_LG,...
                          Material,const_Sol,const_MG,const_LG,...
                          phim_Sol,Phim_Sol,phim_MG,Phim_MG,phim_LG,Phim_LG,...
                          H_Sol,W_Sol,detF0_Sol,pcirc_Sol,wcirc_Sol,...
                          H_MG,W_MG,detF0_MG,pcirc_MG,wcirc_MG,...
                          H_LG,W_LG,detF0_LG,pcirc_LG,wcirc_LG,...
                          ns_s,pn,ElemDofs,Point_inter,Point_inter1); 
        %Eliminate linear constraints
        Kc = K(bc,bc); 
        ffc=ff(bc);         
        deltaf=ffc/norm(Fext(bc));       % compute residual
        uuc=-inv(Kc)*ffc;      % good for calculation, but stress presentation suffers         
        uu(bc) = uu(bc)+uuc;    % add displacement to initial condition
        ee(bc) = ee(bc)+uuc;            
        titer=toc;
        titertot=titertot+titer;   
        if abs(deltaf)<Re*ones(ndof,1)
            disp(['Solution is found by ' num2str(ii) ' iterations. Total CPU-time: ' num2str(titertot)])
            break
        elseif ii==imax 
            disp(['The solution is not found. The maximum number of iterations is reached. Total CPU-time: ' num2str(titertot)])
            break
        else     
            disp(['wait... Iteration ' num2str(ii) ' on step ' num2str(i)])
        end
    end
    %Pick nodal displacements from result vector
    [ux1, uy1, uz1]=Displ(uu,nn_Sol);
    [ux2, uy2, uz2]=Displ(uu,nn_Sol+nn_MG);
    [ux3, uy3, uz3]=Displ(uu,nn_Sol+nn_MG+nn_LG);
    Case1 = [Case1;ux1 uy1 uz1 ux2 uy2 uz2 ux3 uy3 uz3];
end
% POST PROCESSING ###############################################
PostProcessing;
