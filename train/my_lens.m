function [g] = my_lens ( f, x )

%getting size of the input image
R = size(f,1);
C = size(f,2);

%This is how many columns/rows that the intensity slope is measured.
edgeSensitivity = 50;
%This is how much the contrast will be multiplied by
contrastMod = 1.5;

%Obtain grayscale representation.
gimg = rgb2gray(f);
 
%Column mean vector
cmv = mean( gimg, 1 );
%Row mean vector
rmv = mean( gimg, 2 );

%============Left and Right Paper Edges====================
cmaxdiff = 0;
cEndDiff = 0;
for i=edgeSensitivity+1 : C
    diff = cmv(1,i) - cmv(1,i-edgeSensitivity);
    if diff > cmaxdiff
        %Find the max difference ( Left Edge )
        cmaxdiff = diff;
        cmaxindex = i;
    end
    if diff < cEndDiff
        %Find the min difference ( Right Edge )
        cEndDiff = diff;
        cEndindex = i;
    end
end

%============Top and Bottom Paper Edges====================
rmaxdiff = 0;
rEndDiff = 0;
for i=edgeSensitivity+1 : R
    diff = rmv(i,1) - rmv(i-edgeSensitivity,1);
    if diff > rmaxdiff
        %Find the max difference ( Top Edge )
        rmaxdiff = diff;
        rmaxindex = i;
    end
    if diff < rEndDiff
        %Find the max difference ( Bottom Edge )
        rEndDiff = diff;
        rEndindex = i;
    end
end


if(rEndindex - rmaxindex > 0 && cEndindex - cmaxindex > 0)
  %Crop out the result based on the indexes found above.
  result = gimg(rmaxindex:rEndindex,cmaxindex:cEndindex);  
else
  %This is temporary hack.
  result = gimg(1:500,1:500);   
end

processed = result;
%Point Transformation for multiplication contrast enhancement.
for r=1 : size(result,1)
    for c=1 : size(result,2)
        processed(r,c) = min(255,result(r,c) * contrastMod);
    end
end

%Convert the processed greyscale image into RGB.
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

