%% Temperature trial
% Plotting temperature vs time curves with voltage developed over tests.

%% the main code
yyaxis left
plot(Cyl_Cell19.Timeh,Cyl_Cell19.T1C)
yyaxis right
plot(Cyl_Cell19.Timeh,Cyl_Cell19.UV, '-.')
xlabel("Time (hours)")
yyaxis left
ylabel("Temperature (degree Celsius)")
yyaxis right
ylabel("Voltage (V)")
legend('Temperature','Voltage', 'Location','North')
title("Cylindrical Cell 19 (0.3C, 5 deg C): Temperature developed over cycling test")
