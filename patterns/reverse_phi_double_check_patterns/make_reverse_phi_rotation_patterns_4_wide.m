% Create reverse phi rotation patterns: full field, front, left, and right

project = 'reverse_phi_double_check_patterns';
counter = 10;

for stim_type = 1
    name = [];

    switch stim_type
        case 1
        % ReversePhi, full field
        name = [name, 'full_field_rot_']; %#ok<*AGROW> full field
        columns = 1:96;
        case 2
        % ReversePhi, front side (120 degrees, 32 pixels separated by 8 pixels on side and side)
        name = [name, 'front_field_rot_'];
        columns = 29:60;
        case 3
        % ReversePhi, left side (120 degrees, 32 pixels separated by 8 pixels on front and back)
        name = [name, 'left_field_rot_'];
        columns = 5:36;
        case 4
        % ReversePhi, right side (120 degrees, 32 pixels separated by 8 pixels on front and back)
        name = [name, 'right_field_rot_'];
        columns = 53:85;
        case 5
        % ReversePhi, 'hard coded' to flash and move together full field
        name = [name, 'full_field_rot_hard_set_flash_'];
        columns = 1:96;
        case 6
        % ReversePhi, 'hard coded' to flash and move together front side (120 degrees, 32 pixels separated by 8 pixels on side and side)
        name = [name, 'front_field_rot_hard_set_flash_'];
        columns = 29:60;   
        case 7
        % ReversePhi, 'hard coded' to flash and move together left side (120 degrees, 32 pixels separated by 8 pixels on front and back)
        name = [name, 'left_field_rot_hard_set_flash_'];
        columns = 5:36;
        case 8
        % ReversePhi, 'hard coded' to flash and move together right side (120 degrees, 32 pixels separated by 8 pixels on front and back)
        name = [name, 'right_field_rot_hard_set_flash_'];
        columns = 53:85;
    end

    for size = 4

        pattern_name = [name, num2str(size), '_wide'];

        % Set pattern fields up
        pattern.x_num = size*2;         % x is all frames - shouldn't need to be more than 2 x the spatial frequency
        pattern.y_num = 2;              % y is each flicker
        pattern.num_panels = 48;
        pattern.gs_val = 3;
        pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)

        if sum(stim_type == [1 2 3 4])
                Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

                % Make the initial pattern for both y channels (opp polarities)
                Pats(:, :, 1, 1) = repmat([3*ones(4,size), 6*ones(4,size)],1,96/(size*2));
                Pats(:, :, 1, 2) = repmat([3*ones(4,size), 0*ones(4,size)],1,96/(size*2));

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

%         else
%                 % Here the second Y channel is reverse phi with the opposite
%                 % polarity
%                 Pats = zeros(4, 96, pattern.x_num, pattern.y_num);            
%                 PatsON = zeros(4, 96, pattern.x_num, pattern.y_num);
%                 PatsOFF= zeros(4, 96, pattern.x_num, pattern.y_num);
% 
% 
%                 PatsON(:, :, 1, size_iter) = repmat([3*ones(4,sizes(size_iter)), 6*ones(4,sizes(size_iter))],1,96/(sizes(size_iter)*2));
%                 PatsOFF(:, :, 1, size_iter) = repmat([3*ones(4,sizes(size_iter)), 0*ones(4,sizes(size_iter))],1,96/(sizes(size_iter)*2));
%                 for y_chan = 1:pattern.y_num
%                     if y_chan == 1
%                         for i = 1:pattern.x_num
%                             if mod(i,2)
%                                 Pats(:,:,i,size_iter) = circshift(PatsON(:,:,1,size_iter)',i-1)';
%                             else
%                                 Pats(:,:,i,size_iter) = circshift(PatsOFF(:,:,1,size_iter)',i-1)';
%                             end
%                         end   
%                     elseif y_chan == 2
%                         for i = 1:pattern.x_num
%                             if mod(i,2)
%                                 Pats(:,:,i,size_iter) = circshift(PatsOFF(:,:,1,size_iter)',i-1)';
%                             else
%                                 Pats(:,:,i,size_iter) = circshift(PatsON(:,:,1,size_iter)',i-1)';
%                             end
%                         end
%                     end
%                 end
        end

        %% Save the pattern
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
end