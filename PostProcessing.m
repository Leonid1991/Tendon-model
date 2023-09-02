% Postprocessing
fprintf('Nonlinear static test for '+string(Element)+' outer angle '+string(phi)+' inner angle '+'\n')
fprintf('ux & uy & uz & ux & uy & uz  & ux & uy & uz \n')
for k=1:size(Case1,1) 
  fprintf('%10.6f & %10.6f & %10.6f & %10.6f & %10.6f & %10.6f& %10.6f & %10.6f & %10.6f \n',Case1(k,1:9))
end
if Vis_proc_full~=0
   CrossViz;
end 
if Penet~=0
   PenViz;
end 
if para~=0
   ee_Sol= ee(1:nx_Sol);
   ee0_Sol=ee0(1:nx_Sol);
   ee_MG=ee(nx_Sol+1:nx_Sol+nx_MG);
   ee0_MG=ee0(nx_Sol+1:nx_Sol+nx_MG);
   ee_LG=ee(nx_Sol+nx_MG+1:end);
   ee0_LG=ee0(nx_Sol+nx_MG+1:end);
   Para_Gen(L,phi,Phim_Sol,Material,const_Sol,ee_Sol,ee0_Sol,phim_Sol,xloc_Sol,n_Sol,1)
   Para_Gen(L,phi,Phim_MG,Material,const_MG,ee_MG,ee0_MG,phim_MG,xloc_MG,n_MG,2)
   Para_Gen(L,phi,Phim_LG,Material,const_LG,ee_LG,ee0_LG,phim_LG,xloc_LG,n_LG,3)
end  
