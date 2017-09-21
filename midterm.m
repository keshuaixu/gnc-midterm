%% GNC midterm
% Keshuai Xu

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
         0 cos(psi) -sin(psi);
         0 sin(psi) cos(psi)]
     
% y rotation theta
R_a_b = [cos(theta) 0 sin(theta);
         0 1 0;
         -sin(theta) 0 cos(theta)]
     
% z rotation phi
R_b_e = [cos(phi) -sin(phi) 0;
         sin(phi) cos(phi) 0;
         0 0 1]

%% 2.2
R_i_e = R_b_e * R_a_b * R_i_a

%% 2.3
% $$\vec{\omega}_{ie}^{e} = R_b^e R_a^b \vec{\omega}_{ia}^{a} + R_b^e \vec{\omega}_{ab}^{b} + \vec{\omega}_{be}^{e}$$

%% 2.4
omega_ia_a = [psi_d 0 0]'
omega_ab_b = [0 theta_d 0]'
omega_be_e = [0 0 phi_d]'

%% 2.5
omega_ie_e = R_b_e * R_a_b * omega_ia_a + R_b_e * omega_ab_b + omega_be_e

% wrong omega_ie_e_left = omega_ie_e / [psi_d theta_d phi_d]'

%% 2.6

