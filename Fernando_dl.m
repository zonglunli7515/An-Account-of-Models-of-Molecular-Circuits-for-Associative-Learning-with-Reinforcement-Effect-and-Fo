%%% This file is used for the Fernando's model%%%

% v_p = 1.0; v_w = 1.0; delta_p = 0.005; delta_w = 0.0001; epsilon = 0.05; K_w = 50; K_r=0.05; K_p = 50; R = 10; k = 10;

% dimensionless parameters
% alpha = v_p/K_p/delta_p; beta = v_w/K_w/delta_p; theta = delta_w/delta_p; tau = epsilon/K_w/delta_p;
% S = R/K_r;

u = 50;
alpha = 1;
beta = 0.8; %0.8
theta = 0.02;  %0.02
tau = 0.1;
S = 10;

dt = 0.01;
T = 300;
n = T/dt;

U1 = zeros(1,n); U2 = zeros(1,n); P = zeros(1,n); W1 = zeros(1,n); W2 = zeros(1,n);
W1(1) = 4; %10
W2(1) = 0.6;

U1(11/dt:15/dt) = u;
U2(31/dt:35/dt) = u;
U1(51/dt:55/dt) = u;
U2(51/dt:55/dt) = u;
U2(71/dt:75/dt) = u;
U1(91/dt:95/dt) = u;
U2(91/dt:95/dt) = u;
U2(111/dt:115/dt) = u;
U2(131/dt:135/dt) = u;
U2(151/dt:155/dt) = u;
U2(201/dt:205/dt) = u;
U2(251/dt:255/dt) = u;

R1 = S./(1+U1);
R2 = S./(1+U2);
a = 4; 
b = 2;

for i=1:n-1
   fp = alpha * (W1(i)^a/(1+W1(i)^a)) * (1/(1+R1(i)^b)) + alpha * (W2(i)^a/(1+W2(i)^a)) * (1/(1+R2(i)^b)) - P(i);
   fw1 = beta * (P(i)^b/(1+P(i)^b)) * (1/(1+R1(i)^b)) - theta * W1(i) + tau;
   fw2 = beta * (P(i)^b/(1+P(i)^b)) * (1/(1+R2(i)^b)) - theta * W2(i);
   P(i+1) = P(i) + fp * dt;
   W1(i+1) = W1(i) + fw1 * dt;
   W2(i+1) = W2(i) + fw2 * dt;
end

figure('Renderer', 'painters', 'Position', [10 10 400 2000])

subplot(4,1,1);
plot(dt*(0:(n-1)), P);
ylabel('p');
title('(1)');

subplot(4,1,2);
plot(dt*(0:(n-1)), U2);
ylabel('u_{2}');
title('(2)');

subplot(4,1,3);
plot(dt*(0:(n-1)), U1);
ylabel('u_{1}');
title('(3)');

subplot(4,1,4);
plot(dt*(0:(n-1)), W1);
hold on;
plot(dt*(0:(n-1)), W2);
xlabel('time');
ylabel('weight');
title('(4)');
