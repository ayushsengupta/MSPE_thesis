function irrel_ch_cycle_CID(p, g)
%% For internal resistance - charging
% correspoinding data above.
    Charge_irtab = readtable(p,'Range','C82:Z141','ReadVariableNames',false);  
    CU = readtable(p,'Range','C1:Z1','ReadVariableNames',false)
    [m,n] = size(CU)
    j=1
    for i=1:n
        if ismember(CU{:,i},'ECU')
            idx(j) = i
            j=j+1
        end
    end
    SOHtab = readtable(p,'Range','C8:Z8','ReadVariableNames',false);
    irSOH = [SOHtab{:,idx}]
    Charge_ir = [Charge_irtab{:,idx}]
    % The internal resistance values in the table have the wrong units,
    % multiplying the vslues with 1000 to convert the values from Ohm to
    % mOhm
    irSOC = [Charge_ir(1:5:end-4,:)]
    irrel_pt5 = [1000*Charge_ir(3:5:end-2,:)/g]
    irrel_10 = [1000*Charge_ir(4:5:end-1,:)/g]
    irrel_30 = [1000*Charge_ir(5:5:end,:)/g]
    [x,y] = size(irSOC)
    for a=1:x
        for b=1:y
            if (irSOC(a,b)==0 && irrel_pt5(a,b)==0 && irrel_10(a,b) == 0 && irrel_30(a,b) == 0 && a<x && a>1)
                irSOC(a,b) = (irSOC(a+1,b)+irSOC(a-1,b))/2
                irrel_pt5(a,b) = (irrel_pt5(a+1,b)+irrel_pt5(a-1,b))/2
                irrel_10(a,b) = (irrel_10(a+1,b)+irrel_10(a-1,b))/2
                irrel_30(a,b) = (irrel_30(a+1,b)+irrel_30(a-1,b))/2
            elseif (a==x && irSOC(a,b)==0 && irrel_pt5(a,b)==0 && irrel_10(a,b) == 0 && irrel_30(a,b) == 0 )
                irSOC(a,b) = NaN
                irrel_pt5(a,b) = NaN
                irrel_10(a,b) = NaN
                irrel_30(a,b) = NaN
            end
        end
    end
    subleg1 = cellstr(num2str(irSOH', 'at 0.5s and SOH = %f'))
    subleg2 = cellstr(num2str(irSOH', 'at 10s and SOH = %f'))
    subleg3 = cellstr(num2str(irSOH', 'at 30s and SOH = %f'))
    legend_ir = vertcat(subleg1, subleg2, subleg3)
    
    plot(irSOC, irrel_pt5,'-.d')
    hold on
    plot(irSOC, irrel_10, '-o')
    hold on
    plot(irSOC, irrel_30, '-+')
    hold off
    legend(legend_ir, 'Location', 'North')
    xlim([0 100])
    xlabel('State of charge (%)')
    ylabel('Relative Internal resistance (divided by AC resistance)')
    
end