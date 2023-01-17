%% Part 1
clear;  clc; close all;
%% a)

K = 10000;
N = 5;
h = [1 -0.8 0.6 -0.4 0.2];
std_dev = 0;
M = 5;
mu = 0.001;

s = randn(1,K);
x = conv(h,s);
x = x(1:K);
v = std_dev*randn(1,length(x));
d = x + v;

[w,LSE,e] = lms_algo(M, mu, s, d);

figure;
plot(e.^2);
hold on;
xlabel('Samples');
ylabel('e^{2}[n]');

%% b)

mu = 0.1;
[w,LSE,e] = lms_algo(M, mu, s, d);

figure;
plot(e.^2);
hold on;
xlabel('Samples');
ylabel('e^{2}[n]');

%% e)
mu = 0.001;
std_dev = 0.2;
v = std_dev*randn(1,length(x));
d = x + v;
[w,LSE,e] = lms_algo(M, mu, s, d);

figure;
plot(e.^2);
hold on;
xlabel('Samples');
ylabel('e^{2}[n]');

%% f)
mu = 0.1;
[w,LSE,e] = lms_algo(M, mu, s, d);

figure;
plot(e.^2);
hold on;
xlabel('Samples');
ylabel('e^{2}[n]');

%% h)
M = 4;
mu = 0.001;
std_dev = 0;
v = std_dev*randn(1,length(x));
d = x + v;
[w,LSE,e] = lms_algo(M, mu, s, d);
figure;
plot(e.^2);
hold on;
xlabel('Samples');
ylabel('e^{2}[n]');

%% i)
M = 10;
[w,LSE,e] = lms_algo(M, mu, s, d);
figure;
plot(e.^2);
hold on;
xlabel('Samples');
ylabel('e^{2}[n]');
%% Part 2
%% j)
M = 5;
mu = 0.001;
std_dev = 1;
x = sin(2*pi*200/10000*(1:K));
v = std_dev*randn(1,length(x));
s = conv(v,h);
s = s(1:K);
d = x + s;

[w,LSE,e] = lms_algo(M, mu, v, d);

figure;
plot((x-e).^2);
hold on;
xlabel('Samples');
ylabel('(x-e)^{2}[n]');

figure;
plot(x);
hold on;
plot(e);
xlabel('Samples');
ylabel('Amplitude');
legend('x','e');

%% k)
mu = 0.01;
[w,LSE,e] = lms_algo(M, mu, v, d);

figure;
plot((x-e).^2);
hold on;
xlabel('Samples');
ylabel('(x-e)^{2}[n]');

figure;
plot(x);
hold on;
plot(e);
xlabel('Samples');
ylabel('Amplitude');
legend('x','e');

%% m)
mu = 0.001;
std_dev = 2;
v = std_dev*randn(1,length(x));
s = conv(v,h);
s = s(1:K);
d = x + s;

[w,LSE,e] = lms_algo(M, mu, v, d);

figure;
plot((x-e).^2);
hold on;
xlabel('Samples');
ylabel('(x-e)^{2}[n]');

%% n)
M = 4;
mu = 0.001;
std_dev = 1;
v = std_dev*randn(1,length(x));
s = conv(v,h);
s = s(1:K);
d = x + s;

[w,LSE,e] = lms_algo(M, mu, v, d);

figure;
plot((x-e).^2);
hold on;
xlabel('Samples');
ylabel('(x-e)^{2}[n]');

%% o)
M = 10;

[w,LSE,e] = lms_algo(M, mu, v, d);

figure;
plot((x-e).^2);
hold on;
xlabel('Samples');
ylabel('(x-e)^{2}[n]');

%% Functions

function [w,LSE,error] = lms_algo(filter_length, step_size, input, desired)
w = zeros(filter_length,1);
error = zeros(size(input));

for i = 1: length(input)
    sig = zeros(filter_length,1);
    
    if i < filter_length
        sig(1:i) = fliplr(input(1:i)); 
    else 
        sig = fliplr(input(i-filter_length+1:i)).';
    end
    y = sum(w .* sig);
    error(i) = desired(i) - y;
    w = w + step_size * error(i) * sig;
    
end

LSE = mean(error.^2);



end