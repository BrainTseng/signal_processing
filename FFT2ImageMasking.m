
Image=imread('image.jpg');
Gray_Image=rgb2gray(Image);

%FFT
figure
subplot(2,3,1)
imshow(Gray_Image,[]);title('original image');colormap('gray');

FftImage=fft2(Gray_Image);
%frequency spectrum
subplot(2,3,2)
imshow(log(abs(fftshift(FftImage))),[]);title('frequency spectrum');

%phase spectrum
subplot(2,3,3)
real_image=real(FftImage);
Imag_image=imag(FftImage);
imshow(log(angle(fftshift(FftImage))),[]);title('phase spectrum');

%reconstruction
subplot(2,3,4)
ReconOriImage=ifft2(FftImage);
imshow(ReconOriImage,[]);title('recon image')

%Masking/filtering in the frequency domain
height=size(FftImage,1);
width=size(FftImage,2);
mask=zeros(height,width);
n=5;
mask(n:n+100,:)=1;
mask(:,n:n+100)=1;
ShiftMask=fftshift(mask);
AfterMask=mask.*FftImage;
ReconImage=ifft2((mask.*FftImage));% 
subplot(2,3,5)
imshow(ReconImage,[]);title('after masking')
fprintf('finished \n')

