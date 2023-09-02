function [Fe,K]=Fe_Elastic(Data)
h=Data{18};
% Reviving data
ElemDofs=Data{1}; Material=Data{2}; const=Data{3}; 
L=Data{4}; H=Data{5}; W=Data{6}; detF0=Data{7};
pcirc=Data{8}; wcirc=Data{9}; phim=Data{10}; Phim=Data{11};
nx=Data{12}; nl=Data{13};  nn=Data{14}; 
ee=Data{15}; ee0=Data{16}; xloc=Data{17};
% creation of required functions
Fe=zeros(nx,1); % Forces  
K=zeros(nx,nx); % Stiffness matrix
for k = 1:nl
    K_pp = zeros(ElemDofs,ElemDofs);
    eek=ee(xloc(k,:)); 
    eek0=ee0(xloc(k,:)); 
    eek_pos=eek0([1:3,19:21,37:39]);
    phik=phim(k,:);
    Phik=Phim(k,:);
    FeE=Fe_3363(eek,eek_pos,ElemDofs,Material,const,phik,Phik,L,H,W,detF0,pcirc,wcirc)';
    Fe(xloc(k,:))=Fe(xloc(k,:))+FeE;       
    for jj = 1:ElemDofs
        I_vec=zeros(ElemDofs,1);
        I_vec(jj)=1;
        eekh=eek-h*I_vec;
        FeEh=Fe_3363(eekh,eek_pos,ElemDofs,Material,const,phik,Phik,L,H,W,detF0,pcirc,wcirc)'; 
        K_pp(:,jj)=(FeE-FeEh)/h; 
    end
    for jj = 1:ElemDofs
    	ind01 = xloc(k,jj); %Index 01
        for kk = 1:ElemDofs
            ind02 = xloc(k,kk); % Index 02
            K(ind01,ind02) = K(ind01,ind02)+K_pp(jj,kk);
        end
    end %End of Assembly pp
end


