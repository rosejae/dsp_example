clc; clear; close all;

load emg4TKEO.mat

emgf = emg;

for i=2:length(emgf)-1
    emgf(i) = emg(i)^2 - emg(i-1)*emg(i+1);
end

emgf2 = emg;
emgf2(2:end-1) = emg(2:end-1).^2 - emg(1:end-2).*emg(3:end);

time0 = dsearchn(emgtime',0);

emgZ = (emg-mean(emg(1:time0))) / std(emg(1:time0));

emgZf = (emgf-mean(emgf(1:time0))) / std(emgf(1:time0));

figure(1), clf

% plot "raw" (normalized to max-1)
subplot(211), hold on
plot(emgtime,emg./max(emg),'b','linew',2)
plot(emgtime,emgf./max(emgf),'m','linew',2)

xlabel('Time (ms)'), ylabel('Amplitude or energy')
legend({'EMG';'EMG energy (TKEO)'})


% plot zscored
subplot(212), hold on
plot(emgtime,emgZ,'b','linew',2)
plot(emgtime,emgZf,'m','linew',2)

xlabel('Time (ms)'), ylabel('Zscore relative to pre-stimulus')
legend({'EMG';'EMG energy (TKEO)'})