function [ir_SOH, irSOC, ohm_rel, ctk_rel, dif_rel] = ir_ch_cycle_Vito_rel(p)
%% For internal resistance - charging
% correspoinding data above.
    Charge_irtab = readtable(p,'Range','C81:Z140','ReadVariableNames',false);  
    CU = readtable(p,'Range','C11:Z11','ReadVariableNames',false)
    [m,n] = size(CU)
    j=1
    count=1
    for i=1:n
        if ismember(CU{:,i},'ECU') && count<=2
            idx(j) = i
            j=j+1
            count=count+1
        end
    end
    SOHtab = readtable(p,'Range','C10:Z10','ReadVariableNames',false);
    ir_SOH = [SOHtab{:,idx}]
    Charge_ir = [Charge_irtab{:,idx}]
    irSOC = [Charge_ir(1:5:end-4,:)]
    ir_pt5 = [Charge_ir(3:5:end-2,:)]
    ir_10 = [Charge_ir(4:5:end-1,:)]
    ir_30 = [Charge_ir(5:5:end,:)]
    [x,y] = size(irSOC)
    for a=1:x
        for b=1:y
            if (irSOC(a,b)==0 && ir_pt5(a,b)==0 && ir_10(a,b) == 0 && ir_30(a,b) == 0 && a<x && a>1)
                irSOC(a,b) = (irSOC(a+1,b)+irSOC(a-1,b))/2
                ir_pt5(a,b) = (ir_pt5(a+1,b)+ir_pt5(a-1,b))/2
                ir_10(a,b) = (ir_10(a+1,b)+ir_10(a-1,b))/2
                ir_30(a,b) = (ir_30(a+1,b)+ir_30(a-1,b))/2
            elseif (a==x && irSOC(a,b)==0 && ir_pt5(a,b)==0 && ir_10(a,b) == 0 && ir_30(a,b) == 0 )
                irSOC(a,b) = NaN
                ir_pt5(a,b) = NaN
                ir_10(a,b) = NaN
                ir_30(a,b) = NaN 
            end
        end
    end
    ohm = ir_pt5(:,:)
    ctk = ir_10(:,:) - ir_pt5(:,:)
    dif = ir_30(:,:) - ir_10(:,:)
    ohm_rel(:,:) = ohm(:,2)./ohm(:,1)
    ctk_rel(:,:) = ctk(:,2)./ctk(:,1)
    dif_rel(:,:) = dif(:,2)./dif(:,1)
    %{
    subleg1 = cellstr(num2str(ir_SOH', 'at 0.5s and SOH = %f'))
    subleg2 = cellstr(num2str(ir_SOH', 'at 10s and SOH = %f'))
    subleg3 = cellstr(num2str(ir_SOH', 'at 30s and SOH = %f'))
    legend_ir = vertcat(subleg1, subleg2, subleg3)
    
    plot(irSOC, ir_pt5,'-.d')
    hold on
    plot(irSOC, ir_10, '-o')
    hold on
    plot(irSOC, ir_30, '-+')
    hold off
    xlim([0 100])
    legend(legend_ir, 'Location', 'North')
    xlabel('State of charge (%)')
    ylabel('Internal resistance (mOhm)')
    %}
end