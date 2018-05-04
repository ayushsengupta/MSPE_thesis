clc 
clear

%% For SoH vs Age
p = 'G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum\Cal_T45_SOC30_Cyl_Cell25.xlsx'
Data = readtable(p,'Range','B2:L8','ReadRowNames',true);  
Age = Data{'Ageing time (Days)',:}
SoH = Data{'SoH',:}
E_thru = Data{'Total energy throughput during checkups (Wh)',:}
figure(1)
subplot(1,2,1)
plot(SoH, Age)
xlabel('Ageing time (Days)')
ylabel('State of Health (%)')
title('Ageing vs State of Health')

subplot(1,2,2)
plot(SoH, E_thru)
xlabel('Ageing time (Days)')
ylabel('Energy throughput during checkup (Wh)')
title('Energy throughput vs State of Health')

%% For evolution - charging
p = 'G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum\Cal_T45_SOC30_Cyl_Cell25.xlsx'
Charge_evo = readtable(p,'Range','C27:L53'); 
CU = readtable(p,'Range','C9:L9','ReadVariableNames',false)
[m,n] = size(CU)
j=1
for i=1:n
    if CU{:,i} == "ECU"
        idx(j) = i
        j=j+1
    end
end
SOHtab = readtable('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum\Cal_T45_SOC30_Cyl_Cell25.xlsx','Range','C7:L8');
SOH = [SOHtab{:,idx}]
Charge_ocv = [Charge_evo{:,idx}]
SOC = [Charge_ocv(1:2:end-1,:)]
OCV = [Charge_ocv(2:2:end,:)]
figure(2)
plot(SOC, OCV)
legend(strcat('SOH = ', num2str(SOH(1))),strcat('SOH = ', num2str(SOH(2))));
xlabel('State of charge (%)')
ylabel('Open circuit voltage (V)')
title('Evolution curve - charging')

%% For evolution - discharging
p = 'G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum\Cal_T45_SOC30_Cyl_Cell25.xlsx'
dcharge_evo = readtable(p,'Range','C53:L77');
SOHtab = readtable('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum\Cal_T45_SOC30_Cyl_Cell25.xlsx','Range','C7:L8');
dSOH = SOHtab{:,:} 
dcharge_ocv = dcharge_evo{:,:}
dSOC = [dcharge_ocv(1:2:end-1,:)]
dOCV = [dcharge_ocv(2:2:end,:)]
figure(3)
plot(dSOC, dOCV);
legendCell = cellstr(num2str(dSOH', 'SOH = %f'))
legend(legendCell, 'Location', 'NorthWest')
xlabel('State of charge (%)')
ylabel('Open circuit voltage (V)')
title('Evolution curve - discharging')

%% For internal resistance - charging
% IMPORTANT: Cell no. C127 (in excel sheet) value changed from 0 to the
% correspoinding data above.
p = 'G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum\Cal_T45_SOC30_Cyl_Cell25.xlsx'
Charge_irtab = readtable(p,'Range','C77:L137');  
Charge_ir = [Charge_irtab{:,1} , Charge_irtab{:,end-1}]
SOHtab = readtable(p,'Range','C7:L8');
irSOH = [SOHtab{:,1} , SOHtab{:,end-1}]
irSOC = [Charge_ir(1:5:end-4,:)]
ir_pt5 = [Charge_ir(3:5:end-2,:)]
ir_10 = [Charge_ir(4:5:end-1,:)]
ir_30 = [Charge_ir(5:5:end,:)]

subleg1 = cellstr(num2str(irSOH', 'at 0.5s and SOH = %f'))
subleg2 = cellstr(num2str(irSOH', 'at 10s and SOH = %f'))
subleg3 = cellstr(num2str(irSOH', 'at 30s and SOH = %f'))
legend_ir = vertcat(subleg1, subleg2, subleg3)
figure(4)
plot(irSOC, ir_pt5,'-.d')
hold on
plot(irSOC, ir_10, '-o')
hold on
plot(irSOC, ir_30)
hold off
legend(legend_ir)
xlabel('State of charge (%)')
ylabel('Internal resistance (mOhm)')
title('Internal resistance for 30s charge pulses (Charging)')

%% For internal resistance - discharging
p = 'G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum\Cal_T45_SOC30_Cyl_Cell25.xlsx'
dcharge_irtab = readtable(p,'Range','C137:L197');  
dcharge_ir = dcharge_irtab{:,:}
SOHtab = readtable(p,'Range','C7:L8');
irdSOH = SOHtab{:,:}
irdSOC = dcharge_ir(1:5:end-4,:)
ird_pt5 = dcharge_ir(3:5:end-2,:)
ird_10 = dcharge_ir(4:5:end-1,:)
ird_30 = dcharge_ir(5:5:end,:)
legend_ird = cellstr(num2str(irdSOH', 'SOH = %f'))
%subleg1d = cellstr(num2str(irdSOH', 'at 0.5s and SOH = %f'))
%subleg2d = cellstr(num2str(irdSOH', 'at 10s and SOH = %f'))
%subleg3d = cellstr(num2str(irdSOH', 'at 30s and SOH = %f'))
%legend_ird = vertcat(subleg1d, subleg2d, subleg3d)

figure(5)

%subplot(3,1,1)
plot(irdSOC, ird_pt5,'-.d')
legend(legend_ird)
xlabel('State of charge (%)')
ylabel('Internal resistance (mOhm)')
title('Internal resistance (Discharging) - Time elapsed: 0.5 seconds')

figure(6)
%subplot(3,1,2)
plot(irdSOC, ird_10, '-o')
legend(legend_ird)
xlabel('State of charge (%)')
ylabel('Internal resistance (mOhm)')
title('Internal resistance (Discharging)- Time elapsed: 10 seconds')

figure(7)
%subplot(3,1,3)
plot(irdSOC, ird_30, '-<')
legend(legend_ird)
xlabel('State of charge (%)')
ylabel('Internal resistance (mOhm)')
title('Internal resistance (Discharging)- Time elapsed: 30 seconds')


%% Files parsing trials
MyFileInfo = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports\Cal_T45_SOC30_TUM_Tum');
Filepath = strcat(MyFileInfo(3).folder, '\', MyFileInfo(3).name)
Filepath = vertcat(Filepath,strcat(MyFileInfo(3).folder, '\', MyFileInfo(3).name)) 
%Filepath = file_parse(MyFileInfo)

%% Parsing function
p = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Calendar_Test_result_reports');

n=1;
p(1).folder
while p(n+1).folder ~= ""
    n=n+1
end    