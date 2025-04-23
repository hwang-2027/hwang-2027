function yHat = compute_y_hat_CH3OH(X, r)
%COMPUTE_Y_HAT 入力変数X(データ数×変数の数)、パラメーターr(パラメーター数)
%   y_hat is model-predicted Y value

%yHat = zeros(size(X, 2), 1);
%parfor i = 1:size(X, 2)

%if there are two Ys (conv to NH3 and conv to N2)
yHat = zeros(size(X, 1), 1);
parfor i = 1:size(X, 1)
%for i = 1:size(X, 1)
    [~, tmp_y] = compute_ode_CH3OH(X(i, :), r);
    yHat(i) = tmp_y(size(tmp_y, 1), 2);
end
