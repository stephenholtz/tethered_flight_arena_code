%% Copy and paste, then find and replace XxXx with the genotype name...

time = '2';
for g = 1:numel(XxXx.experiment)
    if strcmpi(XxXx.experiment{g}.temp_shift(1),time);
        XxXx.experiment{g}.selected = 1;
    else
        XxXx.experiment{g}.selected = 0;
    end    
end

shifted_XxXx = tfAnalysis.Genotype(XxXx.experiment);
save('shifted_XxXx','shifted_XxXx')

time = '0';
for g = 1:numel(XxXx.experiment)
    if strcmpi(XxXx.experiment{g}.temp_shift(1),time);
        XxXx.experiment{g}.selected = 1;
    else
        XxXx.experiment{g}.selected = 0;
    end    
end

unshifted_XxXx = tfAnalysis.Genotype(XxXx.experiment);
save('unshifted_XxXx','unshifted_XxXx')
