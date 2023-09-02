function SS=GOH(F,const,a)
c10 = const(1);
k1 = const(2);
k2 = const(3);
kappa = const(4);

II=eye(3);
J=det(F);
J_inv=J^(-1);
%The Cayley–Hamilton decomposition
trF=trace(F);
F2=F^2;
Finv=J_inv*(0.5*(trF^2-trace(F2))*II-F*trF+F2);
% Cauchy-Green deformation tensor
CC=F'*F;
Cinv=Finv*Finv';
F_dash = J_inv^(1/3)*II*F;
% Cauchy-Green deformation tensor
C_dash = F_dash'*F_dash;
A = zeros(3);
for ii = 1:3 
    for jj = 1:3
        A(ii,jj)=a(ii)*a(jj);
    end
end
I1=trace(C_dash);
I4 = 0;
for k = 1:3
    for l = 1:3
        I4 = I4+C_dash(k,l)*A(l,k);
    end
end
%4order tensor P
for i = 1:3 
    for j = 1:3
        for k = 1:3
            for l = 1:3
                P(i,j,k,l) = (delt(i,k)*delt(j,l)+delt(i,l)*delt(j,k))*1/2-1/3*Cinv(i,j)*CC(k,l);
            end
        end
    end
end
PSI_1 = c10+k1*kappa*exp(k2*(I4*(3*kappa - 1) - I1*kappa + 1)^2)*(-1)*(I4*(3*kappa - 1) - I1*kappa + 1);
PSI_4 = k1*exp(k2*(I4*(3*kappa - 1) - I1*kappa + 1)^2)*(3*kappa - 1)*(I4*(3*kappa - 1) - I1*kappa + 1);
SS1 = zeros(3,3);
for i = 1:3
    for j = 1:3
        for k = 1:3
            for l = 1:3
                SS1(i,j) = SS1(i,j) + J^(-2/3)*P(i,j,k,l)*2*(PSI_1*II(l,k)+PSI_4*A(l,k));
            end
        end
    end
end
SS = SS1 + 2*J*10^(8)*(J - 1)*Cinv; % for straight 