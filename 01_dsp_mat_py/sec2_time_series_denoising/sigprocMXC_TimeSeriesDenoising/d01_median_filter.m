clc, clear, close all;
randn('seed', 0);

n = 2000;
signal = cumsum(randn(n,1));

% plot(signal);

propnoise = .05;

noisepnts = randperm(n);
noisepnts = noisepnts(1:round(n*propnoise));

signal(noisepnts) = 50+rand(size(noisepnts))*100;

% plot(signal)

figure(1), clf
histogram(signal,100)
zoom on

threshold = 29;

suprathresh = find(signal>threshold);
% suprathresh = 1:n;

filtsig = signal;

% loop through suprathreshold points and set to median of k
k = 20; % actual window is k*2+1
for ti=1:length(suprathresh)
    
    % find lower and upper bounds
    lowbnd = max(1,suprathresh(ti)-k);
    uppbnd = min(suprathresh(ti)+k,n);
    
    % compute median of surrounding points
    filtsig(suprathresh(ti)) = median(signal(lowbnd:uppbnd));
end

% plot
figure(2), clf
plot(1:n,signal, 1:n,filtsig, 'linew',2)
zoom on

