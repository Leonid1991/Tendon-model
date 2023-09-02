function xlocAll= xlocAllANCF_3363(nloc)
% function xlocAllANCF makes full xloc for all elements 
% row - element, column - dof


[nl,m] = size(nloc);

xlocAll = zeros(nl,18*3);

for k = 1:nl
  n1 = [nloc(k,1)*18-17:1:nloc(k,1)*18];
  n2 = [nloc(k,2)*18-17:1:nloc(k,2)*18];
  n3 = [nloc(k,3)*18-17:1:nloc(k,3)*18];
  xlocAll(k,:) = [n1 n2 n3];
end