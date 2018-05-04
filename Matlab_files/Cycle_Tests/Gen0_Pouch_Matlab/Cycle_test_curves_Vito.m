%% Cycling Ageing Tests: Simultaneous curves from all cells
% This code accesses tables from all cycling testing folders and
% evaluates the curves for each cell for different parameters
clear
clc

%% File parsing
MyFileInfo = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch0.3C_VITO_Soft');
F1 = strcat(MyFileInfo(7).folder, "\", MyFileInfo(7).name)
F2 = strcat(MyFileInfo(8).folder, "\", MyFileInfo(8).name) 
MyFileInfo5 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T45_Ch0.3C_VITO_Soft');
F9 = strcat(MyFileInfo5(3).folder, "\", MyFileInfo5(3).name) 
F10 = strcat(MyFileInfo5(4).folder, "\", MyFileInfo5(4).name)

Filepath = [F1; F2; F9; F10]
Filepath_05C = [F1; F2]
Filepath_45C = [F9; F10]
%% Legend matrix and marker initialization

l_05C = ["Cell 19 (0.3C, 05 deg C)"; "Cell 22 (0.3C, 05 deg C)"]
l_45C = ["Cell 14 (0.3C, 45 deg C)"; "Cell 08 (0.3C, 45 deg C)"]
l = [l_05C ; l_45C]
markers = {'+','o','*','<','s','d','x','^','v','>','p','h'}
i=1;
%% Ageing and energy throughput curves
% This code section will produce two curves for ageing vs SOH and energy
% throughput vs SOH for all the cells together.
figure(i)
%subplot(2,1,1)
[j,k]=size(Filepath)
for n=1:j
    [SoH,Ecn] = age_cycle(Filepath(n,:));
    plot(Ecn, SoH, '-','Marker', markers{n})
    ylim([0 100])
    xlabel('Equivalent cycle number')
    ylabel('State of Health (%)')
    hold on
end
title('Equivalent cycle number vs State of Health (Pouch)')
legend(l, 'Location', 'SouthWest');
hold off

i=i+1;
figure(i)
%subplot(2,1,2)
for n=1:j
    [SoH, E_thru] = ethrough_cycle(Filepath(n,:));
    plot(E_thru, SoH, '-','Marker', markers{n})
    ylim([0 100])
    xlabel('Energy throughput during checkup (kWh)(Pouch)')
    ylabel('SOH (%)')
    hold on
end
title('Energy throughput vs State of Health')
legend(l, 'Location', 'SouthWest');
hold off
i=i+1;
%% legend for charging

leg_evo_cycle = legend_evo_cycle(Filepath,l)
leg_evo_cycle_05C = legend_evo_cycle(Filepath_05C,l_05C)
leg_evo_cycle_45C = legend_evo_cycle(Filepath_45C,l_45C)


%% Internal resistance - charging
% For VITO tests

[j,k]=size(Filepath)
for n=1:j
    figure(i)
    ir_ch_cycle_Vito(Filepath(n,:));
    title(strcat('Pouch ', l(n),': Internal resistance for 30s charge pulses (Charging)- Only ECU'))
    i=i+1
end

%% Internal resistances - discharging
% For the Cidetec tests
[j,k]=size(Filepath)
for n=1:j
    figure(i)
    ir_dis_cycle_Vito(Filepath(n,:))
    
    title(strcat('Pouch ', l(n),': Internal resistance for 30s charge pulses (discharging)-Only ECU'))
    i=i+1   
end

%% AC reception resistance values (all values in mOhm)
%Data obtained from reception test results

ACresis = [4.854 4.704 4.36 4.419]


%% (Relative resistance) Internal resistance per AC reception test resistance - charging

[j,k]=size(Filepath)
for n=1:j
    figure(i)
    irrel_ch_cycle_Vito(Filepath(n,:), ACresis(1,n));
    title(strcat('Pouch ', l(n),': relative internal resistance for 30s charge pulses (Charging): AC resistance ', num2str(ACresis(1,n)),' mOhm'))
    i=i+1
end

%% (Relative resistance) Internal resistance per AC reception test resistance - DIScharging

[j,k]=size(Filepath)
for n=1:j
    figure(i)
    irrel_dis_cycle_Vito(Filepath(n,:), ACresis(1,n));
    title(strcat('Pouch  ', l(n),': relative internal resistance for 30s charge pulses (Discharging): AC resistance ', num2str(ACresis(1,n)),' mOhm'))
    i=i+1
end

