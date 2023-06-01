clc
clear all
close all

f=fred 
startdate='01/01/1998';
enddate='07/01/2022';

realGDPforJ=fetch(f,'JPNRGDPEXP',startdate,enddate);
realGDPforT=fetch(f,'NGDPRSAXDCTRQ',startdate,enddate);

