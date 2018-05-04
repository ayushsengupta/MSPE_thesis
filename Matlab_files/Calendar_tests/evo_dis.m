function [dSOC, dOCV,legendCell]= evo_dis(p)
    %% For evolution - discharging
    dcharge_evo = readtable(p,'Range','C53:L77');
    SOHtab = readtable(p,'Range','C7:L8');
    dSOH = SOHtab{:,:} 
    dcharge_ocv = dcharge_evo{:,:}
    dSOC = [dcharge_ocv(1:2:end-1,:)]
    dOCV = [dcharge_ocv(2:2:end,:)]
    legendCell = cellstr(num2str(dSOH', 'SOH = %f'))
end
