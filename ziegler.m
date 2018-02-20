%% Ziegler Nichols
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
    if avg_diff<=(0.003*y_medium(size))
        stable_portion = i;
    else 
        break;
    end
end


hold on
%tan_line = fit([1.934; 0.1656], [2.076; 0.2482], 'poly1');
tan_line = fit([4.393; 4.458], [0.0007428; 0.001123], 'poly1');
plot(tan_line, '--');

fplot(y_medium(stable_portion), ':');

%%
t1 = 4.272;
t2 = 4.608;
teta = t1;
tau = t2 - t1;

kp = 0.0019;

sys = tf(kp, [tau 1], 'OutputDelay', teta);

step(sys);
legend('Conjunto de dados', 'Reta no ponto de inflexão', 'Modelo identificado', 'Location','southeast');

title('Identificação por Ziegler Nichols');


