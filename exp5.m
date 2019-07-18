% Author: Rayanne Souza
% Last modified: 10 Jun 2019
% Info: Script used to measure speed and attenuation using pulse-echo method
%

clc
clear 
close all

% dir = 'C:\Users\Rayanne\Documents\2019.1\ultrassom\resultadoslab2105\lab2\rxp5\'
% file1 = '2019_05_28_18_55_37_steelD1=21.5Grupo 4 - Lab2- exp5 - Sinal 1-2 -ganho 8 dB.mat'
% file2 = '2019_05_28_18_56_40_steelD1=21.5Grupo 4 - Lab2- exp5 - GRUPAO -ganho 8 dB.mat'
% file3 = '2019_05_28_18_57_49_steelD1=21.5Grupo 4 - Lab2- exp5 - Sinal 3 -atenuado -ganho 30 dB.mat'
% 
% s12 = load(strcat(dir,file1))
% sg = load(strcat(dir,file2))
% s3 = load(strcat(dir,file3))

s12 = load('2019_05_28_18_55_37_steelD1=21.5Grupo 4 - Lab2- exp5 - Sinal 1-2 -ganho 8 dB.mat');
sg = load('2019_05_28_18_56_40_steelD1=21.5Grupo 4 - Lab2- exp5 - GRUPAO -ganho 8 dB.mat');
s3 = load('2019_05_28_18_57_49_steelD1=21.5Grupo 4 - Lab2- exp5 - Sinal 3 -atenuado -ganho 30 dB.mat');

freq_central = 5e6;

figure(4)
subplot(2,1,1);
plot(s12.t_d,s12.w);
xlabel('Tempo [s]');
[S12_W_fft,freq_S12_W] = FF_num(s12.w,s12.t_d);
subplot(2,1,2)
plot(freq_S12_W,abs(S12_W_fft))
xlim([freq_central-5e6 freq_central+5e6]);
xlabel('Frequencia [Hz]')

figure (5)
subplot(2,1,1)
plot(sg.t_d,sg.w);
xlabel('Tempo [s]');
[Sg_W_fft,freq_Sg_W] = FF_num(sg.w,sg.t_d);
subplot(2,1,2)
plot(freq_Sg_W,abs(Sg_W_fft))
xlim([freq_central-5e6 freq_central+5e6]);
xlabel('Frequencia [Hz]')

figure (6)
subplot(2,1,1)
plot(s3.t_d,s3.w);
xlabel('Tempo [s]');
[S3_W_fft,freq_S3_W] = FF_num(s3.w,s3.t_d);
subplot(2,1,2)
plot(freq_S3_W,abs(S3_W_fft))
xlim([freq_central-5e6 freq_central+5e6]);
xlabel('Frequencia [Hz]')

% Maximum signal amplitude of signals 1 and 2
[s1_max, is1_max] = max(s12.w(1:5000))
is1_max = is1_max
[s2_max, is2_max] = max(s12.w(5001:10000))
is2_max = is2_max + 5001

% Minimum signal amplitude of signals 1 and 2
[s1_min, is1_min] = min(s12.w(1:7000))
is1_min = is1_min + 1
[s2_min, is2_min] = min(s12.w(5000:10000))
is2_min = is2_min + 5000

% Maximum signal amplitude of signal 3
[s3_max, is3_max] = max(s3.w)
tp3 = s3.t_d(is3_max)
tp2 = s12.t_d(is2_max)


% Water data
c_water = 1480;
rho_water = 1000;

% Acrylic data
c_acri = 2730;
rho_acri = 1180;
d = 5e-3;

% Acrylic speed
c_ac = 2*d/(tp3-tp2)


% Impedance of medium 1 and 3
Z1 = c_water*rho_water
Z3 = c_water*rho_water

% Impedance of medium 2
Z2 = c_acri*rho_acri

% Attenuation in the time-domain
R12 = (Z2-Z1)/(Z2+Z1)
T12 = 1+R12
T21 = 1 + (Z1-Z2)/(Z2+Z1)
R23 = (Z3-Z2)/(Z3+Z2)

R = R12/(T12*R23*T21)
A = 0.01721235044
A_ = (s2_max-s2_min)/(s1_max-s1_min)
alpha = (-1/(2*d))*log(abs(A_*R))*8.686

% Attenuation in the frequency-domain
%y0 = fft(s12.w(1:5000))
%y1 = fft(s12.w(5001:10000))

[y0,f0] = FF_num(s12.w(1:5000),s12.t_d(1:5000))
[y1,f1] = FF_num(s12.w(5001:10000),s12.t_d(5001:10000))
alpha_w = (-1/(2*d))*log(abs((y1./y0)*R))*8.686

figure(30)
plot(f0,abs(y0))
hold on
plot(f1,abs(y1), 'r')
xlim([freq_central-5e6 freq_central+5e6]);
ylabel('Y[V/Hz]')
xlabel('Frequencia [Hz]')
legend('Front eco', 'Back eco')
hold off

figure(31)
plot(f0,alpha_w)
ylabel('\alpha (dB/m)');
xlim([0 10e6])
%xlim([freq_central-5e6 freq_central+5e6]);
xlabel('Frequencia [Hz]')
%xlim([freq_central-5e6 freq_central+5e6]);


%--------------------------------------------------------
figure(1)
plot(s12.t_d,s12.w)
hold on
plot(s12.t_d(is1_max),s1_max, 'b*')
plot(s12.t_d(is1_min),s1_min, 'b*')
plot(s12.t_d(is2_max),s2_max, 'b*')
plot(s12.t_d(is2_min),s2_min, 'b*')
hold off

figure(2)
plot(sg.t_d,sg.w)

figure(3)
plot(s3.t_d,s3.w)
hold on
plot(s3.t_d(is3_max),s3_max, 'b*')
