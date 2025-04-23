function plot_model(X, y, params)
%PLOT_MODEL X(データ数×入力変数の数)、y(データ数×1)、params(パラメーター数)
%   入力変数X(行列:データ数×変数の数)から計算したモデルの出力y_hatと
% 実際の出力y(ベクトル:データ数×1)を比較する図をプロットします。

% model計算値の計算
yHat = compute_y_hat_CH3OH(X, params);

% 特徴量 vs. yのプロット, NH3 selectivity
figure(1)
nX = size(X,2); % 入力変数の数
for i = 1:nX
    %figure(i)
    subplot(ceil(nX/3), 3, i) % 3列のsubplotを作成
    plot(X(:,i), y, 'ko', X(:,i), yHat, 'bx')
    if i==1
        legend('Data','Best fit')
    end
    xlabel(sprintf('X_%d', i))
    ylabel('y')
    ylim([0 1])
end

% 実験値y_obs vs. 計算値y_modのプロット, CH3OH selectivity
figure(2)
plot(y, yHat, 'ko')
xlabel('y_{obs}')
ylabel('y_{mod}')
xlim([0 1])
ylim([0 1])

% 残差プロット, CH3OH selectivity
figure(3)
plot((1:size(y,1)), y - yHat, 'ko')
xlabel('データ番号')
ylabel('残差')


% yとyHatの誤差を計算して出力
err = immse(y, yHat);
end

