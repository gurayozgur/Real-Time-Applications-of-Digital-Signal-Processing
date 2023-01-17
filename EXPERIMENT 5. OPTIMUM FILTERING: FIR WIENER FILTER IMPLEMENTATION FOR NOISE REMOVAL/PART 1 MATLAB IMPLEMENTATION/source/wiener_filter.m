function [MSE, LSE, output,x,s] = wiener_filter(N, P, a, std, P_step, po)
%WIENER_FILTER Summary of this function goes here
%   Detailed explanation goes here
rng default;
w_noise = randn(N,1);
s = filter(1,[1,-a],w_noise);
v = std * randn(N,1);

x = s + v;
Rx = rx_estimator(x, P);
rdx = rdx_estimator(s, x, P_step, P);


h = Rx^(-1) * rdx;

output = conv(x,h);
d = s(1+P_step:end);
output = output(1 :length(d));
e = output - d;

syms m;
the_rx(m) = 1/(1-a^2)*a^(abs(m)) + std^2*kroneckerDelta(m);
the_rdx(m) = 1/(1-a^2)*a^(abs( m + P_step)); 
the_rx = the_rx (0:P-1);
the_rx = toeplitz(the_rx);
the_rdx = the_rdx ((0:P-1)');

hopt = the_rx^(-1)*the_rdx;
MSE = 1/(1-a^2) - hopt'*the_rdx;
MSE = vpa(MSE);

LSE = rx_estimator(e,1);

if po == 1
    figure;
    plot(s(1 + P_step:end));
    hold on;
    plot(output);
    legend('s[n + P_{step}]','y[n]');
    title('Desired Signal and Wiener Output');
    
    figure;
    subplot(3,1,3);
    plot(s(1 + P_step:end));
    hold on;
    title('d[n]');
    subplot(3,1,2);
    plot(output);
    hold on;
    title('y[n]');
    
    subplot(3,1,1);
    plot(x);
    hold on;
    title('x[n]');
    
    figure;
    plot(e);
    hold on;
    title('e[n]');
end
end


%% Auxiliary Functions
function Rx = rx_estimator(x, P)
temp_rx = zeros(P,1);

for i = 1:P
   
    temp_rx(i) = mean(x(1:end-i+1).*x(i:end));
    
end

Rx = toeplitz(temp_rx);

end

function rdx = rdx_estimator(d, x, P_step, P)

rdx = zeros(P,1);

for i = 1:P
   
    rdx(i) = mean(d(i + P_step:end).*x(1:end-i+1-P_step));
    
end

end