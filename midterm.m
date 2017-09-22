%% GNC midterm
% Keshuai Xu


DATA4 = load('acceldata_p4_2017.mat');

%% Problem 1
% 1. ???
% 2. True
% 3. True
% 4. False
% 5. False
% 6. 

%% Problem 2
% Variable naming conventions: R_subscript_superscript
% x_d is dx/dt. x_dd is d(x_d)/dt. 

clear variables
syms psi theta phi psi_d theta_d phi_d real

%% 2.1

% x rotation psi
R_i_a = [1 0 0;
         0 cos(psi) sin(psi);
         0 -sin(psi) cos(psi)]
     
% y rotation theta
R_a_b = [cos(theta) 0 -sin(theta);
         0 1 0;
         sin(theta) 0 cos(theta)]
     
% z rotation phi
R_b_e = [cos(phi) sin(phi) 0;
         -sin(phi) cos(phi) 0;
         0 0 1]

%% 2.2
R_i_e = R_b_e * R_a_b * R_i_a

%% 2.3
% $$\vec{\omega}_{ie}^{e} = R_b^e R_a^b \vec{\omega}_{ia}^{a} + R_b^e \vec{\omega}_{ab}^{b} + I \vec{\omega}_{be}^{e}$$

%% 2.4
omega_ia_a = [psi_d 0 0]'
omega_ab_b = [0 theta_d 0]'
omega_be_e = [0 0 phi_d]'

%% 2.5
omega_ie_e = R_b_e * R_a_b * omega_ia_a + R_b_e * omega_ab_b + omega_be_e

% ANSWER - the part to fill in the blank
H_123_e = [cos(phi)*cos(theta) sin(phi) 0;
           -cos(theta)*sin(phi) cos(phi) 0;
           sin(theta) 0 1]

%% 2.6
% ANSWER - the part to fill in the blank
%
% $$\vec{\omega}_{ie}^i = \underline{(\cos{\theta})^{-1} B} \vec{\omega}_{ie}^e$$
%

% intermediate step and verify 2.5
omega_ie_i = H_123_e \ omega_ie_e

% the whole thing
inv_H123_e = simplify(inv(H_123_e))

% B part of the answer
B = simplify(inv_H123_e * cos(theta))


%% 2.7
% quantity measured by gyro: $$\vec{\omega}_{ie}^e$$

% convert from symbolic expression to function
inv_H123_e_fun = matlabFunction(inv_H123_e, 'Vars', [psi theta phi]');

% euler123_i = [psi theta phi]'
omega_ie_i_fun = @(euler123_i, omega_ie_e) inv_H123_e_fun(euler123_i(1), euler123_i(2), euler123_i(3)) * omega_ie_e;

[t_sim_27, y_sim_27] = ode45(@(t, y) omega_ie_i_fun(y, deg2rad([0 0.25 0.75]')), [0 20], deg2rad([5 10 15]'));

% ANSWER [psi theta phi]' deg
rad2deg(y_sim_27(end, :)')


%% 2.8
DATA28 = load('gyrodata_p2_8_2017.mat');

% linear interpolation of the gyro data
omega_ie_e_fun = @(t) interp1(time_pts', omega_iee', t)';

% TODO: check piazza
ode45(@(t, y) omega_ie_i_fun(y, omega_ie_e_fun(t)), DATA28.time_pts, deg2rad([5 10 15]'))




