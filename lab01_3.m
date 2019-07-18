% Author: Rayanne Souza
% Last modified: 10 Jun 2019
% Info: Script used to measure the ultrasonic wave speed
% in a plate immersed in water
%

clc
clear 
close all

dir = 'C:\Users\Rayanne\Documents\2019.1\ultrassom\resultadoslab2105\lab2\exp3\'
file1 = '2019_05_28_17_17_54_steelD1=21.5Grupo 4-Lab2 placa20mm metal - Sinal 1 - ganho 10dB.mat'
file2 = '2019_05_28_17_20_0_steelD1=21.5Grupo 4-Lab2 placa20mm metal - Sinal 2 - ganho 30dB.mat'
file3 = '2019_05_28_17_20_43_steelD1=21.5Grupo 4-Lab2 placa20mm metal - Sinal 3 - ganho 30dB.mat'
file4 = '2019_05_28_17_22_2_steelD1=21.5Grupo 4-Lab2 placa20mm metal - Sinal 4 - ganho 20dB.mat'
file5 = '2019_05_28_17_22_52_steelD1=21.5Grupo 4-Lab2 placa20mm metal - Sinal 5 GRUPAO - ganho 20dB.mat'

% Files for thin sheets
file6 = '2019_05_28_17_26_36_steelD1=21.5Grupo TODOS-Lab2 placa3.05mm metal - 0dB.mat'
file7 = '2019_05_28_17_29_34_steelD1=21.5Grupo TODOS-Lab2 placa2.0mm metal - 0dB.mat'

s1 = load(strcat(dir,file1))
s2 = load(strcat(dir,file2))
s3 = load(strcat(dir,file3))
s4 = load(strcat(dir,file4))
s5 = load(strcat(dir,file5))
s3mm = load(strcat(dir,file6))
s2mm = load(strcat(dir,file7))

d_agua = 34.7e-3
d_steel = 20e-3

% The time of peak occurrence
[m_p, i_p1] = max(s1.w)
[m_p, i_p2] = max(s2.w)
[m_p, i_p3] = max(s3.w)
[m_p, i_p4] = max(s4.w)

tp_agua1 = s1.t_d(i_p1)
tp_fundo1 = s2.t_d(i_p2)
tp_fundo2 = s3.t_d(i_p3)
tp_agua2 = s4.t_d(i_p4)

% Water speed
c_agua = 2*d_agua/(tp_agua2- tp_agua1)
% Steel speed
c_steel = 2*d_steel/(tp_fundo2- tp_fundo1)


%----------------------------------------
figure(1)

subplot(3,2,1)
plot(s5.t_d,s5.w)
xlabel('Time(s)') 
ylabel('y(V)') 
title('Sinal longo com segundo eco da interface água-aço')

subplot(3,2,2)
hold on
plot(s1.t_d,s1.w)
plot(tp_agua1,s1.w(i_p1), 'r*') 
hold off
xlabel('Time(s)') 
ylabel('y(V)') 
title('Primeiro eco da interface água-aço')


subplot(3,2,3)
hold on
plot(s2.t_d,s2.w)
plot(tp_fundo1,s2.w(i_p2), 'r*')
hold off
xlabel('Time(s)') 
ylabel('y(V)') 
title('Primeiro eco de fundo')

subplot(3,2,4)
hold on
plot(s3.t_d,s3.w)
plot(tp_fundo2,s3.w(i_p3), 'r*')
hold off
xlabel('Time(s)') 
ylabel('y(V)') 
title('Segundo eco de fundo')

subplot(3,2,5)
hold on
plot(s4.t_d,s4.w)
plot(tp_agua2,s4.w(i_p4), 'r*')
hold off 
xlabel('Time(s)') 
ylabel('y(V)') 
title('Segundo eco da interface água-aço')

%------------------------------------------------------
% Plot for the thin sheets
figure(2)
plot(s3mm.t_d,s3mm.w)

figure(3)
plot(s2mm.t_d,s2mm.w)
