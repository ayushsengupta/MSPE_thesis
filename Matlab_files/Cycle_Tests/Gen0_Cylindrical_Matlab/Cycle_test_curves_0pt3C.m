%% Calendar Ageing Tests: Simultaneous curves from all cells
% This code accesses tables from all calendar testing folders and
% evaluates the curves for each cell for different parameters
clear
clc

%% File parsing
MyFileInfo = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T05_Ch0.3C_Cidetec_Cyl');
F1 = strcat(MyFileInfo(3).folder, "\", MyFileInfo(3).name)
F2 = strcat(MyFileInfo(4).folder, "\", MyFileInfo(4).name) 
MyFileInfo5 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T45_Ch0.3C_CEA_Cyl');
F9 = strcat(MyFileInfo5(5).folder, "\", MyFileInfo5(5).name) 
F10 = strcat(MyFileInfo5(6).folder, "\", MyFileInfo5(6).name)

Filepath = [F1; F2; F9; F10]
Filepath_CID = [F1; F2]
Filepath_CEA = [F9; F10]
%% Legend matrix and marker initialization

l_CID = ["Cell 19 (0.3C, 05 deg C)"; "Cell 20 (0.3C, 05 deg C)"]
l_CEA = ["Cell 36 (0.3C, 45 deg C)"; "Cell 44 (0.3C, 45 deg C)"]
l = [l_CID ; l_CEA]
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
title('Equivalent cycle number vs State of Health (Cylindrical)')
legend(l, 'Location', 'SouthWest');
hold off

i=i+1;
figure(i)
%subplot(2,1,2)
for n=1:j
    [SoH, E_thru] = ethrough_cycle(Filepath(n,:));
    plot(E_thru, SoH, '-','Marker', markers{n})
    ylim([0 100])
    xlabel('Energy throughput during checkup (kWh)')
    ylabel('SOH (%)')
    hold on
end
title('Energy throughput vs State of Health (Cylindrical)')
legend(l, 'Location', 'SouthWest');
hold off
i=i+1;
%% legend for charging

leg_evo_cycle = legend_evo_cycle(Filepath,l)
leg_evo_cycle_CID = legend_evo_cycle(Filepath_CID,l_CID)
leg_evo_cycle_CEA = legend_evo_cycle(Filepath_CEA,l_CEA)

%% Internal resistance - charging
% For CID tests

[j,k]=size(Filepath_CID)
for n=1:j
    figure(i)
    ir_ch_cycle_CID(Filepath_CID(n,:));
    title(strcat('Cylindrical ', l_CID(n),': Internal resistance for 30s charge pulses (Charging)- Only ECU'))
    i=i+1
end

% For CEA tests
[j,k]=size(Filepath_CEA)
for n=1:j
    figure(i)
    ir_ch_cycle_CEA(Filepath_CEA(n,:));
    title(strcat('Cylindrical ', l_CEA(n),': Internal resistance for 30s charge pulses (Charging)- Only ECU'))
    i=i+1
end

%% Internal resistances - discharging
% For the Cidetec tests
[j,k]=size(Filepath_CID)
for n=1:j
    figure(i)
    ir_dis_cycle_CID(Filepath_CID(n,:))
    
    title(strcat('Cylindrical ', l_CID(n),': Internal resistance for 30s charge pulses (discharging)-Only ECU'))
    i=i+1   
end

% For the CEA tests
[j,k]=size(Filepath_CEA)
for n=1:j
    figure(i)
    ir_dis_cycle_CEA(Filepath_CEA(n,:))
    
    title(strcat('Cylindrical ', l_CEA(n),': Internal resistance for 30s charge pulses (discharging)-Only ECU'))
    i=i+1
    
end

%% AC reception resistance values (all values in mOhm)
%Data obtained from reception test results

ACresis_CID = [3.125 2.992]
ACresis_CEA = [3.089 3.323]

%% (Relative resistance) Internal resistance per AC reception test resistance - charging
% For CID tests

[j,k]=size(Filepath_CID)
for n=1:j
    figure(i)
    irrel_ch_cycle_CID(Filepath_CID(n,:), ACresis_CID(1,n));
    title(strcat('Cylindrical ', l_CID(n),': relative internal resistance for 30s charge pulses (Charging): AC resistance ', num2str(ACresis_CID(1,n)),' mOhm'))
    i=i+1
end

% For CEA tests
[j,k]=size(Filepath_CEA)
for n=1:j
    figure(i)
    irrel_ch_cycle_CEA(Filepath_CEA(n,:), ACresis_CEA(1,n));
    title(strcat('Cylindrical ', l_CEA(n),': relative internal resistance for 30s charge pulses (Charging): AC resistance ', num2str(ACresis_CEA(1,n)),' mOhm'))
    i=i+1
end

%% (Relative resistance) Internal resistance per AC reception test resistance - DIScharging
% For CID tests

[j,k]=size(Filepath_CID)
for n=1:j
    figure(i)
    irrel_dis_cycle_CID(Filepath_CID(n,:), ACresis_CID(1,n));
    title(strcat('Cylindrical ', l_CID(n),': relative internal resistance for 30s charge pulses (Discharging): AC resistance ', num2str(ACresis_CID(1,n)),' mOhm'))
    i=i+1
end

% For CEA tests
[j,k]=size(Filepath_CEA)
for n=1:j
    figure(i)
    irrel_dis_cycle_CEA(Filepath_CEA(n,:), ACresis_CEA(1,n));
    title(strcat('Cylindrical ', l_CEA(n),': relative internal resistance for 30s charge pulses (Discharging): AC resistance ', num2str(ACresis_CEA(1,n)),' mOhm'))
    i=i+1
end

%% 100% SOH data
%This section calculates all data for 100% SOH. Only the capacity curves
%include all SOHs, WHILE, Internal resistance curves are separate
l2 = ["Cylindrical Cell @ 0.3C, 05 deg C"; "Cylindrical Cell @ 0.3C, 45 deg C"]
%% Capacity curves (the SOH vs equivalent cycle number curves)...values of cells at same conditions averaged out

[j,k]=size(Filepath)
for n=1:(j/2)
    k=n
    [SoH(1,:),Ecn(1,:)] = age_cycle(Filepath(2*k-1,:));
    k=k+1
    [SoH(2,:),Ecn(2,:)] = age_cycle(Filepath(2*k-2,:));
    SoH_avg = (SoH(1,:)+SoH(2,:))/2
    Ecn_avg = (Ecn(1,:)+Ecn(2,:))/2
    plot(Ecn_avg, SoH_avg, '-','Marker', markers{n})
    ylim([0 100])
    xlabel('Equivalent cycle number')
    ylabel('State of Health (%)')
    hold on
end
title('Equivalent cycle number vs State of Health (Cylindrical)')
legend(l2, 'Location', 'SouthWest');
hold off
