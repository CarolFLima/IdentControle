%% Mollenkamp
close all
clear
x = load('Pontos/conjunto6.txt');

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

y1 = 0.15*y_medium(stable_portion);
y2 = 0.45*y_medium(stable_portion);
y3 = 0.75*y_medium(stable_portion);

hold on
%fplot(y1, ':');
%fplot(y2, ':');
%fplot(y3, ':');

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

for i=1:numel(y_values)
    if y3<y_values(i)
        break;
    end
end

t3 = x_values(i);



% Apenas para o conj 6
t1 = 4.264;
t2 = 4.402;
t3 = 4.55;
% Apenas para o conj 6

X = (t2 - t1)/(t3 - t1);
csi = (0.0805 - 5.547*(0.475-X)^2)/(X - 0.356);


if csi < 1
    f2 = (0.708)*((2.811)^csi);
else
	f2 = 2.6*csi - 0.60 ;
    
end

wn = (f2)/(t3 - t1);

f3 = (0.922)*((1.66)^csi);

theta = t2-(f3/wn);

if csi >= 1

    tau1 = (csi + sqrt((csi^2) - 1))/wn;
    tau2 = (csi - sqrt((csi^2) - 1))/wn;
end

hold on
num = wn^2;
den = [1 2*csi*wn wn^2];


sys = tf(num, den, 'OutputDelay', theta);
step(y_medium(stable_portion)*sys);
title('Identificação por Mollenkamp');
legend('Conjunto de dados', 'Modelo identificado', 'Location','southeast');
