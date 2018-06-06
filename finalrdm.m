clearvars -except comp_name change tempfile1 tempfile2 tempfile3 resultfile;
clc;
disp('Processing ASAPP. Awaiting results...');
fid=fopen(tempfile3);
line1=fgets(fid);
line2=fgets(fid);
line3=fgets(fid);
n=1;
while ischar(line1)
    
    l1=length(line1);
    l2=length(line2);
    l3=length(line3);
    C1=strsplit(line1);
    C2=strsplit(line2);
    C3=strsplit(line3);
    
   x=length(C1);
   s=1;count=1;
   %line1
   for i=1:x-1
       if cell2mat(C1(i))==';'
           count=count+1;
           s=1;
       else
           f=cell2mat(C1(i));
           A1(count,s,n)=str2double(f);
           s=s+1;
       end
   end
   
   %line2
    x=length(C2);
   s=1;count=1;
   %line1
   for i=1:x-1
       if cell2mat(C2(i))==';'
           count=count+1;
           s=1;
       else
           %f=cell2mat(C1(i));
           B1(count,s,n)=C2(i);
           s=s+1;
       end
   end
   molwt(1,n)=str2double(cell2mat(C3));
    C(1,n)=count-1;
    %count
    line1=fgets(fid);
    line2=fgets(fid);
    line3=fgets(fid);
    n=n+1;
end
 nom=n-1;
 
 for i=1:n-1
     k1=max(A1(:,1,i));
      k2=max(A1(:,2,i));
      if k1>k1
          G(1,i)=k1;
      else
          G(1,i)=k2;
      end
 end
 
 
 
  count=0;
f=0;

%3 sized
for i=1:nom
f=0;
    for j=1:C(i)
     x=A1(j,1,i);
     y=A1(j,2,i);
     count=count+1;
     for k=j+1:C(i)
         x1=A1(k,1,i);
         y1=A1(k,2,i);
         
         if x==x1 || x==y1 || y==x1 || y==y1
         
             %AB AC
             if x==x1
                 f=f+1;
                 A1(f,3,i)=y1;
                 A1(f,4,i)=x;
                 A1(f,5,i)=y;
                 
                 B1(f,3,i)=B1(k,2,i);
                 B1(f,4,i)=B1(j,1,i);
                 B1(f,5,i)=B1(j,2,i);
             end
             
             %AB CA
             if x==y1
                 f=f+1;
                 A1(f,3,i)=x1;
                 A1(f,4,i)=y1;
                 A1(f,5,i)=y;
                 
                 B1(f,3,i)=B1(k,1,i);
                 B1(f,4,i)=B1(k,2,i);
                 B1(f,5,i)=B1(j,2,i);
             end
             
             %AB BC
             if y==x1
              f=f+1;
                 A1(f,3,i)=x;
                 A1(f,4,i)=y;
                 A1(f,5,i)=y1;
                 
                 B1(f,3,i)=B1(j,1,i);
                 B1(f,4,i)=B1(j,2,i);
                 B1(f,5,i)=B1(k,2,i);
             end
             
             %AB CB
             if y==y1
                 f=f+1;
                 A1(f,3,i)=x;
                 A1(f,4,i)=y;
                 A1(f,5,i)=x1;
                 
                 B1(f,3,i)=B1(j,1,i);
                 B1(f,4,i)=B1(j,2,i);
                 B1(f,5,i)=B1(k,1,i);
             end
             
         end
     end
    end
    V1(i)=f;
end

%5 sized fragments
%count
for i=1:nom
f=0;
    for j=1:V1(i)-1
     x=A1(j,3,i);
     y=A1(j,4,i);
     z=A1(j,5,i);
     %count=count+1;
     for k=j+1:V1(i)
         x1=A1(k,3,i);
         y1=A1(k,4,i);
         z1=A1(k,5,i);
