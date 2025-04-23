function dxdz_CH3OH = calc_dxdz_CH3OH(r_r)
% CO2およびCOの供給速度(F_CO2_0, F_CO_0 [mol/s])、反応速度(r [mol/s/m^3])、触媒表面積(S [m^2])を考慮してメタノール生成反応の速度を計算します。

global S F_CO2_0 F_CO_0

% CO2ベースのメタノール生成反応速度
r_r_CH3OH_1 = r_r(1);

% COベースのメタノール生成反応速度
r_r_CH3OH_2 = r_r(2);

% Total methanol generation rate, indirectly influenced by RWGS-adjusted CO and CO2
dxdz_CH3OH = 1 / (F_CO2_0+F_CO_0) * (r_r_CH3OH_1 + r_r_CH3OH_2) * S; % [1/m]

end
