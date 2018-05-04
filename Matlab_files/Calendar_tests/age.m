%% Ageing and energy throughput vs state of health evaluation
% This fumction takes the path to a file as an input
function [SoH, Age] = age(p)
    Data = readtable(p,'Range','B2:L8','ReadRowNames',true);  
    Age = Data{'Ageing time (Days)',:}
    SoH = Data{'SoH',:}
end

