% makes expansion and contraction at a few poles (changing in Y) and happen

project = 'small_field_telethon_2012_patterns';
pattern_name = 'variable_bar_gs3';
bar_heights = 2:2:32;
bar_widths = 2:2:8;
counter = 34;       % The number of preexisting telethon patterns
pattern.x_num = 96; % Arena Positions
pattern.y_num = numel(bar_heights)*numel(bar_widths); % Diff bars
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 0; % so only make [ L M N O ] with L = 4 (one per panel)

bar_color = 0;
bck_color = 6;

Pats = zeros(32, 96, pattern.x_num, pattern.y_num);

    num_cols = 48;
    
    y = 0;
    for width = bar_widths;
        for height = bar_heights;
            y = y + 1;
            pad_width_size = (96-width)/2;
            pad_height_size = (32-height)/2;
            center_bar = [bck_color*ones(pad_height_size,width); bar_color*ones(height,width); bck_color*ones(pad_height_size,width)];
            Pats(:,:,1,y) = [bck_color*ones(32,pad_width_size) center_bar bck_color*ones(32,pad_width_size)];
        end
    end
    
    for j = 1:pattern.y_num
        for i = 2:pattern.x_num
            Pats(:,:,i,j) = circshift(Pats(:,:,1,j)',i-1)';
        end
    end
    
    % Center the patterns
    for j = 1:pattern.y_num
        for i = 1:pattern.x_num
            Pats(:,:,i,j) = circshift(Pats(:,:,i,j)',44)';
        end
    end    
    
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
            root_pattern_dir = '/Users/holtzs/tethered_flight_arena_code/patterns';
        otherwise
            error('is this linux?')            
    end
    
    counter = counter + 1;
    count = num2str(counter);
    
    pattern_name = ['Pattern_' count '_' pattern_name];
    file_name = fullfile(root_pattern_dir,project,pattern_name);
    disp(file_name);
    save(file_name, 'pattern');