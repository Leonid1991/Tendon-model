%% Subtendon (LG, Type 3) 
curve1=scale*[26 130
        187 157
        330 167
        474 150
        607 130];
curve2=scale*[607 130
        563 80
        488 43
        394 20
        316 14
        232 22
        153 42
        76 80
        26 130];
% collect all original data
curve1=flipud(curve1);
curve2=flipud(curve2);
data_1=[curve1;curve2]; 
max_x=max(data_1(:,1));
min_x=min(data_1(:,1));
max_y=max(data_1(:,2));
min_y=min(data_1(:,2));
% figure();
% for j=1:length(data_1) 
%         xx=data_1(j,1);
%         yy=data_1(j,2);
%         plot(xx,yy,'.k')
%         hold on
%         text(xx,yy,num2str(j),'Color','k')
%  end
%% Such as all point in conter clockwise 
curve1a=[change(curve1(:,1),min_x,max_x) change(curve1(:,2),min_y,max_y)];
curve2a=[change(curve2(:,1),min_x,max_x) change(curve2(:,2),min_y,max_y)];
data_2=[curve1a;curve2a];
data={curve1a,curve2a};
nu=max(size(data));
% figure();
% for j=1:length(data_2) 
%         xx=data_2(j,1);
%         yy=data_2(j,2);
%         plot(xx,yy,'.k')
%         hold on
%         text(xx,yy,num2str(j),'Color','k')
%  end