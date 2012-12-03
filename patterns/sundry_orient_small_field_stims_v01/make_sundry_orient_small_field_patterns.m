% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% Requires the panels matlab code at flypanels.org.
%
% Make a few patterns for stripe wiggling etc.,
%   - Stripe of 8 px wide (diff col in X, diff heights in Y)
%   - Stripe of 4 px wide (diff col in X, diff heights in Y)
%   - 4x4 bar with x and y motion in x and y chans
%   - 8x4 bar with x and y motion in x and y chans
%   - Full stripe that moves around the arena in X and flickers boxes on and off in Y
%
% SLH - 2012

project = 'sundry_orient_small_field_stims_v01';

% The size of the pixels
sizes = [4 8];

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 0;

% Greenscale 3 bright and dark values
bright = 7;
dark = 0;
mid = 3;

for stripe_size = sizes
    
    for p = 1:3
    
    Pats = [];
    
    pattern_name = '';
        

        reps = 96/(stripe_size*2);

        lam = [bright*ones(32,stripe_size), dark*ones(32,stripe_size)];

        pat = repmat(lam,1,reps);

        name = ['vert_' num2str(stripe_size)];

        for i = 1:stripe_size*2
            Pats(:,:,i) = circshift(pat',i-1)';
        end

    
        % Full field
        if p == 1
            
            pattern_name = ['full_field_' num2str(stripe_size) '_wide'];
            
        % Left side
        elseif p == 2
            
            Pats(:,5:36,:) = repmat(mid,32,32);
            pattern_name = ['left_field_' num2str(stripe_size) '_wide'];
                        
        % Right side
        elseif p == 3
            Pats(:,53:85,:) = repmat(mid,32,32);
            pattern_name = ['right_field' num2str(stripe_size) '_wide'];            
           
        end

        
        % Save the pattern, populate required fields.
        pattern.Pats        = Pats;
        pattern.x_num       = size(Pats,3);
        pattern.y_num       = size(Pats,4);
        pattern.num_panels  = 48;
        pattern.gs_val      = 3;     % 8 levels of intensity (0-7)
        pattern.row_compression = 0; % so only make [ L M N O ] with L = 4 (one per panel)
        panel_id_map =                  [12  8  4 11  7  3 10  6  2  9  5  1;
                                         24 20 16 23 19 15 22 18 14 21 17 13;
                                         36 32 28 35 31 27 34 30 26 33 29 25;
                                         48 44 40 47 43 39 46 42 38 45 41 37];
        pattern.Panel_map = panel_id_map;
        pattern.BitMapIndex = process_panel_map(pattern);
        pattern.data = Make_pattern_vector(pattern);

        % Get the correct target directory
        switch computer
            case {'PCWIN','PCWIN64'}
                root_pattern_dir = 'C:\tethered_flight_arena_code\patterns';
            case {'MACI64'}
                root_pattern_dir = '/Users/stephenholtz/tethered_flight_arena_code/patterns';
                %root_pattern_dir = '/Users/stephenholtz/imaging-experiments/panels_pattern_files';
            otherwise
                error('is this linux?')    
        end
        
        % When writing to SD card for the controller, ordering is important
        % and alphabetical.
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
    end
end