%          if x1 == 5 && y1 == 4 && z1 == 3
%              disp('Hello world');
%          end
         t1=[x,y,z];
         t2=[x1,y1,z1];
         flag=check(t1,t2,3,3);
         if x==x1 && flag==0
                f=f+1;
                 A1(f,6,i)=z1;
                 A1(f,7,i)=y1;
                 A1(f,8,i)=x1;
                 A1(f,9,i)=y;
                 A1(f,10,i)=z;
                                  
                 B1(f,6,i)=B1(k,5,i);
                 B1(f,7,i)=B1(k,4,i);
                 B1(f,8,i)=B1(k,3,i);
                 B1(f,9,i)=B1(j,4,i);
                 B1(f,10,i)=B1(j,5,i);
         end
         
         if x==z1 && flag==0
              f=f+1;
                 A1(f,6,i)=x1;
                 A1(f,7,i)=y1;
                 A1(f,8,i)=z1;
                 A1(f,9,i)=y;
                 A1(f,10,i)=z;
                                  
                 B1(f,6,i)=B1(k,3,i);
                 B1(f,7,i)=B1(k,4,i);
                 B1(f,8,i)=B1(k,5,i);
                 B1(f,9,i)=B1(j,4,i);
                 B1(f,10,i)=B1(j,5,i);
         end
         
         if z==x1 && flag==0
             f=f+1;
                 A1(f,6,i)=x;
                 A1(f,7,i)=y;
                 A1(f,8,i)=z;
                 A1(f,9,i)=y1;
                 A1(f,10,i)=z1;
                                  
                 B1(f,6,i)=B1(j,3,i);
                 B1(f,7,i)=B1(j,4,i);
                 B1(f,8,i)=B1(j,5,i);
                 B1(f,9,i)=B1(k,4,i);
                 B1(f,10,i)=B1(k,5,i);
         end
         
         if z==z1 && flag==0
             f=f+1;
                 A1(f,6,i)=x;
                 A1(f,7,i)=y;
                 A1(f,8,i)=z;
                 A1(f,9,i)=y1;
                 A1(f,10,i)=x1;
                                  
                 B1(f,6,i)=B1(j,3,i);
                 B1(f,7,i)=B1(j,4,i);
                 B1(f,8,i)=B1(j,5,i);
                 B1(f,9,i)=B1(k,4,i);
                 B1(f,10,i)=B1(k,3,i);
         end
     end
    end
    V2(i)=f;
end

%7 sized fragments
for i=1:nom
f=0;
    for j=1:V2(i)-1
     x=A1(j,3,i);
     y=A1(j,4,i);
     z=A1(j,5,i);
     %count=count+1;
     for k=j+1:V2(i)
         u1=A1(k,6,i);
         w1=A1(k,7,i);
         x1=A1(k,8,i);
         y1=A1(k,9,i);
         z1=A1(k,10,i);
         t1=[x,y,z];
         t2=[u1,w1,x1,y1,z1];
         flag=check(t1,t2,3,5);
         if x==u1 && flag==0
                f=f+1;
                 A1(f,11,i)= z1;
                 A1(f,12,i)= y1;
                 A1(f,13,i)= x1;
                 A1(f,14,i)= w1;
                 A1(f,15,i)= u1;
                 A1(f,16,i)= y;
                 A1(f,17,i)= z;
                                  
                 B1(f,11,i)= B1(k,10,i);
                 B1(f,12,i)= B1(k,9,i);
                 B1(f,13,i)= B1(k,8,i);
                 B1(f,14,i)= B1(k,7,i);
                 B1(f,15,i)= B1(k,6,i);
                 B1(f,16,i)= B1(j,4,i);
                 B1(f,17,i)= B1(j,5,i);
         end
         
         if x==z1 && flag==0
              f=f+1;
                 A1(f,11,i)= u1;
                 A1(f,12,i)= w1;
                 A1(f,13,i)= x1;
                 A1(f,14,i)= y1;
                 A1(f,15,i)= z1;
                 A1(f,16,i)= y;
                 A1(f,17,i)= z;
                                  
                 B1(f,11,i)= B1(k,6,i);
                 B1(f,12,i)= B1(k,7,i);
                 B1(f,13,i)= B1(k,8,i);
                 B1(f,14,i)= B1(k,9,i);
                 B1(f,15,i)= B1(k,10,i);
                 B1(f,16,i)= B1(j,4,i);
                 B1(f,17,i)= B1(j,5,i);
         end
         
         if z==u1 && flag==0
             f=f+1;
                 A1(f,11,i)= x;
                 A1(f,12,i)= y;
                 A1(f,13,i)= z;
                 A1(f,14,i)= w1;
                 A1(f,15,i)= x1;
                 A1(f,16,i)= y1;
                 A1(f,17,i)= z1;
                                  
                 B1(f,11,i)= B1(j,3,i);
                 B1(f,12,i)= B1(j,4,i);
                 B1(f,13,i)= B1(j,5,i);
                 B1(f,14,i)= B1(k,7,i);
                 B1(f,15,i)= B1(k,8,i);
                 B1(f,16,i)= B1(k,9,i);
                 B1(f,17,i)= B1(k,10,i);
         end
         
         if z==z1 && flag==0
             f=f+1;
                 A1(f,11,i)= u1;
                 A1(f,12,i)= w1;
                 A1(f,13,i)= x1;
                 A1(f,14,i)= y1;
                 A1(f,15,i)= z1;
                 A1(f,16,i)= y;
                 A1(f,17,i)= x;
                                  
                 B1(f,11,i)= B1(k,6,i);
                 B1(f,12,i)= B1(k,7,i);
                 B1(f,13,i)= B1(k,8,i);
                 B1(f,14,i)= B1(k,9,i);
                 B1(f,15,i)= B1(k,10,i);
                 B1(f,16,i)= B1(j,4,i);
                 B1(f,17,i)= B1(j,3,i);
         end
     end
    end
    V3(i)=f;
