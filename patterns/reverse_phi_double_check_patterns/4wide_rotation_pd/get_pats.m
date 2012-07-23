function [Pats] = get_pats(directory)

j = 1;Pats = {};
files = dir(directory);
for i = 1:length(files)
    if strfind(files(i).name, 'mat')
        Pats{j}.Name = files(i).name;
        j = j+1;
    end
end
end
