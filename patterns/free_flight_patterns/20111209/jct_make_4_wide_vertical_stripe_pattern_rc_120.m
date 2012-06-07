%Make_4_wide_vertical_stripe_pattern_rc_120

pattern.x_num = 8;
pattern.y_num = 1; % There is no vertical motion; only one frame is needed
pattern.num_panels = 120; % This is the number of unique Panel IDs required.
pattern.gs_val = 2; % This pattern will be binary , so grey scale code is 1;
pattern.row_compression = 1;

% 24 panels in a circle -> 192 columns, 5 panel high
InitPat = zeros(5,192); %initializes the array with zeros

InitPat = [repmat([ones(5,4), zeros(5,4)], 1,24)];

Pats = zeros(5, 192, pattern.x_num, pattern.y_num);

Pats(:,:,1,1) = InitPat;

for j = 2:8
    Pats(:,:,j,1) = ShiftMatrix(Pats(:,:,j-1,1), 1, 'r', 'y'); 
end

pattern.Pats = Pats;

pattern.Panel_map = [120 116 112 108 104 100 119 115 111 107 103 99 118 114 110 106 102 98 117 113 109 105 101 97;...
                    96 92 88 84 80 76 95 91 87 83 79 75 94 90 86 82 78 74 93 89 85 81 77 73;...                    
                    72 68 64 60 56 52 71 67 63 59 55 51 70 66 62 58 54 50 69 65 61 57 53 49;...
                    48 44 40 36 32 28 47 43 39 35 31 27 46 42 38 34 30 26 45 41 37 33 29 25;...
                    24 20 16 12 8 4 23 19 15 11 7 3 22 18 14 10 6 2 21 17 13 9 5 1];

%pattern.Panel_map = fliplr(pattern.Panel_map);
                 
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\tethered_flight_arena_code\patterns\free_flight_patterns\20111209';

str = [directory_name '\Pattern_4_wide_vertical_stripe_rc_120']
save(str, 'pattern');