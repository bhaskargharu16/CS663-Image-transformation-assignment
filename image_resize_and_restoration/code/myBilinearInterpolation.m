function im = myBilinearInterpolation()
    I = imread('../data/barbaraSmall.png');
    I = double(I);
    sz = size(I);
    m = sz(1);
    n = sz(2);
    I(m+1,n+1) = 0;
    im = zeros(3*m-2,2*n-1);
    for i=1:3*m-2
        for j = 1:2*n-1
            x1 = 3*floor((i-1)/3)+1; x2 = x1+3;
            y1 = 2*floor((j-1)/2)+1;y2 = y1+2;
            Q11 = I(floor((x1-1)/3)+1,floor((y1-1)/2)+1);
            Q12 =  I(floor((x1-1)/3)+1,floor((y2-1)/2)+1);
            Q21 =  I(floor((x2-1)/3)+1,floor((y1-1)/2)+1);
            Q22 =  I(floor((x2-1)/3)+1,floor((y2-1)/2)+1);
            im(i,j) = Q11*(x2-i)*(y2-j)/((x2-x1)*(y2-y1));
            im(i,j) = im(i,j) + Q12*(x2-i)*(j-y1)/((x2-x1)*(y2-y1));
            im(i,j) = im(i,j) + Q21*(i-x1)*(y2-j)/((x2-x1)*(y2-y1));
            im(i,j) = im(i,j) + Q22*(i-x1)*(j-y1)/((x2-x1)*(y2-y1));
        end
    end

end
