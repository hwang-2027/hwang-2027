function r_r = calc_r_r_CH3OH(T, x_combined)

%  Rate equation is Langmuir-Hinshelwood mechanism
%  Reverse reaction not assumed in the model
%  
%  A(i) and E(i) to be fitted

global R
global searchParams 
global Kf_CH3OH_1 Kf_CH3OH_2 Kf_RWGS  Kb_CH3OH_1 Kb_CH3OH_2 Kb_RWGS
global Ka_CO2 Ka_CO Ka_H2 Ka_H2O  %Ka_H1 Ka_OH_2 Ka_CHxO Ka_CH3OH Ka_HxCO Ka_HxCO_2  Ka_HxCO2  Ka_COOH 
global P_t
global F_CO2_0 F_CO_0 F_H2_0  F_H2O_0 F_CH3OH_0  %
global p_CO2 p_CO p_H2 p_H2O p_CH3OH % 
global F_total
global x_CH3OH_1 x_CH3OH_2 x_RWGS

global ADS 
global ratio_r_CH3OH ratio_r_RWGS %ratio_r


   if isempty(ratio_r_CH3OH) 
       ratio_r_CH3OH = 0.5;
       ratio_r_RWGS = 0.5; 

        %CO2 convert into CO based on the RWGS reaction
        x_RWGS = x_combined *  ratio_r_RWGS;

        %conversion to CH3OH with CO2
        x_CH3OH_1 = x_combined*ratio_r_CH3OH;

        % conversion to CH3OH with CO
        x_CH3OH_2 = x_combined*(1-ratio_r_CH3OH);

	end

  ratio_r = [ratio_r_CH3OH ratio_r_RWGS];

R = 8.314;


% 메탄올 생성 반응 (CO2 기반)
% CO2 + 3H2 <-> CH3OH + H2O (x_CH3OH_1)
% RWGS 반응 (CO2와 CO를 조절)
% CO + H2O <-> CO2 + H2
% 메탄올 생성 반응 (CO 기반)
% CO + 2H2 <-> CH3OH (x_CH3OH_2)

% flow rate
F_CO2 = F_CO2_0 * (1 - x_CH3OH_1 - x_RWGS); 

F_CO = F_CO_0 + (F_CO2_0 * x_RWGS) ... 
- (F_CO_0 * x_CH3OH_2);

F_H2 = F_H2_0 - (3 * F_CO2_0 * x_CH3OH_1) ...
- (2 * F_CO_0 * x_CH3OH_2) ...
- (F_CO2_0 * x_RWGS); 

F_H2O = F_H2O_0 + (F_CO2_0 * x_CH3OH_1) ...
+ (F_CO2_0 * x_RWGS);

F_CH3OH = F_CH3OH_0 + (F_CO2_0 * x_CH3OH_1) + (F_CO_0 * x_CH3OH_2); 

F_total = F_CO2 + F_CO + F_H2 + F_H2O + F_CH3OH;  % 전체 유량 계산


p_CO2 = F_CO2 / F_total * P_t;
p_CO = F_CO / F_total * P_t;
p_H2O = F_H2O / F_total * P_t;
p_H2 = F_H2 / F_total * P_t;
p_CH3OH = (F_CH3OH ./ F_total) .* P_t;


%Forward reaction rate constant
Kf_CH3OH_1 = (searchParams(1)*1000)*exp(-searchParams(2)*1000/(R*T));
Kf_CH3OH_2 = (searchParams(3)*1000)*exp(-searchParams(4)*1000/(R*T));
Kf_RWGS = (searchParams(5)*1000)*exp(-searchParams(6)*1000/(R*T));

Kb_CH3OH_1 = (searchParams(7)*1000)*exp(-searchParams(8)*1000/(R*T)); % %Kb_1 = Kf_CH3OH_1/Keq_1; 
Kb_CH3OH_2 = (searchParams(9)*1000)*exp(-searchParams(10)*1000/(R*T)); % %Kb_2 = Kf_CH3OH_2/Keq_2;
Kb_RWGS = (searchParams(11)*1000)*exp(-searchParams(12)*1000/(R*T)); % %Kb_3 = Kf_RWGS/Keq_RWGS;

%Adsorption rate constant
Ka_H2 = searchParams(13)*exp(searchParams(14)*1000/(R*T));
Ka_CO2 = searchParams(15)*exp(searchParams(16)*1000/(R*T));
Ka_CO = searchParams(17)*exp(searchParams(18)*1000/(R*T)); 
Ka_H2O = searchParams(19)*exp(searchParams(20)*1000/(R*T));

Bf_CH3OH_1 = Kf_CH3OH_1 *(p_CO2) * ((p_H2+0.000001)^3) - Kb_CH3OH_1 * ((p_CH3OH) * (p_H2O+0.000001));        %forward numerator CH3OH formation from CO2;
Bf_CH3OH_2 = Kf_CH3OH_2 *(p_CO) * ((p_H2+0.000001)^2) - Kb_CH3OH_2 * (p_CH3OH);        %forward numerator CH3OH formation from CO;
Bf_RWGS = Kf_RWGS *((p_CO2) * (p_H2+0.000001)) - Kb_RWGS * ((p_CO) * (p_H2O+0.000001));        %forward numerator CH3OH formation from CO;


Ba_CO2 = Ka_CO2*p_CO2;
Ba_CO = Ka_CO*p_CO;
Ba_H = Ka_H2*((p_H2+0.000001)^0.5);
Ba_H2O = Ka_H2O*(p_H2O);

% ADS = (1+ Ba_H + Ba_H2O)*(1 + Ba_CO2 + Ba_CO);
ADS = (1 + Ba_H + Ba_H2O + Ba_CO2 + Ba_CO);
%ADS = (1+Ba_CO2 + Ba_CO +  Ba_H + Ba_OH + Ba_COOH + Ba_HxCO + Ba_HxCO_2 + Ba_HxCO2);


% CH3OH formation rate
r_r_CH3OH_1 = Bf_CH3OH_1/ADS^2;
r_r_CH3OH_2 = Bf_CH3OH_2/ADS^2;

r_r_RWGS = Bf_RWGS/ADS^2;

%ratio_r_X is ratio of X formation rate CO2 and CO dependent per overall 
ratio_r_CH3OH = r_r_CH3OH_1/(r_r_CH3OH_1 + r_r_CH3OH_2);


% Rx C3 rate
r_r = [r_r_CH3OH_1, r_r_CH3OH_2, r_r_RWGS];
% r_r = [r_r_CH3OH_1, r_r_CH3OH_2];

end