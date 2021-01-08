function im=myImageRotation()
  I = imread('../data/barbaraSmall.png');
  [m,n] = size(I);
  mr = ceil(((sqrt(3)+1)/2)*m);
  nr = ceil(((sqrt(3)+1)/2)*n);
  im = zeros(m,n);
  ox = 0;
  oy = (n/2);
  for x=0:mr-1
    for y=0:nr-1
      X = (x-ox)*cosd(-30) +(y-oy)*sind(-30);
      Y = (ox-x)*sind(-30) +(y-oy)*cosd(-30);
      iX = floor(X)+1;
      iY = floor(Y)+1;
      Q11=0;
      Q12=0;
      Q21=0;
      Q22=0;
      if iX>=1&&iX<=m&&iY>=1&&iY<=n
        Q11 = I(iX,iY);
      else
        Q11 = 0;
      end

      if iX>=1&&iX<=m&&iY>=0&&iY<=n-1
        Q12 = I(iX,iY+1);
      else
        Q12 = 0;
      end

      if iX>=0&&iX<=m-1&&iY>=1&&iY<=n
        Q21 = I(iX+1,iY);
      else
        Q21 = 0;
      end

      if iX>=0&&iX<=m-1&&iY>=0&&iY<=n-1
        Q22 = I(iX+1,iY+1);
      else
        Q22 = 0;
      end
      iX = iX-1;
      iY = iY-1;
      im(x+1,y+1) = Q11*(X-iX)*(Y-iY);
      im(x+1,y+1) = im(x+1,y+1) + Q12*(iX+1-X)*(Y-iY);
      im(x+1,y+1) = im(x+1,y+1) + Q21*(X-iX)*(iY+1-Y);
      im(x+1,y+1) = im(x+1,y+1) + Q22*(iX+1-X)*(iY+1-Y);



    end
  end
end
