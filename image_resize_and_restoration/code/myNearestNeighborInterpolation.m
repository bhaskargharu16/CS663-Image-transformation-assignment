function im = myNearestNeighborInterpolation()
    I = imread('../data/barbaraSmall.png');
    [m,n] = size(I);
    im = zeros(3*m-2,2*n-1);
    im(1:3:3*m-2,1:2:2*n-1) = I;
    im(1:3:3*m-2,2:2:2*n-1) = I(:,1:n-1);
    im(2:3:3*m-2,1:2:2*n-1) = I(1:m-1,:);
    im(2:3:3*m-2,2:2:2*n-1) = I(1:m-1,1:n-1);
    im(3:3:3*m-2,1:2:2*n-1) = I(2:m,:);
    im(3:3:3*m-2,2:2:2*n-1) = I(2:m,1:n-1);

end
