function loc = xlocANCF_3363(nodes,comps)
% make location vector in x from nodelist and componentlist

loc = [];
for n=1:length(nodes)
  nn = nodes(n);
  loc = [loc 18*(nn-1)+comps];
end
  