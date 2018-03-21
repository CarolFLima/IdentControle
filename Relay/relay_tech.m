
%% Letra b
d0 = 0.2; d2 = 0.6; d1 = -0.4;
eps0 = 0.1; eps = 0.5;

j = 1;
Tpoints = zeros(3);

for i = 1500:2001
    curr_relay = ScopeData1.signals.values(i, 1);
    if curr_relay == d0+d2
        break
    end
end

for i = i:2001
    if curr_relay == ScopeData1.signals.values(i, 1)
    else
        curr_relay = ScopeData1.signals.values(i, 1);
        Tpoints(j) = i;
        j = j+1;
    end
    
    if j == 4
        break
    end
end
Tu1 = ScopeData1.time(Tpoints(2)) - ScopeData1.time(Tpoints(1));
Tu2 = ScopeData1.time(Tpoints(3)) - ScopeData1.time(Tpoints(2));

A1 = trapz(ScopeData1.signals.values(Tpoints(1):Tpoints(3),2));
A2 = trapz(ScopeData1.signals.values(Tpoints(1):Tpoints(3),1));

K = A1/A2;

Au = max(ScopeData1.signals.values(945:977,2));
Ad = min(ScopeData1.signals.values(945:977,2));

theta = log( ((d1-d0)*K + eps0 - eps)/( Ad + (d1 - d0)*K) );
tau = Tu1/log(((d1+d2)*K*exp(theta) - (d1 - d0)*K - eps0 + eps)/( (d0+d2)*K - (eps0+eps)));

num = K;
den = [tau 1];
sys = tf(num, den, 'OutputDelay', theta);
[y1, t1] = step(sys, 0:0.1:300);
hold on
[y2, t2] = step(tf([3], [2 1], 'OutputDelay', 0.1), 0:0.1:300);

xlim([0 30])
ylim([0 3.5])

plot(t1, y1, 'Color', 'r');
plot(t2, y2, 'Color', 'b');
legend('Modelo identificado', 'Modelo original', 'Location', 'Southeast')

% Análise do erro
err = abs(y2 - y1);
max(err);
immse(y1, y2);

%% Letra c
d0 = 0; d2 =1; d1 =1;
eps0 =0.5; eps =0.15;

j = 1;
Tpoints = zeros(3);

for i = 1500:2001
    curr_relay = ScopeData2.signals.values(i, 1);
    if curr_relay == d0+d2
        break
    end
end

for i = i:2001
    if curr_relay == ScopeData2.signals.values(i, 1)
    else
        curr_relay = ScopeData2.signals.values(i, 1);
        Tpoints(j) = i;
        j = j+1;
    end
    
    if j == 4
        break
    end
end

Tu1 = ScopeData2.time(Tpoints(2)) - ScopeData2.time(Tpoints(1));
Tu2 = ScopeData2.time(Tpoints(3)) - ScopeData2.time(Tpoints(2));

A1 = trapz(ScopeData2.signals.values(Tpoints(1):Tpoints(3),2));
A2 = trapz(ScopeData2.signals.values(Tpoints(1):Tpoints(3),1));

K = A1/A2;

Au = max(ScopeData2.signals.values(1500:1600,2));
Ad = min(ScopeData2.signals.values(1500:1600,2));

theta = log( ((d1-d0)*K + eps0 - eps)/( Ad + (d1 - d0)*K) );
tau = Tu1/log(((d1+d2)*K*exp(theta) - (d1 - d0)*K - eps0 + eps)/( (d0+d2)*K - (eps0+eps)));

num = K;
den = [tau 1];
sys = tf(num, den, 'OutputDelay', theta);
[y1, t1] = step(sys, 0:0.1:300);
hold on
[y2, t2] = step(tf([3], [1 2 1], 'OutputDelay', 0.5), 0:0.1:300);

xlim([0 30])
ylim([0 3.5])

plot(t1, y1, 'Color', 'r');
plot(t2, y2, 'Color', 'b');
legend('Modelo identificado', 'Modelo original', 'Location', 'Southeast')

% Análise do erro
err = abs(y2 - y1);
max(err)
immse(y1, y2)

%% Letra d
d0 = 0.5; d2=1.5; d1 =-1;
eps0=0; eps =0.3;

j = 1;
Tpoints = zeros(3);

for i = 1500:2001
    curr_relay = ScopeData3.signals.values(i, 1);
    if curr_relay == d0+d2
        break
    end
end

for i = i:2001
    if curr_relay == ScopeData3.signals.values(i, 1)
    else
        curr_relay = ScopeData3.signals.values(i, 1);
        Tpoints(j) = i;
        j = j+1;
    end
    
    if j == 4
        break
    end
end

Tu1 = ScopeData3.time(Tpoints(2)) - ScopeData3.time(Tpoints(1));
Tu2 = ScopeData3.time(Tpoints(3)) - ScopeData3.time(Tpoints(2));

A1 = trapz(ScopeData3.signals.values(Tpoints(1):Tpoints(3),2));
A2 = trapz(ScopeData3.signals.values(Tpoints(1):Tpoints(3),1));

K = A1/A2;

Au = max(ScopeData3.signals.values(1500:1600,2));
Ad = min(ScopeData3.signals.values(1500:1600,2));

theta = log( ((d1-d0)*K + eps0 - eps)/( Ad + (d1 - d0)*K) );
tau = Tu1/log(((d1+d2)*K*exp(theta) - (d1 - d0)*K - eps0 + eps)/( (d0+d2)*K - (eps0+eps)));

num = K;
den = [tau 1];
sys = tf(num, den);
[y1, t1] = step(sys, 0:0.1:300);
hold on
[y2, t2] = step(tf([1], [5.17 2*5.17 1]), 0:0.1:300);

xlim([0 100])
ylim([0 1.5])

plot(t1, y1, 'Color', 'r');
plot(t2, y2, 'Color', 'b');
legend('Modelo identificado', 'Modelo original', 'Location', 'Southeast')

% Análise do erro
err = abs(y2 - y1);
max(err)
immse(y1, y2)