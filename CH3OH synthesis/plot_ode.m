function plot_ode(z, y)
%y��z�Ɠ��������~2�̍s��By(:,1)�ɉ��xT�Ay(:,2)�ɔ�����x

T = y(:,1) - 273.15;
x = y(:,2);

figure(1)
plot(z, T)
title('���x���z')
xlabel('�G�}�w�� z [m]')
ylabel('���x T [��]')

figure(2)
plot(z, x)
title('���������z')
xlabel('�G�}�w�� z [m]')
ylabel('������ x_T_O_L [-]')

end