end
%%
% segment removal
[x1,y1,z1]=size(A1);
for i=1:z1

    %remove repetition in 3 sized segemnt
    
    maximum=max(max(A1(:,1:2,i)));
    w=ones(maximum,1);
    j=1;
    while j<=V1(i)
    count=0;
       if A1(j,3,i) ~= 0
            
        
        if j == 1
            w(A1(j,3:5,i))=0;
           
        end
        
        if j > 1
            
            if w(A1(j,3,i)) == 0
                count=count+1;
                %disp(' entered');
            end
            if w(A1(j,4,i)) == 0
                count=count+1;
            end
            if w(A1(j,5,i)) == 0
                count=count+1;
            end
            if count ~= 2
                     
                     %i
                     V1(i)
                     if x1 == V1(i)
                         fin=V1(i)-1;
                     else
                         fin=V1(i);
                     end
                for t=j:fin
                A1(t,3:5,i)=A1(t+1,3:5,i);
                B1(t,3:5,i)=B1(t+1,3:5,i);
                end
                %t
                count=0;
                A1(t,3:5,i)=0;
                B1{t,3,i}=[];
                B1{t,4,i}=[];
                B1{t,5,i}=[];
                
                A1(t+1,3:5,i)=0;
                B1{t+1,3,i}=[];
                B1{t+1,4,i}=[];
                B1{t+1,5,i}=[];
                
                V1(i)=V1(i)-1;
                j=j-1;
                
            end
            if count == 2
                
            w(A1(j,3:5,i))=0;
            
            count=0;
            end
        end
        
        j=j+1;
       else
           j=V1(i)+1;
        end
    end
    %disp('ended3');
    %remove repetition in 5 sized segemnt
    w=[];
   maximum=max(max(A1(:,1:2,i)));
    w=ones(maximum,1);
    j=1;
    while j<=V2(i)
    count=0;
        if A1(j,6,i) ~= 0
            
        
        if j == 1
            w(A1(j,6:10,i))=0;
           
        end
        
        if j > 1
            
            if w(A1(j,6,i)) == 0
                count=count+1;
                %disp(' entered');
            end
            if w(A1(j,7,i)) == 0
                count=count+1;
            end
            if w(A1(j,8,i)) == 0
                count=count+1;
            end
            if w(A1(j,9,i)) == 0
                count=count+1;
            end
            if w(A1(j,10,i)) == 0
                count=count+1;
            end
            
            if count ~= 4
                       if x1 == V2(i)
                         fin=V2(i)-1;
                     else
                         fin=V2(i);
                     end
                for t=j:fin
                A1(t,6:10,i)=A1(t+1,6:10,i);
                B1(t,6:10,i)=B1(t+1,6:10,i);
                end
                %t
                count=0;
                A1(t,6:10,i)=0;
                B1{t,6,i}=[];
                B1{t,7,i}=[];
                B1{t,8,i}=[];
                B1{t,9,i}=[];
                B1{t,10,i}=[];
                V2(i)=V2(i)-1;
                j=j-1;
                
            end
            if count == 4
                
            w(A1(j,6:10,i))=0;
            
            count=0;
            end
        end
        j=j+1;
        else
        j=V2(i)+1;
        end
    end
    %disp('ended5');
    %remove repetition in 7 sized segemnt
    w=[];
    maximum=max(max(A1(:,1:2,i)));
    w=ones(maximum,1);
    j=1;
    while j<=x1
        
    count=0;
        
    if A1(j,11,i) ~= 0
            %A1(j,11,i)
            
        
        if j == 1
            w(A1(j,11:17,i))=0;
           %w
        end
        
        if j > 1
            
            if w(A1(j,11,i)) == 0
                count=count+1;
                %disp(' entered');
            end
            if w(A1(j,12,i)) == 0
                count=count+1;
            end
            if w(A1(j,13,i)) == 0
                count=count+1;
            end
            if w(A1(j,14,i)) == 0
                count=count+1;
                %disp(' entered');
            end
            if w(A1(j,15,i)) == 0
                count=count+1;
            end
            if w(A1(j,16,i)) == 0
                count=count+1;
            end
            if w(A1(j,17,i)) == 0
                count=count+1;
            end
            
            if count ~= 6
                      
                for t=j:x1-1
                A1(t,11:17,i)=A1(t+1,11:17,i);
                B1(t,11:17,i)=B1(t+1,11:17,i);
                end
                %t
                count=0;
                A1(t,11:17,i)=0;
                B1{t,11,i}=[];
                B1{t,12,i}=[];
                B1{t,13,i}=[];
                B1{t,14,i}=[];
                B1{t,15,i}=[];
                B1{t,16,i}=[];
                B1{t,17,i}=[];
                V3(i)=V3(i)-1;
                %j
                j=j-1;
                
            end
            if count == 6
                
            w(A1(j,11:17,i))=0;
            %w
            count=0;
            end
        end
        j=j+1;
    else
        j=x1+1;
     end
    end
    %disp('ended7');
