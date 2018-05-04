function [irdSOH, irdSOC, ird_pt5, ird_10, ird_30, legend_ird] = ir_dis(p)
% This function returns the SOH, SOC, internal resistance discharge data for 0.5 seconds, 10 seconds and 30 seconds; 
% and the legend matrix    
    dcharge_irtab = readtable(p,'Range','C137:L197');  
    dcharge_ir = dcharge_irtab{:,:}
    SOHtab = readtable(p,'Range','C7:L8');
    irdSOH = SOHtab{:,:}
    irdSOC = dcharge_ir(1:5:end-4,:)
    ird_pt5 = dcharge_ir(3:5:end-2,:)
    ird_10 = dcharge_ir(4:5:end-1,:)
    ird_30 = dcharge_ir(5:5:end,:)
    legend_ird = cellstr(num2str(irdSOH', 'SOH = %f'))
    %subleg1d = cellstr(num2str(irdSOH', 'at 0.5s and SOH = %f'))
    %subleg2d = cellstr(num2str(irdSOH', 'at 10s and SOH = %f'))
    %subleg3d = cellstr(num2str(irdSOH', 'at 30s and SOH = %f'))
    %legend_ird = vertcat(subleg1d, subleg2d, subleg3d)

    %subplot(3,1,1)
    %figure()
    %plot(irdSOC, ird_pt5,'-.d')
    %legend(legend_ird)
    %xlabel('State of charge (%)')
    %ylabel('Internal resistance (mOhm)')
    %title('Internal resistance (Discharging) - Time elapsed: 0.5 seconds')

    
    %subplot(3,1,2)
    %figure()
    %plot(irdSOC, ird_10, '-o')
    %legend(legend_ird)
    %xlabel('State of charge (%)')
    %ylabel('Internal resistance (mOhm)')
    %title('Internal resistance (Discharging)- Time elapsed: 10 seconds')

    
    %subplot(3,1,3)
    %figure()
    %plot(irdSOC, ird_30, '-<')
    %legend(legend_ird)
    %xlabel('State of charge (%)')
    %ylabel('Internal resistance (mOhm)')
    %title('Internal resistance (Discharging)- Time elapsed: 30 seconds')
end