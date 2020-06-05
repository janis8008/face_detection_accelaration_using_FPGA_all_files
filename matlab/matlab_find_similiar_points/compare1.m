%% img1
img1=imread('ksk1.png');
siz1=size(img1);
%no YCBR panem spilgtuma koef
R1=img1(:,:,1);
V1=img1(:,:,2);
B1=img1(:,:,3);
img_R1(:,:,1)=R1;
img_V1(:,:,2)=V1;
img_B1(:,:,3)=B1;
Y1 = 0.299*R1+0.587*V1+0.114*B1;
img_Y1(:,:,1) = Y1;
img_grey1=img_Y1(:,:,1);

%% img2
img2=imread('ksk2.png');
siz2=size(img2);
%no YCBR panem spilgtuma koef
R2=img2(:,:,1);
V2=img2(:,:,2);
B2=img2(:,:,3);
img_R2(:,:,1)=R2;
img_V2(:,:,2)=V2;
img_B2(:,:,3)=B2;
Y2 = 0.299*R2+0.587*V2+0.114*B2;
img_Y2(:,:,1) = Y2;
img_grey2=img_Y2(:,:,1);

%% img3
img3=imread('ksk3.png');
siz3=size(img3);
%no YCBR panem spilgtuma koef
R3=img3(:,:,1);
V3=img3(:,:,2);
B3=img3(:,:,3);
img_R3(:,:,1)=R3;
img_V3(:,:,2)=V3;
img_B3(:,:,3)=B3;
Y3 = 0.299*R3+0.587*V3+0.114*B3;
img_Y3(:,:,1) = Y3;
img_grey3=img_Y3(:,:,1);

%% img4
img4=imread('ksk4.png');
siz4=size(img4);
%no YCBR panem spilgtuma koef
R4=img4(:,:,1);
V4=img4(:,:,2);
B4=img4(:,:,3);
img_R4(:,:,1)=R4;
img_V4(:,:,2)=V4;
img_B4(:,:,3)=B4;
Y4 = 0.299*R4+0.587*V4+0.114*B4;
img_Y4(:,:,1) = Y4;
img_grey4=img_Y4(:,:,1);

%% img5
img5=imread('ksk5.png');
siz5=size(img5);
%no YCBR panem spilgtuma koef
R5=img5(:,:,1);
V5=img5(:,:,2);
B5=img5(:,:,3);
img_R5(:,:,1)=R5;
img_V5(:,:,2)=V5;
img_B5(:,:,3)=B5;
Y5 = 0.299*R5+0.587*V5+0.114*B5;
img_Y5(:,:,1) = Y5;
img_grey5=img_Y5(:,:,1);


%% processing
koef=80;
kfff=(1-(abs(255-koef))/255)*100 %spilgtuma atskiriba %
sizx=siz1(1);
sizy=siz1(2);
img_compared=zeros(sizx,sizy);
a=0;

for kordx = 1.0:1:sizx
        for kordy = 1.0:1:sizy
            f1=img_grey1(kordx,kordy);
            f2=img_grey2(kordx,kordy);
            f3=img_grey3(kordx,kordy);
            f4=img_grey4(kordx,kordy);
            f5=img_grey5(kordx,kordy);
            if f1 > f2-koef && f1 > f3-koef && f1 > f4-koef && f1 > f5-koef ...
                && f2 > f1-koef && f2 > f3-koef && f2 > f4-koef && f2 > f5-koef ...
                && f3> f1-koef && f3> f2-koef && f3> f4-koef && f3> f5-koef ...
                && f4 > f1-koef && f4 > f2-koef && f4 > f3-koef && f4 > f5-koef ...
                && f5 > f1-koef && f5 > f2-koef && f5 > f3-koef && f5 > f4-koef
                img_compared(kordx,kordy)=f1;
                a=a+1;
            else
            end
            
        end
end
figure(6)
imshow(img_compared)