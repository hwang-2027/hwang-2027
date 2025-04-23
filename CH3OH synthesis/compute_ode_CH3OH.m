function [z, y] = compute_ode_CH3OH(X, r)

% 最適化するパラメーター
global searchParams
searchParams = r;

% parameters--------
% F = [F_CO, F_H2, F_CH3OH, F_CO2, F_Ar, F_H2O];
global F_H2_0 F_CH3OH_0 F_CO_0 F_H2O_0 F_CO2_0 % clac_F
global P_t % clac_p
%global deltaH deltaG %calc_K_eq
global cp_params_H2 cp_params_CH3OH cp_params_CO cp_params_CO2 cp_params_H2O  % P_t % clac_C_p
global U T_s S A_h deltaH % calc_dTdz
%global  ads_params_H2 ads_params_TOL ads_params_MCH k_params calc_K_ads
%global % F_TOL_0 S % calc_dxdz

% 操作条件
F_CO2_0 = X(1); % [mol/s]
F_CO_0 = X(2); % [mol/s]
F_CH3OH_0 = 0; % メチルシクロヘキサン入口流量[mol/s]
F_H2_0 = X(3);
F_H2O_0 = 0;
%F_Ar_0 = X(4);
D_bed = 0.026; % 層直径[m]
S = pi*(D_bed/2)^2; % 反応器断面積[m2]
A_h = pi*D_bed; % 高さあたりの伝熱面積[m]
P_t = X(5); % 全圧[kPa]
T_s = X(4); % 管壁温度[K]

% 物性定数
%dH_H2 = 0; % 水素標準生成熱[kJ/mol]
%dH_N2 = 0;
%dH_NH3 = -46;
%dH_NO = 0;
%dH_N2O = 0;
%dH_H2O = 0;
%deltaH = 2*dH_NH3 - (dH_N2 + 3*dH_H2); % 反応熱[kJ/mol]
deltaH = 0; % 反応熱[kJ/mol]
%dG_H2 = 0;  % 水素標準生成ギブズエネルギー[kJ/mol]
%dG_N2 = 0;
%dG_NH3 = -16.4;
%deltaG = dG_NH3 - (dG_N2 + 3*dG_H2); % ギブズ自由エネルギー変化[kJ/mol]
U = 234; % bed heat transfer coefficient [J/m2/s/K]

% Cp=a+bT+cT^2+dT^3[J/K/mol]
%https://booksite.elsevier.com/9780750683661/Appendix_C.pdf
cp_params_CO = [25.56759, 0.00609613, 4.0546E-6, -2.6713E-9];
cp_params_CO2 = [24.99735, 0.05518696, -33.6914E-6, 7.94839E-9];
cp_params_H2 = [33.066178, -11.363417E-3, 11.432816E-6, 2.772874E-9]; %cp_params_H2 = [27.143, 9.27E-3, -1.38E-5, 7.65E-9]; 
cp_params_CH3OH = [40.046, -3.8287E-2, -2.4529E-4, -3.8287E-7];
cp_params_H2O = [30.092, 0.0068325,6.79344E-6, -2.53448E-9]; 

% 初期値
T_0 = X(6); % 反応器入口ガス温度[K]

x_combined_0 = 0;
y0 = [T_0, x_combined_0];

% 積分区間
z_span = [0 0.026]; %Bed Height[m]
% 許容誤差等
opts = odeset('MaxStep',5e-2, 'InitialStep',1e-4, 'AbsTol',1e-7, 'RelTol',1e-7);

% 微分方程式を解く---------
[z, y] = ode45(@(z, y) odefcn_CH3OH(z, y), z_span, y0, opts);

%plot_ode(z, y)
%y_f = y(size(y,1),2)