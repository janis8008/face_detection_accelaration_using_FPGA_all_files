%Iegustam attelu
clear
img=imread('humface2.jpg');
siz=size(img);
R=img(:,:,1);
V=img(:,:,2);
B=img(:,:,3);

img_R(:,:,1)=R;
img_V(:,:,2)=V;
img_B(:,:,3)=B;

Y = 0.299*R+0.587*V+0.114*B;

img_Y(:,:,1) = Y;
img_grey=img_Y(:,:,1);
figure(3)
imshow(img_grey)

kf=44;
kordx = 61 ;
kordy = 40;

%kolonna 1
piere1=img_grey(kordy,kordx)
acs1=img_grey(kordy+kf,kordx)
vaigs1=img_grey(kordy+2*kf,kordx)
vaigs2=img_grey(kordy+3*kf,kordx)
%kolonna 2
piere2=img_grey(kordy,kordx+kf)
starp_acim=img_grey(kordy+kf,kordx+kf)
starp_vaigiem=img_grey(kordy+2*kf,kordx+kf)
lupas=img_grey(kordy+3*kf,kordx+kf) 
%kolonna 3
piere3=img_grey(kordy,kordx+2*kf)
acs2=img_grey(kordy+kf,kordx+2*kf)
vaigs3=img_grey(kordy+2*kf,kordx+2*kf)
vaigs4=img_grey(kordy+3*kf,kordx+2*kf)
rectangle('Position',[kordx,kordy,2*kf,3*kf],'LineWidth',1,'LineStyle','-')
rectangle('Position',[kordx+kf,kordy,kf,kf],'LineWidth',1,'LineStyle','-')
rectangle('Position',[kordx,kordy+kf,kf,kf],'LineWidth',1,'LineStyle','-')
rectangle('Position',[kordx+kf,kordy+2*kf,kf,kf],'LineWidth',1,'LineStyle','-')