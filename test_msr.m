%%%%%%%%%%%%%%%%%%%%数据准备%%%%%%%%%%%%%%%%%%%% 
clc;  
clear all;  
I=imread('img3.jpg');%读取图像  
Ir=I(:,:,1);  %分别提取图像的R分量,G分量和B分量 
Ig=I(:,:,2); 
Ib=I(:,:,3);  
Ir_double=double(Ir);%分别将RGB分量转换为double型 
Ig_double=double(Ig); 
Ib_double=double(Ib);  
[m,n]=size(Ir_double);%获取图像的大小,m为高n为宽 
%%%%%%%%%%%%%%%%%%%%参数设定%%%%%%%%%%%%%%%%%%%% 
%F1，F2，F3表示小中大三个高斯模板  
%L1，L2，L3表示各个色彩通道与三个高斯模板卷积所得的亮度图像估计 
%Rr,Rg,Rb表示增强后RGB各通道的图像  
%u,s,mi,ma分别表示图像的均值、标准差、最小值、最大值 
%low,high分别表示截断值 
if m<n     
	h=m; 
else     
	h=n; 
end  
sigma1=5;%double(uint8(h*0.03));%小尺寸为图像大小的3% 
sigma2=40;%double(uint8(h*0.13));%中尺寸为图像大小的13% 
sigma3=240;%double(uint8(h*0.40));%大尺寸为图像大小的40% 
aa=125;%颜色回复系数  
%%%%%%%%%%%%%%%%%%%%生成高斯模板%%%%%%%%%%%%%%%%  
F1=fspecial('gaussian',[3*sigma1,3*sigma1],sigma1);%小尺寸模板 
F2=fspecial('gaussian',[3*sigma2,3*sigma2],sigma2);%中尺寸模板 
F3=fspecial('gaussian',[3*sigma3,3*sigma3],sigma3);%大尺寸模板 
%%%%%%%%%%%%%%%%%%%%处理R通道%%%%%%%%%%%%%%%%%%%  
L1=imfilter(Ir_double,F1,'replicate','conv');%三个高斯模板分别与R通道卷积 
L2=imfilter(Ir_double,F2,'replicate','conv'); 
L3=imfilter(Ir_double,F3,'replicate','conv'); 
for i=1:m      
	for j=1:n           
		C(i,j)=((Ir_double(i,j)/(Ir_double(i,j)+Ig_double(i,j)+Ib_double(i,j))));%颜色恢复系数计算     
	end 
end  
for i=1:m      
	for j=1:n               
		G(i,j)=1/3*(log(Ir_double(i,j)+1)-log(L1(i,j)+1));%三尺度加权最后进行颜色恢复          
		G(i,j)=1/3*(log(Ir_double(i,j)+1)-log(L2(i,j)+1))+G(i,j);          
		G(i,j)=(1/3*(log(Ir_double(i,j)+1)-log(L3(i,j)+1))+G(i,j));           
		%G(i,j)=exp(G(i,j));%从对数域恢复到整数域     
	end 
end  
u=mean2(G);%计算图像的均值,方差,最小值，最大值 
s=std2(G);  
mi=min(min(G)); 
ma=max(max(G));  
Rr=(G-mi)*255/(ma-mi);%直接对比度拉伸  
%%%%%%%%%%%%%%%%%%%%处理G通道%%%%%%%%%%%%%%%%%%%  
L1=imfilter(Ig_double,F1,'replicate','conv');%三个高斯模板分别与G通道卷积 
L2=imfilter(Ig_double,F2,'replicate','conv'); 
L3=imfilter(Ig_double,F3,'replicate','conv'); 
for i=1:m      
	for j=1:n           
		C(i,j)=((Ig_double(i,j)/(Ir_double(i,j)+Ig_double(i,j)+Ib_double(i,j))));%颜色恢复系数计算     
	end 
end  
for i=1:m      
	for j=1:n               
		G(i,j)=1/3*(log(Ig_double(i,j)+1)-log(L1(i,j)+1));%三尺度加权最后进行颜色恢复          
		G(i,j)=1/3*(log(Ig_double(i,j)+1)-log(L2(i,j)+1))+G(i,j);          
		G(i,j)=(1/3*(log(Ig_double(i,j)+1)-log(L3(i,j)+1))+G(i,j));           
		%G(i,j)=exp(G(i,j));%从对数域恢复到整数域     
	end 
end  
u=mean2(G);%计算图像的均值,方差,最小值，最大值 
s=std2(G);  
mi=min(min(G)); 
ma=max(max(G));  
Rg=(G-mi)*255/(ma-mi);%直接对比度拉伸  
%%%%%%%%%%%%%%%%%%%%处理B通道%%%%%%%%%%%%%%%%%%%  
L1=imfilter(Ib_double,F1,'replicate','conv');%三个高斯模板分别与B通道卷积 
L2=imfilter(Ib_double,F2,'replicate','conv'); 
L3=imfilter(Ib_double,F3,'replicate','conv'); 
for i=1:m      
	for j=1:n           
		C(i,j)=((Ib_double(i,j)/(Ir_double(i,j)+Ig_double(i,j)+Ib_double(i,j))));%颜色恢复系数计算     
	end 
end  
for i=1:m      
	for j=1:n               
		G(i,j)=1/3*(log(Ib_double(i,j)+1)-log(L1(i,j)+1));%三尺度加权最后进行颜色恢复          
		G(i,j)=1/3*(log(Ib_double(i,j)+1)-log(L2(i,j)+1))+G(i,j);          
		G(i,j)=(1/3*(log(Ib_double(i,j)+1)-log(L3(i,j)+1))+G(i,j));           
		%G(i,j)=exp(G(i,j));%从对数域恢复到整数域     
	end 
end  
u=mean2(G);%计算图像的均值,方差,最小值，最大值 
s=std2(G);  
mi=min(min(G)); 
ma=max(max(G));  
Rb=(G-mi)*255/(ma-mi);%直接对比度拉伸  
%%%%%%%%%%%%%%%%%%%%合成增强图%%%%%%%%%%%%%%%%%%% 
Rr_01=Rr/255; 
Rg_01=Rg/255; 
Rb_01=Rb/255;  
msrcr=cat(3,Rr_01,Rg_01,Rb_01);%合成增强图像 
% msrcr=cat(3,Rr,Rg,Rb);
%%%%%%%%%%%%%%%%%%%%显示图像%%%%%%%%%%%%%%%%%%% 
figure,imshow(msrcr); 
figure,imshow(I);		