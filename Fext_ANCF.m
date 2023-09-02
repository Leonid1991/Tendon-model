function Fext=Fext_ANCF(nn,nx,Fx,Fy,Fz)
% Define vector of external forces
Fext = zeros(nx,1);
Fext(xlocANCF_3363(nn,1)) = Fx;
Fext(xlocANCF_3363(nn,2)) = Fy;
Fext(xlocANCF_3363(nn,3)) = Fz;   

