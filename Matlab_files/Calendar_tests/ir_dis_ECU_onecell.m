function [irdSOH, irdSOC, ird_pt5, ird_10, ird_30, legend_ird] = ir_dis(p)
% This function returns the SOH, SOC, internal resistance discharge data for 0.5 seconds, 10 seconds and 30 seconds; 
% and the legend matrix    
    dcharge_irtab = readtable(p,'Range','C137:L197');  
    CU = readtable(p,'Range','C9:L9','ReadVariableNames',false)
    [m,k] = size(CU)
    j=1
    for i=1:k
        if CU{:,i} == "ECU"
            idx(j) = i
            j=j+1
        end
    end
    SOHtab = readtable(p,'Range','C7:L8');
    irdSOH = [SOHtab{:,idx}]
    dcharge_ir = dcharge_irtab{:,idx}
    irdSOC = dcharge_ir(1:5:end-4,:)
    ird_pt5 = dcharge_ir(3:5:end-2,:)
    ird_10 = dcharge_ir(4:5:end-1,:)
    ird_30 = dcharge_ir(5:5:end,:)
    
    legend_ird = cellstr(num2str(irdSOH', 'SOH = %f'))
    subleg1d = cellstr(num2str(irdSOH', 'at 0.5s and SOH = %f'))
    subleg2d = cellstr(num2str(irdSOH', 'at 10s and SOH = %f'))
    subleg3d = cellstr(num2str(irdSOH', 'at 30s and SOH = %f'))
    legend_ird = vertcat(subleg1d, subleg2d, subleg3d)

    plot(irdSOC, ird_pt5,'-.d')
    hold on
    plot(irdSOC, ird_10, '-o')
    hold on
    plot(irdSOC, ird_30)
    hold off
    legend(legend_ird, 'Location','North')
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Internal resistance (mOhm)')
end