function dTdz = calc_dTdz(T, r, C_p_avg)
global deltaH U T_s S A_h
global F_total

%F_total = sum(F);

reaction_heat = -r * S * deltaH * 1000; % [J/s/m]
heat_exchange = U * A_h * (T_s - T); % [J/s/m]

dTdz = (reaction_heat + heat_exchange) / F_total / C_p_avg; % [K/m]
end