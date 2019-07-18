% Author: Rayanne Souza
% Last modified: 11 Jun 2019
% Info: Script used to measure the impedance of a unknown medium (water)
% by applying relative reflection method
%

clc
clear 
close all

dir = 'C:\Users\Rayanne\Documents\2019.1\ultrassom\resultadoslab2105\lab2\exp4\'
file1 = '2019_05_28_17_39_14_steelD1=21.5Grupo TODOS-Lab2 -10dB ACRYLIC-AIR.mat'
file2 = '2019_05_28_17_40_40_steelD1=21.5Grupo TODOS-Lab2 -10dB ACRYLIC-wATER.mat'

s_air = load(strcat(dir,file1))
s_water = load(strcat(dir,file2))

c_acr = 2755.4
rho = 1217.3
Zacr = c_acr*rho

% Maximum signal amplitude for both signal
[max_air, imax_air] = max(s_air.w)
[max_water, imax_water] = max(s_water.w)

% Minimum signal amplitude for both signal
[min_air, imin_air] = min(s_air.w)
[min_water, imin_water] = min(s_water.w)

% Computes impedance from maximum value
R_max = -max_water/max_air
Z1 = Zacr*(1 + R_max)/(1-R_max)

% Computes impedance from peak-to-peak
R_pp = -(max_water-min_water)/(max_air-min_air)
Z2 = Zacr*(1 + R_pp)/(1-R_pp)


%---------------------------------------------
figure(2)
hold on
plot(s_air.t_d,s_air.w)
plot(s_water.t_d,s_water.w, 'r')

plot(s_air.t_d(imax_water),max_air, 'b*')
plot(s_air.t_d(imin_water),min_air, 'b*')

plot(s_water.t_d(imax_water),max_water, 'b*')
plot(s_water.t_d(imin_water),min_water, 'b*')
hold off
xlabel('Time(s)') 
ylabel('y(V)') 
legend('Ar', 'Agua')

