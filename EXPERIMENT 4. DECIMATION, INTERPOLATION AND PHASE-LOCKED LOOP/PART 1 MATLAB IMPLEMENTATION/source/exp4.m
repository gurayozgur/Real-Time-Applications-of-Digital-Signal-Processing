clear all; close all; clc;
rng default;
M = 4; K = 5; L = 5; N = 9;
%% a.1
fs = 4000*K;
t = 0:1/fs:20*N/1000;
mysin = sin(2*pi*100*K*t);
mydecimated = my_decimate(mysin,M);
time_plot(mysin,mydecimated,fs);
%% a.2
frequency_plot(mysin,mydecimated,fs);
%% a.3
mytriangular = sawtooth(2*pi*100*K*t,1/2);
mydecimated2 = my_decimate(mytriangular,M);
time_plot(mytriangular,mydecimated2,fs);
%% a.4
frequency_plot(mytriangular,mydecimated2,fs);
%% b.1
myinterpolated = my_interpolate(mysin,L);
time_plot(mysin,myinterpolated,fs);
%% b.2
frequency_plot(mysin,myinterpolated,fs);
%% b.3
myinterpolated2 = my_interpolate(mytriangular,L);
time_plot(mytriangular,myinterpolated2,fs);
%% b.4
frequency_plot(mytriangular,myinterpolated2,fs);
%% c.1
myrational = my_rational(mysin,L,M);
time_plot(mysin,myrational,fs)
%% c.2
frequency_plot(mysin,myrational,fs);
%% c.3
myrational2 = my_rational(mytriangular,L,M);
time_plot(mytriangular,myrational2,fs);
%% c.4
frequency_plot(mytriangular,myrational2,fs);
%% d.1 and d.2
fs = 4000*(L+M);
t = 0:1/fs:30/(100*(L+M)); 
x1 = sin(2*pi*100*(L+M)*t+2*pi*rand(1));
x2 = sin(2*pi*25*(L+M)*t+2*pi*rand(1));
pll1 = pll(x1,fs,t);
pll2 = pll(x2,fs,t);
time_plot(x1, pll1, fs);
time_plot(x2, pll2, fs);

function total = pll(x,fs,t)
frequency = estimate_frequency(x,fs);
phase = 0;
k = 100;
total = [];
for i = 1:length(x)/k
	y = cos(2*pi*frequency*t(1+k*(i-1):k*i)+phase);
	add = sin(2*pi*frequency*t(1+k*(i-1):k*i)+phase);
	error = y.*x(1+k*(i-1):k*i);
	gn = mean(error);
	phase = phase+gn;
	total = [total add];    
end
end

function wave_freq = estimate_frequency(wave,sample_freq)
dft_wave = abs(fft(wave));
dex = 0:(length(dft_wave)-1);
dex = dex(max(dft_wave)==dft_wave);
dex= dex(1);
wave_freq = dex/length(dft_wave)*sample_freq;
end

%% plotting functions
function time_plot(input,output, fs)


input_size = length(input);
output_size = length(output);
t1 = 0:1/fs:(1/fs)*(output_size-1);
t = 0:1/fs:(1/fs)*(input_size-1);
fig= figure;

plot(t, input);
xlabel('Time (s)');
ylabel('Amplitude')
hold on
plot(t1, output);
legend("Input","Output")
name = strcat(inputname(2),".png");
saveas(fig,name)
end

function frequency_plot(input, output,fs)

input_size =length(input);
w = 0:2*pi/input_size : 2*pi*(input_size-1)/input_size;
w = fftshift (w);
w (w>pi) = w (w>pi) - 2 * pi;
w = w*fs/(2*pi);

fig=figure;
plot(w, abs(fftshift(fft(input))));
xlabel('Frequency (Hz)');
hold on
input_size = length(output);

w = 0:2*pi/input_size : 2*pi*(input_size-1)/input_size;
w = fftshift (w);
w (w>pi) = w (w>pi) - 2 * pi;
w = w* fs/(2*pi);
plot(w,abs(fftshift(fft(output))));
legend("Input","Output");
name = strcat(inputname(2),"_freq",".png");
saveas(fig,name)
end
%% a
function decimated = my_decimate(input,M)
    decimated = resample(input,1,M);
end
%% b
function interpolated = my_interpolate(input,L)
    interpolated = resample(input,L,1);    
end
%% c
function rational = my_rational(input,L,M)
    rational = resample(input,L,M);   
end
