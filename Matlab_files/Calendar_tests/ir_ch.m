function ir_ch(p)
    %% For internal resistance - charging
% IMPORTANT: Cell no. C127 (in excel sheet) value changed from 0 to the
% correspoinding data above.
    Charge_irtab = readtable(p,'Range','C77:L137');  
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
    irSOH = [SOHtab{:,idx}]
    Charge_ir = [Charge_irtab{:,idx}]
    irSOC = [Charge_ir(1:5:end-4,:)]
    ir_pt5 = [Charge_ir(3:5:end-2,:)]
    ir_10 = [Charge_ir(4:5:end-1,:)]
    ir_30 = [Charge_ir(5:5:end,:)]

    subleg1 = cellstr(num2str(irSOH', 'at 0.5s and SOH = %f'))
    subleg2 = cellstr(num2str(irSOH', 'at 10s and SOH = %f'))
    subleg3 = cellstr(num2str(irSOH', 'at 30s and SOH = %f'))
    legend_ir = vertcat(subleg1, subleg2, subleg3)
    
    plot(irSOC, ir_pt5,'-.d')
    hold on
    plot(irSOC, ir_10, '-o')
    hold on
    plot(irSOC, ir_30)
    hold off
    legend(legend_ir)
    xlabel('State of charge (%)')
    ylabel('Internal resistance (mOhm)')
    
end