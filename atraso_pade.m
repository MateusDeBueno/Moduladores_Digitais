clc
clear ALL
close ALL

% RESULTADOS DESTA PASTA SERÃO SALVOS EM:
target_save = 'figures\varrendo_fs_d';


% CONFIGURAÇÕES DO BODE
opts2 = bodeoptions;
opts2.FreqUnits = 'Hz';                  % set to 'Hz' unit
%opts.Xlim = [50,50000];                 % x-axis limits
%opts.YLim = {[-20,10];[-360,0]};       % y-axis limits
%opts.YLimMode = {'auto';'manual'};     % only x-axis is manually limited
freq_step = 1;
freq_max = 50e3;
freq_min = 50;
vector_freq = freq_min*2*pi:freq_step:freq_max*2*pi;
opts2.Title.FontSize = 14;
opts2.XLabel.FontSize = 11;
opts2.YLabel.FontSize = 11;
opts2.TickLabel.FontSize = 11;
opts2.grid = 'on';
opts2.PhaseWrapping = 'on';

s = tf('s');

% APROXIMAÇÃO DE PADÉ

fs = 5e3;
Ts = 1/fs;

F_fs = pade_apro(fs);
F1_fs = pade_apro(fs*2);
F2_fs = pade_apro(fs*4);
F3_fs = pade_apro(fs*8);
figure
bode(F_fs, F1_fs, F2_fs, F3_fs, vector_freq, opts2);
legend({'fs = 5k','fs = 10k','fs = 20k','fs = 40k'},'Location','southwest')
title('Pade approximation - Variando frequência de chaveamento (fs)')
save_figure('Pade approximation - Variando frequência de chaveamento (fs)', target_save)