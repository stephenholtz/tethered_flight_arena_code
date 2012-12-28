% make some condition space time diagrams for unilateral_flicker_contribution_phi_and_rev_phi_v01

if 1
    conditions = unilateral_flicker_contribution_phi_and_rev_phi_v01
    out_dir = '/Users/stephenholtz/Desktop/temp_space_time/flicker';
    for cond_iter = 1:2:(numel(conditions)-1)
        fprintf('%d of %d',cond_iter/2,numel(conditions)/2)
        name = [num2str(cond_iter)  conditions(cond_iter).PatternName(8:end) '_' num2str(conditions(cond_iter).Gains(1)) '_' num2str(conditions(cond_iter).Gains(3))];
        tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(cond_iter),fullfile(out_dir,name))
    end
end

