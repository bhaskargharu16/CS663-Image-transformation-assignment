%% MyMainScript

tic;
%% Your code here  
im1 = imread("../data/finalwrong.jpg");
im = rgb2gray(im1);
%Strictly use rgb image, this converts rgb to gray.
%For using gray images, comment out the second line and change var name
%from im1 -> im.

si=size(im);
r=si(1);
c=si(2);
pmf = zeros(1,256);

for i = 1:r
    for j = 1:c
        pmf(im(i,j)+1)=pmf(im(i,j)+1)+1;
    end
end

cdf = zeros(1,256);
cdf(1)=pmf(1)/(r*c);
for i = 2:size(pmf,2)
    cdf(i)=cdf(i-1)+pmf(i)/(r*c);
end

pmf_y = zeros(1,256);
for i = 1:256
    t_ind=round(cdf(i)*255);
    pmf_y(t_ind+1)=pmf_y(t_ind+1)+pmf(i);
end

tim=zeros(r,c);
for i = 1:r
    for j = 1:c
        tim(i,j)=(cdf(im(i,j)+1)*255);
    end
end

colormap (gray(256));
imagesc(im,[0,255]); colorbar;
daspect ([1 1 1]);
axis tight;
colorbar
title("image original")


figure, colormap(gray(256)), imagesc(tim,[0,255]); colorbar;
daspect ([1 1 1]);
axis tight;
colorbar
title("image normal equalised")

m1=0;
for i = 1:size(cdf,2)
    if cdf(i)<=0.50
        m1=i-1;
    else
        break;
    end
end

area1=cdf(m1+1);
area2=cdf(size(cdf,2))-area1;
y1=area1/m1;
y2=(1-area1)/(255-m1);
trans=zeros(1,256);
for i = 1:m1+1
    trans(i)=cdf(i)/y1;
end

for i = m1+2:size(trans,2)
    trans(i)=(((cdf(i)-area1)/y2)+m1);
end

tim1=zeros(r,c);
for i = 1:r
    for j = 1:c
        tim1(i,j)=(trans(im(i,j)+1));
    end
end


figure, 
colormap(gray(256)),
imagesc(tim1,[0,255]); colorbar;
daspect ([1 1 1]);
axis tight;
colorbar
title("image median equalised")

pmf_y1=zeros(1,256);
pmf_y2=zeros(1,256);
for i = 1:r
    for j = 1:c
        pmf_y1(round(tim(i,j))+1)=pmf_y1(round(tim(i,j))+1)+1;
    end
end

for i = 1:r
    for j = 1:c
        pmf_y2(round(tim1(i,j))+1)=pmf_y2(round(tim1(i,j))+1)+1;
    end
end
figure, bar(pmf)
title("pmf original")
figure, bar(pmf_y1)
title("pmf normal equalised")
figure, bar(pmf_y2)
title("pmf median equalised")
toc;

