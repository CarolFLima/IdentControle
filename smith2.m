%% Smith Segunda Ordem
close all
clear
x = load('Pontos/conjunto3.txt');

x_values = x(:,2);
y_values = x(:,1);
size = 15;
%fitted_values = fit(x_values, y_values, 'poly9');
%plot(fitted_values, x_values, y_values);
plot(x_values, y_values, 'Color', 'k');

n = numel(y_values);
points_per_slice = floor(n/size);

y_medium = ones(size,1);
for i = 1:size
    y_medium(i) = median(y_values((i-1)* points_per_slice+1:points_per_slice*i));
end

avg_diff = 0;
stable_portion = numel(y_medium);

% Checks for stable region
for i = numel(y_medium):-1:2
    avg_diff = y_medium(i) - y_medium(i-1);
    if avg_diff<=(0.01*y_medium(size))
        stable_portion = i;
    else 
        break;
    end
end


y1 = 0.2*y_medium(stable_portion);
y2 = 0.6*y_medium(stable_portion);

for i=1:numel(y_values)
    if y1<y_values(i)
        break;
    end
end

t1 = x_values(i);

for i=1:numel(y_values)
    if y2<y_values(i)
        break;
    end
end

t2 = x_values(i);


t1/t2 % Razão de checagem do gráfico

tau = 0.33;
csi = 0.5;
tau1 = tau*csi + tau*sqrt(csi*csi -1);
tau2 = tau*csi - tau*sqrt(csi*csi -1);

hold on
num = 1;
den = [tau1*tau2 (tau1+tau2) 1]
sys = tf(num, den, 'OutputDelay', 0.6);
step(y_medium(stable_portion)*sys);
xlim([0 7])
title('Identificação por Smith')