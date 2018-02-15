%Ziegler Nichols
close all
clear
x = load('Pontos/conjunto1.txt');

x_values = x(:,2);
y_values = x(:,1);
size = 30; % numero de fatias ao longo da curva
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
    if avg_diff<=(0.1*y_medium(size))
        stable_portion = i;
    else 
        break;
    end
end

% checar do inicio ate a regiao estavel por ponto de inflexao
% caso nao tenha, nao sei o que fazer
% caso tenha, achar inclinacao a partir dos pontos intermediarios
avg_diff = 0;
for i = 1:stable_portion
    avg_diff = y_medium(i+1)-y_medium(i);
    i
    avg_diff
    
end
%% medias

for i = 1:29
    i
    y_medium(i+1)-y_medium(i)
end


%%
f1 = diff(y_medium);
f2 = diff(y_medium);
inflec_pt = solve(f2,'MaxDegree',1);
double(inflec_pt)













