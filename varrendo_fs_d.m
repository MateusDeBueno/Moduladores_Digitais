clc
clear ALL
close ALL

% CONFIGURAR PARA APARECER OU NAO GRAFICOS AO EXERCUTAR CODIGO
showing_figures = true; %setar esta variavel
if showing_figures == true
    set(0,'DefaultFigureVisible','on')
else
    set(0,'DefaultFigureVisible','off')
end

% PEGAR SUBDIRETORIOS
global folder;
folder = fileparts(which(mfilename)); 
addpath(genpath(folder))

% RESULTADOS DESTA PASTA SERÃO SALVOS EM:
target_save = strcat('figures\',mfilename);

% CONFIGURAÇÕES DO BODE
opts = bodeoptions;
opts.FreqUnits = 'Hz';                  % set to 'Hz' unit
opts.YLim = {[-20,10];[-360,0]};       % y-axis limits
opts.YLimMode = {'auto';'manual'};     % only x-axis is manually limited
freq_step = 1;
freq_max = 50e3;
freq_min = 50;
vector_freq = freq_min*2*pi:freq_step:freq_max*2*pi;
opts.XLabel.FontSize = 11;
opts.YLabel.FontSize = 11;
opts.TickLabel.FontSize = 11;
opts.grid = 'on';


% VALIDAÇÃO DOS MODELOS DOS MODULADORES PWM
s = tf('s');
fs=5e3;
Ts=1/fs;
D=.5;
D1 = D-.3;
D2 = D;
D3 = D+.3;
fs1 = fs;
fs2 = 2*fs;
fs3 = 4*fs;

% MODULADOR CRESCENTE (END-OF-ON-TIME)
A_fs = end_time(D, fs1);
A1_fs = end_time(D, fs2);
A2_fs = end_time(D, fs3);
figure
bode(A_fs, A1_fs, A2_fs, vector_freq, opts);
legend({['fs = ', num2str(fs1)],['fs = ', num2str(fs2)],['fs = ', num2str(fs3)]},'Location','southwest')
title('End-of-on-time - Variando frequência de chaveamento (fs)')
save_figure('End-of-on-time - Variando frequência de chaveamento (fs)', target_save)

A_D = end_time(D1, fs);
A1_D = end_time(D2, fs);
A2_D = end_time(D3, fs);
figure 
bode(A_D, A1_D, A2_D, vector_freq, opts);
legend({['D = ' num2str(D1)],['D = ', num2str(D2)],['D = ', num2str(D3)]},'Location','southwest')
title('End-of-on-time - Variando razão cíclica (D)')
save_figure('End-of-on-time - Variando razão cíclica (D)', target_save)

% MODULADOR DECRESCENTE (BEGIN-OF-ON-TIME)
B_fs = begin_time(D, fs1);
B1_fs = begin_time(D, fs2);
B2_fs = begin_time(D, fs3);
figure
bode(B_fs, B1_fs, B2_fs, vector_freq, opts);
legend({['fs = ', num2str(fs1)],['fs = ', num2str(fs2)],['fs = ', num2str(fs3)]},'Location','southwest')
title('Begin-of-on-time - Variando frequência de chaveamento (fs)')
save_figure('Begin-of-on-time - Variando frequência de chaveamento (fs)', target_save)

B_D = begin_time(D1, fs);
B1_D = begin_time(D2, fs);
B2_D = begin_time(D3, fs);
figure 
bode(B_D, B1_D, B2_D, vector_freq, opts);
legend({['D = ' num2str(D1)],['D = ', num2str(D2)],['D = ', num2str(D3)]},'Location','southwest')
title('Begin-of-on-time - Variando razão cíclica (D)')
save_figure('Begin-of-on-time - Variando razão cíclica (D)', target_save)


% MODULADOR TRIANGULAR VALE (SYMMETRIC-ON-TIME)
C_fs = sym_on(D, fs1);
C1_fs = sym_on(D, fs2);
C2_fs = sym_on(D, fs3);
figure
bode(C_fs, C1_fs, C2_fs, vector_freq, opts);
legend({['fs = ', num2str(fs1)],['fs = ', num2str(fs2)],['fs = ', num2str(fs3)]},'Location','southwest')
title('Symmetric-on-time - Variando frequência de chaveamento (fs)')
save_figure('Symmetric-on-time - Variando frequência de chaveamento (fs)', target_save)

C_D = sym_on(D1, fs);
C1_D = sym_on(D2, fs);
C2_D = sym_on(D3, fs);
figure 
bode(C_D, C1_D, 'r--', C2_D, 'y-.', vector_freq, opts);
legend({['D = ' num2str(D1)],['D = ', num2str(D2)],['D = ', num2str(D3)]},'Location','southwest')
title('Symmetric-on-time - Variando razão cíclica (D)')
save_figure('Symmetric-on-time - Variando razão cíclica (D)', target_save)

% MODULADOR TRIANGULAR PICO (SYMMETRIC-OFF-TIME)
D_fs = sym_off(D, fs1);
D1_fs = sym_off(D, fs2);
D2_fs = sym_off(D, fs3);
figure
bode(D_fs, D1_fs, D2_fs, vector_freq, opts);
legend({['fs = ', num2str(fs1)],['fs = ', num2str(fs2)],['fs = ', num2str(fs3)]},'Location','southwest')
title('Symmetric-off-time - Variando frequência de chaveamento (fs)')
save_figure('Symmetric-off-time - Variando frequência de chaveamento (fs)', target_save)

D_D = sym_off(D1, fs);
D1_D = sym_off(D2, fs);
D2_D = sym_off(D3, fs);
figure 
bode(D_D, D1_D,'r--', D2_D, 'y-.', vector_freq, opts);
legend({['D = ' num2str(D1)],['D = ', num2str(D2)],['D = ', num2str(D3)]},'Location','southwest')
title('Symmetric-off-time - Variando razão cíclica (D)')
save_figure('Symmetric-off-time - Variando razão cíclica (D)', target_save)

% MODULADOR TRIANGULAR VALE E PICO (DOUBLE-UPDATE)
E_fs = double_up(D, fs1);
E1_fs = double_up(D, fs2);
E2_fs = double_up(D, fs3);
figure
bode(E_fs, E1_fs, E2_fs, vector_freq, opts);
legend({['fs = ', num2str(fs1)],['fs = ', num2str(fs2)],['fs = ', num2str(fs3)]},'Location','southwest')
title('Double-update - Variando frequência de chaveamento (fs)')
save_figure('Double-update - Variando frequência de chaveamento (fs)', target_save)

E_D = double_up(D1, fs);
E1_D = double_up(D2, fs);
E2_D = double_up(D3, fs);
figure 
bode(E_D, E1_D,'r--', E2_D, 'y-.', vector_freq, opts);
legend({['D = ' num2str(D1)],['D = ', num2str(D2)],['D = ', num2str(D3)]},'Location','southwest')
title('Double-update - Variando razão cíclica (D)')
save_figure('Double-update - Variando razão cíclica (D)', target_save)