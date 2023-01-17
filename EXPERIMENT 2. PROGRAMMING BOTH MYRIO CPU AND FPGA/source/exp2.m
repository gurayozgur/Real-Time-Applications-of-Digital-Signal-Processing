bitDepth = 8;
filterCoeff = 0.5;

signal = rand(256,1);

%% IIR Filter Floating Point
y1 = zeros(size(signal));
x = signal;
for k = 1:256
    if k == 1
        y1(k) = x(k);
    else
        y1(k) = 0.5*y1(k-1)+x(k);
    end
    
end

%% IIR Filter Fixed Point
x2 = floor((2^7)*signal);
y2 = zeros(size(y1));
for k = 1:256
    if k == 1
        y2(k) = x2(k);
    else
        y2(k) =floor( floor(0.5*(2^7))*y2(k-1)*2^(-7))+x2(k);
    end
    
end

figure 
plot(y1)
hold on
plot(y2./(2^7))
legend("Floating-Point Output","Fixed-Point Output") 
figure
plot(y1-y2./(2^7))
title("Error")