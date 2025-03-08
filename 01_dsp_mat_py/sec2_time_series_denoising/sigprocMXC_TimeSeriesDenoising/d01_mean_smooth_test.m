srate = 1000; % Hz
time  = 0:1/srate:3; % 3 seconds
n     = length(time);
p     = 15;

noiseamp = 5;

ampl = interp1(rand(p,1)*30,linspace(1,p,n)); 
% rand(a,b): making a,b matrix whose magnitude is less than 1
% linspace(a,b,n): making an 1xn array that each point is between a and b
% interp1: [y-axis = 1~30 15ea], [x-axis = 1~15 3001ea]
% interpolate the values between rand(p,1)*30's values
noise = noiseamp * randn(size(time));
% randn(a,b): axb matrix including random -1~1 values
signal = ampl + noise;

filtsig = zeros(size(signal));

k = 100;
for i=k+1:n-k-1
    filtsig(i) = mean(signal(i-k:i+k));
end

windowsize = 1000*(k*2+1) / srate;

% plot the noisy and filtered signals
figure(1), clf, hold on
plot(time,signal, time,filtsig, 'linew',2)

% draw a patch to indicate the window size
tidx = dsearchn(time',1);
ylim = get(gca,'ylim');
patch(time([ tidx-k tidx-k tidx+k tidx+k ]),ylim([ 1 2 2 1 ]),'k','facealpha',.25,'linestyle','none')
plot(time([tidx tidx]),ylim,'k--')

xlabel('Time (sec.)'), ylabel('Amplitude')
title([ 'Running-mean filter with a k=' num2str(round(windowsize)) '-ms filter' ])
legend({'Signal';'Filtered';'Window';'window center'})

zoom on