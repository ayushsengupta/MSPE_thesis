yyaxis left
plot(time, Ah)
ylabel("Instantaneous capacity (Ah)")
yyaxis right
plot(time, unnamed)
ylabel("Current (A)")
xlabel("Time [hours]")
xlim([6 16.60])