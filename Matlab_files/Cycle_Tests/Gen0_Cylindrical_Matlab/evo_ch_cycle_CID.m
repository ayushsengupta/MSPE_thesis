function [SOC,OCV,legendCell_ch] = evo_ch_cycle_CID(p)
    Charge_evo = readtable(p,'Range','C31:Z56','ReadVariableNames',false);  
    CU = readtable(p,'Range','C1:Z1','ReadVariableNames',false)
    CU_arr = [CU(:,:)]
    [m,n] = size(CU_arr)
    j=1
    idx = []
    for i=1:n
        if ismember(CU_arr{:,i},'ECU')
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
    % counters for plot markers and line colors
    % markers = {'+','o','*','x','s','d','^','>','p','h','v','<'}
    % colors = {'r','b','g','y','c','m','k'}
    % 'Color', colors{randi([1 7],1,1)},
    %plot(SOC, OCV,'-', 'Marker', markers{randi([1 12],1,1)}, 'MarkerSize', 10)
    %xlim([0 100])
    %xlabel('State of charge (SOC) in %')
    %ylabel('Open circuit voltage (V)')
end

