function C_p_avg = calc_C_p_CH3OH(T)
%CALC_C_P_AVG 各成分の熱容量C_p[J/K/mol]の平均の計算
%   詳細説明をここに記述
global cp_params_H2  cp_params_CO cp_params_CO2  cp_params_CH3OH cp_params_H2O P_t %cp_params_CH3OH
global p_H2  p_CO p_CO2 p_H2O p_CH3OH %p_CH3OH

C_p_CO = cp_params_CO(1) + cp_params_CO(2)*T + cp_params_CO(3)*T^2 + cp_params_CO(4)*T^3;
C_p_CO2 = cp_params_CO2(1) + cp_params_CO2(2)*T + cp_params_CO2(3)*T^2 + cp_params_CO2(4)*T^3;
C_p_H2 = cp_params_H2(1) + cp_params_H2(2)*T + cp_params_H2(3)*T^2 + cp_params_H2(4)*T^3;
C_p_CH3OH = cp_params_CH3OH(1) + cp_params_CH3OH(2)*T + cp_params_CH3OH(3)*T^2 + cp_params_CH3OH(4)*T^3;
C_p_H2O = cp_params_H2O(1) + cp_params_H2O(2)*T + cp_params_H2O(3)*T^2 + cp_params_H2O(4)*T^3;

C_p_avg = (C_p_H2*p_H2 + C_p_CO*p_CO + C_p_CO2*p_CO2 + C_p_CH3OH*p_CH3OH + C_p_H2O*p_H2O) / P_t; %+ C_p_CH3OH*p_CH3OH 

end
