function plot_ode(z, y)
%yÍzÆ¯¶·³~2ÌsñBy(:,1)É·xTAy(:,2)É½¦x

T = y(:,1) - 273.15;
x = y(:,2);

figure(1)
plot(z, T)
title('·xªz')
xlabel('G}w z [m]')
ylabel('·x T []')

figure(2)
plot(z, x)
title('½¦ªz')
xlabel('G}w z [m]')
ylabel('½¦ x_T_O_L [-]')

end