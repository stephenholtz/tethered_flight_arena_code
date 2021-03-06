% The arena is a 96 x 32 Array of LEDs, patterns played with rev3
% controller, the pattern format is
% Pats(LED-rows, LED-cols, X-chan-buffer, Y-chan-buffer)
% 
% Requires the panels matlab code at flypanels.org.
%
%
% 
% Make patterns for high resolution tuning curves, these are:
%       * full/lateral field grating @ 60 degrees spat wavelength [8 pix bar]
%       * full/lateral field grating @ 30 degrees spat wavelength [4 pix bar]
%       - full/lateral field reverse phi grating @ 60 degrees spat wavelength
%       - full/lateral field reverse phi grating @ 30 degrees spat wavelength
%       - full/lateral field sine wave grating @ 60 degrees
%       - full/lateral field sine wave grating @ 30 degrees
%       - full/lateral field reverse phi sine wave grating @ 60 degrees
%       - full/lateral field reverse phi sine wave grating @ 30 degrees
%
%      '-' Are all TODO
%
% Because it is easier to make each stimulus as its own pattern for the
% fast panels mode, each stimulus has its own pattern in this experiment.
%
% SLH - 2012

try %#ok<*TRYNC>
addpath(genpath('/Users/stephenholtz/Xmega_Controller'))
end

project = 'high_res_tuning_curves_v01';

% The size of the pixels
sizes = [4 8];

% The flicker in motion
flicker = [0 1];

% Counter for iterating the pattern names, set nonzero if appending to 
% another experiment.
counter = 0;

% Greenscale 3 bright and dark values
bright = 6;
dark = 0;
mid = 3;


for rev_phi = flicker
    
    for stripe_size = sizes

        for p = 1:3

        Pats = [];

        pattern_name = '';

            if rev_phi
                
                lam_reps = 96/(stripe_size*2);

                lam_on = [mid*ones(32,stripe_size), bright*ones(32,stripe_size)];
                lam_off = [mid*ones(32,stripe_size), dark*ones(32,stripe_size)];
                
                pat_on = repmat(lam_on,1,lam_reps);
                pat_off = repmat(lam_off,1,lam_reps);
                
                name = ['rev_phi_vert_'];
                
                % twice as many steps for reverse phi
                pat_steps = stripe_size*4;
                
                for i = 1:pat_steps
                    if mod(i,2)
                        Pats(:,:,i) = circshift(pat_on',i-1)';
                    else
                        Pats(:,:,i) = circshift(pat_off',i-1)';
                    end
                end
                
            else
                lam_reps = 96/(stripe_size*2);

                lam = [bright*ones(32,stripe_size), dark*ones(32,stripe_size)];

                pat = repmat(lam,1,lam_reps);

                name = ['norm_phi_vert_'];
                
                % 2*spatial wavelength steps to complete pattern
                pat_steps = stripe_size*2;
                
                for i = 1:pat_steps
                    Pats(:,:,i) = circshift(pat',i-1)';
                end
            end
            
            % Full field
            if p == 1

                pattern_name = [name 'full_field_' num2str(stripe_size) '_wide'];

            % Left side
            elseif p == 2

                blanking_inds = 1:96;
                blanking_inds(5:36) = 0;
                blanking_inds = blanking_inds(blanking_inds~=0);

                Pats(:,blanking_inds,:) = repmat(mid,[32,64,size(Pats,3)]);
                pattern_name = [name 'left_field_' num2str(stripe_size) '_wide'];

            % Right side
            elseif p == 3
                
                % To make the L and R mirror symmetric, shift the R pattern
                % half wavelength. This is probably important for very slow
                % speeds. use pat_steps b/c wavelength rp = 2 * bar size
                for i = 1:pat_steps
                    Pats(:,:,i) = circshift(Pats(:,:,i)',pat_steps/2)';
                end                
                
                blanking_inds = 1:96;
                blanking_inds(53:84) = 0;
                blanking_inds = blanking_inds(blanking_inds~=0);

                Pats(:,blanking_inds,:) = repmat(mid,[32,64,size(Pats,3)]);
                pattern_name = [name 'right_field' num2str(stripe_size) '_wide'];            
                
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
end