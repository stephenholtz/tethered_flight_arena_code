% makes coherence patterns (with various amounts of clutter) This is a very
% simple stimulus: there will be an X% chance that the 2x2 pix will move
% right and a 100 - X% chance it will move to another location on the arena
% Therefore the defenition for coherence is the probability it will move in
% one direction above chance. 
% Clutter levels are arbitrarily created...

% Values for naming the pattern
project = 'telethon_2012_coherence_patterns';
pattern_name = 'coherence_cw_10_20_40_60_pct_medium_clutter';
counter = 35;       % The number of preexisting telethon patterns

% Values for the specific pattern creation
sqr_color = 0;
bck_color = 6;
clutter = .05;
coherence = [.1 .2 .4 .6];

% Values for the pattern file 
% A gain of 48, for a 3 second stim, with 20% give
pattern.x_num = ceil(48*3*1.20); %500; % Arbritrarily long based on desired stim
pattern.y_num = numel(coherence);  % For each coherence or clutter level...
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 0;

% Preallocate the gigantic pattern with background color
Pats = bck_color*ones(32, 96, pattern.x_num, pattern.y_num);

% Define the grid that the squares move on & number of squares
num_rows = 32-1; % allows for x overlap
num_cols = 96-1; % allows for y overlap
max_num_squares = (num_cols*num_rows);
num_squares = floor(max_num_squares*clutter);
n_squares_mat = 1:num_squares;

% Populate random subset, set up indecies that move coherently or relocate
square_inds(1,:) = randi(max_num_squares,[1,num_squares]);        

%For all of the y frames (coherences or clutters)
for g = 1:pattern.y_num
    direction = 1;
    curr_coherence = coherence(g);
    
    num_coh_squares = round(num_squares*curr_coherence);
    
    num_reloc_squares = num_squares-num_coh_squares;
    
    % For the number of frames needed, move with the coherence wanted
    for i = 2:pattern.x_num

        % the squares that will be completely relocated
        relocs = randi(max_num_squares,[1,num_reloc_squares]);
        
        % the squares that will move in the coherent direction, hacky now,
        % but wrapping shouldn't matter because the pattern size is > arena
        % size
        for k = 1:num_coh_squares
            moves(k) = (square_inds(i-1,k)+direction*num_rows)+1;
        end
        
        % combine the two sets of indecies
        square_inds(i,:) = [relocs moves];
        
        relocs = [];
        moves = [];
    end
    
    % For all of the frames made, translate the pattern to the larger actual
    % arena size
    for i = 1:size(square_inds,1)
        for s = 1:numel(square_inds(i,:))
            % hard coded to a square size of two...
            pat_inds = [(square_inds(i,s)+(1:2)), (square_inds(i,s)+1+num_rows)+(1:2)];
            [m,n]=ind2sub([32 96],pat_inds);
            Pats(m,n,i,g) =sqr_color;
        end
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