%%HistogramEqualization
function [Hist_img] = myHE(I)
    Hist_img = I;
    [rows, columns, channels]= size(I);
    for i= 1:channels;
        [A, B] = imhist(I(:,:,i));
        cdf = cumsum(A/ sum(A));
        T = ((size(A,1)-1)* cdf);
        Hist_img(:,:,i) = T(I(:,:,i)+1);  
    end
end




