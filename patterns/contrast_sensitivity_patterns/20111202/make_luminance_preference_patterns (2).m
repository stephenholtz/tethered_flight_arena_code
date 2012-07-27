% Make static luminance preference patterns

% Y = 1 is regular dark on bright stripe 
% Y = 2 is |.9| |1|  |.9|
% Y = 3 is |1|  |.9| |1|
% Y = 4 is |1|  |1|  |1|
% Y = 5 is |1|  |.9| |.8|
% clear all

pattern.x_num = 96;          % x is all frames of one expansion
pattern.y_num = 5;           % y is different starting positions of expansion, one for each ordinate positin in the arena
pattern.num_panels = 48;     
pattern.gs_val = 3;          % for later mod to reverse phi
pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)

bck = 7; %0
b1 = 0; %100
b2 = 1; %93.75% 
b3 = 3; %87.50%

Pats = zeros(4, 96, pattern.x_num, pattern.y_num);
Pats(:,:,1,1) = [b1*ones(4,4) bck*ones(4,92)];
Pats(:,:,1,2) = [b2*ones(4,4) bck*ones(4,28) b1*ones(4,4) bck*ones(4,28) b2*ones(4,4) bck*ones(4,28)];
Pats(:,:,1,3) = [b1*ones(4,4) bck*ones(4,28) b2*ones(4,4) bck*ones(4,28) b1*ones(4,4) bck*ones(4,28)];
Pats(:,:,1,4) = [b1*ones(4,4) bck*ones(4,28) b1*ones(4,4) bck*ones(4,28) b1*ones(4,4) bck*ones(4,28)];
Pats(:,:,1,5) = [b1*ones(4,4) bck*ones(4,28) b2*ones(4,4) bck*ones(4,28) b3*ones(4,4) bck*ones(4,28)];

for g = 1:pattern.y_num;
    for i = 2:pattern.x_num
    Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i-1,g), 1, 'r', 'y'); 
    end
end

for g = 1:pattern.y_num; %to center on panel 3 we need a 3 pixel shift
    for i = 1:pattern.x_num
    Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), 4, 'r', 'y');
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
directory_name = 'R:\slh_database\patterns\20111202';
str = [directory_name '\Pattern_01_luminance_preference_patterns'];
save(str, 'pattern');
