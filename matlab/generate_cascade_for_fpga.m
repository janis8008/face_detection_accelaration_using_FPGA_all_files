


kf = [52, 44, 37, 32]; % att?lumi starp punktiem
kf2=[1,10,100,1000];
const_x =round(kf(1)/5); % cik nob?d?ts pa x asi
const_y =round(kf(1)/5); % cik nob?d?ts pa y asi
matrix = zeros(const_x(1)+2*kf(2),const_y(1)+2*kf(2),'uint32');
% zem?k ir visas kuras izmantoja 
   for i=2:1:2;
    const_x =round(kf(i)/5); % cik nob?d?ts pa x asi
    const_y =round(kf(i)/5); % cik nob?d?ts pa y asi

    matrix(const_x,const_y+kf(i))=1*kf2(i); % acs 1
    matrix(const_x+kf(i),const_y+kf(i))=1*kf2(i); % starp acim deguns
    matrix(const_x+kf(i),const_y+2*kf(i))=1*kf2(i); % luupas
    matrix(const_x+2*kf(i),const_y+kf(i))=1*kf2(i); % acs 2
    matrix(const_x,const_y)=1*kf2(i); %piere 1
    matrix(const_x+kf(i),const_y)=1*kf2(i); %piere 2
    matrix(const_x+kf(i),const_y+2*kf(i))=1*kf2(i); % starp vaigiem deguns
    matrix(const_x+2*kf(i),const_y)=1*kf2(i); %piere 3
    matrix(const_x+2*kf(i),const_y+kf(i))=1*kf2(i); % acs 2
    matrix(const_x+2*kf(i),const_y+2*kf(i))=1*kf2(i); % vaigs 2
   end
c=sum(all(matrix == 0,2))
d=sum(all(matrix == 0,1))

csvwrite('M.csv',matrix) 