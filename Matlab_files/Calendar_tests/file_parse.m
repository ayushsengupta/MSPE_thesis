%% Parsing function
function Filepath = file_parse(p)
    n=1;
    
    while p(n+1).folder ~= ""
        if (p(n).name == '.') || (p(n).name == '..') || (p(n).name == 'thumbs.db');
            break
        elseif p(n).isdir == 1
                f = strcat(MyFileInfo(n).folder, '\', MyFileInfo(n).name);
                p = dir(f);
                Filepath = file_parse(p);
        else
            Filepath = vertcat(Filepath, strcat(MyFileInfo(n).folder, '\', MyFileInfo(n).name));
        end
        Filepath
    end
end