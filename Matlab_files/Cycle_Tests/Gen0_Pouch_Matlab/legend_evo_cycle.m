function leg_evo_cycle = legend_evo_cycle(p,l)
    [j,k]=size(p)
    leg_evo_cycle = []
        
    for n=1:j
        CU = readtable(p(n,:),'Range','C11:Z11','ReadVariableNames',false)
        [m,k] = size(CU)
        j=1
        idx = []
        for i=1:k
            if ismember(CU{:,i},'ECU')
                idx(j) = i
                j=j+1
            end
        end
        SOHtab = readtable(p(n,:),'Range','C10:Z10', 'ReadVariableNames',false);
        SOHtab_arr = SOHtab{:,idx}
        [z,t]=size(idx)
        for q=1:t
                leg_evo_cycle{end+1} = strcat(l(n), ' at SOH = ',num2str(SOHtab_arr(1,q)))
        end
                    
    end
end
