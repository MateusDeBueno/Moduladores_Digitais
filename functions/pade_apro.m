function G = pade_apro(fs)
    s = tf('s');
    Ts = 1/fs;
    G = (1-3*Ts*s/4)/(1+3*Ts*s/4);
end