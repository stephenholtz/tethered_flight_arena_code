conditions = ir_blast_v01;
try mkdir(fullfile('/Users/holtzs/Desktop/space_time_figures/ir_blast_v01/')); end %#ok<TRYNC>

for g = 1:numel(conditions)-1
    condition_name = ['cond_' num2str(g) conditions(g).PatternName];
    disp(condition_name)
    save_file_path = fullfile('/Users/holtzs/Desktop/space_time_figures/ir_blast_v01/',condition_name);
    tfPlot.make_space_time_diagram_for_open_loop_condition(conditions(g),save_file_path);
end
close all force
