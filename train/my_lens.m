function [g] = my_lens ( f, x )

%getting size of the input image
R = size(f,1);
C = size(f,2);
 
gimg = rgb2gray(f);
% gimg = im2bw(img,.50);
 
% histogram equalization========================================== 
% hist = imhist(gimg(:,:));
% maxIntensity = 255;  
% cdf_v(1)= hist(1);
% for i=2:maxIntensity+1
%     cdf_v(i) = hist(i) + cdf_v(i-1);
% end
% cdf_v = cdf_v/double(numel(gimg))*255.0;
% gimg = uint8( cdf_v ( gimg+1));
%=================================================================
 
%Column mean vector
cmv = mean( gimg, 1 );
%Row mean vector
rmv = mean( gimg, 2 );
 
edgeSensitivity = 50;

cmaxdiff = 0;
cEndDiff = 0;
for i=edgeSensitivity+1 : C
    diff = cmv(1,i) - cmv(1,i-edgeSensitivity);
    if diff > cmaxdiff
        cmaxdiff = diff;
        cmaxindex = i;
    end
    if diff < cEndDiff
        cEndDiff = diff;
        cEndindex = i;
    end
end

rmaxdiff = 0;
rEndDiff = 0;
for i=edgeSensitivity+1 : R
    diff = rmv(i,1) - rmv(i-edgeSensitivity,1);
    if diff > rmaxdiff
        rmaxdiff = diff;
        rmaxindex = i;
    end
    if diff < rEndDiff
        rEndDiff = diff;
        rEndindex = i;
    end
end

%This is temporary hack.
if(rEndindex - rmaxindex > 0 && cEndindex - cmaxindex > 0)
  result = gimg(rmaxindex:rEndindex,cmaxindex:cEndindex);  
else
  result = gimg(1:500,1:500);   
end

processed = result;
for r=1 : size(result,1)
    for c=1 : size(result,2)
        processed(r,c) = min(255,result(r,c) * 1.5);
    end
end

processed = cat ( 3, processed, processed, processed );
g = imresize ( processed, x );





















% %getting size of the input image
% Ro = size(f,1);
% Co = size(f,2);
% 
% % convert to grayscale
% im_g = rgb2gray ( f );
% 
% % histogram equalization 
% hist   = imhist(im_g(:,:)); 
% maxIntensity = 255;  
% cdf_v(1)= hist(1);
% for i=2:maxIntensity+1
%     cdf_v(i) = hist(i) + cdf_v(i-1);
% end
% 
% cdf_v = cdf_v/double(numel(im_g))*255.0;
% 
% im_e = uint8( cdf_v ( im_g+1));
% 
% 
% % do not crop.  convert to color
% g = cat ( 3, im_e, im_e, im_e );
% 
% 
% % resize
% g = imresize ( g, x );
