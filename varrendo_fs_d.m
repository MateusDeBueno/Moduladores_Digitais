clc
clear ALL
close ALL

% PEGAR SUBDIRETORIOS
global folder;
folder = fileparts(which(mfilename)); 
addpath(genpath(folder))

% RESULTADOS DESTA PASTA SER�O SALVOS EM:
target_save = strcat('figures\',mfilename);

% CONFIGURA��ES DO BODE
opts = bodeoptions;
opts.FreqUnits = 'Hz';                  % set to 'Hz' unit
%opts.Xlim = [50,50000];                 % x-axis limits
opts.YLim = {[-20,10];[-360,0]};       % y-axis limits
opts.YLimMode = {'auto';'manual'};     % only x-axis is manually limited
freq_step = 1;
freq_max = 50e3;
freq_min = 50;
vector_freq = freq_min*2*pi:freq_step:freq_max*2*pi;
opts.Title.FontSize = 14;
opts.XLabel.FontSize = 11;
opts.YLabel.FontSize = 11;
opts.TickLabel.FontSize = 11;
opts.grid = 'on';


% VALIDA��O DOS MODELOS DOS MODULADORES PWM
s = tf('s');
fs=5e3;
Ts=1/fs;
D=.4;

% MODULADOR CRESCENTE (END-OF-ON-TIME)

A_fs = end_time(D, fs);
A1_fs = end_time(D, fs*2);
A2_fs = end_time(D, fs*4);
figure
bode(A_fs, A1_fs, A2_fs, A3_fs, vector_freq, opts);
legend({'fs = 5k','fs = 10k','fs = 20k','fs = 40k'},'Location','southwest')
title('End-of-on-time - Variando frequ�ncia de chaveamento (fs)')
save_figure('End-of-on-time - Variando frequ�ncia de chaveamento (fs)', target_save)

A_D = end_time(0.2, fs);
A1_D = end_time(0.4, fs);
A2_D = end_time(0.6, fs);
A3_D = end_time(0.8, fs);
figure 
bode(A_D, A1_D, A2_D, A3_D, vector_freq, opts);
legend({'D = 0.2','D = 0.4','D = 0.6','D = 0.8'},'Location','southwest')
title('End-of-on-time - Variando raz�o c�clica (D)')
save_figure('End-of-on-time - Variando raz�o c�clica (D)', target_save)

% MODULADOR DECRESCENTE (BEGIN-OF-ON-TIME)

B_fs = begin_time(D, fs);
B1_fs = begin_time(D, fs*2);
B2_fs = begin_time(D, fs*4);
B3_fs = begin_time(D, fs*8);
figure
bode(B_fs, B1_fs, B2_fs, B3_fs, vector_freq, opts);
legend({'fs = 5k','fs = 10k','fs = 20k','fs = 40k'},'Location','southwest')
title('Begin-of-on-time - Variando frequ�ncia de chaveamento (fs)')
save_figure('Begin-of-on-time - Variando frequ�ncia de chaveamento (fs)', target_save)

B_D = begin_time(0.2, fs);
B1_D = begin_time(0.4, fs);
B2_D = begin_time(0.6, fs);
B3_D = begin_time(0.8, fs);
figure 
bode(B_D, B1_D, B2_D, B3_D, vector_freq, opts);
legend({'D = 0.2','D = 0.4','D = 0.6','D = 0.8'},'Location','southwest')
title('Begin-of-on-time - Variando raz�o c�clica (D)')
save_figure('Begin-of-on-time - Variando raz�o c�clica (D)', target_save)


% MODULADOR TRIANGULAR PICO (SYMMETRIC-ON-TIME)

C_fs = sym_on(D, fs);
C1_fs = sym_on(D, fs*2);
C2_fs = sym_on(D, fs*4);
C3_fs = sym_on(D, fs*8);
figure
bode(C_fs, C1_fs, C2_fs, C3_fs, vector_freq, opts);
legend({'fs = 5k','fs = 10k','fs = 20k','fs = 40k'},'Location','southwest')
title('Symmetric-on-time - Variando frequ�ncia de chaveamento (fs)')
save_figure('Symmetric-on-time - Variando frequ�ncia de chaveamento (fs)', target_save)

C_D = sym_on(0.2, fs);
C1_D = sym_on(0.4, fs);
C2_D = sym_on(0.6, fs);
C3_D = sym_on(0.8, fs);
figure 
bode(C_D, C1_D, C2_D, C3_D, vector_freq, opts);
legend({'D = 0.2','D = 0.4','D = 0.6','D = 0.8'},'Location','southwest')
title('Symmetric-on-time - Variando raz�o c�clica (D)')
save_figure('Symmetric-on-time - Variando raz�o c�clica (D)', target_save)

% MODULADOR TRIANGULAR VALE (SYMMETRIC-OFF-TIME)

D_fs = sym_off(D, fs);
D1_fs = sym_off(D, fs*2);
D2_fs = sym_off(D, fs*4);
D3_fs = sym_off(D, fs*8);
figure
bode(D_fs, D1_fs, D2_fs, D3_fs, vector_freq, opts);
legend({'fs = 5k','fs = 10k','fs = 20k','fs = 40k'},'Location','southwest')
title('Symmetric-off-time - Variando frequ�ncia de chaveamento (fs)')
save_figure('Symmetric-off-time - Variando frequ�ncia de chaveamento (fs)', target_save)

D_D = sym_off(0.2, fs);
D1_D = sym_off(0.4, fs);
D2_D = sym_off(0.6, fs);
D3_D = sym_off(0.8, fs);
figure 
bode(D_D, D1_D, D2_D, D3_D, vector_freq, opts);
legend({'D = 0.2','D = 0.4','D = 0.6','D = 0.8'},'Location','southwest')
title('Symmetric-off-time - Variando raz�o c�clica (D)')
save_figure('Symmetric-off-time - Variando raz�o c�clica (D)', target_save)

% MODULADOR TRIANGULAR VALE E PICO (DOUBLE-UPDATE)

E_fs = double_up(D, fs);
E1_fs = double_up(D, fs*2);
E2_fs = double_up(D, fs*4);
E3_fs = double_up(D, fs*8);
figure
bode(E_fs, E1_fs, E2_fs, E3_fs, vector_freq, opts);
legend({'fs = 5k','fs = 10k','fs = 20k','fs = 40k'},'Location','southwest')
title('Double-update - Variando frequ�ncia de chaveamento (fs)')
save_figure('Double-update - Variando frequ�ncia de chaveamento (fs)', target_save)

E_D = double_up(0.2, fs);
E1_D = double_up(0.4, fs);
E2_D = double_up(0.6, fs);
E3_D = double_up(0.8, fs);
figure 
bode(E_D, E1_D, E2_D, E3_D, vector_freq, opts);
legend({'D = 0.2','D = 0.4','D = 0.6','D = 0.8'},'Location','southwest')
title('Double-update - Variando raz�o c�clica (D)')
save_figure('Double-update - Variando raz�o c�clica (D)', target_save)