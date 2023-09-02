%% Subtendon (MG, Type 3)     
curve1=scale*[330 167
        317 212
        308 262
        316 311
        327 352];
curve2=scale*[327 352
        233 347
        128 317
        40 257
        8 187
        13 156
        26 130];
curve3=scale*[26 130
        187 157
        330 167];    
% collect all original data
data_1=[curve1;curve2;curve3]; 
% figure();
% for j=1:length(data_1) 
%         xx=data_1(j,1);
%         yy=data_1(j,2);
%         plot(xx,yy,'.k')
%         hold on
%         text(xx,yy,num2str(j),'Color','k')
%  end
max_x=max(data_1(:,1));
min_x=min(data_1(:,1));
max_y=max(data_1(:,2));
min_y=min(data_1(:,2));
%% Such as all point in conter clockwise 
curve1a=[change(curve1(:,1),min_x,max_x) change(curve1(:,2),min_y,max_y)];
curve2a=[change(curve2(:,1),min_x,max_x) change(curve2(:,2),min_y,max_y)];
curve3a=[change(curve3(:,1),min_x,max_x) change(curve3(:,2),min_y,max_y)];
data_2=[curve1a;curve2a;curve3a];
data={curve1a,curve2a,curve3a};
nu=max(size(data));

