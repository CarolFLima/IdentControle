%% Smith
close all
clear
x = load('Pontos/conjunto2.txt');

x_values = x(:,2);
y_values = x(:,1);
size = 15;
fitted_values = fit(x_values, y_values, 'poly9');
plot(fitted_values, x_values, y_values);

n = numel(y_values);
points_per_slice = floor(n/size);

y_medium = ones(size,1);
for i = 1:size
    y_medium(i) = median(y_values((i-1)* points_per_slice+1:points_per_slice*i));
end

% adicionar os pontos que faltam

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

y1 = 0.632*y_medium(stable_portion);
y2 = 0.283*y_medium(stable_portion);

for i=1:numel(y_values)
    if y1<y_values(i)
        break;
    end
end

t1 = i;

for i=1:numel(y_values)
    if y2<y_values(i)
        break;
    end
end

t2 = i;

hold on

%plot([x_values(t1) x_values(t2)], [y1 y2]);
%sys = tf([(y_medium(stable_portion) - y_values(1))], [1.5*(x_values(t1) - x_values(t2)) 1]);

sys = tf([(y_medium(stable_portion) - y_values(1))], [1.5*(x_values(t1) - x_values(t2)) 1], 'OutputDelay', (1.5*x_values(t2) - 0.5*x_values(t1)));
step(sys);
% xlim([0 10])
% ylim([0 2])