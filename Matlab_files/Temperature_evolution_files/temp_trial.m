%% Temperature trial
% Plotting temperature vs time curves with voltage developed over tests.

%% the main code
yyaxis left
plot(Prism_Cell20.Timeh,Prism_Cell20.T1C)
yyaxis right
plot(Prism_Cell20.Timeh,Prism_Cell20.UV)
xlabel("Time (hours)")
yyaxis left
ylabel("Temperature (degree Celsius)")
yyaxis right
ylabel("Voltage (V)")
title("Prismatic Cell 20 (0.3C, 5 deg C): Temperature developed over cycling test")
