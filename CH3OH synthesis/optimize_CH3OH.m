% データのロード
% X column B,C,D,E,F
% Y column G
%clear global

data = load_data2();
data = data((1:end),:);
X = data(:, (1:6));
y = data(:, 7);
%y = data(:, (6:7));

% 目的関数、最適化オプション、初期値の設定 
% other option of algorithm is 'levenberg-marquardt' for unconstrained case
% TRR is used for constrained-based calculation
fun = @(params)compute_y_hat_CH3OH(X, params) - y;
options = optimoptions('lsqnonlin', ...
    'Display', ...
    'iter', ...
    'Algorithm', 'trust-region-reflective', ...
    'ScaleProblem', 'Jacobian', ...
    'MaxIter',10000,'MaxFunEvals',10000, ...
    'UseParallel', false, ...
    'StepTolerance', 1e-8);
%    'StepTolerance', 1e-7);
   
%for XXXXX Catalyst

initialParams = [50000, 1.4, 250000, 1.7, 50000, 0.8 ...          %forward reaction of Methanol from CO2 and CO, respectively  : 4             
                10, 2.5, 25, 5, 10, 1.2 ...
                0.5, 0.1, 0.5, 0.1, 0.5, 0.1, 0.5, 0.1];          %ads CO2, CO, OH as a reaction intermediates  : 6
             
% LOWER BOUND CONSTRAINTS
lb(1) = 5e-5;  %A forward must be of positive value
lb(2) = 0;  %Ea forward must be of positive value
lb(3) = 5e-5;  %A forward must be of positive value
lb(4) = 0;  %Ea adsorption must be of positive value
lb(5) = 5e-5; 
lb(6) = 0;  %Ea adsorption must be of positive value
lb(7) = 0; 
lb(8) = 0;  %Ea forward must be of positive value
lb(9) = 0; 
lb(10) = 0;  %Ea adsorption must be of positive value
lb(11) = 0;  
lb(12) = 0;  %Ea forward must be of positive value
lb(13) = 0; 
lb(14) = 0;  %Ea adsorption must be of positive value
lb(15) = 0; 
lb(16) = 0;  %Ea adsorption must be of positive value
lb(17) = 0; 
lb(18) = 0;  %Ea adsorption must be of positive value
lb(19) = 0; 
lb(20) = 0;  %Ea adsorption must be of positive value
% lb(21) = 0;  %Ea adsorption must be of positive value


% UPPER BOUND CONSTRAINTS
ub(1) = inf;  %A forward must be of positive value
ub(2) = 10;    %Ea forward must be of positive value
ub(3) = inf; 
ub(4) = 10;   %Ea adsorption must be of positive value
ub(5) = inf; 
ub(6) = 10;   %Ea adsorption must be of positive value
ub(7) = inf;  %A forward must be of positive value
ub(8) = 10;    %Ea forward must be of positive value
ub(9) = Inf; 
ub(10) = 10;   %Ea adsorption must be of positive value
ub(11) = Inf;  %A forward must be of positive value
ub(12) = 10;    %Ea forward must be of positive value
ub(13) = inf; 
ub(14) = 20;   %Ea adsorption must be of positive value
ub(15) = inf; 
ub(16) = 20;   %Ea adsorption must be of positive value
ub(17) = inf; 
ub(18) = 20;   %Ea adsorption must be of positive value
ub(19) = inf; 
ub(20) = 20;   %Ea adsorption must be of positive value
% ub(21) = 1;   %Ea adsorption must be of positive value

%最適化の実行
optimizedParams = lsqnonlin(fun, initialParams, lb, ub, options);

%結果のプロット
plot_model(X, y, optimizedParams)


% MultiStart optimization (global optimum search)

% optProb = createOptimProblem('lsqnonlin','objective',...
%     fun,'x0',initialParams,'lb',lb,'ub',ub,'options',options);
% 
% ms = MultiStart('FunctionTolerance', 1.0000e-08, ...
%     'XTolerance', 1e-8, 'PlotFcn',{@gsplotbestf});
% 
% %[X,fval,eflag,output,solutions] = run(ms,optimizedParams,100);
% [optimizedParams,fval,eflag,output,solutions] = run(ms,optProb,50);
% 
% % 結果のプロット
% plot_model(X, y, optimizedParams)