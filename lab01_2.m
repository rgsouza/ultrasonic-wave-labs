% Author: Rayanne Souza
% Last modified: 10 Jun 2019
% Info: Script used to investigate the approach pitch-catch 
% angled-beam ultrasonic NDE 
%

clc
clear 
close all

dir = 'C:\Users\Rayanne\Documents\2019.1\ultrassom\resultadoslab2105\'
file1 = '2019_05_21_15_38_46_steelD1=21.5G2-4, ponto1-diagonal 7,3, max_1,.mat'
file2 = '2019_05_21_15_42_21_steelD1=21.5G2-4, ponto2-diagonal 14,2, max_1,.mat'

ponto1 = load(strcat(dir,file1))
ponto2 = load(strcat(dir,file2))

p1 = 7.3e-3 
p2 = 14.2e-3

% Time of peak occurrence 
[m_p1, i_p1] = max(ponto1.w(1000:10000))
i_p1 = i_p1 + 1000

[m_p2, i_p2] = max(ponto2.w(1000:10000))
i_p2 = i_p2 + 1000

tp1 = ponto1.t_d(i_p1) % tempo de pico posicao 1
tp2 = ponto2.t_d(i_p2) % tempo de pico posicao 2

% Theoretical position 
H = 21.5e-3
c = 3200 %m/s
theta = 60 % graus
l1 = 2*21.5*tand(theta)*1e-1 % theoretical position of first peak
l2 = 4*21.5*tand(theta)*1e-1 % theoretical position of second peak
t1 = (2*H/cosd(theta))/c % theoretical time of first peak occurrence
t2 = 2*t1 % theoretical time of second peak occurrence 

%-----------------------------------------------------
figure(1)
plot(ponto1.t_d,ponto1.w)
hold on
plot(ponto1.t_d(i_p1),ponto1.w(i_p1),'r*')
hold off
xlabel('Time(s)') 
ylabel('y(V)') 
title('Primeiro pico')

%------------------------------------------------------
figure(2)
plot(ponto2.t_d,ponto2.w)
hold on
plot(ponto2.t_d(i_p2),ponto2.w(i_p2),'r*')
hold off

xlabel('Time(s)') 
ylabel('y(V)') 
title('Segundo pico')
