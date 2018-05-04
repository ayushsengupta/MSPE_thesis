function SOH = legend_evo_ch(p)
    [j,k]=size(p)
    SOH = [] 
    for n=1:j
        CU = readtable(p(n,:),'Range','C9:L9','ReadVariableNames',false)
        [m,k] = size(CU)
        j=1
        for i=1:k
            if CU{:,i} == "ECU"
                idx(j) = i
                j=j+1
            end
        end
        SOHtab = readtable(p(n,:),'Range','C7:L8');
        SOH = [SOH; SOHtab{:,idx}]
    end
end
