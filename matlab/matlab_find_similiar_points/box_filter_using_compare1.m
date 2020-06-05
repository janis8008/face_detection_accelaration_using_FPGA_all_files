%Iegustam attelu
img=imread('ksk1.png');
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

%figure(3)
%imshow(B2,[])
B3=B2;
% %% -  melna un gaisha enchantment
% B3=zeros(size(B2));
% koef_white=255-max(B2(:));
% koef_black=min(B2(:));
% for kordx = 1.0:1:sizx
%     for kordy = 1.0:1:sizy 
%         if B2(kordx,kordy) <= mean(B2(:))
%             B3(kordx,kordy)=B2(kordx,kordy)-koef_black;
%         else
%             B3(kordx,kordy)=B2(kordx,kordy)+koef_white;
%         end
%     end
% end
% figure(5)
% imshow(B3,[])
%% braucam ar kaskakadi cauri visam attelam
figure(2)
imshow(img)

a=0;
kff1=90;
n=40; % cik daudz punkti
cx=0;
cy=0;
for  kf=logspace(log10(sizx/11),log10(sizx/5),n)
    fprintf('kf = %.4f\n',kf)
    for kordx = 1.0:1:round(sizx-5.1*kf) % vajag papildinat ar kaskades platums
        for kordy = round(1+3*kf):1:round(sizy-3.1*kf) % vajag papildinat ar kaskades augstums
            
            %kaskades pozicija
            f1=B3(kordx,kordy); %vaigs1
            f2=B3(round(kordx+5*kf),kordy); %vaigs2
            f3=B3(kordx,round(kordy+2.5*kf)); %zem vaigs1
            f4=B3(round(kordx+5*kf),round(kordy+2.5*kf)); %zem vaigs2
            f5=B3(round(kordx+3*kf),round(kordy+3*kf)); %zem lupam
            f6=B3(round(kordx+3*kf),round(kordy-3*kf)); %starp uzacim
            if  f1 < f2  ...
                && f1 >	f3  ...
                && f1 < f4  ...
                && f1 < f5  ...
                && f1 < f6  ...
                
                rectangle('Position',[kordx,kordy-3*kf,5*kf,kordy+3*kf],'LineWidth',1,'LineStyle','--')
                % arpus attela
                a=a+1;             
            end
 
        end
    end
end
fprintf('cik daudz sejas = %.4f\n',a)