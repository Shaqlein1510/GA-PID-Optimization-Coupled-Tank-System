function J = coupledTankFitness(x)

Kp = x(1);
Ki = x(2);
Kd = x(3);

assignin('base', 'Kp', Kp);
assignin('base', 'Ki', Ki);
assignin('base', 'Kd', Kd);

try
    simOut = sim('coupled_tank_model', ...
        'StopTime', '30', ...
        'ReturnWorkspaceOutputs', 'on');

    h2_data = simOut.get('h2_data');

    if isempty(h2_data)
        error('h2_data is empty. Check the To Workspace block.');
    end

    t = h2_data.Time;
    h2 = squeeze(h2_data.Data);
    h2 = h2(:);
    t = t(:);

    if numel(t) ~= numel(h2) || numel(t) < 2
        error('Tank 2 time and data vectors are invalid.');
    end

    e = 1 - h2;

    J = trapz(t, e.^2);

    if ~isfinite(J)
        error('Fitness value is not finite.');
    end

catch ME
    fprintf(2, '\nFitness function error:\n%s\n', ...
        getReport(ME, 'extended', 'hyperlinks', 'off'));

    J = 1e8;
end

end