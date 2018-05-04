function [irdSOH, irdSOC, irreld_pt5, irreld_10, irreld_30, legend_ird] = irrel_dis_cycle_CID(p,g)
% This function returns the SOH, SOC, internal resistance discharge data for 0.5 seconds, 10 seconds and 30 seconds; 
% and the legend matrix    
    dcharge_irtab = readtable(p,'Range','C142:Z201','ReadVariableNames',false);  
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
    irreld_pt5 = 1000*dcharge_ir(3:5:end-2,:)/g
    irreld_10 = 1000*dcharge_ir(4:5:end-1,:)/g
    irreld_30 = 1000*dcharge_ir(5:5:end,:)/g
    [x,y] = size(irdSOC)
    for a=1:x
        for b=1:y
            if (irdSOC(a,b)==0 && irreld_pt5(a,b)==0 && irreld_10(a,b) == 0 && irreld_30(a,b) == 0 && a<x && a>1)
                irdSOC(a,b) = (irdSOC(a+1,b)+irdSOC(a-1,b))/2
                irreld_pt5(a,b) = (irreld_pt5(a+1,b)+irreld_pt5(a-1,b))/2
                irreld_10(a,b) = (irreld_10(a+1,b)+irreld_10(a-1,b))/2
                irreld_30(a,b) = (irreld_30(a+1,b)+irreld_30(a-1,b))/2
            end
        end
    end

    legend_ird = cellstr(num2str(irdSOH', 'SOH = %f'))
    subleg1d = cellstr(num2str(irdSOH', 'at 0.5s and SOH = %f'))
    subleg2d = cellstr(num2str(irdSOH', 'at 10s and SOH = %f'))
    subleg3d = cellstr(num2str(irdSOH', 'at 30s and SOH = %f'))
    legend_ird = vertcat(subleg1d, subleg2d, subleg3d)

    plot(irdSOC, irreld_pt5,'-.d')
    hold on
    plot(irdSOC, irreld_10, '-o')
    hold on
    plot(irdSOC, irreld_30, '-+')
    hold off
    legend(legend_ird, 'Location', 'North')
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Relative internal resistance (divided by AC resistance)')
end