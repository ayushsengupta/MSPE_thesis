%% Energy throughput vs state of health evaluation
% This fumction takes the path to a file as an input
function [SoH, E_thru] = ethrough_cycle(p)
    Data = readtable(p,'Range','B2:L8','ReadRowNames',true);  
    SoH = Data{'SoH',:}
    E_thru = Data{'Total discharge energy throughput',:}
end