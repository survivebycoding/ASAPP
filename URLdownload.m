clearvars -except comp_name tempfile1 tempfile2 tempfile3 resultfile;
clc;

% fileID = fopen('C:\Users\Admin\Desktop\inputs\exp1.txt','w');
% fclose(fileID);
% prefix='http://www.genome.jp/dbget-bin/www_bget?-f+k+compound+';
% prefix1='http://www.genome.jp/dbget-bin/www_bget?';
% inputfile=fopen('C:\Users\Admin\Desktop\inputs\compoundlist1.txt','r');

disp('Extracting bonds and atoms from KEGG...');
ff = waitbar(0,'Extracting bonds and atoms from KEGG. Please wait...');
fileID = fopen(tempfile3,'w');
fclose(fileID);
prefix='https://www.genome.jp/dbget-bin/www_bget?-f+k+compound+';
prefix1='https://www.genome.jp/dbget-bin/www_bget?';
inputfile=fopen(tempfile1,'r');

line=fgets(inputfile);
l=1;
cc=1;
nn=1;

while ischar(line)
    line
    
fullURL=strcat(prefix,line);
fullURL1=strcat(prefix1,line);
fullURL
str = urlread(fullURL);

%if K is number then found, if K null then string not found
fileID = fopen(tempfile2,'w');
fprintf(fileID,str);
fclose(fileID);
fid=fopen(tempfile2);
line1=fgets(fid);
h=1;
i=1;
flag=0;


while ischar(line1)
       x1=strfind(line1,'ENTRY');
       x2=strfind(line1,'ATOM');
       x3=strfind(line1,'BOND');
       x4=strfind(line1,'/');
       x5=strfind(line1,'BRACKET');
       
    if isempty(x3)==0
        flag=1;
    end
    if isempty(x5)==0
        break
    end
    if isempty(x1)==1 & isempty(x2)==1 & isempty(x3)==1 & isempty(x4)==1 & flag==0 
        %disp('hell')
        C=strsplit(line1);
        vertexnumber(h,1)=C(2);
        vertexnumber(h,2)=C(4);
        h=h+1;
    end
    if isempty(x1)==1 & isempty(x2)==1 & isempty(x3)==1 & isempty(x4)==1 & flag==1
        %disp('hell')
        C=strsplit(line1);
        edgenumber(i,1)=C(3);
        edgenumber(i,2)=C(4);
        i=i+1;
    end
       
    
    line1=fgets(fid);
end
m=length(vertexnumber);
n=length(edgenumber);
for i=1:n
    edgelabel(i,1)=vertexnumber(str2double(cell2mat(edgenumber(i,1))),2);
    edgelabel(i,2)=vertexnumber(str2double(cell2mat(edgenumber(i,2))),2);
end
% if any('R',edgelabel)==1
% 
%     break;
% end
fclose(fid);
s=blanks(2);
linex='';
liney='';
fileID = fopen(tempfile3,'at');
for i=1:n
linex=strcat(linex,cell2mat(edgenumber(i,1)));
linex=strcat(linex,{' '});
linex=strcat(linex,cell2mat(edgenumber(i,2)));
linex=strcat(linex,{' ; '});
liney=strcat(liney,cell2mat(edgelabel(i,1)));
liney=strcat(liney,{' '});
liney=strcat(liney,cell2mat(edgelabel(i,2)));
liney=strcat(liney,{' ; '});


end

str1 = urlread(fullURL1);
fileID1 = fopen(tempfile2,'w');
fwrite(fileID1,str1);
fclose(fileID1);
fileID1 = fopen(tempfile2,'r');
line=fgets(fileID1);
while ischar(line)
    fg=0;
if strfind(line,'Exact mass')
    %disp('entered');
    %line='';
    line=fgets(fileID1);
    %line
  % C= strsplit(line,'<');
   C= strsplit(line,'>');
   p=cell2mat(C(1,3));
   x=length(p);
   %x
   f='';
   for i=1:x-3
       f=strcat(f,p(1,i));
   end
   %f
   break;
else
    fg=1;
    
end

line=fgets(fileID1);
end
fclose(fileID1);
x5=strfind(cell2mat(liney),'R');
       if isempty(x5)==0
           l;
           
       end
       l=l+1;
 if isempty(x5)==1      
fprintf(fileID,char(linex));
fprintf(fileID,'\n');
fprintf(fileID,char(liney));
fprintf(fileID,'\n');
fprintf(fileID,f);
fprintf(fileID,'\n');
 end
fclose(fileID);
% linex
% liney
%initializing the cells 
edgenumber=cell(1,1);
vertexnumber=cell(1,1);
line=fgets(inputfile);
if fg==1
    ss=strcat('compound',comp_name(cc), 'has no molecular weight');
    %disp(ss);
    %disp(cc)
    change(nn,1)=cc;
    nn=nn+1;
end
cc=cc+1;
end
fclose(inputfile);
disp('Extraction of bonds and atoms from KEGG completed!');
close(ff);