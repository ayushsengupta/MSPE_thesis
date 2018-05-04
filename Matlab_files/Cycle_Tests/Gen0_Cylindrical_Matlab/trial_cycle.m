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

%% further trials: evolution charging
[j,k]=size(Filepath)
for n=1:(j/2)
    evo_ch_cycle_CID(Filepath(n,:));
    hold on
end

%% cycle test evolution curves - CID
p = "G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T05_Ch0.3C_Cidetec_Cyl\Cycl_T05_Ch0.3C_Cidetec_Cyl_Cell19.xlsx"
Charge_evo = readtable(p,'Range','C31:Z56','ReadVariableNames',false);  
CU = readtable(p,'Range','C1:Z1','ReadVariableNames',false)
[m,n] = size(CU)
j=1
idx = []
for i=1:n
    if ismember(CU{:,i},'ECU')
        idx(j) = i
        j=j+1
    end
end
SOHtab = readtable(p,'Range','C7:Z7','ReadVariableNames',false);
SOH = [SOHtab{:,idx}]
Charge_ocv = [Charge_evo{:,idx}]    
SOC = [Charge_ocv(1:2:end-3,:)]
OCV = [Charge_ocv(2:2:end-2,:)]
plot(SOC, OCV,'-+')
xlabel('State of charge (SOC) in %')
ylabel('Open circuit voltage (V)')

%% cycle tests evolution curves: CEA
% This function involves some linear interpolation for 0 (zero) values
p = "G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T45_Ch2C_CEA_Cyl\Cycl_T45_Ch2C_CEA_Cyl_Cell34.xlsx"
Charge_evo = readtable(p,'Range','C27:Z50','ReadVariableNames',false);  
CU = readtable(p,'Range','C1:Z1','ReadVariableNames',false)
[m,n] = size(CU)
idx = []
j=1
for i=1:n
    if ismember(CU{:,i},'ECU')
        idx(j) = i
        j=j+1
    end
end
SOHtab = readtable(p,'Range','C8:Z8','ReadVariableNames',false);
SOH = [SOHtab{:,idx}]
Charge_ocv = [Charge_evo{:,idx}]    
SOC = [Charge_ocv(1:2:end-3,:)]
OCV = [Charge_ocv(2:2:end-2,:)]
SOC_original = SOC
OCV_original = OCV
[x,y] = size(SOC)
for a=1:x
    for b=1:y
        if SOC(a,b)==OCV(a,b)
            SOC(a,b) = (SOC(a+1,b)+SOC(a-1,b))/2
            OCV(a,b) = (OCV(a+1,b)+OCV(a-1,b))/2
        end
    end
end
plot(SOC, OCV,'-+')
xlabel('State of charge (SOC) in %')
ylabel('Open circuit voltage (V)')

