function SS=Neo(F,const)
mu=const;
II=eye(3);
J=det(F);
CC=F'*F;
Cinv=CC^(-1);
%% Neo-Hookean(Weiss)
F_vol = J^(1/3)*II;
F_dash = F_vol^(-1)*F;
C_dash = F_dash'*F_dash;
W_C_dash = mu/2*II;
DEV1 = 0;
for i = 1:3
    for j = 1:3
        DEV1 = DEV1 + W_C_dash(i,j)*C_dash(j,i);
    end    
end
DEV2 = W_C_dash - (1/3)*DEV1*inv(C_dash);
SS =2/(10^(-10))*(J-1)*J*Cinv+2*J^(-2/3)*DEV2;