%% Calendar Ageing Tests: Simultaneous curves from all cells
% This code accesses tables from all calendar testing folders and
% evaluates the curves for each cell for different parameters
clear
clc

%% File parsing
MyFileInfo = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum');
F1 = strcat(MyFileInfo(3).folder, "\", MyFileInfo(3).name)
F2 = strcat(MyFileInfo(4).folder, "\", MyFileInfo(4).name) 
MyFileInfo2 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC65_TUM_Tum');
F3 = strcat(MyFileInfo2(3).folder, "\", MyFileInfo2(3).name) 
F4 = strcat(MyFileInfo2(4).folder, "\", MyFileInfo2(4).name)
MyFileInfo3 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC100_TUM_Tum');
F5 = strcat(MyFileInfo3(3).folder, "\", MyFileInfo3(3).name) 
F6 = strcat(MyFileInfo3(4).folder, "\", MyFileInfo3(4).name)

Filepath = [F1; F2; F3; F4; F5; F6]
Filepath_select = [F2; F4; F6]


%% Legend matrix
l = ["Cell 25";"Cell 26";"Cell 27";"Cell 28";"Cell 29";"Cell 30"]
l_full =["Cell 25 : T45, SOC30","Cell 26 : T45, SOC30","Cell 27 : T45, SOC65", "Cell 28 : T45, SOC65","Cell 29 : T45, SOC100","Cell 30 : T45, SOC100"]
l_select = ["Cell 26";"Cell 28";"Cell 30"]
markers = {'+','o','*','<','s','d','x','^','v','>','p','h'}
i=1;
%% Ageing and energy throughput curves
% This code section will produce two curves for ageing vs SOH and energy
% throughput vs SOH for all the cells together.
figure(i)
subplot(2,1,1)
[j,k]=size(Filepath)
for n=1:j
    [SoH, Age]= age(Filepath(n,:));
    plot(Age, SoH, '-','Marker',markers{n})
    hold on
end
ylim([80 100])
xlabel('Ageing time (Days)')
ylabel('State of Health (%)')
title('Ageing vs State of Health')
legend(l_full,'Location','SouthWest');

subplot(2,1,2)
for n=1:j
    [SoH, E_thru]=ethrough(Filepath(n,:));
    plot(E_thru, SoH, '-','Marker',markers{n})
    hold on
end
ylim([80 100])
xlabel('Energy throughput (Wh)')
ylabel('State of Health (%)')
title('Energy throughput vs State of Health')
legend(l_full,'Location','SouthWest');

i=i+1;
%% legend for charging
SOH = legend_evo_ch(Filepath)
[q,r] = size(SOH);
[s,t] = size(l);
leg_evo_ch = []
for m=1:q
    for o=1:r
        leg_evo_ch{end+1} = strcat(l(m), 'at SOH = ',num2str(SOH(m,o)))
    end
end

leg_evo_ch

% Legend for selection
SOH = legend_evo_ch(Filepath_select)
[q,r] = size(SOH);
[s,t] = size(l_select);
leg_evo_ch_select = []
for m=1:q
    for o=1:r
        leg_evo_ch_select{end+1} = strcat(l_select(m), 'at SOH = ',num2str(SOH(m,o)))
    end
end

%% Evolution - charging
% #1: All curves together
figure(i)
[j,k]=size(Filepath)
for n=1:j
    [SOC,OCV] = evo_ch(Filepath(n,:));
    plot(SOC, OCV,'-','Marker',markers{n})
    title(strcat(l(n),' Evolution curve - charging'))
    hold on
end
% for legend
xlim([0 100])
xlabel('State of charge (%)')
ylabel('Open circuit voltage (V)')
title('Evolution curve - charging (ECU)')
legend(leg_evo_ch,'Location','Southeast')
i=i+1;

% #2: Separate curves for separate cells
[j,k]=size(Filepath)
for n=1:j
    figure(i)
    [SOC,OCV,legendCell_ch] = evo_ch(Filepath(n,:));
    plot(SOC, OCV,'-','Marker',markers{n})
    title(strcat(l(n),' Evolution curve - charging'))
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Open circuit voltage (V)')
    legend(legendCell_ch, 'Location', 'SouthEast')
    i=i+1;
end
% for legend
legend(leg_evo_ch,'Location','Southeast')



%% Evolution - discharging

[j,k]=size(Filepath)
for n=1:j
    figure(i)
    [dSOC, dOCV,legendCell]=evo_dis(Filepath(n,:));
    plot(dSOC, dOCV, '-', 'Marker', markers{n});
    title(strcat(l(n),' Evolution curve - discharging'))
    i=i+1
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Open circuit voltage (V)')
    legend(legendCell, 'Location', 'NorthWest')
end

%% Evolution discharging: All cells together (only ECU)
figure(i)
[j,k]=size(Filepath_select)
for n=1:j
    [dSOC_ECU,dOCV_ECU] = evo_dis_ECU(Filepath(n,:));
    plot(dSOC_ECU, dOCV_ECU,'-','Marker',markers{n})
    hold on
end
% for legend
xlim([0 100])
xlabel('State of charge (%)')
ylabel('Open circuit voltage (V)')
title('Evolution curve - Discharging (ECU)')
legend(leg_evo_ch_select,'Location','Southeast')
i=i+1;


%% Internal resistance - charging
[j,k]=size(Filepath)
for n=1:j
    figure(i)
    ir_ch(Filepath(n,:));
    title(strcat(l(n),': Internal resistance for 30s charge pulses (Charging)'))
    i=i+1
end

%% Internal resistances - discharging
% ir_dis() function returns in order - SOH, SOC, resistance at 0.5 sec, 10 sec, 30 sec and legend matrix 
[j,k]=size(Filepath)
for n=1:j
    
    [irdSOH, irdSOC, ird_pt5, ird_10, ird_30, legend_ird] = ir_dis(Filepath(n,:))
    figure(i)
    plot(irdSOC, ird_pt5,'-','Marker',markers{n})
    xlabel('State of charge (%)')
    ylabel('Internal resistance (mOhm)')
    legend(legend_ird)
    title(strcat(l(n),': Internal resistance for 30s charge pulses (discharging) at 0.5s'))
    i=i+1
    
    figure(i)
    plot(irdSOC, ird_10,'-','Marker',markers{n})
    xlabel('State of charge (%)')
    ylabel('Internal resistance (mOhm)')
    legend(legend_ird)
    title(strcat(l(n),': Internal resistance for 30s charge pulses (discharging) at 10s'))
    i=i+1
    
    figure(i)
    plot(irdSOC, ird_30,'-','Marker',markers{n})
    xlabel('State of charge (%)')
    ylabel('Internal resistance (mOhm)')
    legend(legend_ird)
    title(strcat(l(n),': Internal resistance for 30s charge pulses (discharging) at 30s'))
    i=i+1
end

%% Internal resistance discharging curves - only ECU - one cell all values, one curve
[j,k]=size(Filepath)
for n=1:j
    figure(i)
    ir_dis_ECU_onecell(Filepath(n,:))
    
    title(strcat(l(n),': Internal resistance for 30s charge pulses (discharging)-Only ECU'))
    i=i+1
    
end
