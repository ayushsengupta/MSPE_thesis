
figure()
subplot(1,3,1)
yyaxis left
plot(Cyl_Cell19.Timeh,Cyl_Cell19.T1C)
ylim([24 38])
yyaxis right
plot(Cyl_Cell19.Timeh,Cyl_Cell19.UV, '-.')
yyaxis left
xlim([89.1 91.5])

ylabel("Temperature (degree Celsius)")
legend('Temperature','Voltage', 'Location','North')
title("Cylindrical Cell")

subplot(1,3,2)
yyaxis left
plot(Prism_Cell20.Timeh,Prism_Cell20.T1C)
ylim([24 38])
yyaxis right
plot(Prism_Cell20.Timeh,Prism_Cell20.UV, '-.')
xlim([68.28 70.76])
xlabel("Time (hours)")
legend('Temperature','Voltage', 'Location','North')
title("Prismatic Cell")

subplot(1,3,3)
Pou_Cell19 = readtable('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Raw Data\CURaw_Cycl_T05_Ch0.3C_Vito_Pouch_Cell19_01.xlsx','Range','D4:N188592','ReadVariableNames',true);
[x,y]=size(Pou_Cell19)
Time_pouch = Pou_Cell19{:,'Time_h_'};
Volt_pouch = Pou_Cell19{:,'Voltage_V_'};
Temp_pouch = Pou_Cell19{:,'Temperature_C_'};
count=1
T1C_pouch=(Temp_pouch(~isnan(Temp_pouch)));
UV_pouch=(Volt_pouch(~isnan(Temp_pouch)));
Timeh_pouch=(Time_pouch(~isnan(Temp_pouch)));

yyaxis left
plot(Timeh_pouch,T1C_pouch)
ylim([24 38])
yyaxis right
plot(Timeh_pouch,UV_pouch, '-.')
yyaxis right
xlim([102.9 105.8])
ylabel("Voltage (V)")
legend('Temperature','Voltage', 'Location','North')
title("Pouch Cell")