end

%%
%checking similarity of length 3
l=1;
for i=1:nom
 for z=i+1:nom
     count=0;
    for j=1:V1(i)
     
            a=cell2mat(B1(j,3,i));
            b=cell2mat(B1(j,4,i));
            c=cell2mat(B1(j,5,i));
                        
            m1=[a,b,c];
            
        for k=1:V1(z)
        
            a1=cell2mat(B1(k,3,z));
            b1=cell2mat(B1(k,4,z));
            c1=cell2mat(B1(k,5,z));
                        
            m2=[a1,b1,c1];
%             m1
%             m2
             if isempty(m1)==1 || isempty(m2)==1
                 continue
             end
            flag=match3(m1,m2);
            
            if flag==1
                count=count+1;
                break;
                k=0;
             end
        end
        
    end
%      i
%      z
%     count/(G(i)+G(z))
    final(l,1)=i;
    final(l,2)=z;
    final(l,3)=count/( V1(i)+V1(z)+G(i)+G(z)+C(i)+C(z));
    %G(i)*G(z)*C(i)*C(z)      /(V2(i)+V2(z)+G(i)+G(z)+C(i)+C(z))   nchoosek(C(i),3)+ nchoosek(C(z),3)+
   l=l+1;
  end
end


%checking similarity of length 5 among the 4 molecules
l=1;
for i=1:nom
 for z=i+1:nom
     count=0;
     %j=1;
     %while j<=V2(i)
    for j=1:V2(i)
     
            a=cell2mat(B1(j,6,i));
            b=cell2mat(B1(j,7,i));
            c=cell2mat(B1(j,8,i));
            d=cell2mat(B1(j,9,i));
            e=cell2mat(B1(j,10,i));
%              f=cell2mat(B1(j,16,i));
%              g=cell2mat(B1(j,17,i));
            
            m1=[a,b,c,d,e];
            
        for k=1:V2(z)
        
            a1=cell2mat(B1(k,6,z));
            b1=cell2mat(B1(k,7,z));
            c1=cell2mat(B1(k,8,z));
            d1=cell2mat(B1(k,9,z));
            e1=cell2mat(B1(k,10,z));
%              f1=cell2mat(B1(k,16,z));
%              g1=cell2mat(B1(k,17,z));
            
            m2=[a1,b1,c1,d1,e1];
