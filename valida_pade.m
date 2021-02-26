clc
clear ALL
close ALL

%oi

global folder
addpath(genpath(folder))

% RESULTADOS DESTA PASTA SERÃO SALVOS EM:
target_save = 'figures\modelo_vs_simulacao';

% LER DADOS PSIM
name = 'pade_sem_quantizador.txt';
[freq, amp, phase] = get_txt_bode(name);
freq_min = freq(1);
freq_max = freq(end);

% CONFIGURANDO BODE

opts4 = bodeoptions;
opts4.FreqUnits = 'Hz';                  % set to 'Hz' unit
vector_freq = freq;
opts4.grid = 'on';

% GERANDO MODELO
s = tf('s');
fs=5e3;
atraso = pade_apro(fs);
% atraso  = 1;
[mag2, phase2, wout2] = bode(atraso,vector_freq, opts4);
mag2 = mag2(:,:)';
phase2 = phase2(:,:)';
phase2 = phase2 - 360;



figure
subplot(2,1,1);
semilogx(freq,amp)
ylabel('Magnitude (dB)')
xlabel('Frequency')
xlim([freq_min freq_max])
grid
hold on
semilogx(wout2,20*log(mag2))
hold off
subplot(2,1,2); 
semilogx(freq,phase)
ylabel('Phase (deg)')
xlabel('Frequency')
xlim([freq_min freq_max])
grid
hold on
semilogx(wout2,phase2)
hold off
legend({'Simulação','Modelo'},'Location','southwest')
save_figure('Validar_pade', target_save)