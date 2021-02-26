function G = sym_off(D, fs)
    G = (tf(1,'InputDelay',D/(2*fs)) + tf(1,'InputDelay',(2-D)/(2*fs)))/2;
end