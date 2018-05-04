function [irdSOH, irdSOC, ird_pt5, ird_10, ird_30, legend_ird] = ir_dis_cycle_CEA(p)
% This function returns the SOH, SOC, internal resistance discharge data for 0.5 seconds, 10 seconds and 30 seconds; 
% and the legend matrix    
    dcharge_irtab = readtable(p,'Range','C135:L194','ReadVariableNames',false);  
    CU = readtable(p,'Range','C1:Z1','ReadVariableNames',false)
    [m,n] = size(CU)
    j=1
    for i=1:n
        if ismember(CU{:,i},'ECU')
            idx(j) = i
            j=j+1
        end
    end
    SOHtab = readtable(p,'Range','C8:Z8','ReadVariableNames', false);
    irdSOH = SOHtab{:,idx}
    dcharge_ir = dcharge_irtab{:,idx}
    irdSOC = dcharge_ir(1:5:end-4,:)
    ird_pt5 = dcharge_ir(3:5:end-2,:)
    ird_10 = dcharge_ir(4:5:end-1,:)
    ird_30 = dcharge_ir(5:5:end,:)
    [x,y] = size(irdSOC)
    for a=1:x
        for b=1:y
            if (irdSOC(a,b)==0 && ird_pt5(a,b)==0 && ird_10(a,b) == 0 && ird_30(a,b) == 0 && a<x && a>1)
                irdSOC(a,b) = (irdSOC(a+1,b)+irdSOC(a-1,b))/2
                ird_pt5(a,b) = (ird_pt5(a+1,b)+ird_pt5(a-1,b))/2
                ird_10(a,b) = (ird_10(a+1,b)+ird_10(a-1,b))/2
                ird_30(a,b) = (ird_30(a+1,b)+ird_30(a-1,b))/2
            end
        end
    end

    legend_ird = cellstr(num2str(irdSOH', 'SOH = %f'))
    subleg1d = cellstr(num2str(irdSOH', 'at 0.5s and SOH = %f'))
    subleg2d = cellstr(num2str(irdSOH', 'at 10s and SOH = %f'))
    subleg3d = cellstr(num2str(irdSOH', 'at 30s and SOH = %f'))
    legend_ird = vertcat(subleg1d, subleg2d, subleg3d)

    plot(irdSOC, ird_pt5,'-.d')
    hold on
    plot(irdSOC, ird_10, '-o')
    hold on
    plot(irdSOC, ird_30, '-+')
    hold off
    legend(legend_ird, 'Location', 'North')
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Internal resistance (mOhm)')
    
    %subplot(3,1,3)
    %figure()
    %plot(irdSOC, ird_30, '-<')
    %legend(legend_ird)
    %xlabel('State of charge (%)')
    %ylabel('Internal resistance (mOhm)')
    %title('Internal resistance (Discharging)- Time elapsed: 30 seconds')
end