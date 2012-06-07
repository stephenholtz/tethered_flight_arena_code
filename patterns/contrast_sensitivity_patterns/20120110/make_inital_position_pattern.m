%% Make 1 mobile 4px stripe

pattern.x_num = 96;           % x is all frames of one expansion
pattern.y_num = 2;           % y is different starting positions of expansion
pattern.num_panels = 48;
pattern.gs_val = 3;          % for later mod to reverse phi
pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)

Pats = zeros(4, 96, pattern.x_num, pattern.y_num+1);
Pats(:,:,1,1) = [1*ones(4,4) 5*ones(4,92)];

% make the stripe move around the arena once in the x frames
for g = 1
    for i = 2:pattern.x_num
    Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i-1,g), 1, 'r', 'y');
    end
end

for g = 1;
    for i = 1:pattern.x_num
    Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), 2, 'r', 'y');
    end
end

%% Add expansion and contraction 

% make a pattern of alternating 6 column stripes for the whole arena
Pats(:,:,1,2) = [repmat([5*ones(4,4), 1*ones(4,4)], 1, 6),...
    repmat([1*ones(4,4), 5*ones(4,4)], 1, 6)];

% use simple expansion on the pattern
for i = 2
    for j = 2:pattern.x_num 
    Pats(:,:,j,i) = simple_expansion(Pats(:,:,j-1,i), 49,96);    %centered expansion, from 96/2 + 1    
    end
end

for g = 2; %to center on right we need a 3 pixel shift
    for i = 1:pattern.x_num
    Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), 28, 'l', 'y');
    end
end


for g = 1; %to center on panel 3 we need a 3 pixel shift
    for i = 1:pattern.x_num
    Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), 8, 'l', 'y');
    end
end

%% complete the LR pattern
pattern.Pats = Pats;
new_controller_48_panel_map =   [12  8  4 11  7  3 10  6  2  9  5  1;
                                 24 20 16 23 19 15 22 18 14 21 17 13;
                                 36 32 28 35 31 27 34 30 26 33 29 25;
                                 48 44 40 47 43 39 46 42 38 45 41 37];
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\tethered_flight_arena_code\patterns\contrast_sensitivity_patterns\20120110';
str = [directory_name '\Pattern_01_pretest_pattern'];
save(str, 'pattern'); 
