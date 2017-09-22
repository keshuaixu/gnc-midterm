%% GNC midterm
% Keshuai Xu




%% Problem 1
% 1. 3.1623e-14 W*m^(-2)
%
% 2. True
%
% 3. True
%
% 4. False
%
% 5. False
%
% 6. [0 0 0]'
%
% 7. approx [0 0 2*pi/86400]
%
% 8. 6356.752314245 km
%
% 9. Proper acceleration in an inertial coordinate system
%
% 10. [0 0 0]'


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
omega_ie_e_fun = @(t) interp1(DATA28.time_pts', DATA28.omega_iee', t)';

ode45(@(t, y) omega_ie_i_fun(y, omega_ie_e_fun(t)), DATA28.time_pts, [DATA28.psi_0 DATA28.theta_0 DATA28.phi_0]')

% TODO

%% 3
% TODO add picture
clear variables
syms psi gamma psi_d gamma_d airspeed real

R_i_a = [cos(psi) sin(psi) 0;
         -sin(psi) cos(psi) 0;
         0 0 1];
R_a_e = [cos(gamma) 0 -sin(gamma);
         0 1 0;
         sin(gamma) 0 cos(gamma)];

omega_ia_a = [0 0 psi_d]';
omega_ae_e = [0 gamma_d 0]';
omega_ie_e = R_a_e * omega_ia_a + omega_ae_e;

% @(gamma_d,gamma,psi_d)[-psi_d.*sin(gamma);gamma_d;psi_d.*cos(gamma)]
omega_ie_e_fun = matlabFunction(omega_ie_e);

R_i_e = R_a_e * R_i_a;

% @(gamma,psi)
R_i_e_fun = matlabFunction(R_i_e)


v_e = [airspeed 0 0]'; 
v_i = R_i_e' * v_e

% v_dot_i = [0 0 0]'; % body frame acceleration not given in the problem. assume zero


% v_dot_e = @(v_dot_i, v_e, euler_angles, ) R_i_e * v_dot_i + omega_


%%
syms a_t a_l real;
v_dot_e = []

%%
DATA4 = load('acceldata_p4_2017.mat');

% v_dot_e_fun = @(t) interp1(DATA4.time_pts', DATA4.accel_readings', t)';

omega_ia_i = [0 0 psi_d]';
omega_ae_a = [0 gamma_d 0]';
omega_ie_i = omega_ia_i + R_i_a' * omega_ae_a


function [t_dot, y_dot] = odefun (t, y)
    psi = y(2);
    gamma = y(3);
    v_dot_e = interp1(DATA4.time_pts', DATA4.accel_readings', t)';
    
    
    

end

% y = []

         
         





