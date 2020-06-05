%Iegustam attelu
clear
img=imread('ainava.jpg');
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
kf_spilgtuma=0.455;
tic
for  kf_atstarpes=30:1:80
    for kordx = 1.0:1:round(sizx-3.1*kf_atstarpes) 
        for kordy = 1.0:1:round(sizy-2.1*kf_atstarpes)
            b=b+1;
            %kolonna 1
            piere1=img_grey(kordx,kordy);
            acs1=img_grey(kordx+kf_atstarpes,kordy);
            vaigs1=img_grey(kordx+2*kf_atstarpes,kordy);
            vaigs2=img_grey(kordx+3*kf_atstarpes,kordy);
            %kolonna 2
            piere2=img_grey(kordx,kordy+kf_atstarpes);
            starp_acim=img_grey(kordx+kf_atstarpes,kordy+kf_atstarpes);
            starp_vaigiem=img_grey(kordx+2*kf_atstarpes,kordy+kf_atstarpes);
            lupas=img_grey(kordx+3*kf_atstarpes,kordy+kf_atstarpes); 
            %kolonna 3
            piere3=img_grey(kordx,kordy+2*kf_atstarpes);
            acs2=img_grey(kordx+kf_atstarpes,kordy+2*kf_atstarpes);
            vaigs3=img_grey(kordx+2*kf_atstarpes,kordy+2*kf_atstarpes);
            vaigs4=img_grey(kordx+3*kf_atstarpes,kordy+2*kf_atstarpes);
            if      acs1	<=	kf_spilgtuma*starp_acim  ...
                &&	acs2	<=	kf_spilgtuma*starp_acim  ...
                &&	lupas	<=	kf_spilgtuma*starp_acim  ...
                &&	acs1	<=	kf_spilgtuma*starp_vaigiem  ...
                &&	acs2	<=	kf_spilgtuma*starp_vaigiem  ...
                &&	lupas	<=	kf_spilgtuma*starp_vaigiem  ...
                &&	acs1	<=	kf_spilgtuma*vaigs4  ...
                &&	acs2	<=	kf_spilgtuma*vaigs4  ...
                &&	lupas	<=	kf_spilgtuma*vaigs4  ...
                &&	acs1	<=	kf_spilgtuma*vaigs3  ...
                &&	acs2	<=	kf_spilgtuma*vaigs3  ...
                &&	lupas	<=	kf_spilgtuma*vaigs3  ...
                &&	acs1	<=	kf_spilgtuma*vaigs2  ...
                &&	acs2	<=	kf_spilgtuma*vaigs2  ...
                &&	lupas	<=	kf_spilgtuma*vaigs2  ...
                &&	acs1	<=	kf_spilgtuma*vaigs1  ...
                &&	acs2	<=	kf_spilgtuma*vaigs1  ...
                &&	lupas	<=	kf_spilgtuma*vaigs1  ...
                &&	acs1	<=	kf_spilgtuma*piere3  ...
                &&	acs2	<=	kf_spilgtuma*piere3  ...
                &&	lupas	<=	kf_spilgtuma*piere3  ...
                &&	acs1	<=	kf_spilgtuma*piere2  ...
                &&	acs2	<=	kf_spilgtuma*piere2  ...
                &&	lupas	<=	kf_spilgtuma*piere2  ...
                &&	acs1	<=	kf_spilgtuma*piere1  ...
                &&	acs2	<=	kf_spilgtuma*piere1  ...
                &&	lupas	<=	kf_spilgtuma*piere1
                rectangle('Position',[kordy,kordx,2*kf_atstarpes,3*kf_atstarpes],'LineWidth',1,'LineStyle','-')
                rectangle('Position',[kordy+kf_atstarpes,kordx,kf_atstarpes,kf_atstarpes],'LineWidth',1,'LineStyle','-')
                rectangle('Position',[kordy,kordx+kf_atstarpes,kf_atstarpes,kf_atstarpes],'LineWidth',1,'LineStyle','-')
                rectangle('Position',[kordy+kf_atstarpes,kordx+2*kf_atstarpes,kf_atstarpes,kf_atstarpes],'LineWidth',1,'LineStyle','-')
                a=a+1;
                % kf_atstarpes
%                 starp_acim
%                 kordx+kf_atstarpes
%                 kordy+kf_atstarpes
 %                acs2
%                 kordx+kf_atstarpes 
%                 kordy+2*kf_atstarpes
%                acs1
                 %kordxxx= kordx+kf_atstarpes
  %               kordy
%              lupas
%                 kordx+3*kf_atstarpes
%                 kordy+kf_atstarpes
            end
 
        end
    end
end
toc
fprintf('cik daudz sejas = %.4f\n',a)
fprintf('cik daudz ciklu = %.4f\n',b)