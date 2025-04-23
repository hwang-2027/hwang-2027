function r = calc_r_CH3OH(r_r)

%global r_CH3OH
%global r_r

r_r_CH3OH_1 = r_r(1);
r_r_CH3OH_2 = r_r(2);
r_r_RWGS = r_r(3);

%r_r = [r_CH3OH];

% total rate [mol/s/m3]
r = r_r_CH3OH_1 + r_r_CH3OH_2 + r_r_RWGS;

end

