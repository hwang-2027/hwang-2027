function data = load_data2(filename)
% this code is to connect the general equation and the data set in Excel

if nargin == 0
   filename = 'CH3OH_paramsfitting_TOYOTA_v1e.csv'; % to experimental data set
    sort = false;
end

if nargin == 1
    sort = false;
end

data = readtable(filename, 'ReadVariableNames',true);
% Column 1 in the initial array is deleted
data(:, 1) = [];
data = table2array(data);

% Rearrangement of columns
data(:, 1) = data(:, 1) + 1e-10; % F_CO2_0 (mol/s)
data(:, 2) = data(:, 2) + 1e-10; % F_CO_0 (mol/s)
data(:, 3) = data(:, 3) + 1e-10; % F_H2_0 (mol/s)
data(:, 4) = data(:, 4) + 273.15; % T_s (K)
data(:, 5) = data(:, 5) ; % P_t (kPa abs)
data(:, 6) = data(:, 6) + 273.15; % T_0 (K)
data(:, 7) = data(:, 7); % CO2 and CO conv to CH3OH (-)


%data(:, 4) = data(:, 4) + 1e-10; % F_Ar_0 (mol/s)
%data(:, 6) = data(:, 6); % temperature, assumed isothermal (K)
%data(:, 7) = data(:, 7); % NO conv (-)

% Only Column 1-7 used in the simulation
data(:, (8:end)) = [];

% Sorting out unnecessary rows
if sort == true
    data = sortrows(data, 7);
end

end