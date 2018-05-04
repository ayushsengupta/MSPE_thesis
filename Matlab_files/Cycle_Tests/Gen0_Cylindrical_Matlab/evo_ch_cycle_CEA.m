function [SOC,OCV,legendCell_ch] = evo_ch_cycle_CEA(p)
    % Reading the table values for SCO and OCV for evolution charging
    Charge_evo = readtable(p,'Range','C27:Z50','ReadVariableNames',false);
    % Reading for Extended Check-Ups (ECU) or Short Check-Ups (SCU)
    CU = readtable(p,'Range','C1:Z1','ReadVariableNames',false)
    [m,n] = size(CU)
    idx = []
    j=1
    for i=1:n
        if ismember(CU{:,i},'ECU')
            idx(j) = i
            j=j+1
        end
    end
    Charge_ocv = [Charge_evo{:,idx}]    
    SOC = [Charge_ocv(1:2:end-3,:)]
    OCV = [Charge_ocv(2:2:end-2,:)]
    SOHtab = readtable(p,'Range','C8:Z8', 'ReadVariableNames',false);
    SOH = SOHtab{:,idx}

    % Next two lines store the original segregated table values for SOC
    % and OCV for ECUs
    SOC_original = SOC
    OCV_original = OCV
    
    % Subsequent lines till the end of for loop interpolate the values of
    % the SOC and OCV tables to substitute 0 (zero values)
    [x,y] = size(SOC)
    for a=1:x
        for b=1:y
            if SOC(a,b)==OCV(a,b)
                SOC(a,b) = (SOC(a+1,b)+SOC(a-1,b))/2
                OCV(a,b) = (OCV(a+1,b)+OCV(a-1,b))/2
            end
        end
    end
    legendCell_ch = cellstr(num2str(SOH', 'SOH = %f'))
end

