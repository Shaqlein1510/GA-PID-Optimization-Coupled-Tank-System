clc;
close all;

% =========================================
% Conventional PID vs GA-Tuned PID
% =========================================

model = 'coupled_tank_model';

% Original PID gains
Kp = 2;
Ki = 0.5;
Kd = 0.1;

% Run conventional PID simulation
simOut1 = sim(model, 'StopTime', '30');

h2_original = simOut1.get('h2_data');

t1 = h2_original.Time(:);
y1 = squeeze(h2_original.Data);
y1 = y1(:);

% GA-tuned PID gains
Kp = 6.246747;
Ki = 0.279668;
Kd = 4.795880;

% Run GA-tuned PID simulation
simOut2 = sim(model, 'StopTime', '30');

h2_GA = simOut2.get('h2_data');

t2 = h2_GA.Time(:);
y2 = squeeze(h2_GA.Data);
y2 = y2(:);

% Plot comparison
figure;

plot(t1, y1, 'LineWidth', 1.5);
hold on;

plot(t2, y2, 'LineWidth', 1.5);

yline(1, '--k', 'Setpoint');

xlabel('Time (s)');
ylabel('Tank 2 Level');

title('Conventional PID vs GA-Tuned PID');

legend('Conventional PID', ...
    'GA-Tuned PID', ...
    'Setpoint', ...
    'Location', 'best');

grid on;
% ==========================================
% Performance comparison
% ==========================================

r = 1;

% Conventional PID metrics
e1 = r - y1;
ISE1 = trapz(t1, e1.^2);

[peak1, idx1] = max(y1);
peakTime1 = t1(idx1);
overshoot1 = max(0, (peak1-r)/abs(r)*100);

steadyError1 = abs(r-y1(end));

outside1 = find(abs(y1-r) > 0.02*abs(r));

if isempty(outside1)
    settling1 = 0;
elseif outside1(end) < numel(t1)
    settling1 = t1(outside1(end)+1);
else
    settling1 = NaN;
end

% GA-tuned PID metrics
e2 = r - y2;
ISE2 = trapz(t2, e2.^2);

[peak2, idx2] = max(y2);
peakTime2 = t2(idx2);
overshoot2 = max(0, (peak2-r)/abs(r)*100);

steadyError2 = abs(r-y2(end));

outside2 = find(abs(y2-r) > 0.02*abs(r));

if isempty(outside2)
    settling2 = 0;
elseif outside2(end) < numel(t2)
    settling2 = t2(outside2(end)+1);
else
    settling2 = NaN;
end

% Display results
fprintf('\nCONVENTIONAL PID\n');
fprintf('ISE = %.6f\n', ISE1);
fprintf('Peak level = %.6f\n', peak1);
fprintf('Peak time = %.3f s\n', peakTime1);
fprintf('Overshoot = %.2f%%\n', overshoot1);
fprintf('Steady-state error = %.6f\n', steadyError1);
fprintf('Settling time = %.3f s\n', settling1);

fprintf('\nGA-TUNED PID\n');
fprintf('ISE = %.6f\n', ISE2);
fprintf('Peak level = %.6f\n', peak2);
fprintf('Peak time = %.3f s\n', peakTime2);
fprintf('Overshoot = %.2f%%\n', overshoot2);
fprintf('Steady-state error = %.6f\n', steadyError2);
fprintf('Settling time = %.3f s\n', settling2);

fprintf('\nISE reduction = %.2f%%\n', ...
    (ISE1-ISE2)/ISE1*100);
%% Quality Response Comparison

figure('Color','w','Position',[100 100 900 550]);

plot(t1, y1, 'LineWidth', 2);
hold on;

plot(t2, y2, 'LineWidth', 2);

yline(1, '--k', 'Setpoint', 'LineWidth', 1.5);

grid on;
box on;

xlabel('Time (s)', 'FontSize', 12);
ylabel('Tank 2 Level', 'FontSize', 12);

title('Conventional PID vs GA-Tuned PID', ...
    'FontSize', 14, 'FontWeight', 'bold');

legend('Conventional PID', ...
    'GA-Tuned PID', ...
    'Setpoint', ...
    'Location', 'southeast');

set(gca, 'FontSize', 11, 'LineWidth', 1);

exportgraphics(gcf, ...
    'PID_Response_Comparison.png', ...
    'Resolution', 300);