%% internal resistance charging trial
p = 'G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T25_Ch2C_CEA_Cyl\Cycl_T25_Ch2C_CEA_Cyl_Cell33.xlsx'
Charge_irtab = readtable(p,'Range','C75:Z134','ReadVariableNames',false);  
    CU = readtable(p,'Range','C1:Z1','ReadVariableNames',false)
    [m,n] = size(CU)
    j=1
    for i=1:n
        if ismember(CU{:,i},'ECU')
            idx(j) = i
            j=j+1
        end
    end
    SOHtab = readtable(p,'Range','C8:Z8','ReadVariableNames',false);
    irSOH = [SOHtab{:,idx}]
    Charge_ir = [Charge_irtab{:,idx}]
    irSOC = [Charge_ir(1:5:end-4,:)]
    ir_pt5 = [Charge_ir(3:5:end-2,:)]
    ir_10 = [Charge_ir(4:5:end-1,:)]
    ir_30 = [Charge_ir(5:5:end,:)]
    irSOC_original = irSOC 
    ir_pt5_original= ir_pt5
    ir_10_original= ir_10
    ir_30_original= ir_30
    [x,y] = size(irSOC)
    for a=1:x
        for b=1:y
            if (irSOC(a,b)==0 && ir_pt5(a,b)==0 && ir_10(a,b) == 0 && ir_30(a,b) == 0 && a<x && a>1)
                irSOC(a,b) = (irSOC(a+1,b)+irSOC(a-1,b))/2
                ir_pt5(a,b) = (ir_pt5(a+1,b)+ir_pt5(a-1,b))/2
                ir_10(a,b) = (ir_10(a+1,b)+ir_10(a-1,b))/2
                ir_30(a,b) = (ir_30(a+1,b)+ir_30(a-1,b))/2
            end
        end
    end
    subleg1 = cellstr(num2str(irSOH', 'at 0.5s and SOH = %f'))
    subleg2 = cellstr(num2str(irSOH', 'at 10s and SOH = %f'))
    subleg3 = cellstr(num2str(irSOH', 'at 30s and SOH = %f'))
    legend_ir = vertcat(subleg1, subleg2, subleg3)
    
    plot(irSOC, ir_pt5,'-.d')
    hold on
    plot(irSOC, ir_10, '-o')
    hold on
    plot(irSOC, ir_30)
    hold off
    xlim([0 100])
    legend(legend_ir)
    xlabel('State of charge (%)')
    ylabel('Internal resistance (mOhm)')
    
 %% Relative resistance CIDETEC trial
 g = 3.125;
 path = "G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T05_Ch0.3C_Cidetec_Cyl\Cycl_T05_Ch0.3C_Cidetec_Cyl_Cell19.xlsx";
 Charge_irtab = readtable(path,'Range','C82:Z141','ReadVariableNames',false);  
 CU = readtable(path,'Range','C1:Z1','ReadVariableNames',false)
 [m,n] = size(CU)
 j=1
 for i=1:n
     if ismember(CU{:,i},'ECU')
         idx(j) = i
         j=j+1
     end
 end
 SOHtab = readtable(path,'Range','C8:Z8','ReadVariableNames',false);
 irSOH = [SOHtab{:,idx}]
 Charge_ir = [Charge_irtab{:,idx}]
 % The internal resistance values in the table have the wrong units,
 % multiplying the vslues with 1000 to convert the values from Ohm to
 % mOhm
 irSOC = [Charge_ir(1:5:end-4,:)]
 irrel_pt5 = [1000*Charge_ir(3:5:end-2,:)/g]
 irrel_10 = [1000*Charge_ir(4:5:end-1,:)/g]
 irrel_30 = [1000*Charge_ir(5:5:end,:)/g]
 [x,y] = size(irSOC)
 for a=1:x
     for b=1:y
         if (irSOC(a,b)==0 && irrel_pt5(a,b)==0 && irrel_10(a,b) == 0 && irrel_30(a,b) == 0 && a<x && a>1)
             irSOC(a,b) = (irSOC(a+1,b)+irSOC(a-1,b))/2
             irrel_pt5(a,b) = (irrel_pt5(a+1,b)+irrel_pt5(a-1,b))/2
             irrel_10(a,b) = (irrel_10(a+1,b)+irrel_10(a-1,b))/2
             irrel_30(a,b) = (irrel_30(a+1,b)+irrel_30(a-1,b))/2
         end
     end
 end
 subleg1 = cellstr(num2str(irSOH', 'at 0.5s and SOH = %f'))
 subleg2 = cellstr(num2str(irSOH', 'at 10s and SOH = %f'))
 subleg3 = cellstr(num2str(irSOH', 'at 30s and SOH = %f'))
 legend_ir = vertcat(subleg1, subleg2, subleg3)
  
 plot(irSOC, irrel_pt5,'-.d')
 hold on
 plot(irSOC, irrel_10, '-o')
 hold on
 plot(irSOC, irrel_30, '-+')
 hold off
 legend(legend_ir, 'Location', 'North')
 xlim([0 100])
 xlabel('State of charge (%)')
 ylabel('Relative Internal resistance (divided by AC resistance)')
    