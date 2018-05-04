%% Ageing and energy throughput vs state of health evaluation
% This fumction takes the path to a file as an input
function [SoH,Ecn] = age_cycle(p)
    Data = readtable(p,'Range','B5:J10','ReadRowNames',true);  
    Ecn = Data{'Equivalent cycle number',:}
    SoH = Data{'SoH',:}
end

