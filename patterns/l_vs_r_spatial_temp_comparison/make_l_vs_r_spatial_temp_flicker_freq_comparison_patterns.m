function make_l_vs_r_spatial_temp_flicker_freq_comparison_patterns()
% make_l_vs_r_spatial_temp_flicker_freq_comparison_patterns
% 
% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% Requires the panels matlab code at flypanels.org.
% 
% Make a series of patterns for comparison of spatial and temporal
% frequency on right versus left fields of view, including standard and
% reverse phi as well as flickering bars and fields.
% 
% X-chan will move the left field/flicker and Y-chan will move the right 
% field/flicker. 
% 
% Different pixel widths are poentially [2,3,4,6,8,12]*3.75*2 =>
% 15,22.5,30,45,60,90 degrees spatial wavelength.
% 
% Note: 
% Standard pattern making scripts were getting too crazy to make this
% easily, so this strategy was adopted.
%
% SLH - 12/2012


%% Generate a struct for each type of unilateral stimuli with informative field names.

phi = [];
reverse_phi = [];
full_field_flicker = [];
bar_flicker = [];
alternating_bar_flicker = [];
solid = [];

try %#ok<*TRYNC>
addpath(genpath('/Users/stephenholtz/Xmega_Controller'))
end

project = 'l_vs_r_spatial_temp_comparison';

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 1;

% Greenscale 3 bright and dark values
bright = 6;
dark = 0;
mid = 3;

%grating_widths = [2,3,4,6,8,12];
grating_widths = [2,4,8,12];
temp_Pats = [];

