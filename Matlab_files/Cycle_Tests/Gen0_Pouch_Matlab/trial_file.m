    Data = readtable("G:\Pikoo\Study\MSPE\MasterThesis\Spicy_GEN_0_cells\Spicy_GEN0_Prismatic_soft_casing\Ageing tests\Life-cycling\Test result reports\Cycl_T05_Ch0.3C_VITO_Soft\Cycl_T05_Cha0.3C_ VITO_Soft_Cell19.xlsx",'Range','B5:J10','ReadRowNames',true);  
    Ecn = Data{'Equivalent cycle number',:}
    SoH = Data{'SoH',:}
    plot(Ecn, SoH, '-','Marker', '+')
    ylim([0 100])
    xlabel('Equivalent cycle number')
    ylabel('State of Health (%)')
