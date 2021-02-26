function G = end_time(D, fs)
    G = tf(1,'InputDelay',D/fs);
end