img = imread('data/Office_Lens_Input_3.jpg');
%getting size of the input image
R = size(img,1);
C = size(img,2);
%.70 for first
 
 
%histogram equalization
%contrast enhancement
%How to crop
%   Convert to greyscale
%   Plot intensity as columns, go left to right and find edge
%   plot( mean( g, 2 ) ) ;
%   plot( mean( g, 1 ) ) ;

imshow(img);
pause();
% gimg = im2bw(img,.50);
 
gimg = rgb2gray(img); 
% histogram equalization========================================== 
% hist = imhist(gimg(:,:));
% maxIntensity = 255;  
% cdf_v(1)= hist(1);
% for i=2:maxIntensity+1
%     cdf_v(i) = hist(i) + cdf_v(i-1);
% end
% cdf_v = cdf_v/double(numel(gimg))*255.0;
% gimg = uint8( cdf_v ( gimg+1));
%gimg = histeq(gimg,256);
%=================================================================
%Show equalized 
imshow(gimg);
pause();
 
%Column mean vector
cmv = mean( gimg, 1 );
%Row mean vector
rmv = mean( gimg, 2 );

%plot(cmv);
%pause();
 
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
disp('---Left n Right--');
disp(cmaxindex);
disp(cmaxdiff);
% plot(cmv);

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
disp('---Top n Bottom--');
disp(rmaxindex);
disp(rmaxdiff);
% plot(rmv);

imshow(result);
pause();

result = img(rmaxindex:rEndindex,cmaxindex:cEndindex,:);
processed = result;
for r=1 : size(result,1)
    for c=1 : size(result,2)
        processed(r,c,:) = min(255,result(r,c,:) * 1.5);
    end
end


imshow(processed);
pause();
close;

 

