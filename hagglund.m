%% Hagglund
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
    if avg_diff<=(0.001*y_medium(size))
        stable_portion = i;
    else 
        break;
    end
end

y1 = 0.6325*y_medium(stable_portion);

for i=1:numel(y_values)
    if y1<y_values(i)
        break;
    end
end

hold on
%tan_line = fit([1.934; 0.1656], [2.076; 0.2482], 'poly1');
tan_line = fit(x_values(i-7:i+2), y_values(i-7:i+2), 'poly1');
plot(tan_line, '--');

fplot(y_medium(stable_portion), ':');
fplot(0, ':');

%%
t1 = 4.064;
theta = t1;
tau = x_values(i) - t1;
kp = 0.0019;

sys = tf(kp, [tau 1], 'OutputDelay', theta);

step(sys);
legend('Conjunto de dados', 'Reta em 63.3% de Y', 'Modelo identificado', 'Location','southeast');

title('Identificação por Hagglund');

%%
xlim([0 1])
ylim([-0.4 1.5])