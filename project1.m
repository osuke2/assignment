clc
clear all
close all

f=fred 
startdate='01/01/1998';
enddate='07/01/2022';

realGDPforJ=fetch(f,'JPNRGDPEXP',startdate,enddate);
realGDPforT=fetch(f,'NGDPRSAXDCTRQ',startdate,enddate);

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