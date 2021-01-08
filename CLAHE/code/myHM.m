%%HistogramMatching
function [Histm_img]= myHM(I_orig, I_ref)
    [rows, columns, channels] = size(I_orig);
    [rowsr, columnsr, channelsr]= size(I_ref);
    Histm_img = I_orig;

    for i= 1:channels;
        [A,B] = imhist(I_orig(:,:,i));
        [C,D] = imhist(I_ref(:,:,i));
        T = zeros(size(A,1),1, 'uint8');
        cdf_or = cumsum(A/ sum(A));
        cdf_ref= cumsum(C/ sum(C));
        for j = 1:size(A,1);
            [S,Q] = min(abs(cdf_or(j)- cdf_ref));
            T(j)= Q - 1;  %%Since, the intensities should be in [0,255]
        end
        Histm_img(:,:,i) = T(double(I_orig(:,:,i))+1);  %% To index the array T in [1,256]
    end