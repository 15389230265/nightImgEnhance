%%%%%%%%%%%%%%%%%%%%����׼��%%%%%%%%%%%%%%%%%%%% 
clc;  
clear all;  
I=imread('img3.jpg');%��ȡͼ��  
Ir=I(:,:,1);  %�ֱ���ȡͼ���R����,G������B���� 
Ig=I(:,:,2); 
Ib=I(:,:,3);  
Ir_double=double(Ir);%�ֱ�RGB����ת��Ϊdouble�� 
Ig_double=double(Ig); 
Ib_double=double(Ib);  
[m,n]=size(Ir_double);%��ȡͼ��Ĵ�С,mΪ��nΪ�� 
%%%%%%%%%%%%%%%%%%%%�����趨%%%%%%%%%%%%%%%%%%%% 
%F1��F2��F3��ʾС�д�������˹ģ��  
%L1��L2��L3��ʾ����ɫ��ͨ����������˹ģ�������õ�����ͼ����� 
%Rr,Rg,Rb��ʾ��ǿ��RGB��ͨ����ͼ��  
%u,s,mi,ma�ֱ��ʾͼ��ľ�ֵ����׼���Сֵ�����ֵ 
%low,high�ֱ��ʾ�ض�ֵ 
if m<n     
	h=m; 
else     
	h=n; 
end  
sigma1=5;%double(uint8(h*0.03));%С�ߴ�Ϊͼ���С��3% 
sigma2=40;%double(uint8(h*0.13));%�гߴ�Ϊͼ���С��13% 
sigma3=240;%double(uint8(h*0.40));%��ߴ�Ϊͼ���С��40% 
aa=125;%��ɫ�ظ�ϵ��  
%%%%%%%%%%%%%%%%%%%%���ɸ�˹ģ��%%%%%%%%%%%%%%%%  
F1=fspecial('gaussian',[3*sigma1,3*sigma1],sigma1);%С�ߴ�ģ�� 
F2=fspecial('gaussian',[3*sigma2,3*sigma2],sigma2);%�гߴ�ģ�� 
F3=fspecial('gaussian',[3*sigma3,3*sigma3],sigma3);%��ߴ�ģ�� 
%%%%%%%%%%%%%%%%%%%%����Rͨ��%%%%%%%%%%%%%%%%%%%  
L1=imfilter(Ir_double,F1,'replicate','conv');%������˹ģ��ֱ���Rͨ����� 
L2=imfilter(Ir_double,F2,'replicate','conv'); 
L3=imfilter(Ir_double,F3,'replicate','conv'); 
for i=1:m      
	for j=1:n           
		C(i,j)=((Ir_double(i,j)/(Ir_double(i,j)+Ig_double(i,j)+Ib_double(i,j))));%��ɫ�ָ�ϵ������     
	end 
end  
for i=1:m      
	for j=1:n               
		G(i,j)=1/3*(log(Ir_double(i,j)+1)-log(L1(i,j)+1));%���߶ȼ�Ȩ��������ɫ�ָ�          
		G(i,j)=1/3*(log(Ir_double(i,j)+1)-log(L2(i,j)+1))+G(i,j);          
		G(i,j)=(1/3*(log(Ir_double(i,j)+1)-log(L3(i,j)+1))+G(i,j));           
		%G(i,j)=exp(G(i,j));%�Ӷ�����ָ���������     
	end 
end  
u=mean2(G);%����ͼ��ľ�ֵ,����,��Сֵ�����ֵ 
s=std2(G);  
mi=min(min(G)); 
ma=max(max(G));  
Rr=(G-mi)*255/(ma-mi);%ֱ�ӶԱȶ�����  
%%%%%%%%%%%%%%%%%%%%����Gͨ��%%%%%%%%%%%%%%%%%%%  
L1=imfilter(Ig_double,F1,'replicate','conv');%������˹ģ��ֱ���Gͨ����� 
L2=imfilter(Ig_double,F2,'replicate','conv'); 
L3=imfilter(Ig_double,F3,'replicate','conv'); 
for i=1:m      
	for j=1:n           
		C(i,j)=((Ig_double(i,j)/(Ir_double(i,j)+Ig_double(i,j)+Ib_double(i,j))));%��ɫ�ָ�ϵ������     
	end 
end  
for i=1:m      
	for j=1:n               
		G(i,j)=1/3*(log(Ig_double(i,j)+1)-log(L1(i,j)+1));%���߶ȼ�Ȩ��������ɫ�ָ�          
		G(i,j)=1/3*(log(Ig_double(i,j)+1)-log(L2(i,j)+1))+G(i,j);          
		G(i,j)=(1/3*(log(Ig_double(i,j)+1)-log(L3(i,j)+1))+G(i,j));           
		%G(i,j)=exp(G(i,j));%�Ӷ�����ָ���������     
	end 
end  
u=mean2(G);%����ͼ��ľ�ֵ,����,��Сֵ�����ֵ 
s=std2(G);  
mi=min(min(G)); 
ma=max(max(G));  
Rg=(G-mi)*255/(ma-mi);%ֱ�ӶԱȶ�����  
%%%%%%%%%%%%%%%%%%%%����Bͨ��%%%%%%%%%%%%%%%%%%%  
L1=imfilter(Ib_double,F1,'replicate','conv');%������˹ģ��ֱ���Bͨ����� 
L2=imfilter(Ib_double,F2,'replicate','conv'); 
L3=imfilter(Ib_double,F3,'replicate','conv'); 
for i=1:m      
	for j=1:n           
		C(i,j)=((Ib_double(i,j)/(Ir_double(i,j)+Ig_double(i,j)+Ib_double(i,j))));%��ɫ�ָ�ϵ������     
	end 
end  
for i=1:m      
	for j=1:n               
		G(i,j)=1/3*(log(Ib_double(i,j)+1)-log(L1(i,j)+1));%���߶ȼ�Ȩ��������ɫ�ָ�          
		G(i,j)=1/3*(log(Ib_double(i,j)+1)-log(L2(i,j)+1))+G(i,j);          
		G(i,j)=(1/3*(log(Ib_double(i,j)+1)-log(L3(i,j)+1))+G(i,j));           
		%G(i,j)=exp(G(i,j));%�Ӷ�����ָ���������     
	end 
end  
u=mean2(G);%����ͼ��ľ�ֵ,����,��Сֵ�����ֵ 
s=std2(G);  
mi=min(min(G)); 
ma=max(max(G));  
Rb=(G-mi)*255/(ma-mi);%ֱ�ӶԱȶ�����  
%%%%%%%%%%%%%%%%%%%%�ϳ���ǿͼ%%%%%%%%%%%%%%%%%%% 
Rr_01=Rr/255; 
Rg_01=Rg/255; 
Rb_01=Rb/255;  
msrcr=cat(3,Rr_01,Rg_01,Rb_01);%�ϳ���ǿͼ�� 
% msrcr=cat(3,Rr,Rg,Rb);
%%%%%%%%%%%%%%%%%%%%��ʾͼ��%%%%%%%%%%%%%%%%%%% 
figure,imshow(msrcr); 
figure,imshow(I);		