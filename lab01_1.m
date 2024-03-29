% Author: Rayanne Souza
% Last modified: 11 Jun 2019
% Info: Script used to measure flaw position in a steel plate
%

clc
clear 
close all


dir = 'C:\Users\Rayanne\Documents\2019.1\ultrassom\resultadoslab2105\'
file1 = 'furo3.mat'
file2 = 'furo4.mat'
file3 = 'referencia.mat'

furo3 = load(strcat(dir,file1))
furo4 = load(strcat(dir,file2))
ref = load(strcat(dir,file3))

% Maximum signal amplitude of the reference signal
[m_steel, i_steel] = max(ref.w(5000:10000))
i_steel = i_steel + 5000

% Steel speed
tp = ref.t_d(i_steel) % time of peak occurrence
d = 71.05e-3 % steel plate thickness
c_steel = 2*d/tp 

% Flaw 3 position
[m_flaw3, i_flaw3] = max(furo3.w(2000:5000))
i_flaw3 = i_flaw3 + 2000

tp_flaw3 = furo3.t_d(i_flaw3)
p_flaw3 = c_steel*tp_flaw3/2

% Flaw 4 position
[m_flaw4, i_flaw4] = max(furo4.w(900:3000))
i_flaw4 = i_flaw4 + 900

tp_flaw4 = furo4.t_d(i_flaw4)
p_flaw4 = c_steel*tp_flaw4/2


%----------------------------------------------------------
% Flaw 3 echo
figure(1)
plot(furo3.t_d, furo3.w)
hold on
plot(furo3.t_d(i_flaw3),furo3.w(i_flaw3),'r*')
hold off
xlabel('Time(s)') 
ylabel('y(V)') 
title('Sinal de eco do furo 3')

%----------------------------------------------------------
% Flaw 4 echo
figure(2)
plot(furo4.t_d, furo4.w)
hold on
plot(furo4.t_d(i_flaw4),furo4.w(i_flaw4),'r*')
hold off
xlabel('Time(s)') 
ylabel('y(V)') 
title('Sinal de eco do furo 4')

%{
figure (5)
%hold on
plot(furo4.t_d(900:3000),furo4.w(900:3000))
plot(furo4.t_d(i_flaw4),furo3.w(i_flaw4),'r*')
%hold off
%}

%-----------------------------------------------------------
% Plots reference signal
figure(3)
hold on
plot(ref.t_d, ref.w)
plot(ref.t_d(i_steel),ref.w(i_steel),'r*')
hold off

xlabel('Time(s)') 
ylabel('y(V)') 
title('Sinal de referencia')




