% Make patterns for the chasing incedence optimization 
% Makes an all on pattern of changing intensity values in the y channel
% with greyscale value 3.

% It rotates about the x just because.

    pattern.x_num = 192;
    pattern.y_num = 8;         % There will be one frame per gs value
    pattern.num_panels = 120;
    pattern.gs_val = 3;         % Need full gs values
    pattern.row_compression = 1;

    % 24 panels in a circle -> 192 columns, 5 panel high
    Pats = zeros(5, 192, pattern.x_num, pattern.y_num);

    for gs = 0:6
        y = gs+1;
       Pats(:,:,:,y) = gs*ones(5,192,192); 
    end
    
    for i = 1:pattern.y_num
        for g = 1:pattern.x_num;
            Pats(:,:,g,i) = circshift(Pats(:,:,1,i)',g)';
        end
    end
    pattern.Pats = Pats;

    pattern.Panel_map = [120 116 112 108 104 100 119 115 111 107 103 99 118 114 110 106 102 98 117 113 109 105 101 97;...
                        96 92 88 84 80 76 95 91 87 83 79 75 94 90 86 82 78 74 93 89 85 81 77 73;...                    
                        72 68 64 60 56 52 71 67 63 59 55 51 70 66 62 58 54 50 69 65 61 57 53 49;...
                        48 44 40 36 32 28 47 43 39 35 31 27 46 42 38 34 30 26 45 41 37 33 29 25;...
                        24 20 16 12 8 4 23 19 15 11 7 3 22 18 14 10 6 2 21 17 13 9 5 1];

    pattern.BitMapIndex = process_panel_map(pattern);
    pattern.data = make_pattern_vector(pattern);
    directory_name = 'C:\tethered_flight_arena_code\patterns\free_flight_patterns\chasing_optimization';

    str = [directory_name '\Pattern_99_all_on_gs_3'];
    save(str, 'pattern');