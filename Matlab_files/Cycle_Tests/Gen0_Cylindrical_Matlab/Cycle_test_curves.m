%% Calendar Ageing Tests: Simultaneous curves from all cells
% This code accesses tables from all calendar testing folders and
% evaluates the curves for each cell for different parameters
clear
clc

%% File parsing
MyFileInfo = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T05_Ch0.3C_Cidetec_Cyl');
F1 = strcat(MyFileInfo(3).folder, "\", MyFileInfo(3).name)
F2 = strcat(MyFileInfo(4).folder, "\", MyFileInfo(4).name) 
MyFileInfo2 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T05_Ch1C_Cidetec_Cyl');
F3 = strcat(MyFileInfo2(3).folder, "\", MyFileInfo2(3).name) 
F4 = strcat(MyFileInfo2(4).folder, "\", MyFileInfo2(4).name)
MyFileInfo3 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T05_Ch2C_Cidetec_Cyl');
F5 = strcat(MyFileInfo3(3).folder, "\", MyFileInfo3(3).name) 
F6 = strcat(MyFileInfo3(4).folder, "\", MyFileInfo3(4).name)
MyFileInfo4 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T25_Ch2C_CEA_Cyl');
F7 = strcat(MyFileInfo4(3).folder, "\", MyFileInfo4(3).name) 
F8 = strcat(MyFileInfo4(4).folder, "\", MyFileInfo4(4).name)
MyFileInfo5 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T45_Ch0.3C_CEA_Cyl');
F9 = strcat(MyFileInfo5(5).folder, "\", MyFileInfo5(5).name) 
F10 = strcat(MyFileInfo5(6).folder, "\", MyFileInfo5(6).name)
MyFileInfo6 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T45_Ch2C_CEA_Cyl');
F11 = strcat(MyFileInfo6(3).folder, "\", MyFileInfo6(3).name) 
F12 = strcat(MyFileInfo6(4).folder, "\", MyFileInfo6(4).name)

Filepath = [F1; F2; F3; F4; F5; F6; F7; F8; F9; F10; F11; F12]
Filepath_CID = [F1; F2; F3; F4; F5; F6]
Filepath_CEA = [F7; F8; F9; F10; F11; F12]
%% Legend matrix and marker initialization

l_CID = ["Cid Cell 19";"Cid Cell 20";"Cid Cell 21";"Cid Cell 22";"Cid Cell 23";"Cid Cell 24"]
l_CEA = ["CEA Cell 31";"CEA Cell 33";"CEA Cell 36"; "CEA Cell 44";"CEA Cell 22";"CEA Cell 34"]
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
    plot(SoH, Ecn, '-','Marker', markers{n})
    xlim([0 100])
    xlabel('State of Health (%)')
    ylabel('Equivalent cycle number')
    hold on
end
title('Equivalent cycle number vs State of Health')
legend(l, 'Location', 'SouthWest');
hold off

i=i+1;
figure(i)
%subplot(2,1,2)
for n=1:j
    [SoH, E_thru] = ethrough_cycle(Filepath(n,:));
    plot(SoH, E_thru, '-','Marker', markers{n})
    xlim([0 100])
    xlabel('SOH (%)')
    ylabel('Energy throughput during checkup (kWh)')
    hold on
end
title('Energy throughput vs State of Health')
legend(l, 'Location', 'SouthWest');
hold off
i=i+1;
%% legend for charging

leg_evo_cycle = legend_evo_cycle(Filepath,l)
leg_evo_cycle_CID = legend_evo_cycle(Filepath_CID,l_CID)
leg_evo_cycle_CEA = legend_evo_cycle(Filepath_CEA,l_CEA)

%% Evolution - charging.... #1: All the curves together for one test agency 
figure(i)
[j,k]=size(Filepath_CID)
for n=1:j
    [SOC,OCV] = evo_ch_cycle_CID(Filepath_CID(n,:));
    plot(SOC, OCV,'-', 'Marker', markers{n}, 'MarkerSize', 10)
    xlim([0 100])
    hold on
end
xlabel('State of charge (%)')
ylabel('Open circuit voltage (V)')
title('Evolution curve - charging (Cidetec tests)')
legend(leg_evo_cycle_CID,'Location','Southeast')

figure(i+1)
[x,y]=size(Filepath_CEA)
for n=1:x
    [SOC,OCV] = evo_ch_cycle_CEA(Filepath_CEA(n,:));
    plot(SOC, OCV,'-', 'Marker', markers{n}, 'MarkerSize', 10)
    xlim([0 100])
    hold on
end

% for legend
xlabel('State of charge (%)')
ylabel('Open circuit voltage (V)')
title('Evolution curve - charging (CEA Tests)')
legend(leg_evo_cycle_CEA,'Location','Southeast')
hold off
i=i+1;

%% Evolution - charging.... #2: Curves for one cell type in one curve 

[j,k]=size(Filepath_CID)
for n=1:j
    figure(i)
    [SOC,OCV,legendCell_ch]= evo_ch_cycle_CID(Filepath_CID(n,:));
    plot(SOC, OCV,'-', 'Marker', markers{n}, 'MarkerSize', 10)
    legend(legendCell_ch, 'Location', 'SouthEast')
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Open circuit voltage (V)')
    title(strcat(l_CID(n),' Evolution curve - Charging (Cidetec tests)'))
    i = i+1
end

[x,y]=size(Filepath_CEA)
for n=1:x
    figure(i)
    [SOC,OCV,legendCell_ch]= evo_ch_cycle_CID(Filepath_CEA(n,:));
    plot(SOC, OCV,'-', 'Marker', markers{n}, 'MarkerSize', 10)
    legend(legendCell_ch, 'Location', 'SouthEast')
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Open circuit voltage (V)')
    title(strcat(l_CEA(n),' Evolution curve - Charging (CEA tests)'))
    i=i+1;
end

%% Evolution - discharging.... #1: All the curves together for one test agency 
% NOTE: Values are plotted only for Extended CheckUps (ECU) because of the
% absence of Short Check-Up (SCU) values for some cells and for uniformity

figure(i)
[j,k]=size(Filepath_CID)
for n=1:j
    [dSOC,dOCV] = evo_dis_cycle_CID(Filepath_CID(n,:));
    plot(dSOC, dOCV,'-', 'Marker', markers{n}, 'MarkerSize', 10)
    xlim([0 100])
    hold on
end
xlabel('State of charge (%)')
ylabel('Open circuit voltage (V)')
title('Evolution curve - discharging (Cidetec tests)')
legend(leg_evo_cycle_CID,'Location','Southeast')

figure(i+1)
[x,y]=size(Filepath_CEA)
for n=1:x
    [dSOC,dOCV] = evo_dis_cycle_CEA(Filepath_CEA(n,:));
    plot(dSOC, dOCV,'-', 'Marker', markers{n}, 'MarkerSize', 10)
    xlim([0 100])
    hold on
end
% for legend
xlabel('State of charge (%)')
ylabel('Open circuit voltage (V)')
title('Evolution curve - Discharging (CEA Tests)')
legend(leg_evo_cycle_CEA,'Location','Southeast')
i=i+1;

hold off
%% Evolution - discharging.... #2: Curves for one cell type in one curve 
% NOTE: Values are plotted only for Extended CheckUps (ECU) because of the
% absence of Short Check-Up (SCU) values for some cells and for uniformity
[j,k]=size(Filepath_CID)
for n=1:j
    figure(i)
    [dSOC,dOCV,legendCell_dis]= evo_dis_cycle_CID(Filepath_CID(n,:));
    plot(dSOC, dOCV,'-', 'Marker', markers{n}, 'MarkerSize', 10)
    legend(legendCell_dis, 'Location', 'SouthEast')
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Open circuit voltage (V)')
    title(strcat(l_CID(n),' Evolution curve - Discharging (Cidetec tests)'))
    i = i+1
end

[x,y]=size(Filepath_CEA)
for n=1:x
    figure(i)
    [dSOC,dOCV,legendCell_dis]= evo_dis_cycle_CID(Filepath_CEA(n,:));
    plot(SOC, OCV,'-', 'Marker', markers{n}, 'MarkerSize', 10)
    legend(legendCell_dis, 'Location', 'SouthEast')
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Open circuit voltage (V)')
    title(strcat(l_CEA(n),' Evolution curve - Discharging (CEA tests)'))
    i=i+1;
end


%% Internal resistance - charging
% For CID tests
[j,k]=size(Filepath_CID)
for n=1:j
    figure(i)
    ir_ch_cycle_CID(Filepath_CID(n,:));
    title(strcat(l_CID(n),': Internal resistance for 30s charge pulses (Charging)- Only ECU'))
    i=i+1
end

% For CEA tests
[j,k]=size(Filepath_CEA)
for n=1:j
    figure(i)
    ir_ch_cycle_CEA(Filepath_CEA(n,:));
    title(strcat(l_CEA(n),': Internal resistance for 30s charge pulses (Charging)- Only ECU'))
    i=i+1
end

%% Internal resistances - discharging
% For the Cidetec tests
[j,k]=size(Filepath_CID)
for n=1:j
    figure(i)
    ir_dis_cycle_CID(Filepath_CID(n,:))
    
    title(strcat(l_CID(n),': Internal resistance for 30s charge pulses (discharging)-Only ECU'))
    i=i+1
    
end

% For the CEA tests
[j,k]=size(Filepath_CEA)
for n=1:j
    figure(i)
    ir_dis_cycle_CEA(Filepath_CEA(n,:))
    
    title(strcat(l_CEA(n),': Internal resistance for 30s charge pulses (discharging)-Only ECU'))
    i=i+1
    
end
