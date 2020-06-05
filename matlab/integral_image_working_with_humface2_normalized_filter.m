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
%kaskades
sizx=siz(1); 
sizy=siz(2);
koef=12;
koefx = round(sizx/koef);
koefy = round(sizy/koef);% izpludinašanas koef vajag lai ir atkarigs no att?la izm?ra (lielaks att?ls liel?ks koef)
% cik daudz attela aiznem seja  
x1=round(sizx/koefx); %izpludinašanas platums
y1=round(sizy/koefy); %izpludinašanas augstums
%vajag iegut nepara
if mod(x1,2)<1 
    x2 = fix(x1)+1;
else
    x2 = x1;
end
if mod(y1,2)<1
    y2 = fix(y1)+1;
else    y2 = y1;
end
%boxfilter (izpludinam pa izpludinašas koef izmeru)
filterSize = [x2 y2];
padSize = (filterSize-1)/2;
Apad = padarray(img_grey, padSize, 'replicate','both');
intA = integralImage(Apad);
B2 = integralBoxFilter(intA, filterSize);
% %% -  melna un gaisha enchantment
B3=zeros(size(B2));
koef_white=255-max(B2(:));
koef_black=min(B2(:));
for kordx = 1.0:1:sizx
    for kordy = 1.0:1:sizy 
        if B2(kordx,kordy) <= mean(B2(:))
            B3(kordx,kordy)=B2(kordx,kordy)-koef_black;
        else
            B3(kordx,kordy)=B2(kordx,kordy)+koef_white;
        end
    end
end
figure(5)
imshow(B3,[])
%% braucam ar kaskakadi cauri visam attelam
img_grey=B3;

a=0;
kf_spilgtuma=0.45; %acim

cx=0;
cy=0;
for  kf=5:1:275
    for kordy = 1.0:1:round(sizx-3.1*kf) 
        for kordx = 1.0:1:round(sizy-2.1*kf)
            %kolonna 1
            piere1=img_grey(kordy,kordx);
            acs1=img_grey(kordy+kf,kordx);
            vaigs1=img_grey(kordy+2*kf,kordx);
            vaigs2=img_grey(kordy+3*kf,kordx);
            %kolonna 2
            piere2=img_grey(kordy,kordx+kf);
            starp_acim=img_grey(kordy+kf,kordx+kf);
            starp_vaigiem=img_grey(kordy+2*kf,kordx+kf);
            lupas=img_grey(kordy+3*kf,kordx+kf); 
            %kolonna 3
            piere3=img_grey(kordy,kordx+2*kf);
            acs2=img_grey(kordy+kf,kordx+2*kf);
            vaigs3=img_grey(kordy+2*kf,kordx+2*kf);
            vaigs4=img_grey(kordy+3*kf,kordx+2*kf);
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
                rectangle('Position',[kordx,kordy,2*kf,3*kf],'LineWidth',1,'LineStyle','-')
                rectangle('Position',[kordx+kf,kordy,kf,kf],'LineWidth',1,'LineStyle','-')
                rectangle('Position',[kordx,kordy+kf,kf,kf],'LineWidth',1,'LineStyle','-')
                rectangle('Position',[kordx+kf,kordy+2*kf,kf,kf],'LineWidth',1,'LineStyle','-')
                a=a+1;
            end
 
        end
    end
end
fprintf('cik daudz sejas = %.4f\n',a)