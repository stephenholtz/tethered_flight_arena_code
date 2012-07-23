

%%%run all in folder

aaa = dir;

for ii = 3:length(aaa)-1
        fprintf((aaa(ii).name(1:end-2)));
    run((aaa(ii).name(1:end-2)));

end