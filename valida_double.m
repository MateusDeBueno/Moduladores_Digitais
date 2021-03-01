clc
clear ALL
close ALL

% PEGAR SUBDIRETORIOS
global folder
folder = fileparts(which(mfilename)); 
addpath(genpath(folder))

% RESULTADOS DESTA PASTA SERÃO SALVOS EM:
target_save = 'figures\modelo_vs_simulacao';

% LER DADOS PSIM
name = 'double_100_zoh(tudo_10k).txt';
[freq_zoh, amp_zoh, phase_zoh] = get_txt_bode(name);
name = 'double_100_zoh_quanti(tudo_10k).txt';
[freq_zoh_quanti, amp_zoh_quanti, phase_zoh_quanti] = get_txt_bode(name);




freq = freq_zoh; %vetor de frequencia para todos os plots
vector_freq = freq_zoh;


% RECORTAR TODOS OS DADOS PARA IR SO ATE 5K
freq = freq(1:67);
amp_zoh = amp_zoh(1:67);
phase_zoh = phase_zoh(1:67);
phase_zoh_quanti = phase_zoh_quanti(1:67);
amp_zoh_quanti = amp_zoh_quanti(1:67);
freq_min = freq(1);
freq_max = freq(end);

% CONFIGURANDO BODE
opts4 = bodeoptions;
opts4.FreqUnits = 'Hz';                  % set to 'Hz' unit
opts4.grid = 'on';

% GERANDO MODELO SEM PADE
s = tf('s');
fs=5e3;
Ts=1/fs;
D=.5;
D_modelo = double_up(D, fs);
[mag, phase, wout] = bode(D_modelo,vector_freq, opts4);
mag = mag(:,:)';
mag = 20*log(mag);
phase = phase(:,:)';

% GERANDO MODELO COM PADE
atraso = pade_apro(fs);
[mag2, phase2, wout2] = bode(D_modelo*atraso,vector_freq, opts4);
mag2 = mag2(:,:)';
mag2 = 20*log(mag2);
phase2 = phase2(:,:)';
phase2 = phase2 - 360;

figure
subplot(2,1,1);
semilogx(wout,mag)
ylabel('Magnitude (dB)')
xlabel('Frequency')
xlim([freq_min freq_max])
grid
hold on
semilogx(wout2,mag2)
semilogx(freq,amp_zoh)
semilogx(freq,amp_zoh_quanti)
xline(2488.5,'-')
hold off
subplot(2,1,2); 
semilogx(wout,phase)
ylabel('Phase (deg)')
xlabel('Frequency')
xlim([freq_min freq_max])
grid
hold on
semilogx(wout2,phase2)
semilogx(freq,phase_zoh)
semilogx(freq,phase_zoh_quanti)
ylim([-360, 0])
xline(2488.5,'-',{'Limite','do modelo'},'LabelVerticalAlignment','bottom')
hold off
legend({'Modelo double update','Modelo double update + atraso padé','Simulação (ZOH)','Simulação (ZOH+quantizador)'},'Location','southwest')
%sgtitle('Double update - Modelo vs Simulação no PSIM')
save_figure('Double update', target_save)

