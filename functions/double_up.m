function G = double_up(D, fs)
    G = (tf(1,'InputDelay',(1-D)/fs) + tf(1,'InputDelay',D/fs))/2;
end
