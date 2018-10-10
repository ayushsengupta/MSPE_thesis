%% This script evaluates the data from different cell geometries based on their ageing
% For this case only two states of life are considered - the Beginning of
% Life (BOL) and Mid of Life (MOL, which is usually >70%).
% All values are averaged out for the same cell conditions of same
% geometry.
clear
clc

%% The Cell Files
% The Cylindrical Cells: Sno. 1 to 4 and values of files 1,2 to be averaged
% out and 3,4 to be averaged out. 
% The Prismatic Cells: Sno. 5 to 8 and values of files 5,6 to be averaged
% out and 7,8 to be averaged out. 
% The Pouch Cells: Sno. 9 to 12 and values of files 9,10 to be averaged
% out and 11,12 to be averaged out. 

% Cylindrical
MyFileInfo1 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T05_Ch0.3C_Cidetec_Cyl');
F1 = strcat(MyFileInfo1(3).folder, "\", MyFileInfo1(3).name)
F2 = strcat(MyFileInfo1(4).folder, "\", MyFileInfo1(4).name) 
MyFileInfo2 = dir('G:\Pikoo\Study\MSPE\MasterThesis\GEN0_Cylindrical_Hard_Casing\Cycle life_Test_result_reports\Cycl_T45_Ch0.3C_CEA_Cyl');
F3 = strcat(MyFileInfo2(5).folder, "\", MyFileInfo2(5).name) 
F4 = strcat(MyFileInfo2(6).folder, "\", MyFileInfo2(6).name)

% Prismatic
MyFileInfo3 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_hard_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch0.3C_Cidetec_Pris');
F5 = strcat(MyFileInfo3(3).folder, "\", MyFileInfo3(3).name)
F6 = strcat(MyFileInfo3(4).folder, "\", MyFileInfo3(4).name) 
MyFileInfo4 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_hard_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T45_Ch0.3C_CEA_Pris');
F7 = strcat(MyFileInfo4(3).folder, "\", MyFileInfo4(3).name) 
F8 = strcat(MyFileInfo4(4).folder, "\", MyFileInfo4(4).name)

% Pouch
MyFileInfo5 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch0.3C_VITO_Soft');
F9 = strcat(MyFileInfo5(7).folder, "\", MyFileInfo5(7).name)
F10 = strcat(MyFileInfo5(8).folder, "\", MyFileInfo5(8).name) 
MyFileInfo6 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T45_Ch0.3C_VITO_Soft');
F11 = strcat(MyFileInfo6(3).folder, "\", MyFileInfo6(3).name) 
F12 = strcat(MyFileInfo6(4).folder, "\", MyFileInfo6(4).name)

Filepath = [F1; F2; F3; F4; F5; F6; F7; F8; F9; F10; F11; F12]
markers = {'+','o','*','<','s','d','x','^','v','>','p','h'}

% Legend
legend_com = ["Cylindrical Cell @ 0.3C, 05 deg C"; "Cylindrical Cell @ 0.3C, 45 deg C"; "Prismatic Cell @ 0.3C, 05 deg C"; "Prismatic Cell @ 0.3C, 45 deg C"; "Pouch Cell @ 0.3C, 05 deg C"; "Pouch Cell @ 0.3C, 45 deg C"]

%% 1. Absolute values of internal resistance for charging and discharging
% This is divided into charging and discharging parts.

%% 1.1. Internal resistance - charging

[j,x]=size(Filepath)

for n=1:(j/2)
    k=n
    if(n==1 || n==3)
        figure()
        [ir_SOH1(:,:), irSOC1(:,:), ir_pt51(:,:), ir_101(:,:), ir_301(:,:)] = ir_ch_cycle_CID(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ir_pt52(:,:), ir_102(:,:), ir_302(:,:)] = ir_ch_cycle_CID(Filepath(2*k-2,:));
        ir_SOH_av(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av(:,:) = (irSOC1()+ irSOC2())/2
        ir_pt5_av(:,:) = (ir_pt51()+ ir_pt52())/2
        ir_10_av(:,:) = (ir_101()+ ir_102())/2
        ir_30_av(:,:) = (ir_301()+ ir_302())/2
        plot(irSOC_av, ir_pt5_av,'-.d')
        hold on
        plot(irSOC_av, ir_10_av, '-o')
        hold on
        plot(irSOC_av, ir_30_av, '-+')
        hold on
        subleg1_cyl = strcat(cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_cyl = strcat(cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_cyl = strcat(cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
        legend_ir_cyl = vertcat(subleg1_cyl, subleg2_cyl, subleg3_cyl)
        xlim([0 100])
        ylabel('Internal resistance (mOhm)')
        xlabel('State of Charge (%)')
        legend(legend_ir_cyl, 'Location', 'North')
        title(strcat(legend_com(n),'  Internal resistance(Charging)'))

    end
    if (n==2 || n==4)
        figure()
        [ir_SOH1(:,:), irSOC1(:,:), ir_pt51(:,:), ir_101(:,:), ir_301(:,:)] = ir_ch_cycle_CEA(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ir_pt52(:,:), ir_102(:,:), ir_302(:,:)] = ir_ch_cycle_CEA(Filepath(2*k-2,:));
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
        title(strcat(legend_com(n),'  Internal resistance (Charging)'))

    end
    if (n==5 || n==6)
        figure()
        [ir_SOH1(:,:), irSOC1(:,:), ir_pt51(:,:), ir_101(:,:), ir_301(:,:)] = ir_ch_cycle_Vito(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ir_pt52(:,:), ir_102(:,:), ir_302(:,:)] = ir_ch_cycle_Vito(Filepath(2*k-2,:));
        ir_SOH_av(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av(:,:) = (irSOC1()+ irSOC2())/2
        ir_pt5_av(:,:) = (ir_pt51()+ ir_pt52())/2
        ir_10_av(:,:) = (ir_101()+ ir_102())/2
        ir_30_av(:,:) = (ir_301()+ ir_302())/2
        plot(irSOC_av, ir_pt5_av,'-.>')
        hold on
        plot(irSOC_av, ir_10_av, '-+')
        hold on
        plot(irSOC_av, ir_30_av, '-h')
        hold on
        subleg1_pouch = strcat(cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_pouch = strcat(cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_pouch = strcat(cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
        legend_ir_pouch = vertcat(subleg1_pouch, subleg2_pouch, subleg3_pouch)
        xlim([0 100])
        ylabel('Internal resistance (mOhm)')
        xlabel('State of Charge (%)')
        legend(legend_ir_pouch, 'Location', 'North')
        title(strcat(legend_com(n),'  Internal resistance (Charging)'))

    end
end

%% 1.2. For Internal resistance: DISCHARGING

[j,x]=size(Filepath)

for n=1:(j/2)
    k=n
    if(n==1 || n==3)
        figure()
        [ir_SOH1(:,:), irSOC1(:,:), ir_pt51(:,:), ir_101(:,:), ir_301(:,:)] = ir_dis_cycle_CID(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ir_pt52(:,:), ir_102(:,:), ir_302(:,:)] = ir_dis_cycle_CID(Filepath(2*k-2,:));
        ir_SOH_av(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av(:,:) = (irSOC1()+ irSOC2())/2
        ir_pt5_av(:,:) = (ir_pt51()+ ir_pt52())/2
        ir_10_av(:,:) = (ir_101()+ ir_102())/2
        ir_30_av(:,:) = (ir_301()+ ir_302())/2
        plot(irSOC_av, ir_pt5_av,'-.d')
        hold on
        plot(irSOC_av, ir_10_av, '-o')
        hold on
        plot(irSOC_av, ir_30_av, '-+')
        hold on
        subleg1_cyl = strcat(cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_cyl = strcat(cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_cyl = strcat(cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
        legend_ir_cyl = vertcat(subleg1_cyl, subleg2_cyl, subleg3_cyl)
        xlim([0 100])
        ylabel('Internal resistance (mOhm)')
        xlabel('State of Charge (%)')
        legend(legend_ir_cyl, 'Location', 'North')
        title(strcat(legend_com(n),'  Internal resistance(Discharging)'))

    end
    if (n==2 || n==4)
        figure()
        [ir_SOH1(:,:), irSOC1(:,:), ir_pt51(:,:), ir_101(:,:), ir_301(:,:)] = ir_dis_cycle_CEA(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ir_pt52(:,:), ir_102(:,:), ir_302(:,:)] = ir_dis_cycle_CEA(Filepath(2*k-2,:));
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
        title(strcat(legend_com(n),'  Internal resistance (Discharging)'))

    end
    if (n==5 || n==6)
        figure()
        [ir_SOH1(:,:), irSOC1(:,:), ir_pt51(:,:), ir_101(:,:), ir_301(:,:)] = ir_dis_cycle_Vito(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ir_pt52(:,:), ir_102(:,:), ir_302(:,:)] = ir_dis_cycle_Vito(Filepath(2*k-2,:));
        ir_SOH_av(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av(:,:) = (irSOC1()+ irSOC2())/2
        ir_pt5_av(:,:) = (ir_pt51()+ ir_pt52())/2
        ir_10_av(:,:) = (ir_101()+ ir_102())/2
        ir_30_av(:,:) = (ir_301()+ ir_302())/2
        plot(irSOC_av, ir_pt5_av,'-.>')
        hold on
        plot(irSOC_av, ir_10_av, '-+')
        hold on
        plot(irSOC_av, ir_30_av, '-h')
        hold on
        subleg1_pouch = strcat(cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_pouch = strcat(cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_pouch = strcat(cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
        legend_ir_pouch = vertcat(subleg1_pouch, subleg2_pouch, subleg3_pouch)
        xlim([0 100])
        ylabel('Internal resistance (mOhm)')
        xlabel('State of Charge (%)')
        legend(legend_ir_pouch, 'Location', 'North')
        title(strcat(legend_com(n),'  Internal resistance (Discharging)'))

    end
end

%% 2. This section and the next plot the incremental increase in internal resistance between two ageing 
% stages: i.e. between the BOL and MOL, as a ratio of their values between
% the two stages. The plots are divided into Charging and Discharging
% plots. And further, each one of those two categories are divided
% according to the instant at which the internal resistances are measured,
% namely three sub-categories: after 0.5s, 10s and 30s.
% VERY IMPORTANT: FOR GETTING CURVES IN THE NEXT TWO SECTIONS, PLEASE
% INITIALISE AGAIN (run the first two sections sepaparately and these two sections)
%
%% 2.1. Internal resistance incremental increase (CHARGING)
% First part is the file parsing and averaging of values for the same
% geometries and cell conditions.
[j,x]=size(Filepath)
for n=1:(j/2)
    k=n
    if(n==1)
        [ir_SOH1(:,:), irSOC1(:,:), ohm_rel51(:,:), ctk_rel51(:,:), dif_rel51(:,:)] = ir_ch_cycle_CID_rel(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ohm_rel52(:,:), ctk_rel52(:,:), dif_rel52(:,:)] = ir_ch_cycle_CID_rel(Filepath(2*k-2,:));
        ir_SOH_av_cyl_5(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av_cyl_5(:,:) = (irSOC1()+ irSOC2())/2
        ohm_cyl_5(:,:) = (ohm_rel51()+ ohm_rel52())/2
        ctk_cyl_5(:,:) = (ctk_rel51()+ ctk_rel52())/2
        dif_cyl_5(:,:) = (dif_rel51()+ dif_rel52())/2
        leg_rel1 = strcat(legend_com(n),cellstr(num2str(ir_SOH_av_cyl_5(1,2)', ', at SOH = %f')))
                
    end
    if (n==2)
        
        [ir_SOH1(:,:), irSOC1(:,:), ohm_rel51(:,:), ctk_rel51(:,:), dif_rel51(:,:)] = ir_ch_cycle_CEA_rel(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ohm_rel52(:,:), ctk_rel52(:,:), dif_rel52(:,:)] = ir_ch_cycle_CEA_rel(Filepath(2*k-2,:));
        ir_SOH_av_cyl_45(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av_cyl_45(:,:) = (irSOC1()+ irSOC2())/2
        ohm_cyl_45(:,:) = (ohm_rel51()+ ohm_rel52())/2
        ctk_cyl_45(:,:) = (ctk_rel51()+ ctk_rel52())/2
        dif_cyl_45(:,:) = (dif_rel51()+ dif_rel52())/2
        leg_rel2 = strcat(legend_com(n),cellstr(num2str(ir_SOH_av_cyl_45(1,2)', ', SOH = %f')))
    end
    if (n==3)
        [ir_SOH1(:,:), irSOC1(:,:), ohm_rel51(:,:), ctk_rel51(:,:), dif_rel51(:,:)] = ir_ch_cycle_CID_rel(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ohm_rel52(:,:), ctk_rel52(:,:), dif_rel52(:,:)] = ir_ch_cycle_CID_rel(Filepath(2*k-2,:));
        ir_SOH_av_prism_5(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av_prism_5(:,:) = (irSOC1()+ irSOC2())/2
        ohm_prism_5(:,:) = (ohm_rel51()+ ohm_rel52())/2
        ctk_prism_5(:,:) = (ctk_rel51()+ ctk_rel52())/2
        dif_prism_5(:,:) = (dif_rel51()+ dif_rel52())/2
        leg_rel3 = strcat(legend_com(n), cellstr(num2str(ir_SOH_av_prism_5(1,2)', ', SOH = %f')))
    end
    if (n==4)
      
        [ir_SOH1(:,:), irSOC1(:,:), ohm_rel51(:,:), ctk_rel51(:,:), dif_rel51(:,:)] = ir_ch_cycle_CEA_rel(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ohm_rel52(:,:), ctk_rel52(:,:), dif_rel52(:,:)] = ir_ch_cycle_CEA_rel(Filepath(2*k-2,:));
        ir_SOH_av_prism_45(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av_prism_45(:,:) = (irSOC1()+ irSOC2())/2
        ohm_prism_45(:,:) = (ohm_rel51()+ ohm_rel52())/2
        ctk_prism_45(:,:) = (ctk_rel51()+ ctk_rel52())/2
        dif_prism_45(:,:) = (dif_rel51()+ dif_rel52())/2
        leg_rel4 = strcat(legend_com(n), cellstr(num2str(ir_SOH_av_prism_45(1,2)', ', SOH = %f')))
    end
    if (n==5)
        
        [ir_SOH1(:,:), irSOC1(:,:), ohm_rel51(:,:), ctk_rel51(:,:), dif_rel51(:,:)] = ir_ch_cycle_Vito_rel(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ohm_rel52(:,:), ctk_rel52(:,:), dif_rel52(:,:)] = ir_ch_cycle_Vito_rel(Filepath(2*k-2,:));
        ir_SOH_av_pouch_5(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av_pouch_5(:,:) = (irSOC1()+ irSOC2())/2
        ohm_pouch_5(:,:) = (ohm_rel51()+ ohm_rel52())/2
        ctk_pouch_5(:,:) = (ctk_rel51()+ ctk_rel52())/2
        dif_pouch_5(:,:) = (dif_rel51()+ dif_rel52())/2
        leg_rel5 = strcat(legend_com(n),cellstr(num2str(ir_SOH_av_pouch_5(1,2)', ', SOH = %f')))

    end
    if (n==6)
        
        [ir_SOH1(:,:), irSOC1(:,:), ohm_rel51(:,:), ctk_rel51(:,:), dif_rel51(:,:)] = ir_ch_cycle_Vito_rel(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH2(:,:), irSOC2(:,:), ohm_rel51(:,:), ctk_rel51(:,:), dif_rel51(:,:)] = ir_ch_cycle_Vito_rel(Filepath(2*k-2,:));
        ir_SOH_av_pouch_45(:,:) = (ir_SOH1()+ ir_SOH2())/2
        irSOC_av_pouch_45(:,:) = (irSOC1()+ irSOC2())/2
        ohm_pouch_45(:,:) = (ohm_rel51()+ ohm_rel52())/2
        ctk_pouch_45(:,:) = (ctk_rel51()+ ctk_rel52())/2
        dif_pouch_45(:,:) = (dif_rel51()+ dif_rel52())/2
        leg_rel6 = strcat(legend_com(n),cellstr(num2str(ir_SOH_av_pouch_45(1,2)', ', SOH = %f')))

    end
end    
    legrel= vertcat(leg_rel1, leg_rel2, leg_rel3, leg_rel4, leg_rel5, leg_rel6)
    legrel_l = {'Cylindrical at 5°C'; 'Cylindrical at 45°C'; 'Prismatic at 5°C'; 'Prismatic at 45°C'; 'Pouch at 5°C'; 'Pouch at 45°C'}
    % for the 0.5s instant
    fig = figure;
    figure()
    subplot(1,3,1)
    plot(irSOC_av_cyl_5(:,2), ohm_cyl_5, 'r-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_cyl_45(:,2), ohm_cyl_45, 'r-o', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_prism_5(:,2), ohm_prism_5, 'g-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_prism_45(:,2), ohm_prism_45, 'g-o', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_pouch_5(:,2), ohm_pouch_5, 'k-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_pouch_45(:,2), ohm_pouch_45, 'k-o', 'LineWidth', 1.5)
    xlim([0 100])
    ylim([0 3.5])
    set(gca,'fontsize',18)
    xlabel('State of Charge (%)', 'FontName', 'Arial', 'FontSize', 18)
    ylabel('IRR for 30s charge pulse', 'FontName', 'Arial', 'FontSize', 18)
    title('Ohmic resistance', 'FontName', 'Arial', 'FontSize', 18)
    hold off
% for the 10s instant
    %figure()
    subplot(1,3,2)
    plot(irSOC_av_cyl_5(:,2), ctk_cyl_5, 'r-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_cyl_45(:,2), ctk_cyl_45, 'r-o', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_prism_5(:,2), ctk_prism_5, 'g-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_prism_45(:,2), ctk_prism_45, 'g-o', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_pouch_5(:,2), ctk_pouch_5, 'k-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_pouch_45(:,2), ctk_pouch_45, 'k-o', 'LineWidth', 1.5)
    xlim([0 100])
    ylim([0 3.5])
    set(gca,'fontsize',18)
    xlabel('State of Charge (%)', 'FontName', 'Arial', 'FontSize', 18)
    legend(legrel_l, 'Location', 'North', 'FontName', 'Arial', 'FontSize', 18)
    title('Charge transfer kinetic', 'FontName', 'Arial', 'FontSize', 18)
    hold off
    
    % for the 30s instant
    %figure()
    subplot(1,3,3)
    plot(irSOC_av_cyl_5(:,2), dif_cyl_5, 'r-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_cyl_45(:,2), dif_cyl_45, 'r-o', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_prism_5(:,2), dif_prism_5, 'g-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_prism_45(:,2), dif_prism_45, 'g-o', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_pouch_5(:,2), dif_pouch_5, 'k-.+', 'LineWidth', 1.5)
    hold on
    plot(irSOC_av_pouch_45(:,2), dif_pouch_45, 'k-o', 'LineWidth', 1.5)
    title("Diffusion", 'FontName', 'Arial', 'FontSize', 22)
    xlim([0 100])
    ylim([0 3.5])
    set(gca,'fontsize',18)
    xlabel('State of Charge (%)', 'FontName', 'Arial', 'FontSize', 18)
    hold off
    %orient(fig,'landscape')
    %print(fig,'LandscapePage.pdf','-dpdf')
    %print(fig, '-dbitmap','G:\Pikoo\Study\MSPE\MasterThesis\MSPE_thesis\Matlab_files\Cycle_Tests\Gen0_common_files\Chap2\IRR_charge_res_sep1.bmp','PaperSize',[ 8.2677 11.6929 ])

%% 2.2. Internal resistance incremental increase (DISCHARGING)
% First part is the file parsing and averaging of values for the same
% geometries and cell conditions.
[j,x]=size(Filepath)
for n=1:(j/2)
    k=n
    if(n==1)
        [ird_SOH1(:,:), irdSOC1(:,:), ohmd_rel51(:,:), ctkd_rel51(:,:), difd_rel51(:,:)] = ir_dis_cycle_CID_rel(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH2(:,:), irdSOC2(:,:), ohmd_rel52(:,:), ctkd_rel52(:,:), difd_rel52(:,:)] = ir_dis_cycle_CID_rel(Filepath(2*k-2,:));
        ird_SOH_av_cyl_5(:,:) = (ird_SOH1()+ ird_SOH2())/2
        irdSOC_av_cyl_5(:,:) = (irdSOC1()+ irdSOC2())/2
        ohmd_cyl_5(:,:) = (ohm_rel51()+ ohm_rel52())/2
        ctkd_cyl_5(:,:) = (ctk_rel51()+ ctk_rel52())/2
        difd_cyl_5(:,:) = (difd_rel51()+ difd_rel52())/2
        legd_rel1 = strcat(legend_com(n),cellstr(num2str(ird_SOH_av_cyl_5(1,2)', ', increment at SOH = %f')))
                
    end
    if (n==2)
        
        [ird_SOH1(:,:), irdSOC1(:,:), ohmd_rel51(:,:), ctkd_rel51(:,:), difd_rel51(:,:)] = ir_dis_cycle_CEA_rel(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH2(:,:), irdSOC2(:,:), ohmd_rel52(:,:), ctkd_rel52(:,:), difd_rel52(:,:)] = ir_dis_cycle_CEA_rel(Filepath(2*k-2,:));
        ird_SOH_av_cyl_45(:,:) = (ird_SOH1()+ ird_SOH2())/2
        irdSOC_av_cyl_45(:,:) = (irdSOC1()+ irdSOC2())/2
        ohmd_cyl_45(:,:) = (ohmd_rel51()+ ohmd_rel52())/2
        ctkd_cyl_45(:,:) = (ctkd_rel51()+ ctkd_rel52())/2
        difd_cyl_45(:,:) = (difd_rel51()+ difd_rel52())/2
        legd_rel2 = strcat(legend_com(n),cellstr(num2str(ird_SOH_av_cyl_45(1,2)', ', increment at SOH = %f')))
    end
    if (n==3)
        [ird_SOH1(:,:), irdSOC1(:,:), ohmd_rel51(:,:), ctkd_rel51(:,:), difd_rel51(:,:)] = ir_dis_cycle_CID_rel(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH2(:,:), irdSOC2(:,:), ohmd_rel52(:,:), ctkd_rel52(:,:), difd_rel52(:,:)] = ir_dis_cycle_CID_rel(Filepath(2*k-2,:));
        ird_SOH_av_prism_5(:,:) = (ird_SOH1()+ ird_SOH2())/2
        irdSOC_av_prism_5(:,:) = (irdSOC1()+ irdSOC2())/2
        ohmd_prism_5(:,:) = (ohmd_rel51()+ ohmd_rel52())/2
        ctkd_prism_5(:,:) = (ctkd_rel51()+ ctkd_rel52())/2
        difd_prism_5(:,:) = (difd_rel51()+ difd_rel52())/2
        legd_rel3 = strcat(legend_com(n), cellstr(num2str(ird_SOH_av_prism_5(1,2)', ', increment at SOH = %f')))
    end
    if (n==4)
      
        [ird_SOH1(:,:), irdSOC1(:,:), ohmd_rel51(:,:), ctkd_rel51(:,:), difd_rel51(:,:)] = ir_dis_cycle_CEA_rel(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH2(:,:), irdSOC2(:,:), ohmd_rel52(:,:), ctkd_rel52(:,:), difd_rel52(:,:)] = ir_dis_cycle_CEA_rel(Filepath(2*k-2,:));
        ird_SOH_av_prism_45(:,:) = (ird_SOH1()+ ird_SOH2())/2
        irdSOC_av_prism_45(:,:) = (irdSOC1()+ irdSOC2())/2
        ohmd_prism_45(:,:) = (ohmd_rel51()+ ohmd_rel52())/2
        ctkd_prism_45(:,:) = (ctkd_rel51()+ ctkd_rel52())/2
        difd_prism_45(:,:) = (difd_rel51()+ difd_rel52())/2
        legd_rel4 = strcat(legend_com(n), cellstr(num2str(ird_SOH_av_prism_45(1,2)', ', increment at SOH = %f')))
    end
    if (n==5)
        
        [ird_SOH1(:,:), irdSOC1(:,:), ohmd_rel51(:,:), ctkd_rel51(:,:), difd_rel51(:,:)] = ir_dis_cycle_Vito_rel(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH2(:,:), irdSOC2(:,:), ohmd_rel52(:,:), ctkd_rel52(:,:), difd_rel52(:,:)] = ir_dis_cycle_Vito_rel(Filepath(2*k-2,:));
        ird_SOH_av_pouch_5(:,:) = (ird_SOH1()+ ird_SOH2())/2
        irdSOC_av_pouch_5(:,:) = (irdSOC1()+ irdSOC2())/2
        ohmd_pouch_5(:,:) = (ohmd_rel51()+ ohmd_rel52())/2
        ctkd_pouch_5(:,:) = (ctkd_rel51()+ ctkd_rel52())/2
        difd_pouch_5(:,:) = (difd_rel51()+ difd_rel52())/2
        legd_rel5 = strcat(legend_com(n),cellstr(num2str(ird_SOH_av_pouch_5(1,2)', ', increment at SOH = %f')))

    end
    if (n==6)
        
        [ird_SOH1(:,:), irdSOC1(:,:), ohmd_rel51(:,:), ctkd_rel51(:,:), difd_rel51(:,:)] = ir_dis_cycle_Vito_rel(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH2(:,:), irdSOC2(:,:), ohmd_rel52(:,:), ctkd_rel52(:,:), difd_rel52(:,:)] = ir_dis_cycle_Vito_rel(Filepath(2*k-2,:));
        ird_SOH_av_pouch_45(:,:) = (ird_SOH1()+ ird_SOH2())/2
        irdSOC_av_pouch_45(:,:) = (irdSOC1()+ irdSOC2())/2
        ohmd_pouch_45(:,:) = (ohmd_rel51()+ ohmd_rel52())/2
        ctkd_pouch_45(:,:) = (ctkd_rel51()+ ctkd_rel52())/2
        difd_pouch_45(:,:) = (difd_rel51()+ difd_rel52())/2
        legd_rel6 = strcat(legend_com(n),cellstr(num2str(ird_SOH_av_pouch_45(1,2)', ', increment at SOH = %f')))

    end
end    
    legreld= vertcat(legd_rel1, legd_rel2, legd_rel3, legd_rel4, legd_rel5, legd_rel6)
    
    % for the 0.5s instant
    figure()
    subplot(1,3,1)
    plot(irdSOC_av_cyl_5(:,2), ohmd_cyl_5, 'r-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_cyl_45(:,2), ohmd_cyl_45, 'r-o', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_prism_5(:,2), ohmd_prism_5, 'g-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_prism_45(:,2), ohmd_prism_45, 'g-o', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_pouch_5(:,2), ohmd_pouch_5, 'k-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_pouch_45(:,2), ohmd_pouch_45, 'k-o', 'LineWidth', 1.5)
    xlim([0 100])
    ylim([0 2])
    set(gca,'fontsize',18)
    xlabel('State of Charge (%)', 'FontName', 'Arial', 'FontSize', 18)
    ylabel('IRR for 30s discharge pulse','FontName', 'Arial', 'FontSize', 18)
    title('Ohmic')

% for the 10s instant
    %figure()
    subplot(1,3,2)
    plot(irdSOC_av_cyl_5(:,2), ctkd_cyl_5, 'r-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_cyl_45(:,2), ctkd_cyl_45, 'r-o', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_prism_5(:,2), ctkd_prism_5, 'g-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_prism_45(:,2), ctkd_prism_45, 'g-o', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_pouch_5(:,2), ctkd_pouch_5, 'k-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_pouch_45(:,2), ctkd_pouch_45, 'k-o', 'LineWidth', 1.5)
    xlim([0 100])
    ylim([0 2])
    set(gca,'fontsize',18)
    legend(legrel_l, 'Location', 'North','FontName', 'Arial', 'FontSize', 18)
    xlabel('State of Charge (%)','FontName', 'Arial', 'FontSize', 18)
    title('Charge transfer kinetic','FontName', 'Arial', 'FontSize', 18)

    % for the 30s instant
    %figure()
    subplot(1,3,3)
    plot(irdSOC_av_cyl_5(:,2), difd_cyl_5, 'r-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_cyl_45(:,2), difd_cyl_45, 'r-o', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_prism_5(:,2), difd_prism_5, 'g-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_prism_45(:,2), difd_prism_45, 'g-o', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_pouch_5(:,2), difd_pouch_5, 'k-.+', 'LineWidth', 1.5)
    hold on
    plot(irdSOC_av_pouch_45(:,2), difd_pouch_45, 'k-o', 'LineWidth', 1.5)
    xlim([0 100])
    ylim([0 2])
    set(gca,'fontsize',18)
    xlabel('State of Charge (%)','FontName', 'Arial', 'FontSize', 18)
    title('Diffusion','FontName', 'Arial', 'FontSize', 18)
