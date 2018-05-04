function [dSOC, dOCV, legendCell_dis] = evo_dis_cycle_CID(p)
    %% For evolution - discharging
    dcharge_evo = readtable(p,'Range','C58:Z81','ReadVariableNames',false);
     
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
    SOHtab = readtable(p,'Range','C8:Z8','ReadVariableNames',false);
    dSOH = SOHtab{:,idx}
    dSOC = [dcharge_ocv(1:2:end-1,:)]
    dOCV = [dcharge_ocv(2:2:end,:)]
    % Code to plot the values
    % counters for plot markers and line colors
    % markers = {'+','o','*','x','s','d','^','v','<','>','p','h'}
    % colors = {'r','b','g','y','c','m','k'}
    % 'Color', colors{randi([1 7],1,1)},
    % plot(dSOC, dOCV,'-', 'Marker', markers{randi([1 12],1,1)}, 'MarkerSize', 10)
    legendCell_dis = cellstr(num2str(dSOH', 'SOH = %f'))
    % legend(legendCell, 'Location', 'NorthWest')
    % xlabel('State of charge (%)')
    ylabel('Open circuit voltage (V)')
end
