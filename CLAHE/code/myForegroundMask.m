%%ForegroundMask a)
function [fore_img, fore_img1 ,masked_img,masked_img1, binarymask] = myForegroundMask(img, K)
    binarymask = img >= K;
    fore_img  = 255* binarymask;
    fore_img1 = medfilt2(medfilt2(255 * binarymask)); %%Medianfilter twice, to de-noise image
    binarymask = uint8(binarymask);
    masked_img = img .* binarymask;
    masked_img1 = img .* binarymask;
    masked_img1( masked_img1 == 0)= 140;  
    masked_img1 = medfilt2(medfilt2(masked_img1));
end
    


