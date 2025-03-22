% randn('seed', 50);

order = 5;
x = linspace(-15,15,100);

y = zeros(size(x));

for i=1:order+1
    y = y + randn*x.^(i-1);
end

figure(1), clf
hold on
plot(x,y,'linew',4)
title([ 'Order-' num2str(order) ' polynomial' ])


n = 10000;
t = (1:n)';
k = 10; % number of poles for random amplitudes
slowdrift = interp1(100*randn(k,1),linspace(1,k,n),'pchip')';
signal = slowdrift + 20*randn(n,1);


figure(2), clf, hold on
h = plot(t,signal);
set(h,'color',[1 1 1]*.6)
xlabel('Time (a.u.)'), ylabel('Amplitude')

%% fit a 3-order polynomial

% polynomial fit (returns coefficients)
p = polyfit(t,signal,7);

% predicted data is evaluation of polynomial
yHat = polyval(p,t);

% compute residual (the cleaned signal)
residual = signal - yHat;


% now plot the fit (the function that will be removed)
plot(t,yHat,'r','linew',4)
plot(t,residual,'k','linew',2)

legend({'Original';'Polyfit';'Filtered signal'})

