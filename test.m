clear all;
clc;
a = imread('img1.jpg');  
subplot(221);
imshow(a);
title('彩色图');
R = a(:,:,1);  
G = a(:,:,2);  
B = a(:,:,3);  
  
R = histeq(R, 256);  
G = histeq(G, 256);  
B = histeq(B, 256);  
  
a(:,:,1) = R;  
a(:,:,2) = G;  
a(:,:,3) = B;
subplot(222);
imshow(a) 
title('彩色直方图均衡化');

hsvImg = rgb2hsv(a);  
V=hsvImg(:,:,3);  
[height,width]=size(V);  
  
V = uint8(V*255);  
NumPixel = zeros(1,256);  
for i = 1:height  
    for j = 1: width  
    NumPixel(V(i,j) + 1) = NumPixel(V(i,j) + 1) + 1;  
    end  
end  
  
  
ProbPixel = zeros(1,256);  
for i = 1:256  
    ProbPixel(i) = NumPixel(i) / (height * width * 1.0);  
end  
  
CumuPixel = cumsum(ProbPixel);  
CumuPixel = uint8(255 .* CumuPixel + 0.5);  
  
for i = 1:height  
    for j = 1: width  
        V(i,j) = CumuPixel(V(i,j));  
    end  
end  
   
V = im2double(V);  
hsvImg(:,:,3) = V;  
outputImg = hsv2rgb(hsvImg); 
subplot(223);
imshow(outputImg);  
title('HSV彩色直方图均衡化');