classdef patternFactory < handle
% classdef patternFactory easily makes simple patterns, and is easily
% extended with more methods/properties...
% 
% Call constructor, populate required properties (i.e. lambda,
% row_compression, etc.) and call methods to make desired patterns. Handle
% class with most methods returning the obj. So can use eihter as a mutable
% handle, or use intermediate objects for loops.
% 
% All patterns are by default clockwise.
% 
% SLH 1/2013

    properties (Constant, Access = private)
        
        left_120_deg_window_cols_small_arena = 5:36;
        right_120_deg_window_cols_small_arena = 53:84;
        center_120_deg_window_cols_small_arena = 29:60;
        
        left_60_deg_window_cols_small_arena = 13:28;
        right_60_deg_window_cols_small_arena = 61:76;
        center_60_deg_window_cols_small_arena = 37:52;
        
        % X channel is by default the left, and is the 3rd dimension
        left_pattern_chan_dim = 3
        left_pattern_chan_name = 'x_chan'
        % Y channel is by default the right, and is the 4rd dimension
        right_pattern_chan_dim = 4
        right_pattern_chan_name = 'y_chan'
        
        % All patterns will move clockwise by default
        pattern_movement_direction = 1;
    end
    
    properties (Access = private)
        
        temp_pattern        
    end
    
    properties
        
        % Properties set by constructor
        arena_type
        row_compression
        grayscale_val
        
        % Output of many methods below
        pattern
        
        % Determined by the grayscale_val
        low_val
        mid_val
        high_val
        
        % Determined by the arena_type, and row_compression
        num_arena_cols
        num_arena_rows
    end
	
    methods
    
%-------CONSTRUCTOR, PROPERTY SETTING-------------------------------------%        
        
        function obj = patternFactory(arena_type,row_compression,grayscale_val)
            
            % Only things that have to be constant for the pattern should
            % be set in the constructor.
            obj.arena_type      = arena_type;
            obj.row_compression = row_compression;
            obj.grayscale_val   = grayscale_val;
            
            % For now it makes sense to define high mid and low intensity
            % values here and use those everywhere.
            obj.DetermineLowMidHighIntensityVals;
            
            obj.DetermineNumArenaColsRows;
        end
        
        function DetermineLowMidHighIntensityVals(obj)
            
            switch obj.grayscale_val
                case 1
                    obj.low_val     = 0;
                    obj.mid_val     = 0;
                    obj.high_val    = 1;                    
                case 2
                    obj.low_val     = 0;
                    obj.mid_val     = 1;
                    obj.high_val    = 3;
                case 3
                    obj.low_val     = 0;
                    obj.mid_val     = 3;
                    obj.high_val    = 6;
            end
        end
        
        function DetermineNumArenaColsRows(obj)
            
            switch obj.arena_type
                case {'small','Small'}
                    obj.num_arena_cols = 96;
                    
                    if obj.row_compression
                        obj.num_arena_rows = 4;
                    else
                        obj.num_arena_rows = 32;
                    end
                otherwise
                    error('Unrecognized arena_type')
            end
            
        end
        
        function [out_pattern,row_compressed,gs_val] = ReturnPatternAndParams(obj)
            
            out_pattern     = obj.pattern;
            row_compressed  = obj.row_compression;
            gs_val          = obj.grayscale_val;
            
        end
        
