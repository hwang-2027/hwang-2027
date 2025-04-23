function dydz = odefcn_CH3OH(z, y)
%T = y(1);  temperature profile x_CO_1, x_CO2_1, x_RWGS_CO
T = y(1);      % temperature profile
x_combined = y(2); % fraction of consumed NO converted into NH3

r_r = calc_r_r_CH3OH(T, x_combined); 
r = calc_r_CH3OH(r_r); % [mol/s/m3]
C_p_avg = calc_C_p_CH3OH(T);


dydz(1,:) = calc_dTdz(T, r, C_p_avg);
dydz(2,:) = calc_dxdz_CH3OH(r_r);

end