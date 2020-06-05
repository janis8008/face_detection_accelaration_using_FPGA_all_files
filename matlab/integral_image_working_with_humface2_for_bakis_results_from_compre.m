%Iegustam attelu
clear
img=imread('humface2.jpg');
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
kf_spilgtuma=0.50;

for  kf_atstarpes=1:1:20
    for kordx = 1.0:1:round(sizx-3.1*kf_atstarpes) 
        for kordy = 1.0:1:round(sizy-2.1*kf_atstarpes)
            b=b+1;
            %kolonna 1
            nulle=img_grey(kordx,kordy);
            pirma=img_grey(kordx+5*kf_atstarpes,kordy+13*kf_atstarpes);
            otra=img_grey(kordx+0*kf_atstarpes,round(kordy+5.5*kf_atstarpes));
            tresa=img_grey(round(kordx+10.5*kf_atstarpes),kordy+8*kf_atstarpes);
            ceturta=img_grey(round(kordx+3.5*kf_atstarpes),kordy+5*kf_atstarpes);
            piekta=img_grey(kordx+4*kf_atstarpes,kordy+0*kf_atstarpes);
            tumsa=img_grey(kordx+1*kf_atstarpes,kordy+2*kf_atstarpes);
            if      tumsa > kf_spilgtuma*piekta ...
                &&  tumsa > kf_spilgtuma*pirma ...
                &&  tumsa > kf_spilgtuma*otra ...
                &&  tumsa > kf_spilgtuma*tresa ...
                &&  tumsa > kf_spilgtuma*ceturta ...
                
                
                rectangle('Position',[kordy,kordx,round(10.5*kf_atstarpes),13*kf_atstarpes],'LineWidth',1,'LineStyle','-')

                a=a+1;

            end
 
        end
    end
end
fprintf('cik daudz sejas = %.4f\n',a)
fprintf('cik daudz ciklu = %.4f\n',b)