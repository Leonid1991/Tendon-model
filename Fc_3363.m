function Fc=Fc_3363(ee,xloc_Sol,xloc_MG,xloc_LG,nloc_Sol,nloc_MG,nloc_LG,nx_Sol,nx_MG,nx_LG,nl_Sol,nl_MG,nl_LG,...
             nn_Sol,nn_MG,nn_LG,L_Sol,L_MG,L_LG,H_Sol,W_Sol,detF0_Sol,H_MG,W_MG,detF0_MG,H_LG,W_LG,detF0_LG,...
             ns_s,pn,Point_inter,Point_inter1)
% Splitting all information (Sol - 1, MG - 2, LG - 3)
ee_Sol=ee(1:nx_Sol);             
ee_MG=ee(nx_Sol+1:nx_Sol+nx_MG);
ee_LG=ee(nx_Sol+nx_MG+1:end);
Subs_info{1}={ee_Sol,L_Sol,H_Sol,W_Sol,detF0_Sol,nloc_Sol,xloc_Sol,nl_Sol,nn_Sol,nx_Sol}; % 10 components
Subs_info{2}={ ee_MG, L_MG, H_MG, W_MG, detF0_MG, nloc_MG, xloc_MG, nl_MG, nn_MG, nx_MG};
Subs_info{3}={ ee_LG, L_LG, H_LG, W_LG, detF0_LG, nloc_LG, xloc_LG, nl_LG, nn_LG, nx_LG};
%% part 1
Fc1=Tendon_Couple(Point_inter,Point_inter1,ns_s,pn,Subs_info,1,2);
%% part 2
Fc2=Tendon_Couple(Point_inter,Point_inter1,ns_s,pn,Subs_info,2,3);
%% part 3
Fc3=Tendon_Couple(Point_inter,Point_inter1,ns_s,pn,Subs_info,3,1);
Fc=Fc1+Fc2+Fc3;
