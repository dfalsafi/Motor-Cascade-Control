% PI Controller Calculator for DC Motor Inner Current Loop

% 1. Define Motor Parameters
R = 1;      % Armature resistance (Ohms)
L = 0.004;  % Armature inductance (H)

% 2. Define Inputs for the 3 Cases
% Input your desired phase margins (in degrees) here:
phi_m_inputs = [30, 60, 85];      

% Input your desired crossover frequencies (in rad/s) here:
omega_c_inputs = [500*pi, 500*pi, 500*pi]; 

fprintf('--- PI Controller Gains Calculator ---\n\n');

% 3. Loop through each case and calculate gains
for i = 1:length(phi_m_inputs)
    pm = phi_m_inputs(i);
    wc = omega_c_inputs(i);
    
    % Step A: Plant magnitude and phase at crossover frequency
    % Magnitude of Gp(jwc) = 1 / sqrt(R^2 + (wc*L)^2)
    Gp_mag = 1 / sqrt(R^2 + (wc * L)^2);
    
    % Phase of Gp(jwc) in degrees
    Gp_phase_rad = atan2(-wc * L, R); 
    Gp_phase_deg = rad2deg(Gp_phase_rad); 
    
    % Step B: Required Controller magnitude and phase
    Gc_mag = 1 / Gp_mag;
    Gc_phase_deg = -180 + pm - Gp_phase_deg;
    
    % Step C: Calculate kp and ki
    % Using trigonometric relations: kp = |Gc|*cos(theta) and ki = -wc*|Gc|*sin(theta)
    kp = Gc_mag * cosd(Gc_phase_deg);
    ki = -wc * Gc_mag * sind(Gc_phase_deg);
    
    % Print Results to the Command Window
    fprintf('Case %d: Phase Margin = %d deg, Crossover Freq = %.2f rad/s\n', i, pm, wc);
    fprintf('  kp = %.4f\n', kp);
    fprintf('  ki = %.4f\n', ki);
    fprintf('--------------------------------------------------\n');
end