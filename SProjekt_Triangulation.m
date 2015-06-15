
close all;clear all;clc
  
  
a=[32;  22; 16.2;   12.8;   10.5;   6;  4];  %cm
b=[0.4; 0.6;0.8;    1;      1.2;    2;  2.7];  %Volt
for i=1:length(b)
    d(i)=1;
end
e=d'./b;
for i=1:length(b)
    e(i,2)=1;
end
q=pinv(e)*a

hold on
x=.1:0.01:4;
 for i=1:length(x);
  
  y(i)=q(1)/x(i)-q(2);
  
 end
  plot(x,y)

  
  
  x=.1:0.01:4;
 for i=1:length(x);
  
  y(i)=1/x(i)-0.42;
  
 end
  plot(x,y,'r')
  
  
  