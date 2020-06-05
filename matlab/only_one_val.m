

matrixxxx = zeros(228,221);
starp_acim = 255; % y 83 x 107

acs2 = 34; % y 83 x 151

acs1 = 20; %    y 83 x  63

lupas = 39 % y 171 x 107
 matrixxxx(89,45)=  starp_acim;
 matrixxxx(83,107)= starp_acim;
 matrixxxx(83,151)= acs2;
 matrixxxx(83,63)= acs1;
 matrixxxx(171,107)= lupas;
 
 %%
 matrixxxx = zeros(20,30);
starp_acim = 255; % y 83 x 107

acs2 = 34; % y 83 x 151

acs1 = 20; %    y 83 x  63
%(256,0,0,0,0,0,120,0,0,0,0,0,256)
lupas = 39 % y 171 x 107
 matrixxxx(2,7)=  starp_acim;
 %matrixxxx(1,7)= starp_acim;
 matrixxxx(2,1)= acs2;
 matrixxxx(2,13)= acs1;
 %matrixxxx(3,7)= lupas;
 kf=6;
 kf_sp=120/255;
 c=0;
    for kordy = 1.0:1:30-13 
        for kordx = 1.0:1:20-2
            acs2=matrixxxx(kordy, kordx);
            acs1=matrixxxx(kordy, kordx+2*kf);
            starp_acim=matrixxxx(kordy, kordx+1*kf);
            if acs2 < starp_acim*kf_sp && ...
                    acs1 < starp_acim*kf_sp
                c=c+1
                kordy
                kordx
            end
        end
    end

 %%
 matrix2 = zeros(20,30);
 a=1;
 c=1;
 for i= (1:1:20*30)
   
    matrix2(a,c)=i;
    c=c+1;
    if c > 30
        c=c-30;
        a=a+1;
    end
    
 end
 