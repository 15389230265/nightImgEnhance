clear all;
clc;
close all;
IMG = imread('img3.jpg');
figure();imshow(IMG);
[wid,len,height]=size(IMG);
%-------------------------------------------------------------------------
c=[15,80,120];
% c=80;
sigma=1;
K=size(c,2);
c=c.*2+1;
img1=zeros(wid,len,height);
for a=1:K
    g=fspecial('gaussian',c(a),sigma);
%     g=fspecial('average',c(a));
    img=imfilter(IMG,g,'same');
    img1=img1+(log(double(IMG)+1.)-log(double(img)))./K;
%     figure();imshow(img);
end
% img1=double(img1>=0);
% img1=exp(img1);
figure();imshow(img1);
%---------------------------É«²Ê»Ö¸´---------------------------------------
alpha  = 128.;
gain   = 1.;
offset = 0.;
logl=log(double(IMG(:,:,1))+double(IMG(:,:,2))+double(IMG(:,:,3))+3.);

img1(:,:,1)=gain*((log(alpha*(double(IMG(:,:,1))+1.))-logl).*img1(:,:,1))+offset;
img1(:,:,2)=gain*((log(alpha*(double(IMG(:,:,2))+1.))-logl).*img1(:,:,2))+offset;
img1(:,:,3)=gain*((log(alpha*(double(IMG(:,:,3))+1.))-logl).*img1(:,:,3))+offset;
figure();imshow(img1);
%-----------------------------Á¿»¯-----------------------------------------
img2=reshape(img1,wid*len,3);
Mean=mean(img2);
Var=var(img2);
A=ones(wid*len,1);
dynamic=1.5;
Min=Mean-dynamic*Var;
Min=A*Min;
Max=Mean+dynamic*Var;
Max=A*Max;
t=255*((img2-Min)./(Max-Min));
t(t<0)=0;
t(t>255)=255;
img1=uint8(reshape(t,wid,len,3));
figure();imshow(img1);
                    