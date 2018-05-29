clear
clc
Pou_Cell19 = readtable('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Raw Data\CURaw_Cycl_T05_Ch0.3C_Vito_Pouch_Cell19_01.xlsx','Range','D4:N188592','ReadVariableNames',true);
[x,y]=size(Pou_Cell19)
Time_pouch = Pou_Cell19{:,'Time_h_'};
Volt_pouch = Pou_Cell19{:,'Voltage_V_'};
Temp_pouch = Pou_Cell19{:,'Temperature_C_'};
count=1
T1C_pouch=(Temp_pouch(~isnan(Temp_pouch)));
UV_pouch=(Volt_pouch(~isnan(Temp_pouch)));
Timeh_pouch=(Time_pouch(~isnan(Temp_pouch)));

figure()
yyaxis left
plot(Timeh_pouch,T1C_pouch)
yyaxis right
plot(Timeh_pouch,UV_pouch, '-.')
xlabel("Time (hours)")
yyaxis left
ylabel("Temperature (degree Celsius)")
yyaxis right
ylabel("Voltage (V)")
legend('Temperature','Voltage', 'Location','North')
title("Pouch Cell 19(0.3C, 5 deg C): Temperature developed over cycling test")