%             m1
%             m2
            if isempty(m1)==1 || isempty(m2)==1
                 continue
            end 
            flag=match5(m1,m2);
            
            if flag==1
                count=count+1;
                break;
                k=0;
             end
        end
        %j=j+1;
    end

    %final(l,4)=count/( nchoosek(C(i),5)+ nchoosek(C(z),5)+V2(i)+V2(z)+G(i)+G(z)+C(i)+C(z));
    if C(i)>=5 && C(z)>=5
    %disp('entered');
    final(l,4)=count/( V2(i)+V2(z)+G(i)+G(z)+C(i)+C(z));
else
    final(l,4)=0;
    end
    %final(l,4)=0;
    %G(i)*G(z)*C(i)*C(z)  /(V2(i)+V2(z)+G(i)+G(z)+C(i)+C(z))  nchoosek(C(i),5)+ nchoosek(C(z),5)+
   l=l+1;
  end
end

%checking similarity of length 7 among the 4 molecules
l=1;
for i=1:nom
 for z=i+1:nom
     count=0;
    for j=1:V3(i)
     
            a=cell2mat(B1(j,11,i));
            b=cell2mat(B1(j,12,i));
            c=cell2mat(B1(j,13,i));
            d=cell2mat(B1(j,14,i));
            e=cell2mat(B1(j,15,i));
             f=cell2mat(B1(j,16,i));
             g=cell2mat(B1(j,17,i));
            
            m1=[a,b,c,d,e,f,g];
            
        for k=1:V3(z)
        
            a1=cell2mat(B1(k,11,z));
            b1=cell2mat(B1(k,12,z));
            c1=cell2mat(B1(k,13,z));
            d1=cell2mat(B1(k,14,z));
            e1=cell2mat(B1(k,15,z));
             f1=cell2mat(B1(k,16,z));
             g1=cell2mat(B1(k,17,z));
            
            m2=[a1,b1,c1,d1,e1,f1,g1];
%             m1
%             m2
             if isempty(m1)==1 || isempty(m2)==1
                 continue
             end
            flag=match7(m1,m2);
            
            if flag==1
                count=count+1;
               break;
                k=0;
             end
        end
        
    end

if C(i)>=7 && C(z)>=7
    %disp('entered');
    final(l,5)=count/( V3(i)+V3(z)+G(i)+G(z)+C(i)+C(z));
else
    final(l,5)=0;
    %/(V3(i)+V3(z)+G(i)+G(z)+C(i)+C(z))  nchoosek(C(i),7)+ nchoosek(C(z),7)+
end
%final(l,5)=0;
   l=l+1;
 end
 
end

for i=1:l-1
    if 1
         final(i,6)=final(i,3)+3*final(i,4)+final(i,5);
         
    end
end
final1=transpose(final);
     [Y,I]=sort(final1(6,:),'descend');
     final2=final1(:,I);
%     final2

[m,n]=size(final2);
c=1;
final1=final2;


[m,n]=size(final1);
for i=1:n
    norm=C(final1(1,i))+C(final1(2,i));
        final1(7,i)  = abs((molwt(final1(1,i))-molwt(final1(2,i)))/norm);
        final1(8,i)=final1(6,i)-final1(7,i);
end
     [Y,I]=sort(final1(8,:),'descend');
     final3=final1(:,I);

     %mean of the values
     sum=0;
[m,n]=size(final3);
for i=1:n
       sum=sum+final3(8,i);
end
mean=sum/n;
%mean
for i=1:n
    if final3(8,i)>mean
        xx(i,1)=final3(1,i);
        xx(i,2)=final3(2,i);
    end
end
b=xx;
bb1=0;
for i=1:n
    for j=1:n
    if final3(1,j)==i || final3(2,j)==i
         if final3(1,j)==i
             bb1(i)=final3(2,j);
             break;
         end
         if final3(2,j)==i
             bb1(i)=final3(1,j);
             break;
         end
    end
    end
end
bb2=0;
%2nd best
for i=1:n
    flag1=0;
    flag2=0;
for j=1:n
if final3(1,j)==i && ((flag1==1 && flag2==0) || (flag2==1 && flag1==0))
bb2(i)=final3(2,j);
break;
end
if final3(1,j)==i && flag1==0 && flag2==0
    flag1=1;flag2=0;
end
if final3(2,j)==i && ((flag2==1 && flag1==0) || (flag1==1 && flag2==0))
bb2(i)=final3(1,j);
break;
end 
if final3(2,j)==i && flag2==0 && flag1==0
flag2=1; flag1=0;
end
end
end

