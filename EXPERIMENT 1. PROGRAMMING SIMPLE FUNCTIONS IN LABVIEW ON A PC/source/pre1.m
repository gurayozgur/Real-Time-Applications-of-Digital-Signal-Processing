clear; clc; close all;
x = [2 1 6 7 0 5];

y = fft(x,6);
figure
hold on
subplot(211)
stem(abs(y))
ylabel('abs(y)')
subplot(212)
stem(phase(y))
ylabel('phase(y)')
sgtitle('6-point fft of x');

z = fft(x,9);
figure
hold on
subplot(211)
stem(abs(z))
ylabel('abs(z)')
subplot(212)
stem(phase(z))
ylabel('phase(z)')
sgtitle('9-point fft of x');

v = fft(x,4);
figure
hold on
subplot(211)
stem(abs(v))
ylabel('abs(v)')
subplot(212)
stem(phase(v))
ylabel('phase(v)')
sgtitle('4-point fft of x');

x
x1 = ifft(z,9)
x2 = ifft(z,6)
x3 = ifft(v,4)

