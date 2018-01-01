clear all;
clc;
close all;
IMG = imread('img2.jpg');
figure();imshow(IMG);
[wid,len,height]=size(IMG);
%-------------------------------------------------------------------------
if wid<len
    h=wid;
else
    h=len;
end
c(1)=double(uint8(h*0.03));
c(2)=double(uint8(h*0.13));
c(3)=double(uint8(h*0.40));
% c=[11,88,147];
% c=80;
sigma=c;
K=size(c,2);
c=c.*3;
img1=zeros(wid,len,height);
for a=1:K
    g=fspecial('gaussian',c(a),sigma(a));
%     g=fspecial('average',c(a));
    img=imfilter(IMG,g,'replicate','conv');
    img1=img1+(log(double(IMG)+1.)-log(double(img)))./K;
%     figure();imshow(img);
end
% img1=exp(img1);
figure();imshow(img1);
%---------------------------É«²Ê»Ö¸´---------------------------------------
alpha  = 130.;
gain   = 1.;
offset = 0.;
logl=log(double(IMG(:,:,1))+double(IMG(:,:,2))+double(IMG(:,:,3))+3.);

img1(:,:,1)=gain*((log(alpha*(double(IMG(:,:,1))+1.))-logl).*img1(:,:,1))+offset;
img1(:,:,2)=gain*((log(alpha*(double(IMG(:,:,2))+1.))-logl).*img1(:,:,2))+offset;
img1(:,:,3)=gain*((log(alpha*(double(IMG(:,:,3))+1.))-logl).*img1(:,:,3))+offset;
figure();imshow(img1);
%-----------------------------Á¿»¯-----------------------------------------
img2=reshape(img1,wid*len,height);
Mean=mean(img2);
Var=std(img2);
A=ones(wid*len,1);
dynamic=2;
Min=Mean-dynamic*Var;
Min=A*Min;
Max=Mean+dynamic*Var;
Max=A*Max;
t=255*(img2-Min)./(Max-Min);
t(t<0)=0;
t(t>255)=255;
% img1=uint8(reshape(t,wid,len,3));
img1=uint8(reshape(t,wid,len,3));
figure();imshow(img1);
                    