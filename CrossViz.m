% cross-section visualization    
xi_line=[-1,-0.5,0,0.5,1];
    ee_Sol=ee(1:nx_Sol);                
    for ii=1:nl_Sol
         ee_Sol_n=ee_Sol(xloc_Sol(ii,:));
         for jj=1:length(xi_line)
            R_Sol_fig=zeros(3,length(Xi_Sol)+1);
            for kk=1:length(Xi_Sol(:,2))
                 R_Sol_fig(:,kk)= N_3363_axes(L_Sol,H_Sol,W_Sol,xi_line(jj),Xi_Sol(kk,1),Xi_Sol(kk,2))*ee_Sol_n; 
            end
            R_Sol_fig(:,end)=R_Sol_fig(:,1);
            cs_Sol{ii,jj}=R_Sol_fig;
         end  
    end
    ee_MG=ee(nx_Sol+1:nx_Sol+nx_MG);
    for ii=1:nl_MG
        ee_MG_n=ee_MG(xloc_MG(ii,:));
        for jj=1:length(xi_line)
            R_MG_fig=zeros(3,length(Xi_MG)+1);
            for kk=1:length(Xi_MG(:,2))
                R_MG_fig(:,kk)=N_3363_axes(L_MG,H_MG,W_MG,xi_line(jj),Xi_MG(kk,1),Xi_MG(kk,2))*ee_MG_n; 
            end
            R_MG_fig(:,end)=R_MG_fig(:,1);
            cs_MG{ii,jj}=R_MG_fig;
        end    
    end
    ee_LG=ee(nx_Sol+nx_MG+1:nx_Sol+nx_MG+nx_LG);
    for ii=1:nl_LG
        ee_LG_n=ee_LG(xloc_LG(ii,:));
        for jj=1:length(xi_line)
            R_LG_fig=zeros(3,length(Xi_LG)+1);
            for kk=1:length(Xi_LG(:,2))
                R_LG_fig(:,kk)=N_3363_axes(L_LG,H_LG,W_LG,xi_line(jj),Xi_LG(kk,1),Xi_LG(kk,2))*ee_LG_n; 
            end
            R_LG_fig(:,end)=R_LG_fig(:,1);
            cs_LG{ii,jj}=R_LG_fig;
        end    
    end
    
    figure();
    for ii=1:nl_Sol
        for jj=1:length(xi_line)
            plot3(cs_Sol{ii,jj}(1,:),cs_Sol{ii,jj}(2,:),cs_Sol{ii,jj}(3,:),'--r')
            hold on
        end
    end
    for ii=1:nl_MG
        for jj=1:length(xi_line)
            plot3(cs_MG{ii,jj}(1,:),cs_MG{ii,jj}(2,:),cs_MG{ii,jj}(3,:),'--g')
            hold on
        end
    end
    for ii=1:nl_LG
        for jj=1:length(xi_line)
            plot3(cs_LG{ii,jj}(1,:),cs_LG{ii,jj}(2,:),cs_LG{ii,jj}(3,:),'--b')
            hold on
        end
    end