%% Subtendon (Sol, Type 3)
curve1=scale*[330 167
        317 212
        308 262
        316 311
        327 352];
curve2=scale*[607 130
        474 150
        330 167];
curve3=scale*[327 352
        444 339
        529 308
        594 260
        626 184
        623 158
        607 130];    
% collect all original data
curve1=flipud(curve1);
curve2=flipud(curve2);
curve3=flipud(curve3);
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
%% all point in conter clockwise 
curve1a=[change(curve1(:,1),min_x,max_x) change(curve1(:,2),min_y,max_y)];
curve2a=[change(curve2(:,1),min_x,max_x) change(curve2(:,2),min_y,max_y)];
curve3a=[change(curve3(:,1),min_x,max_x) change(curve3(:,2),min_y,max_y)];
data_2=[curve1a;curve2a;curve3a];
data={curve1a,curve2a,curve3a};
nu=max(size(data));
% figure();
% for j=1:length(data_2) 
%         xx=data_2(j,1);
%         yy=data_2(j,2);
%         plot(xx,yy,'.k')
%         hold on
%         text(xx,yy,num2str(j),'Color','k')
%  end