%--Make the phi fields--
for bar_width = grating_widths

    % make a full version of what will be on the left or right side
    lam_reps = 96/(bar_width*2);
    lam = [dark*ones(32,bar_width), bright*ones(32,bar_width)];
    pat = repmat(lam,1,lam_reps);

    pat_steps = bar_width*2;

    for i = 1:pat_steps
        temp_Pats(:,:,i) = circshift(pat',i-1)'; %#ok<*SAGROW>
    end

    phi.(['lam_' num2str(bar_width*2)]) = temp_Pats;

    clear temp_Pats
end


%--Make the reverse phi fields--
for bar_width = grating_widths
    
    lam_reps = 96/(bar_width*2);

    lam_on = [mid*ones(32,bar_width), bright*ones(32,bar_width)];
    lam_off = [mid*ones(32,bar_width), dark*ones(32,bar_width)];

    pat_on = repmat(lam_on,1,lam_reps);
    pat_off = repmat(lam_off,1,lam_reps);

    % twice as many steps for reverse phi
    pat_steps = bar_width*4;

    for i = 1:pat_steps
        if mod(i,2)
            temp_Pats(:,:,i) = circshift(pat_on',i-1)';
        else
            temp_Pats(:,:,i) = circshift(pat_off',i-1)';
        end
    end
    
    reverse_phi.(['lam_' num2str(bar_width*2)]) = temp_Pats;
    
    clear temp_Pats
end

%--Make the full field flicker--

for i = [1 0]
   temp_Pats(:,:,i+1) = bright*i*ones(32,96); %#ok<*AGROW>
end

full_field_flicker.('lam') = temp_Pats;

clear temp_Pats

%--Make a plain pattern--

temp_Pats(:,:,1) = mid*ones(32,96); %#ok<*AGROW>

solid.('lam') = temp_Pats;

clear temp_Pats

%--Make the bar flicker fields--
for bar_width = grating_widths
    
    lam_reps = 96/(bar_width*2);

    flick_on = [dark*ones(32,bar_width), bright*ones(32,bar_width)];
    flick_off = [dark*ones(32,bar_width), dark*ones(32,bar_width)];
    
    temp_Pats(:,:,1) = repmat(flick_on,1,lam_reps);
    temp_Pats(:,:,2) = repmat(flick_off,1,lam_reps);
    
    bar_flicker.(['lam_' num2str(bar_width*2)]) = temp_Pats;
    
    clear temp_Pats flick_on flick_on lam_reps
end

%--Make the alternating bar flickers--
for bar_width = grating_widths
    
    lam_reps = 96/(bar_width*2);

    flick_on = [dark*ones(32,bar_width), bright*ones(32,bar_width)];
    flick_shift = circshift(flick_on',bar_width)';

    temp_Pats(:,:,1) = repmat(flick_on,1,lam_reps);
    temp_Pats(:,:,2) = repmat(flick_shift,1,lam_reps);
    
    alternating_bar_flicker.(['lam_' num2str(bar_width*2)]) = temp_Pats;
    
    clear temp_Pats flick_on flick_on lam_reps
end

%% left and right motion diff spatial frequencies only one half
phi_field_types = fieldnames(phi);

% solid on the left
for right_lam_iter = 1:numel(phi_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    solid.('lam'),...
                    phi.(phi_field_types{right_lam_iter}),mid);

    pattern_name = ['left_solid_right_' phi_field_types{right_lam_iter}];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

% solid on the right
for left_lam_iter = 1:numel(phi_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    phi.(phi_field_types{left_lam_iter}),...
                    solid.('lam'),mid);
    
    pattern_name = ['left_' phi_field_types{left_lam_iter} '_right_solid'];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end


%% left and right rev phi diff spatial frequencies only one half
rp_field_types = fieldnames(reverse_phi);

% solid on the left
for right_lam_iter = 1:numel(rp_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    solid.('lam'),...
                    reverse_phi.(rp_field_types{right_lam_iter}),mid);

    pattern_name = ['left_solid_rev_phi_right_' rp_field_types{right_lam_iter}];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

% solid on the right
for left_lam_iter = 1:numel(rp_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    reverse_phi.(rp_field_types{left_lam_iter}),...
                    solid.('lam'),mid);

    pattern_name = ['rev_phi_left_' rp_field_types{left_lam_iter} '_right_solid'];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end


%% left and right different spat freq combinations
phi_field_types = fieldnames(phi);

for left_lam_iter = 1:numel(phi_field_types)
    for right_lam_iter = 1:numel(phi_field_types)

        Pats = zeros(32,96,1,1);
        Pats = add_unilat_pattern_to_left_right(Pats,...
                        phi.(phi_field_types{left_lam_iter}),...
                        phi.(phi_field_types{right_lam_iter}),mid);

        pattern_name = ['left_' phi_field_types{left_lam_iter} '_right_' phi_field_types{right_lam_iter}];
        counter = save_make_pattern(Pats,pattern_name,project,counter);

    end
end

%% left and right different spat freq with one side full field flicker
phi_field_types = fieldnames(phi);

% Flicker on the left
for right_lam_iter = 1:numel(phi_field_types)

    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    full_field_flicker.('lam'),...
                    phi.(phi_field_types{right_lam_iter}),mid);
    
    pattern_name = ['left_full_field_flicker_right_' phi_field_types{right_lam_iter}];
    counter = save_make_pattern(Pats,pattern_name,project,counter);

end

% Flicker on the right
for left_lam_iter = 1:numel(phi_field_types)

    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    phi.(phi_field_types{left_lam_iter}),...
                    full_field_flicker.('lam'),mid);
    
    pattern_name = ['left_' phi_field_types{left_lam_iter} '_right_full_field_flicker'];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

%% left and right different spat freq with one side of identical spat freq flickering bars    
phi_field_types = fieldnames(phi);

% bar flicker on the left
for right_lam_iter = 1:numel(phi_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    bar_flicker.(phi_field_types{right_lam_iter}),...
                    phi.(phi_field_types{right_lam_iter}),mid);

    pattern_name = ['left_grating_flicker_right_' phi_field_types{right_lam_iter}];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

% bar flicker on the right
for left_lam_iter = 1:numel(phi_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    phi.(phi_field_types{left_lam_iter}),...
                    bar_flicker.(phi_field_types{left_lam_iter}),mid);
    
    pattern_name = ['left_' phi_field_types{left_lam_iter} '_right_grating_flicker'];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

%% left and right different spat freq with one side of identical spat freq flickering bars that alternate position
phi_field_types = fieldnames(phi);

% bar flicker on the left
for right_lam_iter = 1:numel(phi_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    alternating_bar_flicker.(phi_field_types{right_lam_iter}),...
                    phi.(phi_field_types{right_lam_iter}),mid);

    pattern_name = ['left_grating_alt_flicker_right_' phi_field_types{right_lam_iter}];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

% bar flicker on the right
for left_lam_iter = 1:numel(phi_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    phi.(phi_field_types{left_lam_iter}),...
                    alternating_bar_flicker.(phi_field_types{left_lam_iter}),mid);
    
    pattern_name = ['left_' phi_field_types{left_lam_iter} '_right_grating_alt_flicker'];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

%% left and right combinations of phi and reverse phi
rp_field_types = fieldnames(reverse_phi);
phi_field_types = fieldnames(phi);

% rev phi on the left, phi on the right
for left_lam_iter = 1:numel(rp_field_types)
    for right_lam_iter = 1:numel(phi_field_types)
        
        Pats = zeros(32,96,1,1);
        Pats = add_unilat_pattern_to_left_right(Pats,...
                        reverse_phi.(rp_field_types{left_lam_iter}),...
                        phi.(phi_field_types{right_lam_iter}),mid);
        
        pattern_name = ['rev_phi_left_' rp_field_types{left_lam_iter} '_right_' phi_field_types{right_lam_iter}];
        counter = save_make_pattern(Pats,pattern_name,project,counter);
        
    end
end

% phi on the left, rev phi on the right
for left_lam_iter = 1:numel(phi_field_types)
    for right_lam_iter = 1:numel(rp_field_types)
        
        Pats = zeros(32,96,1,1);
        Pats = add_unilat_pattern_to_left_right(Pats,...
                        phi.(phi_field_types{left_lam_iter}),...
                        reverse_phi.(rp_field_types{right_lam_iter}),mid);
        
        pattern_name = ['left_' phi_field_types{left_lam_iter} '_rev_phi_right_' rp_field_types{right_lam_iter}];
        counter = save_make_pattern(Pats,pattern_name,project,counter);
        
    end
end

%% left and right reverse phi

rp_field_types = fieldnames(reverse_phi);

for left_lam_iter = 1:numel(rp_field_types)
    for right_lam_iter = 1:numel(rp_field_types)

        Pats = zeros(32,96,1,1);
        Pats = add_unilat_pattern_to_left_right(Pats,...
                        reverse_phi.(rp_field_types{left_lam_iter}),...
                        reverse_phi.(rp_field_types{right_lam_iter}),mid);
        
        pattern_name = ['rev_phi_left_' rp_field_types{left_lam_iter} '_rev_phi_right_' rp_field_types{right_lam_iter}];

        counter = save_make_pattern(Pats,pattern_name,project,counter);
    end
end

%% left and right reverse phi with one side full field flicker
rp_field_types = fieldnames(reverse_phi);

% Flicker on the left
for right_lam_iter = 1:numel(rp_field_types)

    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    full_field_flicker.('lam'),...
                    reverse_phi.(rp_field_types{right_lam_iter}),mid);

    pattern_name = ['left_full_field_flicker_rev_phi_right_' rp_field_types{right_lam_iter}];
    counter = save_make_pattern(Pats,pattern_name,project,counter);

end

% Flicker on the right
for left_lam_iter = 1:numel(rp_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    reverse_phi.(rp_field_types{left_lam_iter}),...
                    full_field_flicker.('lam'),mid);

    pattern_name = ['rev_phi_left_' rp_field_types{left_lam_iter} '_right_full_field_flicker'];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

%% left and right reverse phi with one side of identical spat freq flickerng bars
rp_field_types = fieldnames(reverse_phi);

% Flicker on the left
for right_lam_iter = 1:numel(rp_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    bar_flicker.(rp_field_types{right_lam_iter}),...
                    reverse_phi.(rp_field_types{right_lam_iter}),mid);

    pattern_name = ['left_grating_flicker_rev_phi_right_' rp_field_types{right_lam_iter}];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

% Flicker on the right
for left_lam_iter = 1:numel(rp_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    reverse_phi.(rp_field_types{left_lam_iter}),...
                    bar_flicker.(rp_field_types{left_lam_iter}),mid);

    pattern_name = ['rev_phi_left_' rp_field_types{left_lam_iter} '_right_grating_flicker'];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

%% left and right reverse phi different spat freq with one side of identical spat freq flickering bars that alternate position
rp_field_types = fieldnames(reverse_phi);

% Flicker on the left
for right_lam_iter = 1:numel(rp_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    alternating_bar_flicker.(rp_field_types{right_lam_iter}),...
                    reverse_phi.(rp_field_types{right_lam_iter}),mid);

    pattern_name = ['left_grating_alt_flicker_rev_phi_right_' rp_field_types{right_lam_iter}];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end

% Flicker on the right
for left_lam_iter = 1:numel(rp_field_types)
    
    Pats = zeros(32,96,1,1);
    Pats = add_unilat_pattern_to_left_right(Pats,...
                    reverse_phi.(rp_field_types{left_lam_iter}),...
                    alternating_bar_flicker.(rp_field_types{left_lam_iter}),mid);

    pattern_name = ['rev_phi_left_' rp_field_types{left_lam_iter} '_right_grating_alt_flicker'];
    counter = save_make_pattern(Pats,pattern_name,project,counter);
    
end


%% Helper functions
    function Pats = add_unilat_pattern_to_left_right(Pats,left_pattern,right_pattern,background_intensity)

        left_cols = 5:36;
        right_cols = 53:84;

        for left_iter = 1:size(left_pattern,3)
            for right_iter = 1:size(right_pattern,3)
                Pats(:,right_cols,left_iter,right_iter) = right_pattern(:,right_cols,right_iter);
                Pats(:,left_cols,left_iter,right_iter) = left_pattern(:,left_cols,left_iter);
                Pats(:,[1:4 37:52 85:96],left_iter,right_iter) = background_intensity*ones(32,32);            
            end
        end

    end


    function new_count = save_make_pattern(Pats,pattern_name,project,counter)
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
            otherwise
                error('is this linux?')    
        end

        % When writing to SD card for the controller, ordering is important
        % and alphabetical.
        new_count = counter + 1;
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
