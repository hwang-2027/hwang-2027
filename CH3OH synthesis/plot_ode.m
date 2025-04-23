function plot_ode(z, y)
%yはzと同じ長さ×2の行列。y(:,1)に温度T、y(:,2)に反応率x

T = y(:,1) - 273.15;
x = y(:,2);

figure(1)
plot(z, T)
title('温度分布')
xlabel('触媒層高 z [m]')
ylabel('温度 T [℃]')

figure(2)
plot(z, x)
title('反応率分布')
xlabel('触媒層高 z [m]')
ylabel('反応率 x_T_O_L [-]')

end