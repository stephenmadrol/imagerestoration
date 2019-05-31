close all; 
%................Using Fourier Transforms.................
%image preprocessing
y = rgb2gray((imread('capture2.jpg')));
y = im2double(y); 
 
%take disk psf
PSF = fspecial('disk', 8);
%convolve image with psf
%or use imfilter w/ 'conv'
yblur = conv2(y,PSF); 
 
%plot original image
figure(); 
subplot(2,1,1); imshow(y); title('actual image'); 
%plot unnoisy blurred image
subplot(2,1,2); imshow(yblur); title('blurred image');  
 
%add noise at different levels to the blurred image
y2BlurredNoisy = imnoise(yblur,'gaussian',0,.0000000000001);
y3BlurredNoisy = imnoise(yblur,'gaussian',0,.00000000001);
y4BlurredNoisy = imnoise(yblur, 'gaussian', 0,.000001); 
 
%plot different noisy blurred images
figure(); 
subplot(2,4,1); imshow(yblur); title('no noise');
subplot(2,4,2); imshow(y2BlurredNoisy); title('Gaussian white noise of variance 10^{-13}'); 
subplot(2,4,3); imshow(y3BlurredNoisy); title('Gaussian white noise of variance 10^{-11}');
subplot(2,4,4); imshow(y4BlurredNoisy); title('Gaussian white noise of variance 10^{-6}');
 
%use simple X = Y/H to get back original image
%show how much noise affects it
Y1 = fft2(yblur); 
Y2 = fft2(y2BlurredNoisy);
Y3 = fft2(y3BlurredNoisy); 
Y4 = fft2(y4BlurredNoisy); 
 
%zero pad the psf to match the size of the blurred image
%noisy images are all the same size, thus do not require unique PSF's
newh = zeros(size(yblur)); 
psfsize = size(PSF); 
newh(1: psfsize(1), 1:psfsize(2))= PSF;
H = fft2(newh); 
 
%use simple X = Y/H to get back original image
%show how much noise affects it
y1deblurred = ifft2(Y1./H);
y2deblurred = ifft2(Y2./H); 
y3deblurred = ifft2(Y3./H); 
y4deblurred = ifft2(Y4./H); 
 
%plot deblurred images
subplot(2,4,5);imshow(y1deblurred);title('no noise');
subplot(2,4,6);imshow(y2deblurred);title('Gaussian white noise of variance 10^{-13}');
subplot(2,4,7);imshow(y3deblurred);title('Gaussian white noise of variance 10^{-11}');
subplot(2,4,8);imshow(y4deblurred);title('Gaussian white noise of variance 10^{-6}');
