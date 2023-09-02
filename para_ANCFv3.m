%number of column (components)  
ND=3;  %number of column of NODES.
NS=8;  %number of column of ELEM
NN3=Nodes_r;    % deformed shape
%NN3=COORD;    % undeformed shape
%NN1=displacement;
NN21=ELIST; 
[Ncell2,~]=size(ELIST);
%NN2=stress;
%% Cell type
Type=12; %For 8-node solid185 in ANSYS 
fid1=fopen(sprintf(TenName+string(nl)+'_twist'+string(abs(phi))+MatName+'.vtu'),'w'); % write the VTK file
%fid1=fopen(sprintf(MatName+string(Element)+Form+'_El'+string(n)+'_twist'+string(phi)+BC_c+Apr+'.vtu'),'w'); % write the VTK file
fprintf(fid1,' <VTKFile type="UnstructuredGrid" version ="1.0"> \n'); %choose the file Type
fprintf(fid1,'\t <UnstructuredGrid>\n');
fprintf(fid1,'\t\t <Piece NumberOfPoints =" %i " NumberOfCells =" %i ">\n',Nnode, Ncell2); % determime the number 
% of nodes and elements
fprintf(fid1,'\t\t\t <PointData>\n'); % start Data point 
%% Displacements
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="disp_x" NumberOfComponents ="1" format = "ascii"/>\n');  
% loop for writing the displacements 
for i=1:Nnode
    fprintf(fid1,'\t\t');
    fprintf (fid1,'%.10E ',disp_x(i));
    fprintf (fid1,'\n');
end
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="disp_y" NumberOfComponents ="1" format = "ascii"/>\n');  
% loop for writing the displacements 
for i=1:Nnode
    fprintf(fid1,'\t\t');
    fprintf (fid1,'%.10E ' ,disp_y(i));
    fprintf (fid1,'\n');
end
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="disp_z" NumberOfComponents ="1" format = "ascii"/>\n');  
% loop for writing the displacements 
for i=1:Nnode
    fprintf(fid1,'\t\t');
    fprintf (fid1,'%.10E ' ,disp_z(i));
    fprintf (fid1,'\n');
end
%% stress
% loop for writing the stresses 
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="stress_VM" NumberOfComponents ="1" format = "ascii"/>\n');
for i=1:Nnode
    fprintf(fid1,'\t\t');
    %fprintf (fid1, '%.10E \t %.10E \t %.10E \t %.10E \t %.10E \t %.10E'  ,NN2(i,:));
    fprintf (fid1, '%.10E'  ,stress_VM(i));
    fprintf (fid1, '\n');         
end
% loop for writing the stresses 
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="stress_x" NumberOfComponents ="1" format = "ascii"/>\n');
for i=1:Nnode
    fprintf(fid1,'\t\t');
    %fprintf (fid1, '%.10E \t %.10E \t %.10E \t %.10E \t %.10E \t %.10E'  ,NN2(i,:));
    fprintf (fid1, '%.10E'  ,stress_x(i));
    fprintf (fid1, '\n');         
end
% loop for writing the stresses 
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="stress_y" NumberOfComponents ="1" format = "ascii"/>\n');
for i=1:Nnode
    fprintf(fid1,'\t\t');
    %fprintf (fid1, '%.10E \t %.10E \t %.10E \t %.10E \t %.10E \t %.10E'  ,NN2(i,:));
    fprintf (fid1, '%.10E'  ,stress_y(i));
    fprintf (fid1, '\n');         
end
% loop for writing the stresses 
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="stress_z" NumberOfComponents ="1" format = "ascii"/>\n');
for i=1:Nnode
    fprintf(fid1,'\t\t');
    %fprintf (fid1, '%.10E \t %.10E \t %.10E \t %.10E \t %.10E \t %.10E'  ,NN2(i,:));
    fprintf (fid1, '%.10E'  ,stress_z(i));
    fprintf (fid1, '\n');         
end
% loop for writing the stresses 
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="stress_xy" NumberOfComponents ="1" format = "ascii"/>\n');
for i=1:Nnode
    fprintf(fid1,'\t\t');
    %fprintf (fid1, '%.10E \t %.10E \t %.10E \t %.10E \t %.10E \t %.10E'  ,NN2(i,:));
    fprintf (fid1, '%.10E'  ,stress_xy(i));
    fprintf (fid1, '\n');         
end
% loop for writing the stresses 
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="stress_xz" NumberOfComponents ="1" format = "ascii"/>\n');
for i=1:Nnode
    fprintf(fid1,'\t\t');
    %fprintf (fid1, '%.10E \t %.10E \t %.10E \t %.10E \t %.10E \t %.10E'  ,NN2(i,:));
    fprintf (fid1, '%.10E'  ,stress_xz(i));
    fprintf (fid1, '\n');         
end
% loop for writing the stresses 
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" Name="stress_yz" NumberOfComponents ="1" format = "ascii"/>\n');
for i=1:Nnode
    fprintf(fid1,'\t\t');
    %fprintf (fid1, '%.10E \t %.10E \t %.10E \t %.10E \t %.10E \t %.10E'  ,NN2(i,:));
    fprintf (fid1, '%.10E'  ,stress_yz(i));
    fprintf (fid1, '\n');         
end
%% Nodal coordinates
fprintf(fid1,'\t\t\t </PointData> \n'); 
fprintf(fid1,'\t\t\t <CellData> \n');
fprintf(fid1,'\t\t\t </CellData> \n');
fprintf(fid1,'\t\t\t <Points> \n');
fprintf(fid1,'\t\t\t\t <DataArray type ="Float64" NumberOfComponents ="3" format = "ascii"/>\n'); 
for i=1:Nnode
    fprintf(fid1,'\t\t');
    fprintf(fid1,'%.10E \t %.10E \t %.10E',NN3(i,:));
    fprintf(fid1,'\n');
end
fprintf(fid1,'\t\t\t </Points> \n');
fprintf(fid1,'\t\t\t <Cells> \n'); 
%% Connectivity    
fprintf(fid1,'\t\t\t\t <DataArray type="Int32" Name="connectivity" format="ascii"/> \n');
for i=1:1*Ncell2
    fprintf(fid1,'\t\t\t\t');
    for j=1:8
        fprintf (fid1,'%d \t %d \t %d \t %d \t %d \t %d \t %d \t %d',NN21(i,j)-1);
    end
    fprintf ( fid1,'\n');
end   
 %% Offsets
fprintf(fid1,'\t\t\t\t <DataArray type="Int32" Name="offsets" format="ascii" /> \n');
for i = 1:Ncell2
    fprintf(fid1,'\t\t\t\t');
    fprintf(fid1,num2str(i*8,'%d'));
    fprintf(fid1,'\n');
end
%% Element type
fprintf(fid1,'\t\t\t\t <DataArray type="Int32" Name="types" format="ascii" /> \n');
for ii = 1:Ncell2
    fprintf(fid1,num2str(Type,'%d'));
    fprintf(fid1,'\n');
end
fprintf(fid1,'\t\t\t </Cells> \n');
fprintf(fid1,'\t\t </Piece> \n');
fprintf(fid1,'\t </UnstructuredGrid> \n');
fprintf(fid1,' </VTKFile> \n');
fclose(fid1);

