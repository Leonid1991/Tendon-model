function [eta_2,zeta_2]=Contact_pair_2(Points_in_xi,r_1,ee_2,xi_2,L_2,H_2,W_2) 
    num_xi_point2=length(Points_in_xi(:,1));
    r_2_edge=zeros(3,num_xi_point2); % form the edge 
    for ji=1:num_xi_point2
        eta_ed=Points_in_xi(ji,1);
        zeta_ed=Points_in_xi(ji,2);
        r_2_edge(:,ji)=N_3363_axes(L_2,H_2,W_2,xi_2,eta_ed,zeta_ed)*ee_2;
    end
    % creation of the edge line and calculation of distances
    if num_xi_point2>3
        type_app='spline';
    else
        type_app='pchip';
    end
    [r_2,~,~] = distance2curve(r_2_edge(2:3,:)',r_1(2:3)',type_app);
   
    %finding eta
    r_2_eta1=N_3363_axes(L_2,H_2,W_2,xi_2,-1,0)*ee_2;
    r_2_eta2=N_3363_axes(L_2,H_2,W_2,xi_2, 1,0)*ee_2;
    r_2_eta_line=[r_2_eta1(2:3)';r_2_eta2(2:3)'];
    [r_zeta0,~,~] = distance2curve(r_2_eta_line,r_2,'linear');
    l1=norm(r_zeta0-r_2_eta1(2:3)');
    l2=norm(r_2_eta1(2:3)'-r_2_eta2(2:3)');
    eta_2=-1+2*(l1/l2);
             
    %finding zeta
    r_2_zeta1=N_3363_axes(L_2,H_2,W_2,xi_2,0,-1)*ee_2;
    r_2_zeta2=N_3363_axes(L_2,H_2,W_2,xi_2,0, 1)*ee_2;
    r_2_zeta_line=[r_2_zeta1(2:3)';r_2_zeta2(2:3)'];
    [r_eta0,~,~] = distance2curve(r_2_zeta_line,r_2,'linear');
    l1=norm(r_eta0-r_2_zeta1(2:3)');
    l2=norm(r_2_zeta1(2:3)'-r_2_zeta2(2:3)');
    zeta_2=-1+2*(l1/l2);

    