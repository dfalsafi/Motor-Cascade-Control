% Motor Parameters from experimental extraction
J = 150e-6;      % Moment of inertia (kg*m^2)
B = 0.0000586;   % Viscous friction (N*m*s/rad)

% Define the frequency range for the plot 
% We use logspace to get points from 10^-3 (0.001 Hz) to 10^2 (100 Hz).
% This satisfies the requirement to show data for frequencies lower than 0.1 Hz.
f = logspace(-3, 2, 1000); % Frequency in Hz
w = 2 * pi * f;            % Frequency in rad/s

% Theoretical Transfer Function Magnitude: |G(jw)| = 1 / sqrt(B^2 + (w*J)^2)
magnitude = 1 ./ sqrt(B.^2 + (w.*J).^2);

% Convert magnitude to Decibels (20*log10)
magnitude_dB = 20 * log10(magnitude);

% Calculate the theoretical Cut-off Frequency (Pole)
w_c = B / J;               % Cut-off frequency in rad/s
f_c = w_c / (2 * pi);      % Cut-off frequency in Hz

% Calculate DC Gain and the exact -3dB magnitude point
DC_gain_dB = 20 * log10(1 / B);
cutoff_mag_dB = DC_gain_dB - 3;

% Create the Figure
figure;
semilogx(f, magnitude_dB, 'b-', 'LineWidth', 2);
hold on;

% Mark the -3dB cut-off frequency point on the plot
plot(f_c, cutoff_mag_dB, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Add reference lines for clarity
yline(cutoff_mag_dB, 'r--', '-3 dB Magnitude');
xline(f_c, 'r--');

% Formatting the plot to look professional for your assignment
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude 20log_{10}(|\omega/T|) (dB)');
title('Theoretical Bode Plot of DC Motor Dynamics');

% Add a dynamic legend that prints your exact cutoff frequency
legend_str = sprintf('Cut-off Frequency: %.3f Hz (%.2f rad/s)', f_c, w_c);
legend('Theoretical Model', legend_str, 'Location', 'southwest');

hold off;