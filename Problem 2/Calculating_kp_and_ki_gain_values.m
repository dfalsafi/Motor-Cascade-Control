% Speed Controller (Outer Loop) PI Design

% Motor Mechanical Parameters
J = 200e-6;  % Rotational inertia (kg.m^2)
B = 500e-6;  % Viscous friction (kg.m^2.s^-1)
kt = 0.1;    % Torque constant (Nm/A)

% Design Specifications
phi_m_speed = 60;       % Phase margin (degrees)
omega_c_speed = 50*pi;  % Crossover frequency (rad/s)

% Step 1: Plant magnitude and phase at crossover frequency
% Plant Gps(s) = kt / (Js + B)
Gps_mag = kt / sqrt(B^2 + (omega_c_speed * J)^2);
Gps_phase_deg = rad2deg(atan2(-omega_c_speed * J, B));

% Step 2: Required Controller magnitude and phase
Gcs_mag = 1 / Gps_mag;
Gcs_phase_deg = -180 + phi_m_speed - Gps_phase_deg;

% Step 3: Calculate kp and ki
kp_speed = Gcs_mag * cosd(Gcs_phase_deg);
ki_speed = -omega_c_speed * Gcs_mag * sind(Gcs_phase_deg);

fprintf('--- Speed Loop PI Controller Gains ---\n');
fprintf('  kp = %.4f\n', kp_speed);
fprintf('  ki = %.4f\n', ki_speed);