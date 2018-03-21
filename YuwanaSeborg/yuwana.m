%% Letra A
close all
pontos = [ScopeData.time, ScopeData.signals.values];

x_values = pontos(:,1);
y_values = pontos(:,2);

range2 = numel(y_values);
range1 = range2 - 12;

% Peek values
y_p1 = max(y_values);
[row] = find(y_values == y_p1);

y_pm = min(y_values(row:range2));
[row] = find(y_values == y_pm);

y_p2 = max(y_values(row:range2));

% Stable region estimate
y_inf1 = median(y_values(range1:range2));
y_inf = (y_p2*y_p1 - y_pm^2)/(y_p1 + y_p2 - 2*y_pm);

% Delta t
bound1 = y_inf - 0.003;
bound2 = y_inf + 0.009;
[row] = find(y_values>bound1 & y_values<bound2, 2);
dt = x_values(row(2)) - x_values(row(1));

% Function parameters
P = log((y_p2 - y_inf)/(y_p1 - y_inf));
zeta1 = - (P/sqrt(4*pi*pi + P^2));
P1 = log( (y_inf - y_pm)/(y_p1 - y_inf) );
zeta2 = -(P1/sqrt(pi*pi + P1^2));

zeta = (zeta1 + zeta2)/2;
A = 1;
Kc = 1;
K = y_inf/(Kc*(A-y_inf));
Kf = K*Kc;
tau = (dt/pi)*(zeta*sqrt(Kf+1) + sqrt(zeta*zeta*(Kf+1)+Kf) * sqrt((1-zeta^2)*(Kf+1)) );
theta = (2*dt*sqrt(((1-zeta*zeta))*(Kf+1))) / (pi*(zeta*sqrt(Kf+1)+sqrt((zeta^2)*(Kf+1)+Kf)));

K_bar = Kf/(Kf+1);
tau_bar = ((theta*tau)/(2*(Kf+1)))^0.5;
zeta_bar = (tau + 0.5*theta*(1-Kf))/(sqrt(2*theta*tau*(Kf+1)));

% Transfer function
num = [-K_bar*0.5*theta K_bar];
den = [tau_bar^2 2*zeta*tau_bar 1];
Ts = tf(num, den, 'OutputDelay', 1.5);

% Plot settings
plot(x_values, y_values, 'Color', 'k');
hold on
[y_tf t_tf] = step(Ts, 0:0.2:40);
plot(t_tf, y_tf, 'Color', 'r');
f1 = y_inf*ones(numel(x_values));
plot(x_values, f1, ':', 'Color', 'b');
title('Conjunto 1')
legend('Modelo original', 'Modelo identificado')
xlim([0 35])
ylim([-0.2 0.8])

% Error analysis
immse(y_values, y_tf)
%% Letra B
close all;
pontos = [ScopeData1.time, ScopeData1.signals.values];

x_values = pontos(:,1);
y_values = pontos(:,2);

range2 = numel(y_values);
range1 = range2 - 12;

% Peek values
y_p1 = max(y_values);
[row] = find(y_values == y_p1);

y_pm = min(y_values(row:range2));
[row] = find(y_values == y_pm);

y_p2 = max(y_values(row:range2));

% Stable region estimate
y_inf1 = median(y_values(range1:range2));
y_inf = (y_p2*y_p1 - y_pm^2)/(y_p1 + y_p2 - 2*y_pm);

% Delta t
bound1 = y_inf - 0.003;
bound2 = y_inf + 0.003;

[row] = find(y_values>bound1 & y_values<bound2, 2);
dt = x_values(row(2)) - x_values(row(1));

% Function parameters
P = log((y_p2 - y_inf)/(y_p1 - y_inf));
zeta1 = - (P/sqrt(4*pi*pi + P^2));
P1 = log( (y_inf - y_pm)/(y_p1 - y_inf) );
zeta2 = -(P1/sqrt(pi*pi + P1^2));

zeta = (zeta1 + zeta2)/2;
A = 1;
Kc = 1;
K = y_inf/(Kc*(A-y_inf));
Kf = K*Kc;
tau = (dt/pi)*(zeta*sqrt(Kf+1) + sqrt(zeta*zeta*(Kf+1)+Kf) * sqrt((1-zeta^2)*(Kf+1)) );
theta = (2*dt*sqrt(((1-zeta*zeta))*(Kf+1))) / (pi*(zeta*sqrt(Kf+1)+sqrt((zeta^2)*(Kf+1)+Kf)));

K_bar = Kf/(Kf+1);
tau_bar = ((theta*tau)/(2*(Kf+1)))^0.5;
zeta_bar = (tau + 0.5*theta*(1-Kf))/(sqrt(2*theta*tau*(Kf+1)));

%tau_bar = 1.5;
% Transfer function
num = [-K_bar*0.5*theta K_bar];
den = [tau_bar^2 2*zeta*tau_bar 1];
Ts = tf(num, den, 'OutputDelay', theta);


% Plot settings
plot(x_values, y_values, 'Color', 'k');
hold on
[y_tf t_tf] = step(Ts, 0:0.2:40);
plot(t_tf, y_tf, 'Color', 'r');
f1 = y_inf*ones(numel(x_values));
plot(x_values, f1, ':', 'Color', 'b');
title('Conjunto 2')
legend('Modelo original', 'Modelo identificado')
xlim([0 30])
ylim([-0.2 0.8])

% Error analysis
immse(y_values, y_tf)