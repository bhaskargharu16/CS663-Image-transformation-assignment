function im= myShrinkImageByFactorD(d)
    I = imread("../data/circles_concentric.png");
    sz = size(I);
    n = sz(1);
    im = I(d:d:n,d:d:n);
end
