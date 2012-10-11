% Make patterns for VS and HS cells

project = 'VS_HS_grating_patterns';
pattern_name = '';
sizes = 4;
counter = 0;
pattern.x_num = max(sizes)*2;         % x is all frames - shouldn't need to be more than 2 x the spatial frequency
pattern.y_num = 1;              % y is each flicker
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

%%% MEAT
    
pattern.Pats = Pats;
new_controller_48_panel_map =   [12  8  4 11  7  3 10  6  2  9  5  1;
                                 24 20 16 23 19 15 22 18 14 21 17 13;
                                 36 32 28 35 31 27 34 30 26 33 29 25;
                                 48 44 40 47 43 39 46 42 38 45 41 37];

pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = Make_pattern_vector(pattern);

switch computer
    case {'PCWIN','PCWIN64'}
        root_pattern_dir = 'C:\tethered_flight_arena_code\patterns';
    case {'MACI64'}
        root_pattern_dir = '/Users/stephenholtz/tethered_flight_arena_code/patterns';
    otherwise
        error('is this linux?')            
end

counter = counter + 1;
if numel(num2str(counter)) < 2
    count = ['00' num2str(counter)];
elseif numel(num2str(counter)) < 3
    count = ['0' num2str(counter)];        
else
    count = num2str(counter);        
end

pattern_name = ['Pattern_' count '_' pattern_name];
file_name = fullfile(root_pattern_dir,project,pattern_name);
disp(file_name);
save(file_name, 'pattern');