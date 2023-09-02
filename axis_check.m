clc, clear, close all;
step=100;
L=10;Phi=360;
y_c=5;z_c=5;
nx=0:L/step:L;
phi=0:Phi/step:Phi;
ro=sqrt(y_c^2+z_c^2); % distance to the axis
ny=y_c+ro*cosd(phi);
nz=z_c+ro*sind(phi);
plot3(nx,ny,nz)



%% after implemnetation
point1=P01(:,1:3);
point2=P02(:,1:3);
point3=P03(:,1:3);
plot3(point1(:,1),point1(:,2),point1(:,3),'--k')
hold on
plot3(point2(:,1),point2(:,2),point2(:,3),'--g')
plot3(point3(:,1),point3(:,2),point3(:,3),'--b')