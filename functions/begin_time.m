function G = begin_time(D, fs)
    G = tf(1,'InputDelay',(1-D)/fs);
end

