clc
clear 
close all

dir = 'C:\Users\Rayanne\Documents\2019.1\ultrassom\resultadoslab2105\lab2\rxp5\'
file1 = '2019_05_28_18_55_37_steelD1=21.5Grupo 4 - Lab2- exp5 - Sinal 1-2 -ganho 8 dB.mat'
file2 = '2019_05_28_18_56_40_steelD1=21.5Grupo 4 - Lab2- exp5 - GRUPAO -ganho 8 dB.mat'
file3 = '2019_05_28_18_57_49_steelD1=21.5Grupo 4 - Lab2- exp5 - Sinal 3 -atenuado -ganho 30 dB.mat'

s12 = load(strcat(dir,file1))
sg = load(strcat(dir,file2))
s3 = load(strcat(dir,file3))

% Obtem amplitudes maximas do sinal 1 e 2
[s1_max, is1_max] = max(s12.w(1:7000))
is1_max = is1_max + 1
[s2_max, is2_max] = max(s12.w(5000:10000))
is2_max = is2_max + 5000

% Obtem amplitudes minimas do sinal 1 e 2
[s1_min, is1_min] = min(s12.w(1:7000))
is1_min = is1_min + 1
[s2_min, is2_min] = min(s12.w(5000:10000))
is2_min = is2_min + 5000


% Dados da agua
c_water = 1480
rho_water = 1000

% Dados acrilico 
c_acri = 2730
rho_acri = 1180
d = 5.1e-3

% Impedancia meio 1/meio3
Z1 = c_water*rho_water

% Impedância meio 2
Z2 = c_acri*rho_acri

% Obtendo a atenuacao no dominio do tempo
R12 = Z2-Z1/(Z2+Z1)
T12 = 1+R12
T21 = 1 + (Z1-Z2)/(Z2+Z1)
Z3 = 0
R23 = (Z3-Z2)/(Z3+Z1)

R = R12/(T12*R23*T21)
A = (s2_max-s2_min)/(s1_max-s1_min)
alpha = (-1/2*d)*log(A*R)

% Obtendo a atenuacao no dominio da frequencia


%--------------------------------------------------------
figure(1)
hold on
plot(s12.t_d,s12.w)
plot(s12.t_d(is1_max),s1_max, 'b*')
plot(s12.t_d(is1_min),s1_min, 'b*')
plot(s12.t_d(is2_max),s2_max, 'b*')
plot(s12.t_d(is2_min),s2_min, 'b*')
hold off

figure(2)
plot(sg.t_d,sg.w)

figure(3)
plot(s3.t_d,s3.w)