%-------MAKE SIMPLE PATTERNS IN JUST ONE CHANNEL--------------------------%
        
        function obj = SquareWave(obj,bar_width,varargin)
            
            obj.pattern = [];
            
            lambda_reps = obj.num_arena_cols/(bar_width*2);
            lambda_col = [obj.low_val*ones(obj.num_arena_rows,bar_width), obj.high_val*ones(obj.num_arena_rows,bar_width)];
            pat = repmat(lambda_col,1,lambda_reps);
            
            pat_steps = bar_width*2;
            
            for i = 1:pat_steps
                obj.pattern(:,:,i) = circshift(pat',i-1)'; %#ok<*SAGROW>
            end
            
        end
        
        function obj = SquareWaveContrasts(obj,bar_width,contrasts)
            
            obj.pattern = [];
            
            lambda_reps = obj.num_arena_cols/(bar_width*2);
            lambda_col = [contrasts(1)*ones(obj.num_arena_rows,bar_width), contrasts(2)*ones(obj.num_arena_rows,bar_width)];
            pat = repmat(lambda_col,1,lambda_reps);
            
            pat_steps = bar_width*2;
            
            for i = 1:pat_steps
                obj.pattern(:,:,i) = circshift(pat',i-1)'; %#ok<*SAGROW>
            end
            
        end        
        
        function obj = RevPhiSquareWave(obj,bar_width,varargin)

            obj.pattern = [];
            
            lambda_reps = obj.num_arena_cols/(bar_width*2);
            lambda_on   = [obj.mid_val*ones(obj.num_arena_rows,bar_width),...
                          obj.high_val*ones(obj.num_arena_rows,bar_width)];
            lambda_off  = [obj.mid_val*ones(obj.num_arena_rows,bar_width),...
                          obj.low_val*ones(obj.num_arena_rows,bar_width)];

            pattern_on  = repmat(lambda_on,1,lambda_reps);
            pattern_off = repmat(lambda_off,1,lambda_reps);

            % twice as many steps for reverse phi
            pat_steps = bar_width*4;

            for i = 1:pat_steps
                if mod(i,2)
                    obj.pattern(:,:,i) = circshift(pattern_on',i-1)';
                else
                    obj.pattern(:,:,i) = circshift(pattern_off',i-1)';
                end
            end
            
        end
        
        function obj = EdgeFlicker(obj,bar_width,varargin)
            
            obj.pattern = [];
            
            lambda_reps = obj.num_arena_cols/(bar_width*4);
            
            flick_on =  [obj.mid_val*ones(obj.num_arena_rows,bar_width),...
                        obj.low_val*ones(obj.num_arena_rows,bar_width),...
                        obj.mid_val*ones(obj.num_arena_rows,bar_width),...
                        obj.high_val*ones(obj.num_arena_rows,bar_width)];
            flick_off = [obj.mid_val*ones(obj.num_arena_rows,bar_width),...
                        obj.high_val*ones(obj.num_arena_rows,bar_width),...
                        obj.mid_val*ones(obj.num_arena_rows,bar_width),...
                        obj.low_val*ones(obj.num_arena_rows,bar_width)];
            
            obj.pattern(:,:,1) = repmat(flick_on,1,lambda_reps);
            obj.pattern(:,:,2) = repmat(flick_off,1,lambda_reps);
            
        end
        
        function obj = AltBarFlicker(obj,bar_width,varargin)
            
            obj.pattern = [];
            
            lambda_reps = obj.num_arena_cols/(bar_width*2);

            flick_on = [obj.low_val*ones(obj.num_arena_rows,bar_width), obj.high_val*ones(obj.num_arena_rows,bar_width)];
            flick_shift = circshift(flick_on',bar_width)';

            obj.pattern(:,:,1) = repmat(flick_on,1,lambda_reps);
            obj.pattern(:,:,2) = repmat(flick_shift,1,lambda_reps);
            
        end
        
        function obj = FullFieldFlicker(obj,varargin)
            
            obj.pattern = [];
            
            obj.pattern(:,:,1) = obj.high_val*ones(obj.num_arena_rows,obj.num_arena_cols);
            obj.pattern(:,:,2) = obj.low_val*ones(obj.num_arena_rows,obj.num_arena_cols);
           
        end
        
        function obj = SingleBarForEdgeLoop(obj,bar_width,side,motion_type)
            % A very specific stimulus...
            
            obj.pattern = [];
            
            pattern_offset = 4;
            half_mask_size = 8;
            half_arena = 48;
            
            unshifted_bar = [obj.low_val*ones(obj.num_arena_rows,bar_width),...
                            obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-bar_width)];
            
            switch side
                case 'left'
                    switch motion_type
                        case 'progressive'
                            bar = circshift(unshifted_bar',half_arena-pattern_offset-half_mask_size)';
                            dir = -1;
                        case 'regressive'
                            bar = circshift(unshifted_bar',half_mask_size-bar_width-pattern_offset)';
                            dir = 1;
                    end
                
                case 'right'
                    switch motion_type
                        case 'progressive'
                            bar = circshift(unshifted_bar',half_arena-pattern_offset+(half_mask_size-bar_width))';
                            dir = 1;
                        case 'regressive'
                            bar = circshift(unshifted_bar',-half_mask_size-pattern_offset)';
                            dir = -1;
                    end
            end
            
            for i = 1:(half_arena-(half_mask_size-bar_width)-(2*pattern_offset));
                if dir == 1
                    obj.pattern(:,:,i) = circshift(bar',i-1)';
                else
                    obj.pattern(:,:,i) = circshift(bar',1-i)';
                end
            end
            
        end
        
        function obj = SingleBar(obj,bar_width,bar_type,offset_start_pos,relative_loop_vec)
            
            obj.pattern = [];
            pattern_offset = 4;
            
            if ~exist('relative_loop_vec','var')
                relative_loop_vec = 1:obj.num_arena_cols;
            end
            
            switch bar_type
                case {'low'}
                    bar = [obj.low_val*ones(obj.num_arena_rows,bar_width),...
                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-bar_width)];

                case {'high'}
                    bar = [obj.high_val*ones(obj.num_arena_rows,bar_width),...
                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-bar_width)];

                otherwise
                    error('background_type must be low or mid')

            end
            
            % note the -arena_offset to make the standard pattern start behind the fly
            bar = circshift(bar',offset_start_pos-(pattern_offset)-bar_width/2)';
            
            iter = 1;
            for shift = relative_loop_vec
                obj.pattern(:,:,iter) = circshift(bar',shift)';
                iter = iter + 1;
            end
            
        end
        
        function obj = SingleEdge(obj,start_col,direction,edge_type)
            
            obj.pattern = [];
            
            iter = 0;
            
            for i = 1:obj.num_arena_cols
                
                temp_frame = obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols);
                
                switch direction
                    case {'cw',1}
                        % Make an edge growing to the right
                        edge_cols = start_col:(start_col+i-1);                
                        edge_cols(edge_cols > obj.num_arena_cols) = edge_cols(edge_cols > obj.num_arena_cols) - obj.num_arena_cols;
                    case {'ccw',-1,2}
                        % Make an edge growing to the left
                        edge_cols = (start_col-i+1):start_col;
                        edge_cols(edge_cols < obj.num_arena_cols) = edge_cols(edge_cols > obj.num_arena_cols) + obj.num_arena_cols;
                    otherwise
                        error('direction must be cw or ccw')
                end
                
                switch edge_type
                    case {'high'}
                        temp_frame(:,edge_cols) = obj.high_val*ones(obj.num_arena_rows,i);
                    case {'low'}
                        temp_frame(:,edge_cols) = obj.low_val*ones(obj.num_arena_rows,i);
                    otherwise 
                        error('edge_type must be high or low')
                end
                
                if iter > obj.num_arena_cols
                    iter = 1;
                else 
                    iter = iter + 1;
                end
                
                obj.pattern(:,:,iter) = temp_frame;
                
                clear temp_frame
                
            end
            
        end
        
        function obj = MinimalMotion(obj,bar_size,start_cols,direction,edge_type_1,edge_type_2)
            
            % this is terrible, don't look
            
            obj.pattern = [];
            
            switch direction
                
                case {'cw'}

                    switch edge_type_1

                        case {'off'}

                            bar_t_1 = [obj.low_val*ones(obj.num_arena_rows,bar_size),...
                                obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-bar_size)];

                            switch edge_type_2
                                case {'off'}
                                    bar_t_2 = [obj.low_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.low_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(2*bar_size))];
                                case {'on'}
                                    bar_t_2 = [obj.low_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.high_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(2*bar_size))];                            
                            end

                        case {'on'}

                            bar_t_1 = [obj.high_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-bar_size)];                    

                            switch edge_type_2
                                case {'off'}      
                                    bar_t_2 = [obj.high_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.low_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(2*bar_size))];
                                case {'on'}
                                    bar_t_2 = [obj.high_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.high_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(2*bar_size))];                            
                            end

                    end
                    
                case {'ccw'}
                    switch edge_type_1
                        
                        case {'off'}

                            bar_t_1 = [obj.low_val*ones(obj.num_arena_rows,bar_size),...
                                obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-bar_size)];

                            switch edge_type_2
                                case {'off'}
                                    bar_t_2 = [obj.low_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(2*bar_size)),...
                                        obj.low_val*ones(obj.num_arena_rows,bar_size)];
                                case {'on'}
                                    bar_t_2 = [obj.low_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(2*bar_size)),...
                                        obj.high_val*ones(obj.num_arena_rows,bar_size)];
                            end

                        case {'on'}

                            bar_t_1 = [obj.high_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-bar_size)];                    

                            switch edge_type_2
                                case {'off'}      
                                    bar_t_2 = [obj.high_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(2*bar_size)),...
                                        obj.low_val*ones(obj.num_arena_rows,bar_size)];
                                case {'on'}
                                    bar_t_2 = [obj.high_val*ones(obj.num_arena_rows,bar_size),...
                                        obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(2*bar_size)),...
                                        obj.high_val*ones(obj.num_arena_rows,bar_size)];
                            end
                    end
            end
            
            % Get symmetry with cw and ccw... this way
            pattern_offset = 4;
            % make the bar start in a bunch of different places
            
            start_pos_iter = 1;
            for start_pos = start_cols
                
                obj.pattern(:,:,1,start_pos_iter) = circshift(bar_t_1',start_pos-(pattern_offset)-bar_size/2)';
                obj.pattern(:,:,2,start_pos_iter) = circshift(bar_t_2',start_pos-(pattern_offset)-bar_size/2)';
                
                start_pos_iter = start_pos_iter + 1;
                
            end
            
        end
        
        function obj = MakeONOFFEdges(obj,start_loc,jump_size,on_direction)
            
            movement_range = (obj.num_arena_cols/2);
            step_vector = 0:jump_size:movement_range;
            
            x_iter = 1;
            for es = step_vector
                switch on_direction
                    case {'cw'}
                        obj.pattern(:,:,x_iter) = ...
                            [obj.high_val*ones(obj.num_arena_rows,es),...
                            obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(es*2)),...
                            obj.low_val*ones(obj.num_arena_rows,es)];
                            
                    case {'ccw'}
                        obj.pattern(:,:,x_iter) = ...
                            [obj.low_val*ones(obj.num_arena_rows,es),...
                            obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(es*2)),...
                            obj.high_val*ones(obj.num_arena_rows,es)];
                end
                
                x_iter = x_iter + 1;
            end
            
            % second half of the stimulus where both sides 'recede'
            for es = fliplr(step_vector(1:end-1))
                switch on_direction
                    case {'cw'}
                        obj.pattern(:,:,x_iter) = ...
                            [obj.high_val*ones(obj.num_arena_rows,es),...
                            obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(es*2)),...
                            obj.low_val*ones(obj.num_arena_rows,es)];
                            
                    case {'ccw'}
                        obj.pattern(:,:,x_iter) = ...
                            [obj.low_val*ones(obj.num_arena_rows,es),...
                            obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols-(es*2)),...
                            obj.high_val*ones(obj.num_arena_rows,es)];
                end
                
                x_iter = x_iter + 1;
            end
            
            pattern_offset = 4;
            
            % Make whole pattern then shift to the start_loc
            for x = 1:size(obj.pattern,3)
                
                obj.pattern(:,:,x) = circshift(obj.pattern(:,:,x)',start_loc-pattern_offset)';
                
            end
            
        end

        function empty_frame = MakeEmptyMidValFrame(obj,num_frames)
                        
            empty_frame = obj.mid_val*ones(obj.num_arena_rows,obj.num_arena_cols);
            
            if exist('num_frames','var')
               for i = 1:num_frames
                   empty_frame(:,:,i) = empty_frame(:,:,1);
               end
            end
        end
        
%-------MISC USEFUL PATTERN MANIPULATIONS---------------------------------%
        
        function obj = AddPatternLoops(obj,num_loops)
            
            orig_loop_len = size(obj.pattern,3);
            loop_iter = 1;
            iter = orig_loop_len;
            
            for i = 1:(orig_loop_len*num_loops)
                iter = iter + 1;
                
                obj.pattern(:,:,iter) = obj.pattern(:,:,loop_iter);
                
                if loop_iter > orig_loop_len
                    loop_iter = 1;
                else
                    loop_iter = loop_iter+1;
                end
                
            end
        end
        
        function obj = AddDummyFrames(obj,channel_dim,num_frames)
            
            switch channel_dim
                case {3,'x'}
                    obj.temp_pattern = obj.pattern;
                    obj.pattern = [];
                    
                    for i = 1:size(obj.temp_pattern,4)
                        blank_pattern = obj.MakeEmptyMidValFrame(num_frames);
                        
                        blank_pattern(:,:,(1+num_frames):size(obj.temp_pattern,3)+num_frames) = obj.temp_pattern(:,:,:,i);
                        
                        obj.pattern(:,:,:,i) = blank_pattern;
                        
                        clear blank_pattern
                    end
                case {4,'y'}
                    obj.temp_pattern = obj.pattern;
                    obj.pattern = [];
                    
                    for i = 1:size(obj.temp_pattern,3)
                        blank_pattern = obj.MakeEmptyMidValFrame(num_frames);
                        
                        blank_pattern(:,:,:,(1+num_frames):size(obj.temp_pattern,4)+num_frames) = obj.temp_pattern(:,:,i,:);
                        
                        obj.pattern(:,:,:,i) = blank_pattern;
                        
                        clear blank_pattern
                    end
                otherwise
                    error('channel_dim must be 3,''x'',4, or ''y''')
            end
            
            clear obj.temp_pattern;
            
        end % y chan might not work, never tested
        
        function obj = SwitchXYChannels(obj)
            
            temp_pat = obj.pattern;
            obj.pattern = [];
            
            for old_y_iter = 1:size(temp_pat,4)
                for old_x_iter = 1:size(temp_pat,3)
                    obj.pattern(:,:,old_y_iter,old_x_iter) = temp_pat(:,:,old_x_iter,old_y_iter);
                end
            end
            
        end
        
%-------MASK PATTERNS, ETC------------------------------------------------%
        
        function obj = SimpleMask(obj,mask_location,window_size)
            full_cols = 1:obj.num_arena_cols;
            
            if window_size ~= 60 && window_size ~= 120
                error('window_size must be 60 or 120')
            end
            
            switch mask_location
                case {'left'}
                    full_cols(obj.(['left_' num2str(window_size) '_deg_window_cols_small_arena'])) = 0;
                case {'right'}
                    full_cols(obj.(['right_' num2str(window_size) '_deg_window_cols_small_arena'])) = 0;
                case {'center'}
                    full_cols(obj.(['center_' num2str(window_size) '_deg_window_cols_small_arena'])) = 0;
                case {'left+right'}
                    full_cols(obj.(['left_' num2str(window_size) '_deg_window_cols_small_arena'])) = 0;
                    full_cols(obj.(['right_' num2str(window_size) '_deg_window_cols_small_arena'])) = 0;
                otherwise
                    eror('maske_location must be left right or center')
            end
            
            num_mask_cols = sum(~~full_cols);
            
            for j = 1:size(obj.pattern,4)
                for i = 1:size(obj.pattern,3)
                    obj.pattern(:,(~~full_cols),i,j) = obj.mid_val*ones(obj.num_arena_rows,num_mask_cols);
                end
            end
        end
        
        function obj = VerticalTopBottomMaskUncompressedPattern(obj,mask_height)
            % A centered window of mask_height
            
            num_mask_rows = obj.num_arena_rows - mask_height;
            
            full_rows = 1:obj.num_arena_rows;
            non_mask_inds = ((obj.num_arena_rows/2)+1-ceil(mask_height/2)):(obj.num_arena_rows/2)+floor(mask_height/2);
            full_rows(non_mask_inds) = 0;
            
            for j = 1:size(obj.pattern,4)
                for i = 1:size(obj.pattern,3)
                    obj.pattern((~~full_rows),:,i,j) = obj.mid_val*ones(num_mask_rows,obj.num_arena_cols);
                end
            end
            
        end
        
        function obj = MaskTopBottomPanelsInRowCompressedPattern(obj)
            if ~obj.row_compression
                error('pattern must be row compressed to mask with this function')
            end
            
            for j = 1:size(obj.pattern,4)
                for i = 1:size(obj.pattern,3)
                    obj.pattern([1, end],:,i,j) = obj.mid_val*ones(2,obj.num_arena_cols);
                end
            end
            
        end
        
    end
    
    methods (Static)
        
%-------COMBINE PREVIOUSLY MADE PATTERNS IN X AND Y CHANNELS--------------%

        function combined_pattern = AddPatternsBilatLeftRight(left_pat_obj,right_pat_obj,window_size)
            % Right pat obj must be in Y and left must be in X for this to
            % work properly
            
            if window_size ~= 60 && window_size ~= 120
                error('window_size must be 60 or 120')
            end
            
            full_cols = 1:left_pat_obj.num_arena_cols;
            
            left_cols = full_cols;
            left_cols(left_pat_obj.(['left_' num2str(window_size) '_deg_window_cols_small_arena'])) = 0;
            
            right_cols = full_cols;
            right_cols(left_pat_obj.(['right_' num2str(window_size) '_deg_window_cols_small_arena'])) = 0;
            
            for left_iter = 1:size(left_pat_obj.pattern,3)
                for right_iter = 1:size(right_pat_obj.pattern,4)
                    combined_pattern(:,:,left_iter,right_iter) = left_pat_obj.MakeEmptyMidValFrame;
                    combined_pattern(:,~right_cols,left_iter,right_iter) = right_pat_obj.pattern(:,~right_cols,right_iter); %#ok<*AGROW>
                    combined_pattern(:,~left_cols,left_iter,right_iter) = left_pat_obj.pattern(:,~left_cols,left_iter);
                end
            end
           
        end
        
        function shifted_pattern = ShiftWindowedToEdgeStart(pattern,channel,edge_type,has_dummy_frame)
                        
            % the row with the edge is by default in the middle
            row_with_edge = ceil(size(pattern,1)/2);
            
            if has_dummy_frame
                if channel == 'x'
                    full_pat_rows = pattern(row_with_edge,:,2:end,1);
                elseif channel == 'y'
                    full_pat_rows = pattern(row_with_edge,:,1,2:end);
                end
            else
                if channel == 'x'
                    full_pat_rows = pattern(row_with_edge,:,1:end,1);
                elseif channel == 'y'
                    full_pat_rows = pattern(row_with_edge,:,1,1:end);
                end
            end
            
            sq_pat_rows = squeeze(full_pat_rows)';
            
            periodic_rows = sq_pat_rows(:,((min(sq_pat_rows)-max(sq_pat_rows)) ~= 0));
            
            single_row = periodic_rows(1,:);
            
            for i = 2:(size(periodic_rows,1))
                
                prev_val = single_row(i-1);
                curr_val = single_row(i);
                
                shift_amount = 0;
                
                if strcmpi(edge_type,'low')
                    
                    if prev_val == min(single_row) && curr_val == max(single_row) 
                        shift_amount = i-1;
                        break
                    end
                    
                elseif strcmpi(edge_type,'high')
                    
                    if prev_val == min(single_row) && curr_val == max(single_row) 
                        shift_amount = i-1;
                        break
                    end
                end
                
            end            
            
            if has_dummy_frame
            
                if channel == 'x'
                    for i = 2:size(pattern,3)
                        shifted_ind = shift_amount + i;
                        
                        if shifted_ind == size(pattern,3)
                           shifted_ind = shifted_ind - (size(pattern,3) - 1);
                        end
                        
                        shifted_pattern(:,:,shifted_ind,:) = pattern(:,:,i,:);
                        
                    end
                    
                    shifted_pattern(:,:,1,:) = pattern(:,:,1,:);
                    
                elseif channel == 'y'
                    
                    for i = 2:size(pattern,4)
                        shifted_ind = shift_amount + i;
                        
                        if shifted_ind > size(pattern,4)
                           shifted_ind = shifted_ind - (size(pattern,4) - 1);
                        end

                        shifted_pattern(:,:,:,shifted_ind) = pattern(:,:,:,i);
                        
                    end
                    
                    shifted_pattern(:,:,:,1) = pattern(:,:,:,1);
                    
                end                
                
            end
            
        end
        
        function combined_pattern = AddPatternsOverlayedForNulling(x_pat_obj,y_pat_obj,gs_val)
            x_max = max(max(max(x_pat_obj.pattern)));
            y_max = max(max(max(y_pat_obj.pattern)));
            
            if x_max+y_max > gs_val^2
                warning('Summed patterns will exceed maximum intensity for given greyscale level')
            end
            if size(x_pat_obj.pattern,3) ~= size(y_pat_obj.pattern,3)
                warning('Pattern lengths do not match. May be OK.')
            end
            
            for x_iter = 1:size(x_pat_obj.pattern,3)
                for y_iter = 1:size(y_pat_obj.pattern,3)
                    combined_pattern(:,:,x_iter,y_iter) =...
                        y_pat_obj.pattern(:,:,y_iter) + x_pat_obj.pattern(:,:,x_iter);
                end
            end
                        
        end
        
    end
end