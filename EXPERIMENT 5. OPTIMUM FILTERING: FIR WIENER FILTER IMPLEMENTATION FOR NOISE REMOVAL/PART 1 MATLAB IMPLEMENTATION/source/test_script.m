%% Part 1)
N = 1000;
P = 8;
a = 0.8;
std = 1;
P_step = 0;

[MSE, LSE, output,x,s] = wiener_filter(N, P, a, std, P_step, 1);

%% Part 2)
f = [0 0.4 0.8 1];
a = [1 1 0 0];
order = 30;
b = firpm(order,f,a)

y = conv(x,b);
y = y(order/2+1:end-order/2);
e = y-s;
LSE2 = mean(e.*e)

figure;
plot(s);
hold on;
plot(y);
legend('s[n]','y[n]');
title('Desired Signal and Parks-McClellan Output');

figure;
subplot(3,1,3);
plot(s);
hold on;
title('d[n]');
subplot(3,1,2);
plot(y);
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
%% Part 3)
mse = zeros(size(1:5));
lse = mse;
N = 1000;
P = 8;
a = 0.8;
std = 1;
for P_step = 1:5
   if P_step == 3
       po = 1;
   else
       po = 0;
   end
   
   [MSE, LSE, ~,~,~] = wiener_filter(N, P, a, std, P_step, po);
   lse(P_step) = LSE;
   mse(P_step) = MSE;
    
end