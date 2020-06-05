kf = [44, 44, 37, 32]; % att?lumi starp punktiem
kf2=[1,10,100,1000];
nobide=[1,2,3,4];
const_x =nobide(1); % cik nob?d?ts pa x asi
const_y =nobide(1); % cik nob?d?ts pa y asi
matrix = zeros(const_y(1)+2*kf(2),const_x(1)+2*kf(2),'uint32');
% zem?k ir visas kuras izmantoja 
   for i=44:-1:1;
    const_x =1; % cik nob?d?ts pa x asi
    const_y =1; % cik nob?d?ts pa y asi

    matrix(const_x,const_y)=i; % acs 1
    matrix(const_y,const_x+i)=i; % starp acim deguns
    matrix(const_y,const_x+2*i)=i; % acs 2
    matrix(const_y+2*i,const_x+i)=i; % luupas

   end
c=sum(all(matrix == 0,2))
d=sum(all(matrix == 0,1))

csvwrite('M.csv',matrix) 