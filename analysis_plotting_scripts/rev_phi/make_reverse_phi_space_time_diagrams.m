% Make reverse phi space time diagrams!
conditions = rev_phi_phase_delay_4_wide_asym_test_v01;
pbar = waitbar(0,'Progress');
for g = 1:numel(conditions)
    condition_name = ['cond_' num2str(g) '_' conditions(g).PosFuncNameX(end-25:end-19) '_' conditions(g).PosFuncNameY(51:end-10)];
    disp(condition_name)
    save_file_path = fullfile('/Users/holtzs/Desktop/space_time_figures/rev_phi_phase_delay_4_wide_asym_test_v01/',condition_name);
    tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(g),save_file_path);
    waitbar(g/numel(conditions),pbar,'Progress')
end
close all force