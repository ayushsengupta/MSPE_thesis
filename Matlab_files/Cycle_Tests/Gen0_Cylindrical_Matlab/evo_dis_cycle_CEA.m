function [dSOC, dOCV, legendcell_dis] = evo_dis_cycle_CEA(p)
    %% For evolution - discharging
    dcharge_evo = readtable(p,'Range','C51:Z74', 'ReadVariableNames',false);
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
    dcharge_ocv = dcharge_evo{:,idx}
    dSOC = [dcharge_ocv(1:2:end-1,:)]
    dOCV = [dcharge_ocv(2:2:end,:)]
    SOHtab = readtable(p,'Range','C8:Z8', 'ReadVariableNames',false);
    dSOH = SOHtab{:,idx} 

    % Storing original SOC and OCV values before interpolation
    dSOC_original = dSOC
    dOCV_original = dOCV
    
    % Subsequent lines till the end of for loop interpolate the values of
    % the SOC and OCV tables to substitute 0 (zero values)
    [x,y] = size(dSOC)
    for a=1:x
        for b=1:y
            if dSOC(a,b)==dOCV(a,b)
                dSOC(a,b) = (dSOC(a+1,b)+dSOC(a-1,b))/2
                dOCV(a,b) = (dOCV(a+1,b)+dOCV(a-1,b))/2
            end
        end
    end
    % Code to plot the values (error: the substituted values also showed with markers)
    % counters for plot markers and line colors
    markers = {'+','o','*','<','s','d','x','^','v','>','p','h'}
    % colors = {'r','b','g','y','c','m','k'}
    % 'Color', colors{randi([1 7],1,1)},
    % plot(dSOC, dOCV,'-', 'Marker', markers{randi([1 12],1,1)}, 'MarkerSize', 10)

    legendCell_dis = cellstr(num2str(dSOH', 'SOH = %f'))
    %legend(legendCell, 'Location', 'NorthWest')
    %xlabel('State of charge (%)')
    %ylabel('Open circuit voltage (V)')
end
