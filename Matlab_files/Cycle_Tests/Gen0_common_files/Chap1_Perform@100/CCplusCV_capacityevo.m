yyaxis left
plot(time, Ah, 'LineWidth', 2)
ylabel("Instantaneous capacity (Ah)", 'FontName', 'Arial', 'FontSize', 18)
yyaxis right
plot(time, current, 'LineWidth', 2)
ylabel("Current (A)", 'FontName', 'Arial', 'FontSize', 18)
xlabel("Time [hours]", 'FontName', 'Arial', 'FontSize', 18)
set(gca,'fontsize',18)
xlim([6 16.60])