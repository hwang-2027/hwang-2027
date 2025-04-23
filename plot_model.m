function plot_model(X, y, params)
%PLOT_MODEL X(�f�[�^���~���͕ϐ��̐�)�Ay(�f�[�^���~1)�Aparams(�p�����[�^�[��)
%   ���͕ϐ�X(�s��:�f�[�^���~�ϐ��̐�)����v�Z�������f���̏o��y_hat��
% ���ۂ̏o��y(�x�N�g��:�f�[�^���~1)���r����}���v���b�g���܂��B

% model�v�Z�l�̌v�Z
yHat = compute_y_hat_CH3OH(X, params);

% ������ vs. y�̃v���b�g, NH3 selectivity
figure(1)
nX = size(X,2); % ���͕ϐ��̐�
for i = 1:nX
    %figure(i)
    subplot(ceil(nX/3), 3, i) % 3���subplot���쐬
    plot(X(:,i), y, 'ko', X(:,i), yHat, 'bx')
    if i==1
        legend('Data','Best fit')
    end
    xlabel(sprintf('X_%d', i))
    ylabel('y')
    ylim([0 1])
end

% �����ly_obs vs. �v�Z�ly_mod�̃v���b�g, CH3OH selectivity
figure(2)
plot(y, yHat, 'ko')
xlabel('y_{obs}')
ylabel('y_{mod}')
xlim([0 1])
ylim([0 1])

% �c���v���b�g, CH3OH selectivity
figure(3)
plot((1:size(y,1)), y - yHat, 'ko')
xlabel('�f�[�^�ԍ�')
ylabel('�c��')


% y��yHat�̌덷���v�Z���ďo��
err = immse(y, yHat);
end

