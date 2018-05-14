%% For trials: Checking prismatic cell internal resistance chart
clear
clc
figure()
        [ir_SOH1(:,:), irSOC1(:,:), ir_pt51(:,:), ir_101(:,:), ir_301(:,:)] = ir_ch_cycle_Vito('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch0.3C_VITO_Soft\Cycl_T05_Cha0.3C_ VITO_Soft_Cell19.xlsx');
        [ir_SOH2(:,:), irSOC2(:,:), ir_pt52(:,:), ir_102(:,:), ir_302(:,:)] = ir_ch_cycle_Vito('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch0.3C_VITO_Soft\Cycl_T05_Cha0.3C_ VITO_Soft_Cell22.xlsx');
        ir_SOH_av(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av(:,:) = (irSOC1()+ irSOC2())/2
        ir_pt5_av(:,:) = (ir_pt51()+ ir_pt52())/2
        ir_10_av(:,:) = (ir_101()+ ir_102())/2
        ir_30_av(:,:) = (ir_301()+ ir_302())/2
        plot(irSOC_av, ir_pt5_av,'-*')
        hold on
        plot(irSOC_av, ir_10_av, '-<')
        hold on
        plot(irSOC_av, ir_30_av, '-s')
        hold on
        subleg1_prism = strcat(cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_prism = strcat(cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_prism = strcat(cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
        legend_ir_prism = vertcat(subleg1_prism, subleg2_prism, subleg3_prism)
        xlim([0 100])
        ylabel('Internal resistance (mOhm)')
        xlabel('State of Charge (%)')
        legend(legend_ir_prism, 'Location', 'North')


