%makes expansion and contraction at a few poles (changing in Y) and happen

project = 'basic_expansion_v01';
pattern_name = 'gs3_mc_1_expansion_4_wide';
sizes = 4;
counter = 0;
pattern.x_num = max(sizes)*2;         % x is all frames - shouldn't need to be more than 2 x the spatial frequency
pattern.y_num = 1;              % y is each flicker
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

    num_cols = 48;
    
    y = 0;
    for size = sizes;
        
        for pole = 1;
            y = y+1;
            reps = 96/(size*2);
            % contrast = 71%
            Pats(:,:,1,y) = repmat([0*ones(4,size) 7*ones(4,size)],1,reps); 
            Pats(:,:,1,y) = circshift(Pats(:,:,1,y)',size/2)';
        end
    end
    
    for i = 1:pattern.y_num
        for j = 2:pattern.x_num 
        Pats(:,:,j,i) = simple_expansion(Pats(:,:,j-1,i), 96/2+1,96);
        end
    end
    
    for g = 1;
        for i = 1:pattern.x_num
            Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), 28, 'l', 'y');
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