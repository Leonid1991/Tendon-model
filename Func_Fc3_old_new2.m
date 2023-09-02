function [Fc_master,Fc_slave]=Func_Fc3_old_new2(Master,Slave,Points_master_slave,Points_slave_master,ns_s,pn)
eps=1e-11;
num_xi_point=length(Points_master_slave(:,1));
%% Splitting the data
% contact 
ns=ns_s{1};zzz=ns_s{2};ttt=ns_s{3};
% master beam
ee_m=Master{1}; L_m=Master{2}; H_m=Master{3}; W_m=Master{4}; detF0_m=Master{5};
nloc_m=Master{6}; xlock_m=Master{7};nl_m=Master{8};nn_m=Master{9};
nx_m=Master{10};
% slave beam
ee_s=Slave{1}; L_s=Slave{2}; H_s=Slave{3};W_s=Slave{4}; detF0_s=Slave{5};
nloc_s=Slave{6}; xlock_s=Slave{7}; nl_s=Slave{8};nn_s=Slave{9}; 
nx_s=Slave{10};
%% Creating of the force vectors
Fc_master=zeros(nx_m,1);
Fc_slave=zeros(nx_s,1);
%%  Array of Master points
xi_m_arr=zeros(nl_m,ns,num_xi_point);
xi_s_arr=zeros(2,nl_m,ns,num_xi_point);
for kk=1:nl_m  % loop over the master contact elements (other1 to base)
   ee_m_ii=ee_m(xlock_m(kk,:)); %% ee in current cycle
   for ii=1:ns
        xi_m=zzz(ii);
        xi_m_arr(kk,ii,1:num_xi_point)=xi_m;
        cbar=ee_m_ii(1)/2*(1-xi_m)+ee_m_ii(37)/2*(1+xi_m); %from  x=A/2*(1-xi)+B/2*(xi+1)            
        dtest1=zeros(nl_s,1);
        for j = 1:nl_s
            midnodes_s=nloc_s(j,2);
            c0=ee_s(xlocANCF_3363(midnodes_s,1)); % the middle node of each element of the slave subtendon
            dtest1(j)=norm(cbar-c0); % cbar is the x coordinate
        end     
        edetect1 = min(find(dtest1 == min(dtest1)));  % closest element of the slave subt.
        ee_s_ii=ee_s(xlock_s(edetect1,:)); % ee_s in current cycle
        xi_s_arr(1,kk,ii,1:num_xi_point)=edetect1;
        xi_s_arr(2,kk,ii,1:num_xi_point)=(2*cbar-(ee_s_ii(1)+ee_s_ii(37)))/(ee_s_ii(37)-ee_s_ii(1)); %from  x=A/2*(1-xi)+B/2*(xi+1)
    end    
end
  
for kk=1:nl_m
    ee_m_ii=ee_m(xlock_m(kk,:)); %% ee in current cycle
    for ii=1:ns
        for jj=1:num_xi_point
            % master point (initial position, initial such as back projection is required)
            xi_m_in=xi_m_arr(kk,ii,jj);
            eta_m_in=Points_master_slave(jj,1);
            zeta_m_in=Points_master_slave(jj,2);      
            r_m_in=N_3363_axes(L_m,H_m,W_m,xi_m_in,eta_m_in,zeta_m_in)*ee_m_ii;
            

            % slave point
            elem=xi_s_arr(1,kk,ii,jj);
            ee_s_ii=ee_s(xlock_s(elem,:)); %% ee in current cycle
            xi_s=xi_s_arr(2,kk,ii,jj);
            [eta_s,zeta_s]=Contact_pair_2(Points_slave_master,r_m_in,ee_s_ii,xi_s,L_s,H_s,W_s); 
            r_s=N_3363_axes(L_s,H_s,W_s,xi_s,eta_s,zeta_s)*ee_s_ii;
            
%             % back projection  
            cbar=r_s(1);   
            dtest1=zeros(nl_m,1);
            for j = 1:nl_m
                midnodes_m=nloc_m(j,2);
                c0=ee_m(xlocANCF_3363(midnodes_m,1)); % the middle node of each element of the slave subtendon
                dtest1(j)=norm(cbar-c0); % cbar is the x coordinate
            end     
            edetect1 = min(find(dtest1 == min(dtest1)));  % closest element of the slave subt.
            ee_m_ii=ee_m(xlock_m(edetect1,:)); % ee_s in current cycle
            xi_m=(2*cbar-(ee_m_ii(1)+ee_m_ii(37)))/(ee_m_ii(37)-ee_m_ii(1)); %from  x=A/2*(1-xi)+B/2*(xi+1)
            [eta_m,zeta_m]=Contact_pair_2(Points_master_slave,r_s,ee_m_ii,xi_m,L_m,H_m,W_m); 
            r_m=N_3363_axes(L_m,H_m,W_m,xi_m,eta_m,zeta_m)*ee_m_ii;
%              
            cen_s=N_3363_axes(L_s,H_s,W_s,xi_s,0,0)*ee_s_ii; % center of the slave beam
            cen_m=N_3363_axes(L_m,H_m,W_m,xi_m,0,0)*ee_m_ii; % center of the slave beam
            
            v_1 = cen_s -cen_m;
            v_2 = r_m - cen_m;
            Theta_m = atan2(norm(cross(v_1, v_2)), dot(v_1, v_2));
            
            v_1 = cen_m -cen_s;
            v_2 = r_s - cen_s;
            Theta_s = atan2(norm(cross(v_1, v_2)), dot(v_1, v_2));
            
            l_m=norm(r_m - cen_m);
            l_s=norm(r_s - cen_s);
            l_all=norm(cen_s - cen_m);
            %if abs(norm(cen_s - cen_m)-(norm(r_m - cen_m)*cos(Theta_m)+norm(r_s - cen_s)*cos(Theta_s)))<eps
            if abs(l_m*cos(Theta_m)+l_s*cos(Theta_s)-l_all)<eps
            %if l_m*cos(Theta_m)+l_s*cos(Theta_s)-l_all>eps
                f_N_s=0;
                f_N_m=0;
                nv_s=[0 0 0].';
                nv_m=[0 0 0].';
            else
                g_N=r_m-r_s;
                nv_m=(cen_m-cen_s)/norm(cen_m-cen_s);
                
                %nv_m=(r_m-cen_s)/norm(r_m-cen_s);
                %nv_m=(r_m-r_s)/norm(r_m-r_s);
                
                nv_s=nv_m;
                f_N_s=pn*g_N'*nv_s;
                f_N_m=pn*g_N'*nv_m;
                
            end
            D_N_m=N_3363_axes(L_m,H_m,W_m,xi_m,eta_m,zeta_m)'*nv_m; 
            D_N_s=N_3363_axes(L_s,H_s,W_s,xi_s,eta_s,zeta_s)'*nv_s;
            
            Fc_m_add= detF0_m*f_N_m*D_N_m*ttt(ii);
            Fc_s_add=-detF0_s*f_N_s*D_N_s*ttt(ii);
            Fc_master(xlock_m(kk,:)) = Fc_master(xlock_m(kk,:))+Fc_m_add;
            Fc_slave(xlock_s(elem,:))= Fc_slave(xlock_s(elem,:))+Fc_s_add; % we have to push the slave from penetration
        end
    end
end    





