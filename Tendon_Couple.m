function  Fc_all=Tendon_Couple(Point_inter,Point_inter1,ns_s,pn,Subs_info,num1,num2)
    num3=6-(num1+num2); % subtendondon, which doesn't participate;
    Fc{num3}=zeros(Subs_info{num3}{10},1);  % its forces;
    ee_1=Subs_info{num1}{1}; nn_1=Subs_info{num1}{9}; Leng_1=ee_1(xlocANCF_3363(nn_1,1));
    ee_2=Subs_info{num2}{1}; nn_2=Subs_info{num2}{9}; Leng_2=ee_2(xlocANCF_3363(nn_2,1));
    if Leng_1<=Leng_2 % shorter is "master" (or Base)
       [Fc{num1},Fc{num2}]=Func_Fc3_old_new2(Subs_info{num1},Subs_info{num2},Point_inter{num1}{num2},Point_inter{num2}{num1},ns_s,pn);
    else
       [Fc{num2},Fc{num1}]=Func_Fc3_old_new2(Subs_info{num2},Subs_info{num1},Point_inter{num2}{num1},Point_inter{num1}{num2},ns_s,pn);
    end

    Fc_all=[Fc{1};Fc{2};Fc{3}];
    
    
   
    
    
    
    
    