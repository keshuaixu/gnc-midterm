function y_dot = odefun_4 (t, y, R_i_e_fun, DATA4)
    airspeed = y(1,:);
    psi = y(2,:);
    gamma = y(3,:);
    accel_reading = interp1(DATA4.time_pts', DATA4.accel_readings', t)';
    p_ddot_t = R_i_e_fun(gamma, psi)' * accel_reading;
    
    y_dot = [accel_reading(1,:); 
        accel_reading(2,:)/(airspeed * cos(gamma)); % psi_dot
        accel_reading(3,:)/(-airspeed); % gamma_dot. divide by zero?
        y(7:9,:);
        p_ddot_t];
end

