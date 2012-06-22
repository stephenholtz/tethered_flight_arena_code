% Create reverse phi rotation patterns: full field, front, left, and right
% First y channel will be 4 wide second will be 8 wide.

%% Set pattern fields up
pattern.x_num = 16;             % x is all frames - shouldn't need to be more than 2 x the spatial frequency
pattern.y_num = 2;              % y is each flicker
pattern.num_panels = 48;        
pattern.gs_val = 3;          
pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)

project = 'rev_phi_testing_062012';
sizes = [4 8];
counter = 0;

for stim_type = 1:4
name = [];

switch stim_type
    case 1
    % Reverse Phi, full field
    name = [name, 'full_field_rot_']; %#ok<*AGROW> full field
    columns = 1:96;
end

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

for size_iter = 1:numel(sizes)
    
    pattern_name = [name, num2str(sizes(size_iter)), '_wide'];
    PatsON = zeros(4, 96, pattern.x_num, pattern.y_num);
    PatsOFF= zeros(4, 96, pattern.x_num, pattern.y_num);
    
    % Make the initial pattern for both y channels (opp polarities)
    PatsON(:, :, 1, size_iter) = repmat([3*ones(4,sizes(size_iter)), 6*ones(4,sizes(size_iter))],1,96/(sizes(size_iter)*2));
    PatsOFF(:, :, 1, size_iter) = repmat([3*ones(4,sizes(size_iter)), 0*ones(4,sizes(size_iter))],1,96/(sizes(size_iter)*2));
    
    for i = 1:pattern.x_num
        if mod(i,2)
            Pats(:,:,i,size_iter) = circshift(PatsON(:,:,1,size_iter)',i-1)';
        else
            Pats(:,:,i,size_iter) = circshift(PatsOFF(:,:,1,size_iter)',i-1)';
        end
    end
    
%     % Mask out the part of the arena not needed 
%     % NOT USED IN THIS PATTERN SCRIPT!
%     for j = 1:pattern.y_num
%         for i = 1:pattern.x_num
%             temp = Pats(:,columns,i,j);
%             l_half = columns(1)-1;
%             r_half = 96-(columns(end));
%             
%             Pats(:,:,i,j) =  [3*ones(4,l_half), temp, 3*ones(4,r_half)];
%         end
%     end
end
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