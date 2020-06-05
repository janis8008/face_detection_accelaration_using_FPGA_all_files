%Iegustam attelu
clear
img=imread('humface2.jpg');
detected_output = csvread('detected_output.txt');
siz=size(img);
%no YCBR panem spilgtuma koef
R=img(:,:,1);
V=img(:,:,2);
B=img(:,:,3);

img_R(:,:,1)=R;
img_V(:,:,2)=V;
img_B(:,:,3)=B;


Y = 0.299*R+0.587*V+0.114*B;
img_Y(:,:,1) = Y;
img_grey=img_Y(:,:,1);


sizx=siz(1); 
sizy=siz(2);

figure(5)
imshow(img)
b=0;
a=0;
kf_spilgtuma=120/256;

for  kf_atstarpes=45:1:45
    for kordx = 1.0:1:round(sizx-3*kf_atstarpes-1) 
        for kordy = 1.0:1:round(sizy-2*kf_atstarpes-1)
            if    detected_output(kordx,kordy) == 1
                a=a+1;
                rectangle('Position',[kordy,kordx,2*kf_atstarpes,2*kf_atstarpes],'LineWidth',1,'LineStyle','-')
                %rectangle('Position',[kordy+kf_atstarpes,kordx,kf_atstarpes,kf_atstarpes],'LineWidth',1,'LineStyle','-')
                %rectangle('Position',[kordy,kordx+kf_atstarpes,kf_atstarpes,kf_atstarpes],'LineWidth',1,'LineStyle','-')
                %rectangle('Position',[kordy+kf_atstarpes,kordx+2*kf_atstarpes,kf_atstarpes,kf_atstarpes],'LineWidth',1,'LineStyle','-')
            end
 
        end
    end
end
fprintf('cik daudz sejas = %.4f\n',a)
fprintf('cik daudz ciklu = %.4f\n',b)