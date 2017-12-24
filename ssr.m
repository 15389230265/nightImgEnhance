IMG = imread('img1.jpg');
c=3;
[wid,len,height]=size(IMG);
sum=0;
si = c*2+1;
for i=0:si-1
    for j=0:si-1
        f(i+1,j+1)=exp(-((i-c)^2+(j-c)^2)/c^2);
        sum=sum+f(i+1,j+1);
    end
end
k=1/sum;
for t=1:3
    w=IMG(:,:,t);
    w=double(w);
    f=k.*f;
    q=conv2(w,f,'same');
    q=double(q);
    newIMG(:,:,t)=(log(w)-log(q));
    maxium=max(max(newIMG(:,:,t)));
    minium=min(min(newIMG(:,:,t)));
    for i=1:wid
        for j=1:len
            newIMG(i,j,t)=(newIMG(i,j,t)-minium)/(maxium-minium);
        end
    end
end
subplot(1,2,1);imshow(IMG);title('原始图像');
subplot(1,2,2);imshow(newIMG);title('SSR增强后的图像');