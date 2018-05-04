function [SOC,OCV,legendCell_ch] = evo_ch(p)
    Charge_evo = readtable(p,'Range','C27:L53');  
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
    SOH = [SOHtab{:,idx}]
    Charge_ocv = [Charge_evo{:,idx}]    
    SOC = [Charge_ocv(1:2:end-1,:)]
    OCV = [Charge_ocv(2:2:end,:)]
    legendCell_ch = cellstr(num2str(SOH', 'SOH = %f'))
end

