function  clahed_img = myCLAHE(I, windowsize, histogram_threshold)
    r = windowsize/2;
    [m,n,l] = size(I);
    clahed_img = zeros(m,n,l);
    for z=1:l
        histogram = zeros(256,1);
        for row=1:m
            uppermost_row = max(1,row-r);
            lowermost_row = min(m,row+r);
            if mod(row,2) ~= 0
                for column = 1:n
                    if row == 1 && column == 1
                        for k=1:r
                            for h = 1:r-1
                                intensity = I(k,h,z) + 1;
                                histogram(intensity) = histogram(intensity)+1;
                            end
                        end
                    end
                    remove_column = column - r -1;
                    add_column = column + r;
                    if (remove_column >= 1)
                        for row_num=uppermost_row:lowermost_row
                            intensity = I(row_num,remove_column,z)+1;
                            histogram(intensity) = histogram(intensity) - 1;
                        end
                    end
                    if (add_column <= n)
                        for row_num=uppermost_row:lowermost_row
                            intensity = I(row_num,add_column,z)+1;
                            histogram(intensity) = histogram(intensity) + 1;
                        end
                    end
                    centre_intensity_index = I(row,column,z)+1;
                    collect = 0;
                    copy_hist = histogram/sum(histogram);
                    for k=1:256
                        if (copy_hist(k) > histogram_threshold)
                            collect = collect + (copy_hist(k) - histogram_threshold);
                            copy_hist(k) = histogram_threshold;
                        end
                    end
                    cdf = 0;
                    share = collect/256;
                    for k = 1:centre_intensity_index
                        cdf = cdf+copy_hist(k) + share;
                    end
                    clahed_img(row,column,z) = cdf*255;
                end
            else
                for column = n:-1:1
                    remove_column = column + r+1;
                    add_column = column - r;
                    if (remove_column <= n && remove_column >=1)
                        for row_num=uppermost_row:lowermost_row
                            intensity = I(row_num,remove_column,z)+1;
                            histogram(intensity) = histogram(intensity) - 1;
                        end
                    end
                    if (add_column >= 1 && add_column <=n)
                        for row_num=uppermost_row:lowermost_row
                            intensity = I(row_num,add_column,z)+1;
                            histogram(intensity) = histogram(intensity) + 1;
                        end
                    end
                    centre_intensity_index = I(row,column,z)+1;
                    collect = 0;
                    copy_hist = histogram/sum(histogram);
                    for k=1:256
                        if (copy_hist(k) > histogram_threshold)
                            collect = collect + (copy_hist(k) - histogram_threshold);
                            copy_hist(k) = histogram_threshold;
                        end
                    end
                    cdf = 0;
                    share = collect/256;
                    for k = 1:centre_intensity_index
                        cdf = cdf+copy_hist(k) + share;
                    end
                    clahed_img(row,column,z) = cdf*255;
                end
            end
        end
    end
end