%% Ageing and energy throughput vs state of health evaluation
% This fumction takes the path to a file as an input
function [SoH,Ecn] = age_cycle_pouch(p)
    Data = readtable(p,'Range','B5:Z10','ReadRowNames',true);  
    Ecn = Data{'Equivalent cycle number',:}
    SoH = Data{'SoH',:}
end

