clc;
close all;

% ==========================================
% GA-Based PID Tuning: Coupled-Tank System
% ==========================================

% Store best fitness at each generation
global scoreHistory
scoreHistory = [];

% Optimization variables: [Kp, Ki, Kd]
nvars = 3;

% Lower and upper bounds
lb = [0.01, 0.01, 0];
ub = [20, 10, 5];

% Original PID gains as an initial candidate
initialPID = [2, 0.5, 0.1];

% GA options
options = optimoptions('ga', ...
    'PopulationSize', 20, ...
    'MaxGenerations', 20, ...
    'MaxStallGenerations', 10, ...
    'InitialPopulationMatrix', initialPID, ...
    'Display', 'iter', ...
    'PlotFcn', [], ...
    'OutputFcn', @recordGAHistory);

% Fitness function
fitness = @coupledTankFitness;

fprintf('Starting GA optimization...\n');

% Run Genetic Algorithm
[xbest, Jbest, exitflag, output] = ga( ...
    fitness, nvars, [], [], [], [], ...
    lb, ub, [], options);

% Extract optimized gains
Kp_best = xbest(1);
Ki_best = xbest(2);
Kd_best = xbest(3);

% Display results
fprintf('\n========== GA RESULTS ==========\n');
fprintf('Kp = %.6f\n', Kp_best);
fprintf('Ki = %.6f\n', Ki_best);
fprintf('Kd = %.6f\n', Kd_best);
fprintf('Best ISE = %.8f\n', Jbest);
fprintf('Generations completed = %d\n', output.generations);
fprintf('Exit flag = %d\n', exitflag);

% Save results and fitness history
save('GA_PID_results.mat', ...
    'Kp_best', 'Ki_best', 'Kd_best', ...
    'Jbest', 'output', 'exitflag', 'scoreHistory');

fprintf('\nResults saved successfully.\n');

% ==========================================
% Plot GA Convergence
% ==========================================

if ~isempty(scoreHistory)

    figure('Color', 'w', ...
        'Position', [100 100 900 550]);

    plot(1:numel(scoreHistory), scoreHistory, ...
        'b-o', 'LineWidth', 1.8, 'MarkerSize', 4);

    grid on;
    box on;

    xlabel('Generation', 'FontSize', 12);
    ylabel('Best ISE', 'FontSize', 12);

    title('Genetic Algorithm Convergence', ...
        'FontSize', 14, 'FontWeight', 'bold');

    set(gca, 'FontSize', 11, 'LineWidth', 1);

    exportgraphics(gcf, ...
        'GA_Convergence.png', ...
        'Resolution', 300);

    fprintf('Convergence graph saved as GA_Convergence.png\n');

else
    warning('No fitness history recorded.');
end


% ==========================================
% Local function: Record best fitness
% ==========================================

function [state, options, optchanged] = ...
    recordGAHistory(options, state, flag)

    global scoreHistory
    optchanged = false;

    if strcmp(flag, 'iter') && ~isempty(state.Score)

        % Best fitness in the current generation
        bestCurrent = min(state.Score(:));

        % Record the value
        scoreHistory(end+1, 1) = bestCurrent;
    end
end