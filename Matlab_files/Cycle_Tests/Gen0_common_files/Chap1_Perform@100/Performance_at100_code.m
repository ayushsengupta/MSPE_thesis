%% Curves for the Performance at 100% analysis

% Here all the cylindrical, prismatic and pouch cells are taken together.
% The values cells from similar test condition and same geometry are
% averaged out. The cell references are given in comments for better
% understanding.  
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

% More cylindrical

MyFileInfo7 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Cylindrical_hard_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch2C_Cidetec_Cyl');
F13 = strcat(MyFileInfo7(5).folder, "\", MyFileInfo7(5).name) 
F14 = strcat(MyFileInfo7(8).folder, "\", MyFileInfo7(8).name)

MyFileInfo8 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Cylindrical_hard_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T25_Ch2C_CEA_Cyl');
F15 = strcat(MyFileInfo8(5).folder, "\", MyFileInfo8(5).name) 
F16 = strcat(MyFileInfo8(7).folder, "\", MyFileInfo8(7).name)

MyFileInfo9 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Cylindrical_hard_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T45_Ch2C_CEA_Cyl');
F17 = strcat(MyFileInfo9(5).folder, "\", MyFileInfo9(5).name) 
F18 = strcat(MyFileInfo9(8).folder, "\", MyFileInfo9(8).name)

% More Prismatic

MyFileInfo10 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_hard_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch2C_Cidetec_Pris');
F19 = strcat(MyFileInfo10(5).folder, "\", MyFileInfo10(5).name) 
F20 = strcat(MyFileInfo10(8).folder, "\", MyFileInfo10(8).name)

MyFileInfo11 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_hard_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T25_Ch2C_CEA_Pris');
F21 = strcat(MyFileInfo11(3).folder, "\", MyFileInfo11(3).name) 
F22 = strcat(MyFileInfo11(4).folder, "\", MyFileInfo11(4).name)

MyFileInfo12 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_hard_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T45_Ch2C_CEA_Pris');
F23 = strcat(MyFileInfo12(3).folder, "\", MyFileInfo12(3).name) 
F24 = strcat(MyFileInfo12(4).folder, "\", MyFileInfo12(4).name)

% More Pouch

MyFileInfo13 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch2C_VITO_Soft');
F25 = strcat(MyFileInfo13(3).folder, "\", MyFileInfo13(3).name) 

MyFileInfo14 = dir('G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T25_Ch2C_VITO_Soft');
F26 = strcat(MyFileInfo14(4).folder, "\", MyFileInfo14(4).name) 
F27 = strcat(MyFileInfo14(5).folder, "\", MyFileInfo14(5).name)


Filepath = [F1; F2; F3; F4; F5; F6; F7; F8; F9; F10; F11; F12]
Filepath_ecn = [F1; F2; F5; F6; F9; F10; F13; F14; F15; F16; F17; F18; F19; F20; F21; F22; F23; F24; F25; F26; F27]
markers = {'+','o','*','<','s','d','x','^','v','>','p','h'}
% Legend
legend_com = ["Cylindrical Cell @ 0.3C, 05 deg C"; "Cylindrical Cell @ 0.3C, 45 deg C"; "Prismatic Cell @ 0.3C, 05 deg C"; "Prismatic Cell @ 0.3C, 45 deg C"; "Pouch Cell @ 0.3C, 05 deg C"; "Pouch Cell @ 0.3C, 45 deg C"]

%% Capacity evolution tests (SoH vs Equivalent cycle number)
% The file Filepath_ecn will be used. The curve will be of the 2x2 form,
% divided into the follows:
% 5 deg C, 0.3C --> Cyl (F1,2), Prism (F5,6), Pouch (F9,10)
% 5 deg C, 2C --> Cyl (F13,14), Prism (F19,20), Pouch (F25)
% 25 deg C, 2C--> Cyl (F15,16), Prism (F21,22), Pouch (F26,27)
% 45 deg C, 0.3C--> Cyl (F3,4), Prism (F7,8), Pouch (F11,12) 

figure()
subplot(2,2,1)
% The 5 deg C, 0.3 C curves : Cyl (F1,2), Prism (F5,6), Pouch (F9,10)
% cylindrical part
[SoH_cyl(1,:),Ecn_cyl(1,:)] = age_cycle_cyl(F1);
[SoH_cyl(2,:),Ecn_cyl(2,:)] = age_cycle_cyl(F2);
SoH_avg_cyl_5pt3(1,:) = (SoH_cyl(1,:)+SoH_cyl(2,:))/2
Ecn_avg_cyl_5pt3(1,:) = (Ecn_cyl(1,:)+Ecn_cyl(2,:))/2
plot(Ecn_avg_cyl_5pt3, SoH_avg_cyl_5pt3, 'r-+')
hold on

% Prismatic part
[SoH_prism(1,:),Ecn_prism(1,:)] = age_cycle_prism(F5);
[SoH_prism(2,:),Ecn_prism(2,:)] = age_cycle_prism(F6);
SoH_avg_prism_5pt3 = (SoH_prism(1,:)+SoH_prism(2,:))/2
Ecn_avg_prism_5pt3 = (Ecn_prism(1,:)+Ecn_prism(2,:))/2
plot(Ecn_avg_prism_5pt3, SoH_avg_prism_5pt3, 'g-s')
            
% Pouch part
[SoH_pouch(1,:), Ecn_pouch(1,:)] = age_cycle_pouch(F9);
[SoH_pouch(2,:), Ecn_pouch(2,:)] = age_cycle_pouch(F10);
SoH_avg_pouch_5pt3(1,:) = (SoH_pouch(1,:)+SoH_pouch(2,:))/2
Ecn_avg_pouch_5pt3(1,:) = (Ecn_pouch(1,:)+Ecn_pouch(2,:))/2
plot(Ecn_avg_pouch_5pt3, SoH_avg_pouch_5pt3, 'k-.x')
            
ylim([0 100])
xlabel('Equivalent full cycle (EFC)')
ylabel('State of Health (%)')
legend('Cylindrical', 'Prismatic', 'Pouch', 'Location', 'SouthWest')
title('Ageing at 5 degC and 0.3C')

subplot(2,2,2)
% The 5 deg C, 2 C curves : Cyl (F13,14), Prism (F19,20), Pouch (F25)
% cylindrical part
[SoH_cyl(1,:),Ecn_cyl(1,:)] = age_cycle_cyl(F13);
[SoH_cyl(2,:),Ecn_cyl(2,:)] = age_cycle_cyl(F14);
SoH_avg_cyl_5_2(1,:) = (SoH_cyl(1,:)+SoH_cyl(2,:))/2
Ecn_avg_cyl_5_2(1,:) = (Ecn_cyl(1,:)+Ecn_cyl(2,:))/2
plot(Ecn_avg_cyl_5_2, SoH_avg_cyl_5_2, 'r-+')
hold on

% Prismatic part
[SoH_prism(1,:),Ecn_prism(1,:)] = age_cycle_prism(F19);
[SoH_prism(2,:),Ecn_prism(2,:)] = age_cycle_prism(F20);
SoH_avg_prism_5_2 = (SoH_prism(1,:)+SoH_prism(2,:))/2
Ecn_avg_prism_5_2 = (Ecn_prism(1,:)+Ecn_prism(2,:))/2
plot(Ecn_avg_prism_5_2, SoH_avg_prism_5_2, 'g-s')
            
% Pouch part
[SoH_pouch_5_2(1,:), Ecn_pouch_5_2(1,:)] = age_cycle_pouch(F25);
plot(Ecn_pouch_5_2, SoH_pouch_5_2, 'k-.x')
            
ylim([0 100])
xlabel('Equivalent full cycle (EFC)')
ylabel('State of Health (%)')
legend('Cylindrical', 'Prismatic', 'Pouch', 'Location', 'SouthWest')
title('Ageing at 5 degC and 2C')

subplot(2,2,3)
% The 25 deg C, 2 C curves: Cyl (F15,16), Prism (F21,22), Pouch (F26,27)
% cylindrical part
[SoH_cyl(1,:),Ecn_cyl(1,:)] = age_cycle_cyl(F15);
[SoH_cyl(2,:),Ecn_cyl(2,:)] = age_cycle_cyl(F16);
SoH_avg_cyl_25_2(1,:) = (SoH_cyl(1,:)+SoH_cyl(2,:))/2
Ecn_avg_cyl_25_2(1,:) = (Ecn_cyl(1,:)+Ecn_cyl(2,:))/2
plot(Ecn_avg_cyl_25_2, SoH_avg_cyl_25_2, 'r-+')
hold on

% Prismatic part
% Here it was found that there were some errors in File F22, so only File
% F21 is used
[SoH_prism_25_2(1,:),Ecn_prism_25_2(1,:)] = age_cycle_prism(F21);
plot(Ecn_prism_25_2, SoH_prism_25_2, 'g-s')
            
% Pouch part
Data = readtable(F26,'Range','B5:Z11','ReadRowNames',true);  
Ecn_pouch(1,:) = Data{'Equivalent cycle number',:}
SoH_pouch(1,:) = Data{'SoH',:}
Data = readtable(F27,'Range','B5:Z11','ReadRowNames',true);  
Ecn_pouch(2,:) = Data{'Equivalent cycle number',:}
SoH_pouch(2,:) = Data{'SoH',:}

SoH_avg_pouch_25_2(1,:) = (SoH_pouch(1,:)+SoH_pouch(2,:))/2
Ecn_avg_pouch_25_2(1,:) = (Ecn_pouch(1,:)+Ecn_pouch(2,:))/2
plot(Ecn_avg_pouch_25_2, SoH_avg_pouch_25_2, 'k-.x')
            
ylim([0 100])
xlabel('Equivalent full cycle (EFC)')
ylabel('State of Health (%)')
legend('Cylindrical', 'Prismatic', 'Pouch', 'Location', 'SouthWest')
title('Ageing at 25 degC and 2C')

subplot(2,2,4)
% The 45 deg C, 2C curves: Cyl (F17,18), Prism (F23,24)
% cylindrical part
[SoH_cyl(1,:),Ecn_cyl(1,:)] = age_cycle_cyl(F3);
[SoH_cyl(2,:),Ecn_cyl(2,:)] = age_cycle_cyl(F4);
SoH_avg_cyl_45pt3(1,:) = (SoH_cyl(1,:)+SoH_cyl(2,:))/2
Ecn_avg_cyl_45pt3(1,:) = (Ecn_cyl(1,:)+Ecn_cyl(2,:))/2
plot(Ecn_avg_cyl_45pt3, SoH_avg_cyl_45pt3, 'r-+')
hold on

% Prismatic part
[SoH_prism(1,:),Ecn_prism(1,:)] = age_cycle_prism(F7);
[SoH_prism(2,:),Ecn_prism(2,:)] = age_cycle_prism(F8);
SoH_avg_prism_45pt3 = (SoH_prism(1,:)+SoH_prism(2,:))/2
Ecn_avg_prism_45pt3 = (Ecn_prism(1,:)+Ecn_prism(2,:))/2
plot(Ecn_avg_prism_45pt3, SoH_avg_prism_45pt3, 'g-s')

[SoH_pouch(1,:), Ecn_pouch(1,:)] = age_cycle_pouch(F11);
[SoH_pouch(2,:), Ecn_pouch(2,:)] = age_cycle_pouch(F12);
SoH_avg_pouch_45pt3(1,:) = (SoH_pouch(1,:)+SoH_pouch(2,:))/2
Ecn_avg_pouch_45pt3(1,:) = (Ecn_pouch(1,:)+Ecn_pouch(2,:))/2
plot(Ecn_avg_pouch_45pt3, SoH_avg_pouch_45pt3, 'k-.x')

ylim([0 100])
xlabel('Equivalent full cycle (EFC)')
ylabel('State of Health (%)')
legend('Cylindrical', 'Prismatic','Pouch','Location', 'SouthWest')
title('Ageing at 45 degC and 0.3C')

%% Internal resistance (charging) for 100% SOH
% Includes following two sections: Low Temp and High Temp
%% For low temp files (5 deg C)
[j,x]=size(Filepath)
figure()
for n=1:(j/2)
    k=n
    if(n==1)
        [ir_SOH(1,:), irSOC(1,:), ir_pt5(1,:), ir_10(1,:), ir_30(1,:)] = ir_ch_cycle_cyl_CID_100(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH(2,:), irSOC(2,:), ir_pt5(2,:), ir_10(2,:), ir_30(2,:)] = ir_ch_cycle_cyl_CID_100(Filepath(2*k-2,:));
        ir_SOH_av(1,:) = (ir_SOH(1,:)+ ir_SOH(2,:))/2
        irSOC_av(1,:) = (irSOC(1,:)+ irSOC(2,:))/2
        ir_pt5_av(1,:) = (ir_pt5(1,:)+ ir_pt5(2,:))/2
        ir_10_av(1,:) = (ir_10(1,:)+ ir_10(2,:))/2
        ir_30_av(1,:) = (ir_30(1,:)+ ir_30(2,:))/2
        plot(irSOC_av, ir_pt5_av,'r-.d')
        hold on
        plot(irSOC_av, ir_10_av, 'r-o')
        hold on
        plot(irSOC_av, ir_30_av, 'r-+')
        hold on
        subleg1_cyl = strcat('Cylindrical, ', cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_cyl = strcat('Cylindrical, ', cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_cyl = strcat('Cylindrical, ', cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
    end
    if (n==3)
        [ir_SOH(1,:), irSOC(1,:), ir_pt5(1,:), ir_10(1,:), ir_30(1,:)] = ir_ch_cycle_prism_CID_100(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH(2,:), irSOC(2,:), ir_pt5(2,:), ir_10(2,:), ir_30(2,:)] = ir_ch_cycle_prism_CID_100(Filepath(2*k-2,:));
        ir_SOH_av(1,:) = (ir_SOH(1,:)+ ir_SOH(2,:))/2
        irSOC_av(1,:) = (irSOC(1,:)+ irSOC(2,:))/2
        ir_pt5_av(1,:) = (ir_pt5(1,:)+ ir_pt5(2,:))/2
        ir_10_av(1,:) = (ir_10(1,:)+ ir_10(2,:))/2
        ir_30_av(1,:) = (ir_30(1,:)+ ir_30(2,:))/2
        plot(irSOC_av, ir_pt5_av,'g-*')
        hold on
        plot(irSOC_av, ir_10_av, 'g-<')
        hold on
        plot(irSOC_av, ir_30_av, 'g-s')
        hold on
        subleg1_prism = strcat('Prismatic, ', cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_prism = strcat('Prismatic, ', cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_prism = strcat('Prismatic, ', cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
    end
    if (n==5)
        [ir_SOH(1,:), irSOC(1,:), ir_pt5(1,:), ir_10(1,:), ir_30(1,:)] = ir_ch_cycle_Vito_100(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH(2,:), irSOC(2,:), ir_pt5(2,:), ir_10(2,:), ir_30(2,:)] = ir_ch_cycle_Vito_100(Filepath(2*k-2,:));
        ir_SOH_av(1,:) = (ir_SOH(1,:)+ ir_SOH(2,:))/2
        irSOC_av(1,:) = (irSOC(1,:)+ irSOC(2,:))/2
        ir_pt5_av(1,:) = (ir_pt5(1,:)+ ir_pt5(2,:))/2
        ir_10_av(1,:) = (ir_10(1,:)+ ir_10(2,:))/2
        ir_30_av(1,:) = (ir_30(1,:)+ ir_30(2,:))/2
        plot(irSOC_av, ir_pt5_av,'k-.>')
        hold on
        plot(irSOC_av, ir_10_av, 'k-.x')
        hold on
        plot(irSOC_av, ir_30_av, 'k-h')
        hold on
        subleg1_pouch = strcat('Pouch, ', cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_pouch = strcat('Pouch, ', cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_pouch = strcat('Pouch, ', cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
    end
end
hold off
legend_ir_100 = vertcat(subleg1_cyl, subleg2_cyl, subleg3_cyl, subleg1_prism, subleg2_prism, subleg3_prism, subleg1_pouch, subleg2_pouch, subleg3_pouch)
xlim([0 100])
ylabel('Internal resistance (mOhm)')
xlabel('State of Charge (%)')
legend(legend_ir_100, 'Location', 'North')
title('Internal resistance at 100% SOH for cells at 0.3C and 5 deg C (Charging, all geometries)')

%% For high temp files (45 deg C)
[j,x]=size(Filepath)
figure()
for n=1:(j/2)
    k=n
    if(n==2)
        [ir_SOH(1,:), irSOC(1,:), ir_pt5(1,:), ir_10(1,:), ir_30(1,:)] = ir_ch_cycle_CEA_100(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH(2,:), irSOC(2,:), ir_pt5(2,:), ir_10(2,:), ir_30(2,:)] = ir_ch_cycle_CEA_100(Filepath(2*k-2,:));
        ir_SOH_av(1,:) = (ir_SOH(1,:)+ ir_SOH(2,:))/2
        irSOC_av(1,:) = (irSOC(1,:)+ irSOC(2,:))/2
        ir_pt5_av(1,:) = (ir_pt5(1,:)+ ir_pt5(2,:))/2
        ir_10_av(1,:) = (ir_10(1,:)+ ir_10(2,:))/2
        ir_30_av(1,:) = (ir_30(1,:)+ ir_30(2,:))/2
        plot(irSOC_av, ir_pt5_av,'r-.d')
        hold on
        plot(irSOC_av, ir_10_av, 'r-o')
        hold on
        plot(irSOC_av, ir_30_av, 'r-+')
        hold on
        subleg1_cyl = strcat('Cylindrical, ', cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_cyl = strcat('Cylindrical (0.3C, 45 deg C), ', cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_cyl = strcat('Cylindrical (0.3C, 45 deg C), ', cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
    end
    if (n==4)
        [ir_SOH(1,:), irSOC(1,:), ir_pt5(1,:), ir_10(1,:), ir_30(1,:)] = ir_ch_cycle_CEA_100(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH(2,:), irSOC(2,:), ir_pt5(2,:), ir_10(2,:), ir_30(2,:)] = ir_ch_cycle_CEA_100(Filepath(2*k-2,:));
        ir_SOH_av(1,:) = (ir_SOH(1,:)+ ir_SOH(2,:))/2
        irSOC_av(1,:) = (irSOC(1,:)+ irSOC(2,:))/2
        ir_pt5_av(1,:) = (ir_pt5(1,:)+ ir_pt5(2,:))/2
        ir_10_av(1,:) = (ir_10(1,:)+ ir_10(2,:))/2
        ir_30_av(1,:) = (ir_30(1,:)+ ir_30(2,:))/2
        plot(irSOC_av, ir_pt5_av,'-*')
        hold on
        plot(irSOC_av, ir_10_av, '-<')
        hold on
        plot(irSOC_av, ir_30_av, '-s')
        hold on
        subleg1_prism = strcat('Prismatic (0.3C, 45 deg C), ', cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_prism = strcat('Prismatic (0.3C, 45 deg C), ', cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_prism = strcat('Prismatic (0.3C, 45 deg C), ', cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
    end
    if (n==6)
        [ir_SOH(1,:), irSOC(1,:), ir_pt5(1,:), ir_10(1,:), ir_30(1,:)] = ir_ch_cycle_Vito_100(Filepath(2*k-1,:));
        k=k+1
        [ir_SOH(2,:), irSOC(2,:), ir_pt5(2,:), ir_10(2,:), ir_30(2,:)] = ir_ch_cycle_Vito_100(Filepath(2*k-2,:));
        ir_SOH_av(1,:) = (ir_SOH(1,:)+ ir_SOH(2,:))/2
        irSOC_av(1,:) = (irSOC(1,:)+ irSOC(2,:))/2
        ir_pt5_av(1,:) = (ir_pt5(1,:)+ ir_pt5(2,:))/2
        ir_10_av(1,:) = (ir_10(1,:)+ ir_10(2,:))/2
        ir_30_av(1,:) = (ir_30(1,:)+ ir_30(2,:))/2
        plot(irSOC_av, ir_pt5_av,'-.>')
        hold on
        plot(irSOC_av, ir_10_av, '-p')
        hold on
        plot(irSOC_av, ir_30_av, '-h')
        hold on
        subleg1_pouch = strcat('Pouch, (0.3C, 45 deg C), ', cellstr(num2str(ir_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2_pouch = strcat('Pouch, (0.3C, 45 deg C), ', cellstr(num2str(ir_SOH_av', 'at 10s and SOH = %f')))
        subleg3_pouch = strcat('Pouch, (0.3C, 45 deg C), ', cellstr(num2str(ir_SOH_av', 'at 30s and SOH = %f')))
    end
end
hold off
legend_ir_100 = vertcat(subleg1_cyl, subleg2_cyl, subleg3_cyl, subleg1_prism, subleg2_prism, subleg3_prism, subleg1_pouch, subleg2_pouch, subleg3_pouch)
xlim([0 100])
ylabel('Internal resistance (mOhm)')
xlabel('State of Charge (%)')
legend(legend_ir_100, 'Location', 'North')
title('Internal resistance at 100% SOH for cells at 0.3C and 45 deg C (Charging, all geometries)')

%% Internal resistance (DIScharging) for 100% SOH
% Includes following two sections: Low Temp and High Temp
%% For low temp files (5 deg C)
[j,x]=size(Filepath)
figure()
for n=1:(j/2)
    k=n
    if(n==1)
        [ird_SOH(1,:), irdSOC(1,:), ird_pt5(1,:), ird_10(1,:), ird_30(1,:)] = ir_dis_cycle_CID_100(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH(2,:), irdSOC(2,:), ird_pt5(2,:), ird_10(2,:), ird_30(2,:)] = ir_dis_cycle_CID_100(Filepath(2*k-2,:));
        ird_SOH_av(1,:) = (ird_SOH(1,:)+ ird_SOH(2,:))/2
        irdSOC_av(1,:) = (irdSOC(1,:)+ irdSOC(2,:))/2
        ird_pt5_av(1,:) = (ird_pt5(1,:)+ ird_pt5(2,:))/2
        ird_10_av(1,:) = (ird_10(1,:)+ ird_10(2,:))/2
        ird_30_av(1,:) = (ird_30(1,:)+ ird_30(2,:))/2
        plot(irdSOC_av, ird_pt5_av,'r-.d')
        hold on
        plot(irdSOC_av, ird_10_av, 'r-o')
        hold on
        plot(irdSOC_av, ird_30_av, 'r-+')
        hold on
        subleg1d_cyl = strcat('Cylindrical, ', cellstr(num2str(ird_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2d_cyl = strcat('Cylindrical, ', cellstr(num2str(ird_SOH_av', 'at 10s and SOH = %f')))
        subleg3d_cyl = strcat('Cylindrical, ', cellstr(num2str(ird_SOH_av', 'at 30s and SOH = %f')))
    end
    if (n==3)
        [ird_SOH(1,:), irdSOC(1,:), ird_pt5(1,:), ird_10(1,:), ird_30(1,:)] = ir_dis_cycle_CID_100(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH(2,:), irdSOC(2,:), ird_pt5(2,:), ird_10(2,:), ird_30(2,:)] = ir_dis_cycle_CID_100(Filepath(2*k-2,:));
        ird_SOH_av(1,:) = (ird_SOH(1,:)+ ird_SOH(2,:))/2
        irdSOC_av(1,:) = (irdSOC(1,:)+ irdSOC(2,:))/2
        ird_pt5_av(1,:) = (ird_pt5(1,:)+ ird_pt5(2,:))/2
        ird_10_av(1,:) = (ird_10(1,:)+ ird_10(2,:))/2
        ird_30_av(1,:) = (ird_30(1,:)+ ird_30(2,:))/2
        plot(irdSOC_av, ird_pt5_av,'g-*')
        hold on
        plot(irdSOC_av, ird_10_av, 'g-<')
        hold on
        plot(irdSOC_av, ird_30_av, 'g-s')
        hold on
        subleg1d_prism = strcat('Prismatic, ', cellstr(num2str(ird_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2d_prism = strcat('Prismatic, ', cellstr(num2str(ird_SOH_av', 'at 10s and SOH = %f')))
        subleg3d_prism = strcat('Prismatic, ', cellstr(num2str(ird_SOH_av', 'at 30s and SOH = %f')))
    end
    if (n==5)
        [ird_SOH(1,:), irdSOC(1,:), ird_pt5(1,:), ird_10(1,:), ird_30(1,:)] = ir_dis_cycle_Vito_100(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH(2,:), irdSOC(2,:), ird_pt5(2,:), ird_10(2,:), ird_30(2,:)] = ir_dis_cycle_Vito_100(Filepath(2*k-2,:));
        ird_SOH_av(1,:) = (ird_SOH(1,:)+ ird_SOH(2,:))/2
        irdSOC_av(1,:) = (irdSOC(1,:)+ irdSOC(2,:))/2
        ird_pt5_av(1,:) = (ird_pt5(1,:)+ ird_pt5(2,:))/2
        ird_10_av(1,:) = (ird_10(1,:)+ ird_10(2,:))/2
        ird_30_av(1,:) = (ird_30(1,:)+ ird_30(2,:))/2
        plot(irdSOC_av, ird_pt5_av,'k-.>')
        hold on
        plot(irdSOC_av, ird_10_av, 'k-.x')
        hold on
        plot(irdSOC_av, ird_30_av, 'k-h')
        hold on
        subleg1d_pouch = strcat('Pouch, ', cellstr(num2str(ird_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2d_pouch = strcat('Pouch, ', cellstr(num2str(ird_SOH_av', 'at 10s and SOH = %f')))
        subleg3d_pouch = strcat('Pouch, ', cellstr(num2str(ird_SOH_av', 'at 30s and SOH = %f')))
    end
end
hold off
legend_ird_100 = vertcat(subleg1d_cyl, subleg2d_cyl, subleg3d_cyl, subleg1d_prism, subleg2d_prism, subleg3d_prism, subleg1d_pouch, subleg2d_pouch, subleg3d_pouch)
xlim([0 100])
ylabel('Internal resistance (mOhm)')
xlabel('State of Charge (%)')
legend(legend_ird_100, 'Location', 'North')
title('Internal resistance at 100% SOH for cells at 0.3C and 5 deg C (Discharging, all geometries)')

%% For high temp files (45 deg C)
[j,x]=size(Filepath)
figure()
for n=1:(j/2)
    k=n
    if(n==2)
        [ird_SOH(1,:), irdSOC(1,:), ird_pt5(1,:), ird_10(1,:), ird_30(1,:)] = ir_dis_cycle_CEA_100(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH(2,:), irdSOC(2,:), ird_pt5(2,:), ird_10(2,:), ird_30(2,:)] = ir_dis_cycle_CEA_100(Filepath(2*k-2,:));
        ird_SOH_av(1,:) = (ird_SOH(1,:)+ ird_SOH(2,:))/2
        irdSOC_av(1,:) = (irdSOC(1,:)+ irdSOC(2,:))/2
        ird_pt5_av(1,:) = (ird_pt5(1,:)+ ird_pt5(2,:))/2
        ird_10_av(1,:) = (ird_10(1,:)+ ird_10(2,:))/2
        ird_30_av(1,:) = (ird_30(1,:)+ ird_30(2,:))/2
        plot(irdSOC_av, ird_pt5_av,'-.d')
        hold on
        plot(irdSOC_av, ird_10_av, '-o')
        hold on
        plot(irdSOC_av, ird_30_av, '-+')
        hold on
        subleg1d_cyl = strcat('Cylindrical (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2d_cyl = strcat('Cylindrical (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 10s and SOH = %f')))
        subleg3d_cyl = strcat('Cylindrical (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 30s and SOH = %f')))
    end
    if (n==4)
        [ird_SOH(1,:), irdSOC(1,:), ird_pt5(1,:), ird_10(1,:), ird_30(1,:)] = ir_dis_cycle_CEA_100(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH(2,:), irdSOC(2,:), ird_pt5(2,:), ird_10(2,:), ird_30(2,:)] = ir_dis_cycle_CEA_100(Filepath(2*k-2,:));
        ird_SOH_av(1,:) = (ird_SOH(1,:)+ ird_SOH(2,:))/2
        irdSOC_av(1,:) = (irdSOC(1,:)+ irdSOC(2,:))/2
        ird_pt5_av(1,:) = (ird_pt5(1,:)+ ird_pt5(2,:))/2
        ird_10_av(1,:) = (ird_10(1,:)+ ird_10(2,:))/2
        ird_30_av(1,:) = (ird_30(1,:)+ ird_30(2,:))/2
        plot(irdSOC_av, ird_pt5_av,'-*')
        hold on
        plot(irdSOC_av, ird_10_av, '-<')
        hold on
        plot(irdSOC_av, ird_30_av, '-s')
        hold on
        subleg1d_prism = strcat('Prismatic (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2d_prism = strcat('Prismatic (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 10s and SOH = %f')))
        subleg3d_prism = strcat('Prismatic (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 30s and SOH = %f')))
    end
    if (n==6)
        [ird_SOH(1,:), irdSOC(1,:), ird_pt5(1,:), ird_10(1,:), ird_30(1,:)] = ir_dis_cycle_Vito_100(Filepath(2*k-1,:));
        k=k+1
        [ird_SOH(2,:), irdSOC(2,:), ird_pt5(2,:), ird_10(2,:), ird_30(2,:)] = ir_dis_cycle_Vito_100(Filepath(2*k-2,:));
        ird_SOH_av(1,:) = (ird_SOH(1,:)+ ird_SOH(2,:))/2
        irdSOC_av(1,:) = (irdSOC(1,:)+ irdSOC(2,:))/2
        ird_pt5_av(1,:) = (ird_pt5(1,:)+ ird_pt5(2,:))/2
        ird_10_av(1,:) = (ird_10(1,:)+ ird_10(2,:))/2
        ird_30_av(1,:) = (ird_30(1,:)+ ird_30(2,:))/2
        plot(irdSOC_av, ird_pt5_av,'-.>')
        hold on
        plot(irdSOC_av, ird_10_av, '-p')
        hold on
        plot(irdSOC_av, ird_30_av, '-h')
        hold on
        subleg1d_pouch = strcat('Pouch, (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 0.5s and SOH = %f')))
        subleg2d_pouch = strcat('Pouch, (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 10s and SOH = %f')))
        subleg3d_pouch = strcat('Pouch, (0.3C, 45 deg C), ', cellstr(num2str(ird_SOH_av', 'at 30s and SOH = %f')))
    end
end
hold off
legend_ird_100 = vertcat(subleg1d_cyl, subleg2d_cyl, subleg3d_cyl, subleg1d_prism, subleg2d_prism, subleg3d_prism, subleg1d_pouch, subleg2d_pouch, subleg3d_pouch)
xlim([0 100])
ylabel('Internal resistance (mOhm)')
xlabel('State of Charge (%)')
legend(legend_ird_100, 'Location', 'North')
title('Internal resistance at 100% SOH for cells at 0.3C and 45 deg C (Discharging, all geometries)')
