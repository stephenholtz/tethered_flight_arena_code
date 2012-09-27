% % Make reverse phi space time diagrams!
% 
% % Added unilateral reverse phi stimuli protocols. One for a few speeds and one for one speed at high resolution.
% conditions = unilat_rev_phi_phase_delay_4_wide_high_res_v01;
% pbar = waitbar(0,'Progress');
% for g = 110:numel(conditions)-1
%     condition_name = ['cond_' num2str(g) '_' conditions(g).PosFuncNameX(end-25:end-19) '_' conditions(g).PosFuncNameY(51:end-10)];
%     disp(condition_name)
%     save_file_path = fullfile('/Users/holtzs/Desktop/space_time_figures/unilat_rev_phi_phase_delay_4_wide_high_res_v01/',condition_name);
%     tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(g),save_file_path);
%     waitbar(g/numel(conditions),pbar,'Progress')
% end
% close all force
% 
% 
% % Added unilateral reverse phi stimuli protocols. One for a few speeds and one for one speed at high resolution.
% conditions = unilat_rev_phi_phase_delay_4_wide_v01;
% pbar = waitbar(0,'Progress');
% for g = 1:numel(conditions)-1
%     condition_name = ['cond_' num2str(g) '_' conditions(g).PosFuncNameX(end-25:end-19) '_' conditions(g).PosFuncNameY(51:end-10)];
%     disp(condition_name)
%     save_file_path = fullfile('/Users/holtzs/Desktop/space_time_figures/unilat_rev_phi_phase_delay_4_wide_v01/',condition_name);
%     tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(g),save_file_path);
%     waitbar(g/numel(conditions),pbar,'Progress')
% end
% close all force
%
% conditions = rev_phi_phase_delay_4_wide_contrast_change_v01;
% pbar = waitbar(0,'Progress');
% for g = 1:numel(conditions)-1
%     %condition_name = ['cond_' num2str(g) '_' conditions(g).PosFuncNameX(end-25:end-19) '_' conditions(g).PosFuncNameY(51:end-10)];
%     condition_name = ['cnd_' num2str(g) '_gs3_val_' conditions(g).PatternName(end-4) '_' conditions(g).PosFuncNameX(end-29:end-19) '_' conditions(g).PosFuncNameY(46:end-10)];
%     disp(condition_name)
%     save_file_path = fullfile('/Users/holtzs/Desktop/space_time_figures/rev_phi_phase_delay_4_wide_contrast_change_v01_fig/',condition_name);
%     tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(g),save_file_path);
%     waitbar(g/numel(conditions),pbar,'Progress')
% end
% close all force



conditions = rev_phi_no_stagger_testing_v01;
pbar = waitbar(0,'Progress');
mkdir(fullfile('/Users/holtzs/Desktop/space_time/'));

for g = 1:numel(conditions)-1
    %condition_name = ['cond_' num2str(g) '_' conditions(g).PosFuncNameX(end-25:end-19) '_' conditions(g).PosFuncNameY(51:end-10)];
    condition_name = ['cond_' num2str(g) conditions(g).PatternName];
    disp(condition_name)
    save_file_path = fullfile('/Users/holtzs/Desktop/space_time/',condition_name);
    tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(g),save_file_path);
    waitbar(g/numel(conditions),pbar,'Progress')
end
close all force
