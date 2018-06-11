
%clearing the workspace
clear;
clc;

%Initialization of file names
compounddatabase='kegg_compound_list.mat';
compoundfile='C:\Users\Admin\Desktop\inputs\compound_list2.txt';
resultfile='C:\Users\Admin\Desktop\inputs\result.txt';
tempfile1='C:\Users\Admin\Desktop\inputs\compoundlist1.txt';
tempfile2='C:\Users\Admin\Desktop\inputs\exp.txt';
tempfile3='C:\Users\Admin\Desktop\inputs\exp1.txt';

disp('Extracting compound IDs from compound database...');
ff=waitbar(0,'Extracting compound IDs from compound database. Please wait...');
comp_name={};
%text files and databases to be given as input
load(compounddatabase);
% inputfile=fopen('C:\Users\Admin\Desktop\inputs\compound_list.txt','r');
% outputfile=fopen('C:\Users\Admin\Desktop\inputs\compoundlist1.txt','w');

inputfile=fopen(compoundfile,'r');
outputfile=fopen(tempfile1,'w');

line=fgets(inputfile);
%line
l=1;
while ischar(line)
    comp_name(l,1)=cellstr(line);
    l=l+1;
    score=[];
 [m,n]=size(Kegg_compound_database);
 for i=1:m
     for j=2:n
         if isempty(Kegg_compound_database{i,j})==0
             p=[];
         p=cell2mat(Kegg_compound_database(i,j));
%          x=strsplit(line,'\n');
%          x
         score(i,j-1)=strdist(line,p,1,1);
%          if j+1<n
%          
%          end
         else
             score(i,j-1)=1000;
         end
         max_score=1000;
         max_pos_x=0;
         max_pos_y=0;
     end
 end
 [m,n]=size(score);
 for i=1:m
     for j=1:n
         if max_score>score(i,j)
             max_score=score(i,j);
             max_pos_x=i;
             max_pos_y=j;
         end
     end
 end
 
 %size(line)
 %Kegg_compound_database(max_pos_x,max_pos_y+1)
 h=Kegg_compound_database(max_pos_x,1)
 fwrite(outputfile,cell2mat(h));
 fprintf(outputfile,'\n');
 %max_score
 %score(10,2)
 line='';
 line=fgets(inputfile);
 %line
end
fclose(inputfile);
fclose(outputfile);
close(ff);
disp('Extraction of compound ID completed!');
run('H:\rishika\MATLAB\graph\URLdownload.m')
run('H:\rishika\MATLAB\graph\finalrdm.m')