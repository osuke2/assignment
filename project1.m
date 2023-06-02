clc
clear all
close all

f=fred 
startdate='01/01/1998';
enddate='07/01/2022';

realGDPforJ=fetch(f,'JPNRGDPEXP',startdate,enddate);
realGDPforT=fetch(f,'NGDPRSAXDCTRQ',startdate,enddate);

year1 = realGDPforJ.Data(:,1);
y1 = realGDPforJ.Data(:,2);
year2 = realGDPforT.Data(:,1);
y2= realGDPforT.Data(:,2);

[cycle1,trend1] = qmacro_hpfilter(log(y1), 1600);
[cycle2,trend2] = qmacro_hpfilter(log(y2), 1600);

std_J = std(cycle1);
std_T = std(cycle2);
corr=corrcoef(cycle1,cycle2);
corr_JT = corr(1,2);

disp(['日本の標準偏差: ', num2str(std_J)]);
disp(['トルコの標準偏差: ', num2str(std_T)]);
disp(['相関係数: ', num2str(corr_JT)]);

figure
plot(year1, cycle1,'r')
datetick('x', 'yyyy')
xlabel('Time')
title('Cyclical components')
hold on;
plot(year2, cycle2,'b')
datetick('x', 'yyyy')
xlabel('Time')
legend('Japan', 'Turkey');
grid on;
hold off;

text(729846, 0.09, sprintf('corrcoef = %f', corr_JT)); 
text(729846, 0.07, sprintf('std_J = %f', std_J));
text(729846, 0.05, sprintf('std_T = %f', std_T));

function [ytilde,tauGDP]=qmacro_hpfilter(y,lam)
T=size(y,1);
A=zeros(T,T);
A(1,1)=lam+1; A(1,2)= -2*lam; A(1,3)= lam;
A(2,1)= -2*lam; A(2,2)= 5*lam+1; A(2,3)= -4*lam; A(2,4)= lam;
A(T-1,T)= -2*lam; A(T-1,T-1)= 5*lam+1; A(T-1,T-2)= -4*lam; A(T-1,T-3)= lam;
A(T,T)= lam+1; A(T,T-1)= -2*lam; A(T,T-2)= lam;

for i=3:T-2
    A(i,i-2) = lam; A(i,i-1) = -4*lam; A(i,i) = 6*lam+1;
    A(i,i+1) = -4*lam; A(i,i+2) = lam;
end

tauGDP = A\y;
ytilde=y-tauGDP;
end










