%%% This file is used for the new model%%%

alpha_yx = 2; alpha_yz = 4; alpha_xyz = 4; alpha_ux = 0.6; alpha_vx = 1.5; % 0.6
beta_u = 0.1; beta_v = 0.02; 

dt = 0.01;
T = 200;
n = T/dt;

X = zeros(1,n); Y = zeros(1,n); Z = zeros(1,n); U = zeros(1,n); V = zeros(1,n); W = zeros(1,n);

input = 10;  %10
V(1) = 6;

Z(11/dt:15/dt) = input;
X(31/dt:35/dt) = input;
%Z(51/dt:55/dt) = input; % uncomment this line to create figure 7
X(51/dt:55/dt) = input;
X(81/dt:85/dt) = input;
X(101/dt:105/dt) = input;
%Z(101/dt:105/dt) = input; % uncomment this line to create figure 7
X(131/dt:135/dt) = input;
X(151/dt:155/dt) = input;
X(171/dt:175/dt) = input;

a = 2; 

for i=1:n-1
   fy = alpha_yx * X(i)^a/(1+X(i)^a) * 1/(1+Z(i)^a) * 1/(1+V(i)^a) ...
       +alpha_yz * 1/(1+X(i)^a) * Z(i)^a/(1+Z(i)^a) * 1/(1+V(i)^a) ...
       +alpha_xyz * X(i)^a/(1+X(i)^a) * Z(i)^a/(1+Z(i)^a) * 1/(1+V(i)^a) ...
       -Y(i);
   fu = alpha_ux * X(i)^a/(1+X(i)^a) - beta_u * U(i);
   fv = alpha_vx * X(i)^a/(1+X(i)^a) * 1/(1+U(i)^a) * 1/(1+Z(i)^a) - beta_v * V(i);
   %fv = alpha_vx * X(i)^a/(1+X(i)^a) * 1/(1+Z(i)^a) - beta_v * V(i);
   Y(i+1) = Y(i) + fy * dt;
   U(i+1) = U(i) + fu * dt;
   V(i+1) = V(i) + fv * dt;
end

figure('Renderer', 'painters', 'Position', [10 10 400 2000])

subplot(4,1,1);
plot(dt*(0:(n-1)), Y);
ylabel('y');
title('(1)');

subplot(4,1,2);
plot(dt*(0:(n-1)), X);
ylabel('x');
title('(2)');

subplot(4,1,3);
plot(dt*(0:(n-1)), Z);
ylabel('z')
title('(3)');

subplot(4,1,4);
plot(dt*(0:(n-1)), U);
hold on;
plot(dt*(0:(n-1)), V);
xlabel('time');
ylabel('weight');
title('(4)');