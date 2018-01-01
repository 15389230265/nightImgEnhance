clear all;
clc;
close all;
IMG = imread('img2.jpg');
c=80;
[wid,len,height]=size(IMG);
sum=0;
si = c*2+1;
f=zeros(si);
for i=0:si-1
    for j=0:si-1
        f(i+1,j+1)=exp(-((i-c)^2+(j-c)^2)/c^2);
        sum=sum+f(i+1,j+1);
    end
end
k=1/sum;
newIMG=zeros(size(IMG));
for t=1:3
    w=IMG(:,:,t);
    w=double(w);
    f=k.*f;
    q=imfilter(w,f,'replicate','conv');
    q=double(q);
    newIMG(:,:,t)=(log(w+1.)-log(q));
    a=newIMG;
end
for t=1:3
%---------------------------------------------------------------
%     maxium=max(max(newIMG(:,:,t)));
% %     minium=min(min(newIMG(:,:,t)));
%     minium=0;
%     for i=1:wid
%         for j=1:len
%             if newIMG(i,j,t)<0
%                 newIMG(i,j,t)=0;
%             end
%             newIMG(i,j,t)=255*((newIMG(i,j,t)-minium)/(maxium-minium));
%         end
%     end
% %     newIMG(:,:,t)=round(exp(newIMG(:,:,t).*5.54));
%---------------------------------------------------------------
    G=30;
    B=-6;
    I=double(IMG(:,:,t));
    Ij=0;
%     Ij=sum(sum(I));
    for i=1:wid
        for j=1:len
            Ij=Ij+I(i,j);
        end
    end
    alpha=125;
    beta=1;
    Ci=zeros(size(IMG));
    Ii=Ci;
    for i=1:wid
        for j=1:len
%            newIMG(i,j,t)=(newIMG(i,j,t)-B).*G;
           Ii(i,j,t)=I(i,j)./Ij;
        end
    end
    Ci=(log((Ii.*alpha))).*beta;
    newIMG=newIMG.*Ci;
end
subplot(1,2,1);imshow(IMG);title('原始图像');
subplot(1,2,2);imshow(newIMG);title('SSR增强后的图像');