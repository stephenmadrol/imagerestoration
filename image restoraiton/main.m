clc;
close all;
 %*********IMAGE RESTORATION***************
y = imread('capture.jpg');
y = rgb2gray(y);
y = im2double(y);
%figure,imshow(y);
%.........Bluring an image..............% 
PSF = fspecial('disk', 10);
yblur = conv2(y,PSF); 
%figure,imshow(yblur);
%...................wiener deconvolution method of restoring.................
wd = deconvwnr(yblur, PSF, 0.005);
%figure,imshow(wd)  
   %.............using blind deconv
psf2 = fspecial('disk', 5.4);
bd = deconvblind(yblur, PSF, 18);
%figure,imshow(bd)
subplot(2,2,1);imshow(y);title('Original')
subplot(2,2,2);imshow(yblur);title('Blured Image')
subplot(2,2,3);imshow(wd);title('Weiner restoration')
subplot(2,2,4);imshow(bd);title('Blind Deconv')