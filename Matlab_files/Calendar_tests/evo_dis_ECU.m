function [dSOC_ECU, dOCV_ECU,legendCell_ECU]= evo_dis_ECU(p)
    %% For evolution - discharging
    dcharge_evo = readtable(p,'Range','C53:L77');
    CU = readtable(p,'Range','C9:L9','ReadVariableNames',false)
    [m,n] = size(CU)
    j=1
    for i=1:n
        if CU{:,i} == "ECU"
            idx(j) = i
            j=j+1
        end
    end
    SOHtab = readtable(p,'Range','C7:L8');
    dSOH = [SOHtab{:,idx}]    
    dcharge_ocv = dcharge_evo{:,idx}
    dSOC_ECU = [dcharge_ocv(1:2:end-1,:)]
    dOCV_ECU = [dcharge_ocv(2:2:end,:)]
    legendCell_ECU = cellstr(num2str(dSOH', 'SOH = %f'))
end
