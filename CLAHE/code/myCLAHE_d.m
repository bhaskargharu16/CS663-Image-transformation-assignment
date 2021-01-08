function X = myCLAHE_d(path,g,t)
A = imread(path);
sz = size(A);
m = sz(1);
n = sz(2);
X = uint8(zeros(sz)); 
val=0;
gridSize=g;
threshold = t;
display(threshold);
for i=1:m
    for j=1:n
        x = size(sz);
        if(x(2)==3)
            val = 3;
        cnt = (zeros(val,256));
        for i1=max(1,i-floor(gridSize/2)):min(m,i+floor(gridSize/2))
            for j1 = max(1,j-floor(gridSize/2)):min(n,j+floor(gridSize/2))
                for k = 1:val
                cnt(k,A(i1,j1,k)+1)= cnt(k,A(i1,j1,k)+1)+1;
                end
            end
        end
        
        cnt = double(cnt);
        var = zeros(1,sz(3));
        for i1=1:256
            for j1=1:val
          %  curr(1,j1)=curr(1,j1)+cnt(j1,i1)/((min(m,i+floor(gridSize/2))-max(1,i-floor(gridSize/2)))*(min(m,j+floor(gridSize/2))-max(1,j-floor(gridSize/2))));
            cnt(j1,i1)=cnt(j1,i1)/((min(m,i+floor(gridSize/2))-max(1,i-floor(gridSize/2)))*(min(n,j+floor(gridSize/2))-max(1,j-floor(gridSize/2))));
            if(cnt(j1,i1)>threshold)
                var(1,j1)=cnt(j1,i1)-threshold;
                cnt(j1,i1)=threshold;
            end
            end
        end
            curr=zeros(1,sz(3));
            var(1,1)=var(1,1)/256;
            var(1,2)=var(1,2)/256;
            var(1,3)=var(1,3)/256;
            for i1=1:256
                for j1=1:val
                    cnt(j1,i1)=cnt(j1,i1)+var(1,j1);
                    curr(1,j1)=curr(1,j1)+cnt(j1,i1);
                    cnt(j1,i1)=round(curr(1,j1)*255);
                end
            end

                for k = 1:val
                X(i,j,k) = cnt(k,A(i,j,k)+1);
                end
        else 
                cnt = (zeros(1,256));
            for i1=max(1,i-floor(gridSize/2)):min(m,i+floor(gridSize/2))
                for j1 = max(1,j-floor(gridSize/2)):min(n,j+floor(gridSize/2))
                    cnt(1,A(i1,j1)+1)= cnt(1,A(i1,j1)+1)+1;
                end
            end
            curr=0;
            var=0;
            cnt = double(cnt);
            curr= double(curr);
            var = double(var);
            for i1=1:256
               % curr=curr+cnt(1,i1)/((min(m,i+floor(gridSize/2))-max(1,i-floor(gridSize/2)))*(min(m,j+floor(gridSize/2))-max(1,j-floor(gridSize/2))));
                cnt(1,i1)=cnt(1,i1)/((min(m,i+floor(gridSize/2))-max(1,i-floor(gridSize/2)))*(min(n,j+floor(gridSize/2))-max(1,j-floor(gridSize/2))));
                if(cnt(1,i1)>threshold)
                    var = cnt(1,i1)-threshold;
                    cnt(1,i1)= threshold;
                end
            end
             var = var/256;
           % display(var);
            for i1=1:256
                cnt(1,i1)=cnt(1,i1)+var;
                curr=curr+cnt(1,i1);
                cnt(1,i1)=round(curr*255);
            end
                    X(i,j) = cnt(1,A(i,j)+1);
        end
    end
end
% imshow([A,X])
% colorbar
% %display(A);
% imwrite(X,"C:\Users\Dhananjay Singh\Documents\Semester 5\DIP\assignment-1-transformations\2\data\chestXrayCLAHE150_0.02.png")
end