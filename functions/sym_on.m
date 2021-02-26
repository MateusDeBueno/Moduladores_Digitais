function G = sym_on(D, fs)
    G = (tf(1,'InputDelay',(1-D)/(2*fs)) + tf(1,'InputDelay',(1+D)/(2*fs)))/2;
end

