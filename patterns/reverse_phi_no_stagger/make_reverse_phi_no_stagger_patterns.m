% Makes reverse phi patterns where the x channel controls the flicker and
% the motion going in one direction i.e. Flicker -> Motion CW, 
% Motion -> Flicker CCW.
% 
% Can use a position function that will scale with the sampling rate, and
% have variable delays
% 

counter = 0;

project = 'reverse_phi_no_stagger';

bar_size = 4;

background_level = 3;

base_name = ['rev_phi_' num2str(4) '_wide_'];

pattern.x_num = bar_size*4;         % x is all frames - shouldn't need to be more than 2 x the spatial frequency (x2 more for the flicker component!)
pattern.y_num = 1;                  % y, unused, for now
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)

for flicker_pos = 1:10
    
    Pats = [];
    
    bar_polarity = 6; % to start out oscillation

    frame_iter = 0;
    
    % Flicker before movement cw
    if flicker_pos == 1
        
        flick_name = [base_name 'flkr_then_move_cw'];
        
        if bar_polarity == 0; bar_polarity = 6; elseif bar_polarity == 6; bar_polarity = 0; end
        
        for i = 1:pattern.x_num
            
            % Switch the polarity
            
            frame_iter = frame_iter + 1;
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',i-1)';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
            % Shift the pattern
            
            frame_iter = frame_iter + 1;
            
            if bar_polarity == 0; bar_polarity = 6; elseif bar_polarity == 6; bar_polarity = 0; end
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',i-1)';

            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
        end
    
    % Flicker before movement ccw
    elseif flicker_pos == 2
        
        flick_name = [base_name 'flkr_then_move_ccw'];
        
        if bar_polarity == 0; bar_polarity = 6; elseif bar_polarity == 6; bar_polarity = 0; end
        
        for i = 1:pattern.x_num
            
            % Switch the polarity
            
            frame_iter = frame_iter + 1;
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',-abs(i-1))';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
            % Shift the pattern
            
            frame_iter = frame_iter + 1;
            
            if bar_polarity == 0; bar_polarity = 6; elseif bar_polarity == 6; bar_polarity = 0; end
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',-abs(i-1))';

            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
        end
        
    % Flicker after movement
    elseif flicker_pos == 3
        
        flick_name = [base_name 'move_then_flkr_cw'];
        
        for i = 1:pattern.x_num
            
            % Switch the polarity
            
            frame_iter = frame_iter + 1;
            
            if bar_polarity == 0; bar_polarity = 6; elseif bar_polarity == 6; bar_polarity = 0; end
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',i-1)';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
            % Shift the pattern
            
            frame_iter = frame_iter + 1;
            
            Pats(:,:,frame_iter) = circshift(base_frame',1)';
            
        end

    % Flicker after movement
    elseif flicker_pos == 4
        
        flick_name = [base_name 'move_then_flkr_ccw'];
        
        for i = 1:pattern.x_num
            
            % Switch the polarity
            
            frame_iter = frame_iter + 1;
            
            if bar_polarity == 0; bar_polarity = 6; elseif bar_polarity == 6; bar_polarity = 0; end
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',-abs(i-1))';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
            % Shift the pattern
            
            frame_iter = frame_iter + 1;
            
            Pats(:,:,frame_iter) = circshift(base_frame',-1)';
            
        end        
        
    elseif flicker_pos == 5
        
        flick_name = [base_name 'move_and_flkr_cw'];
        
        for i = 1:pattern.x_num
            
            % Switch the polarity
            
            frame_iter = frame_iter + 1;
            
            if bar_polarity == 0; bar_polarity = 6; elseif bar_polarity == 6; bar_polarity = 0; end
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',i-1)';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
        end
        
    elseif flicker_pos == 6
        
        flick_name = [base_name 'move_and_flkr_ccw'];
        
        for i = 1:pattern.x_num
            
            % Switch the polarity
            
            frame_iter = frame_iter + 1;
            
            if bar_polarity == 0; bar_polarity = 6; elseif bar_polarity == 6; bar_polarity = 0; end
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',-abs(i-1))';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
        end        
        
    elseif flicker_pos == 7
        
        flick_name = [base_name 'high_contrast_cw'];
        
        for i = 1:pattern.x_num
                        
            frame_iter = frame_iter + 1;
            
            bar_polarity = 0;
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',i-1)';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
        end
        
    elseif flicker_pos == 8
        
        flick_name = [base_name 'high_contrast_ccw'];
        
        for i = 1:pattern.x_num
                        
            frame_iter = frame_iter + 1;
            
            bar_polarity = 0;
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',-abs(i-1))';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
        end
        
    elseif flicker_pos == 9
        
        flick_name = [base_name 'low_contrast_cw'];
        
        for i = 1:pattern.x_num
                        
            frame_iter = frame_iter + 1;
            
            bar_polarity = 6;
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',i-1)';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
        end
        
    elseif flicker_pos == 10
        
        flick_name = [base_name 'low_contrast_ccw'];
        
        for i = 1:pattern.x_num
                        
            frame_iter = frame_iter + 1;
            
            bar_polarity = 6;
            
            base_frame = circshift(repmat([background_level*ones(4,bar_size), bar_polarity*ones(4,bar_size)],1,96/(bar_size*2))',-abs(i-1))';
            
            Pats(:,:,frame_iter) = circshift(base_frame',0)';
            
        end
        
    end
    
    pattern_name = flick_name;

    % Save the pattern
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
    disp(file_name);
    
end