%% Ageing and energy throughput vs state of health evaluation
% This fumction takes the path to a file as an input
function age_ethrough(p)
    Data = readtable(p,'Range','B2:L8','ReadRowNames',true);  
    Age = Data{'Ageing time (Days)',:}
    SoH = Data{'SoH',:}
    
    plot(SoH, Age)
    xlabel('Ageing time (Days)')
    ylabel('State of Health (%)')
    title('Ageing vs State of Health')

end

