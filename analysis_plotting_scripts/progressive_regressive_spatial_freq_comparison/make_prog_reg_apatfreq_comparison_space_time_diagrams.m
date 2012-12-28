% make some condition space time diagrams for progressive_regressive_spatial_freq_comparison_v01

if 1
    conditions = progressive_regressive_spatial_freq_comparison_v01
    out_dir = '/Users/stephenholtz/Desktop/temp_space_time/prog_reg';
    for cond_iter = 1:(numel(conditions)-1)
        %name = [num2str(cond_iter)  conditions(cond_iter).PatternName(8:end) '_' num2str(conditions(cond_iter).Gains(1)) '_' num2str(conditions(cond_iter).Gains(3))];
        name = [num2str(cond_iter) ' ' conditions(cond_iter).note];
        tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(cond_iter),fullfile(out_dir,name))
    end
end

