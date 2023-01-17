%% EXPERIMENT 7 
% GROUP 2
clear;  
%%
clc; close all;

%% Part a
A = imread('cameraman.tif');
B = imread('lena.png');
figure
imshow(A)
figure
imshow(B)

%% Part b
AFFT=fft2(A);
AFFT_max=AFFT/max(max(abs(AFFT)));
AFFT_10 = AFFT/10000;
figure
mesh(abs(fftshift(AFFT)));
figure
imshow(fftshift(abs(AFFT_max)));
figure
imshow(fftshift(abs(AFFT_10)));

%% Part c
X= [1 2 3 4; 5 6 7 8; 9 10 11 12];
Y = fft2(X)
for k = 1:size(X,1)
    Z(k,:) = fft(X(k,:));
end
Z
for k = 1:size(X,2)
    T(:,k) = fft(Z(:,k));
end
T

%% Part d
AFFTP = angle(AFFT);
phase = exp(1i*AFFTP);
BFFT = fft2(imresize(B,1/2));
BFFT=BFFT/max(max(abs(BFFT)));
ReconA1 = ones(256,256).*phase;
ReconA2 = rand(256,256).*phase;
ReconA3 = abs(BFFT).*phase;
figure
imshow(mat2gray(real(ifft2(ReconA1))));
figure
imshow(mat2gray(real(ifft2(ReconA2))));
figure
imshow(mat2gray(real(ifft2(ReconA3))));

%% Part e
h1=1/4248*[  92    35    75    96    22    39    70    30    81;
 		     82    40    38    34   100    49    36     3     3;
 		     16    66    60    71    57    88    80     8    21;
 		     82    37    15    93    81    90    98    17    91;
    		 82     9     4    41    52    92    68    34    82;
  		     49    37    56    54    84     6    62    98    50;
  		     82     9    28    88     9    36    73    83    40;
              2    58     2    40    48    38    54    79    19;
   		     80    77     6    54    58    50    35    60    84;  ];
    
H1FFT = fft2(h1,256,256);
H1FFT=H1FFT/max(max(abs(H1FFT)));
H1FFTP = angle(H1FFT);
figure
mesh(abs(fftshift(H1FFT)));
figure
mesh(fftshift(H1FFTP));
 
ha=[1 2 3 4 5 4 3 2 1];
hb=[1 1 2 2 3 2 2 1 1];
h2 = (ha'*hb)/sum(sum(ha'*hb));
H2FFT = fft2(h2,256,256);
H2FFT=H2FFT/max(max(abs(H2FFT)));
H2FFTP = angle(H2FFT);
figure
mesh(abs(fftshift(H2FFT)));
figure
mesh(fftshift(H2FFTP));

figure
imshow(mat2gray(filter2(h1,double(A))));
figure
imshow(mat2gray(filter2(h2,double(A))));
figure
imshow(mat2gray(filter2(h1,double(B))));
figure
imshow(mat2gray(filter2(h2,double(B))));

%% Part f
%% i)
BH2 = ifft2(fft2(B,512,512).*fft2(h2,512,512)) + randn(512,512);
std_dev1 = 10;
std_dev2 = 100;
B10H2 = ifft2(fft2(B,512,512).*fft2(h2,512,512)) + std_dev1*randn(512,512);
B100H2 = ifft2(fft2(B,512,512).*fft2(h2,512,512)) + std_dev2*randn(512,512);


figure
imshow(mat2gray(BH2));
title('Noise added Lena Image std = 1.0');
H2MAG = abs(fft2(h2,512,512));
H2FFT = fft2(h2,512,512);
H2INV = (H2MAG.^2)./((H2MAG.^2).*H2FFT+1);

ReconBH2 = ifft2(fft2(BH2,512,512).*H2INV);
figure
imshow(mat2gray(ReconBH2));
title('Reconstructed Lena Image std = 1.0');


figure
imshow(mat2gray(B10H2));
title('Noise added Lena Image std = 10.0');
H2MAG = abs(fft2(h2,512,512));
H2FFT = fft2(h2,512,512);
H2INV = (H2MAG.^2)./((H2MAG.^2).*H2FFT+1);

ReconB10H2 = ifft2(fft2(B10H2,512,512).*H2INV);
figure
imshow(mat2gray(ReconB10H2));
title('Reconstructed Lena Image std = 10.0');


figure
imshow(mat2gray(B100H2));
title('Noise added Lena Image std = 100.0');
H2MAG = abs(fft2(h2,512,512));
H2FFT = fft2(h2,512,512);
H2INV = (H2MAG.^2)./((H2MAG.^2).*H2FFT+1);

ReconB100H2 = ifft2(fft2(B100H2,512,512).*H2INV);
figure
imshow(mat2gray(ReconB100H2));
title('Reconstructed Lena Image std = 100.0');


LSE=mean(mean((mat2gray(ReconBH2)-mat2gray(B)).^2));
LSE
LSE10=mean(mean((mat2gray(ReconB10H2)-mat2gray(B)).^2));
LSE10
LSE100=mean(mean((mat2gray(ReconB100H2)-mat2gray(B)).^2));
LSE100
%% ii)


ha_new=[1.0000    7.9139   27.5038   54.7921   68.4044   54.7921   27.5038   7.9139    1.0000];
hb_new=ha_new;
h2_new=(ha_new'*hb_new)/sum(sum(ha_new'*hb_new));





H2NEWMAG = abs(fft2(h2_new,512,512));
H2NEWFFT = fft2(h2_new,512,512);
H2NEWINV = (H2NEWMAG.^2)./((H2NEWMAG.^2).*H2NEWFFT+1);
ReconBH2 = ifft2(fft2(BH2,512,512).*H2NEWINV);
ReconB10H2 = ifft2(fft2(B10H2,512,512).*H2NEWINV);
ReconB100H2 = ifft2(fft2(B100H2,512,512).*H2NEWINV);

figure
imshow(mat2gray(ReconBH2));
title('Reconstructed Lena Image std = 1.0');
figure
imshow(mat2gray(ReconB10H2));
title('Reconstructed Lena Image std = 10.0');
figure
imshow(mat2gray(ReconB100H2));
title('Reconstructed Lena Image std = 100.0');

LSE=mean(mean((mat2gray(ReconBH2)-mat2gray(B)).^2));
LSE
LSE10=mean(mean((mat2gray(ReconB10H2)-mat2gray(B)).^2));
LSE10
LSE100=mean(mean((mat2gray(ReconB100H2)-mat2gray(B)).^2));
LSE100

figure
zplane(roots(ha))
title('ha')
figure
zplane(roots(hb))
title('hb')
figure
zplane(roots(ha_new))
title('ha_{new}')