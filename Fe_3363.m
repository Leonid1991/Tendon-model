function Fe = Fe_3363(ee,ee_pos,ElemDofs,Material,const,phik,Phik,L,H,W,detF0,pcirc,wcirc)
% Function: Integrate elastic forces using Gaussian quadratures
Fe=zeros(1,ElemDofs);
[xi,wxi] = gauleg2(-1,1,3);
for ii1=1:3
    for kk1=1:length(pcirc)       
            Fe_dV = FedV(ee,ee_pos,L,H,W,xi(ii1),pcirc(kk1,1),pcirc(kk1,2),Material,const,phik,Phik);
            Fe=Fe+Fe_dV*wxi(ii1)*wcirc(kk1);
    end
end
Fe=Fe*1/2*L*detF0;



