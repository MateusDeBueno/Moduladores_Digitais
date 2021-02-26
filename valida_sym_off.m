clc
clear ALL
close ALL

% PEGAR SUBDIRETORIOS
global folder
addpath(genpath(folder))

% RESULTADOS DESTA PASTA SERÃO SALVOS EM:
target_save = 'figures\modelo_vs_simulacao';

% LER DADOS PSIM
name = 'trian_vale_100_zoh(tudo_5k).txt';
[freq, amp, phase] = get_txt_bode(name);
freq_min = freq(1);
freq_max = freq(end);

name = 'trian_vale_100_zoh_quanti(tudo_5k).txt';
[freq_quanti, amp_quanti, phase_quanti] = get_txt_bode(name);

% CONFIGURANDO BODE

opts4 = bodeoptions;
opts4.FreqUnits = 'Hz';                  % set to 'Hz' unit
vector_freq = freq;
opts4.grid = 'on';

% GERANDO MODELO
s = tf('s');
fs=5e3;
Ts=1/fs;
D=.5;
D_modelo = sym_off(D, fs);
% atraso = pade_apro(fs);
atraso  = 1;
[mag2, phase2, wout2] = bode(D_modelo*atraso,vector_freq, opts4);
mag2 = mag2(:,:)';
phase2 = phase2(:,:)';



figure
subplot(2,1,1);
semilogx(wout2,20*log(mag2))
ylabel('Magnitude (dB)')
xlabel('Frequency')
xlim([freq_min freq_max])
grid
hold on
semilogx(freq,amp)
semilogx(freq_quanti,amp_quanti)
hold off
subplot(2,1,2); 
semilogx(wout2,phase2)
ylabel('Phase (deg)')
xlabel('Frequency')
xlim([freq_min freq_max])
grid
hold on
semilogx(freq,phase)
semilogx(freq_quanti,phase_quanti)
hold off
legend({'Modelo matemático','Simulação (ZOH)','Simulação (ZOH+quantizador)'},'Location','southwest')
sgtitle('Symmetric-off-time - Modelo vs Simulação no PSIM')
save_figure('Sym_off', target_save)

