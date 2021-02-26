function [freq, amp, phase] = get_txt_bode(name)
    location = fullfile('simulacoes',name);
    dat = importdata(location);
    freq = dat.data(:,1);
    amp = dat.data(:,2);
    phase = dat.data(:,3);
end