bb3=0;
%third best
for i=1:n
   count=1;
    for j=1:n
        if (final3(1,j)==i || final3(2,j)==i) && count<3
            count=count+1;
            continue;
         end
        
        if (final3(1,j)==i || final3(2,j)==i) && count==3
            count=1;
            if final3(1,j)==i
            bb3(i)=final3(2,j);
            break;
            end
            if final3(2,j)==i
            bb3(i)=final3(1,j);
            break;
            end
            break;
        end
    end
end

%%
%sort
Y=[];
I=[];
final1=[];
 [Y,I]=sort(final3(8,:),'descend');
     final1=final3(:,I);

     %mean of the values
     sum=0;
[m,n]=size(final1);
for i=1:n
       sum=sum+final1(8,i);
end
mean=sum/n;
final2=[];
for i=1:n
    if final1(8,i)>mean
        final2(:,i)=final1(:,i);
    end
    
end



%% Displaying result
for i=1:length(bb1)
   if  bb1(1,i)~=0
        if i==bb1(1,bb1(1,i)) && bb1(1,bb1(1,i))~=0
            bb1(1,bb1(1,i))=0;
        end
        if i==bb2(1,bb1(1,i)) && bb2(1,bb1(1,i)) ~=0
            bb2(1,bb1(1,i))=0;
        end
        if i==bb3(1,bb1(1,i)) && bb3(1,bb1(1,i))~=0
            bb3(1,bb1(1,i))=0;
        end
   end
        %-------------------
        if bb2(1,i)~=0
        if i==bb1(1,bb2(1,i)) && bb1(1,bb2(1,i))~=0
            bb1(1,bb2(1,i))=0;
        end
        if i==bb2(1,bb2(1,i)) && bb2(1,bb2(1,i))~=0
            bb2(1,bb2(1,i))=0;
        end
        if i==bb3(1,bb2(1,i)) && bb3(1,bb2(1,i))~=0
            bb3(1,bb2(1,i))=0;
        end
        end
        %--------------------
        if bb3(1,i)~=0
        if i==bb1(1,bb3(1,i)) && bb1(1,bb3(1,i))~=0
            bb1(1,bb3(1,i))=0;
        end
        if i==bb2(1,bb3(1,i)) && bb2(1,bb3(1,i))~=0
            bb2(1,bb3(1,i))=0;
        end
        if i==bb3(1,bb3(1,i)) && bb3(1,bb3(1,i))~=0
            bb3(1,bb3(1,i))=0;
        end
        end
end
for i=1:length(bb1)
    
        if bb1(1,i)==bb3(1,i)
            bb3(1,i)=0;
        end
    
end
disp('              --------------------Results--------------------');
fprintf('\n');
fprintf('\n');
if exist('change','var')==1
     pp=1;
     for j=1:length(comp_name)
        if any(change(:) == j)
            
        else
            comp_name1(pp)=comp_name(j);
            pp=pp+1;
        end
     end
     
 for i=1:length(change)
     X=['Compound ',comp_name(change(i)),' does not have molecular weight. '];
     disp(X);
 end
comp_name={};
comp_name=comp_name1;
 end


x=fopen(resultfile,'w');
for i=1:length(comp_name)
    s='';
    s=strcat(comp_name(i),' can transform to: ');
    X=['Compound ',comp_name(i),' can transform to compounds: '];
    %disp(X);
    sprintf('\n');
    sprintf('\n');
    if bb1(1,i)~=0;
        X(4)=comp_name(bb1(1,i));
        s=strcat(s,comp_name(bb1(1,i)),'; ');
        %disp(comp_name(bb1(1,i)));
    else
        X(4)=cellstr('');
    end
    if bb2(1,i)~=0;
         X(5)=comp_name(bb2(1,i));
         s=strcat(s,comp_name(bb2(1,i)),'; ');
    else
         X(5)=cellstr('');
        %disp(comp_name(bb2(1,i)));
    end
    if bb3(1,i)~=0;
        X(6)=comp_name(bb3(1,i));
        s=strcat(s,comp_name(bb3(1,i)));
    else
         X(6)=cellstr('');
        %disp(comp_name(bb3(1,i)));
    end
    %disp(X);
    fprintf(x,char(s));
    fprintf(x,char('\n'));
    fprintf(x,char('\n'));
    disp(s);
end
fclose(x);
