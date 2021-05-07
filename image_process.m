 clear all, close all ;  clc;
 I1=imread('3096.jpg');
 I2=imnoise(I1,'salt & pepper',0.2);
   
   
 IN=filtre(I2);
 
%    psnr_degeri_noisy=psnr(I1,I2);
%    psnr_degeri_ASWMF=psnr(I1,IN);
%    psnr_degeri_median=psnr(I1,I3);  
%    ssim_degeri_ASWMF=ssim(I1,IN);
%    ssim_degeri_noisy=ssim(I1,I2);
%    ssim_degeri_median=ssim(I1,I3);
   
  
figure; imshow(I1); title('orjinal görüntü');
figure; imshow(I2); title('gürültülü görüntü');
figure; imshow(IN); title('ASWMF görüntü');
% figure; imshow(I3); title('median filtreli görüntü');


function [u] = filtre(v)
    h = 3;
    I = padarray(v, [h h], 'symmetric');  %bütün pixelleri gezmek için h boyutu kadar disi kapladim
    for i = h+1:size(I,1)-h
        for j=h+1:size(I,2)-h
            if I(i,j)==0 || I(i,j)==255
               I(i,j) = yeni_deger_hesapla(I, i, j, h); 
            end
        end
    end
    u = I(h+1:size(I,1)-h,h+1:size(I,2)-h);
end

function [yeni_gri_deger]= yeni_deger_hesapla(Imge, ii, jj, hh)

w1=1;w2=1;w3=10;
blok = Imge(ii-hh:ii+hh, jj-hh:jj+hh); % 7*7 boyutunda filtre tasarladim

[H1,W1]=size(blok);  
  
   for  ii=1:1:H1
    for jj=1:1:W1 
        if ii==jj  
           k1(ii,jj)=blok(ii,jj); %1. kosegeni buldum
        end
    end
   end

    for ii=1:1:H1
    for jj=1:1:W1
if   ii+jj ==8
    k2(ii,jj)=blok(ii,jj) ; %2. kosegeni buldum
elseif  blok(ii)+blok(jj)~=8
    k2(ii,jj)=0;
end
    end
    end

for ii=1:1:H1
    for jj=1:1:W1
if ii==jj || ii+jj==8 
  k3(ii,jj)=0;
else
    k3(ii,jj)=blok(ii,jj);   % kosegen disindaki elemanlari aldim.
end
    end
end
 
  h=3;
  ks1=(h*2)+1; ks2= (h*2)+1 ; ks3=(ks1-1)^2; % k1,k2,k3 ' ün kaç tane elemani oldugunu hesapladim.
  yeni_gri_deger =uint8((w1*sum(sum(k1))+w2*sum(sum(k2))+w3*sum(sum(k3)))/(w1*ks1+w1*ks2+w3*ks3));
 end

