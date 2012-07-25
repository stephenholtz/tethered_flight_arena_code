function make_reverse_phi_double_check_patterns
% Create reverse phi rotation patterns both for use with position functions
% and ones that are hard coded from position functions in the reverse phi
% double check v02 folder

project = 'reverse_phi_double_check_patterns_v02';
pattern_base = fullfile('/Users/holtzs/tethered_flight_arena_code/patterns',project);
pattern_loc = fullfile('/Users/holtzs/tethered_flight_arena_code/patterns',project,'Pattern_001_fullRotRp_4_wide.mat');
counter = 0;
pat_size = 4;
name = ['fullRotRp_', num2str(pat_size), '_wide'];
func_freq = 200; % aka fps here
gain = 100;
bias = (func_freq - gain)/2.5;
duration = 3;

for pattern_type = [1 2]
    
    if pattern_type == 1
        % ReversePhi, full field, for use with position functions
        columns = 1:96;

        pattern_name = name;
        
        % Set pattern fields up
        pattern.x_num = pat_size*2;         % x is all frames - shouldn't need to be more than 2 x the spatial frequency
        pattern.y_num = 2;              % y is each flicker
        pattern.num_panels = 48;
        pattern.gs_val = 3;
        pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)

        Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

        % Make the initial pattern for both y channels (opp polarities)
        Pats(:, :, 1, 1) = repmat([3*ones(4,pat_size), 6*ones(4,pat_size)],1,96/(pat_size*2));
        Pats(:, :, 1, 2) = repmat([3*ones(4,pat_size), 0*ones(4,pat_size)],1,96/(pat_size*2));

        for j = 1:pattern.y_num
            for i = 1:pattern.x_num
                Pats(:,:,i,j) = circshift(Pats(:,:,1,j)',i-1)';
            end
        end
        
        % Mask out the part of the arena not needed
        for j = 1:pattern.y_num
            for i = 1:pattern.x_num
                temp = Pats(:,columns,i,j);
                l_half = columns(1)-1;
                r_half = 96-(columns(end));
                
                Pats(:,:,i,j) =  [3*ones(4,l_half), temp, 3*ones(4,r_half)];
            end
        end
        
        counter = counter + 1;
        save_pat(Pats,pattern_name,pattern_base,counter)
        Pats = [];
    else
        % Now make the hard coded patterns with the position functions
        % below
        func_path = '/Users/holtzs/tethered_flight_arena_code/position_functions/reverse_phi_double_check_v02_functions';
        for temp_freq = [.75 2 4]    
            for direction = 1:2
                
                % Determine frequency and direction
                if temp_freq == .75
                    
                    speed_name = [name,'_0pt75_Hz_'];
                    
                    if direction == 1
                        pos_func_x = fullfile(func_path,'position_function_001_lam_8_rev_phi_0pt75Hz_CW_Xchan_200Hz');
                    elseif direction == 2
                        pos_func_x = fullfile(func_path,'position_function_002_lam_8_rev_phi_0pt75Hz_CCW_Xchan_200Hz');
                    end
                
                elseif temp_freq == 2
                    speed_name = [name,'_2_Hz_'];
                    
                    if direction == 1
                        pos_func_x = fullfile(func_path,'position_function_024_lam_8_rev_phi_2Hz_CW_Xchan_200Hz');
                    elseif direction == 2
                        pos_func_x = fullfile(func_path,'position_function_025_lam_8_rev_phi_2Hz_CCW_Xchan_200Hz');
                    end
                    
                elseif temp_freq == 4
                    speed_name = [name,'_4_Hz_'];
                    
                    if direction == 1
                        pos_func_x = fullfile(func_path,'position_function_039_lam_8_rev_phi_4Hz_CW_Xchan_200Hz');
                    elseif direction == 2
                        pos_func_x = fullfile(func_path,'position_function_040_lam_8_rev_phi_4Hz_CCW_Xchan_200Hz');
                    end
                    
                end
                
                % Determine offset
                if temp_freq == .75
                    for func_num = 3:23
                        if func_num < 10
                            func_name = dir(fullfile(func_path,['position_function_00' num2str(func_num) '*']));
                        else
                            func_name = dir(fullfile(func_path,['position_function_0' num2str(func_num) '*']));
                        end
                        pos_func_y = fullfile(func_path,func_name.name);
                        
                        Pats(:,:,:,1) = hard_code_pattern_from_pos_funcs(pattern_loc,pos_func_x,pos_func_y,func_freq,duration);
                        if direction == 1; direction_name = 'CW_'; else direction_name = 'CCW_'; end
                        pattern_name = [speed_name direction_name func_name.name(regexpi(func_name.name,'[^_]+ms'):regexpi(func_name.name,'[^_]ms')) '_ms_' func_name.name(regexpi(func_name.name,'(after|before)'):regexpi(func_name.name,'(after|before)')+4) '_gain' num2str(gain) '_bias' num2str(bias)];           
                        counter = counter + 1;
                        
                        save_pat(Pats,pattern_name,pattern_base,counter)  
                        Pats = [];                        
                    end
                
                elseif temp_freq == 2
                    Pats = [];
                    for func_num = 26:38
                        if func_num < 10
                            func_name = dir(fullfile(func_path,['position_function_00' num2str(func_num) '*']));
                        else
                            func_name = dir(fullfile(func_path,['position_function_0' num2str(func_num) '*']));
                        end
                        pos_func_y = fullfile(func_path,func_name.name);
                        
                        Pats(:,:,:,1) = hard_code_pattern_from_pos_funcs(pattern_loc,pos_func_x,pos_func_y,func_freq,duration);
                        if direction == 1; direction_name = 'CW_'; else direction_name = 'CCW_'; end
                        pattern_name = [speed_name direction_name func_name.name(regexpi(func_name.name,'[^_]+ms'):regexpi(func_name.name,'[^_]ms')) '_ms_' func_name.name(regexpi(func_name.name,'(after|before)'):regexpi(func_name.name,'(after|before)')+4) '_gain' num2str(gain) '_bias' num2str(bias)];           
                        counter = counter + 1;
                        
                        save_pat(Pats,pattern_name,pattern_base,counter)      
                        Pats = [];                        
                    end

                    
                elseif temp_freq == 4
                    Pats = [];
                    for func_num = 41:47
                        if func_num < 10
                            func_name = dir(fullfile(func_path,['position_function_00' num2str(func_num) '*']));
                        else
                            func_name = dir(fullfile(func_path,['position_function_0' num2str(func_num) '*']));
                        end
                        pos_func_y = fullfile(func_path,func_name.name);
                        
                        Pats(:,:,:,1) = hard_code_pattern_from_pos_funcs(pattern_loc,pos_func_x,pos_func_y,func_freq,duration);
                        if direction == 1; direction_name = 'CW_'; else direction_name = 'CCW_'; end
                        pattern_name = [speed_name direction_name func_name.name(regexpi(func_name.name,'[^_]+ms'):regexpi(func_name.name,'[^_]ms')) '_ms_' func_name.name(regexpi(func_name.name,'(after|before)'):regexpi(func_name.name,'(after|before)')+4) '_gain' num2str(gain) '_bias' num2str(bias)];           
                        counter = counter + 1;
                        
                        save_pat(Pats,pattern_name,pattern_base,counter)   
                        Pats = [];                        
                    end
                end
            end
        end
        
    end
end
end

function save_pat(Pats,pattern_name,pattern_loc,counter)
    %% Save the pattern
    
    pattern.num_panels = 48;
    pattern.x_num = size(Pats,3);
    pattern.y_num = size(Pats,4);
    pattern.gs_val = 3;
    pattern.row_compression = 1;
    pattern.Pats = Pats;
    new_controller_48_panel_map =   [12  8  4 11  7  3 10  6  2  9  5  1;
                                     24 20 16 23 19 15 22 18 14 21 17 13;
                                     36 32 28 35 31 27 34 30 26 33 29 25;
                                     48 44 40 47 43 39 46 42 38 45 41 37];
    pattern.Panel_map = new_controller_48_panel_map;
    pattern.BitMapIndex = process_panel_map(pattern);
    pattern.data = Make_pattern_vector(pattern);
%     switch computer
%         case {'PCWIN','PCWIN64'}
%             root_pattern_dir = 'C:\tethered_flight_arena_code\patterns';
%         case {'MACI64'}
%             root_pattern_dir = '/Users/holtzs/tethered_flight_arena_code/patterns';
%         otherwise
%             error('is this linux?')            
%     end
    
    if numel(num2str(counter)) < 2
        count = ['00' num2str(counter)];
    elseif numel(num2str(counter)) < 3
        count = ['0' num2str(counter)];        
    else
        count = num2str(counter);        
    end

    pattern_name = ['Pattern_' count '_' pattern_name]; %#ok<*AGROW>
    file_name = fullfile(pattern_loc,pattern_name);
    save(file_name, 'pattern');
    disp(file_name);
    
end