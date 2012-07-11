% Make reverse phi space time diagrams!
conditions = rev_phi_phase_delay_4_wide_high_res_v02;
pbar = waitbar(0,'Progress');
for g = 1:numel(conditions)
    condition_name = ['Condition ' num2str(g)];
    save_file_path = fullfile('/Users/holtzs/Desktop/space_time_figures/rev_phi_phase_delay_4_wide_high_res_v02/',condition_name);
    tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(g),save_file_path);
    waitbar(g/numel(conditions),pbar,'Progress')
end
close all force