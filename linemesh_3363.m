function [P,nloc,phim,Phim] = linemesh_3363(n,L,phi,Phi,ro,phi_init,cen_ten)
% generate nodal coordinates in xy-plane 
nodes=n*3-(n-1); % number of nodes
if phi ~= 0
    phik=geospace(0,phi,nodes,1)'; % outer twist
else
    phik=zeros(1,nodes)';
end
if Phi ~= 0
    Phik=geospace(0,Phi,nodes,1)'; % inner twist
else
    Phik=zeros(1,nodes)';
end
phim=[];
Phim=[];
for k = 1:n
    phim=[phim; phik(((k-1)*2+1)) phik(((k-1)*2+2)) phik(((k-1)*2+3))];
    Phim=[Phim; Phik(((k-1)*2+1)) Phik(((k-1)*2+2)) Phik(((k-1)*2+3))];
end

xk=geospace(0,L,nodes,1)';
yk=cen_ten(1)+ro*cosd(phik+phi_init);
zk=cen_ten(2)+ro*sind(phik+phi_init);
dr1dy=[0 1 0]';
dr1dz=[0 0 1]';
nullmat1 = zeros(nodes,3*3);
dr1dy_mat= zeros(nodes,3);
dr1dz_mat= zeros(nodes,3);
for i=1:nodes
    % form a rotation matrix around x axís
    A = [1 0 0;
         0 cosd(phik(i)) -sind(phik(i));
         0 sind(phik(i))  cosd(phik(i))];
    % counterclockwise rotation 
    dr1dyk=A*dr1dy;
    dr1dzk=A*dr1dz;
    dr1dy_mat(i,:)=dr1dyk.';
    dr1dz_mat(i,:)=dr1dzk.';
end    
P = [];
Pk = [xk yk zk dr1dy_mat dr1dz_mat nullmat1];
P = [P; Pk];
% generate elememnt connectivity
nloc = [];
for k = 1:n
    loc = [(k-1)*2+1 (k-1)*2+2 (k-1)*2+3];
    nloc = [nloc; loc];
end
