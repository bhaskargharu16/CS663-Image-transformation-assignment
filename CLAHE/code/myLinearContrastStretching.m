%%LinearContrastStretching b)
function [cont_img] = myLinearContrastStretching(I)
    [rows, columns, channels]= size(I);
    cont_img = zeros(size(I));
    for i = 1:channels;
        max_I = max(max(I(:,:,i)));
        min_I = min(min(I(:,:,i)));
        t = double(max_I - min_I);
        cont_img(:,:,i) = double(((255 - 0) / t) * (I(:,:,i) - min_I ) + 0 );
%         cont_img = uint8(cont_img);
    end
end
