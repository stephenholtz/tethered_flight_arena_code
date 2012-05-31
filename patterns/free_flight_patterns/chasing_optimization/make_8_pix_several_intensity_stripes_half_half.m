% Make patterns for the chasing incedence optimization 
% Makes 8 pixel stripes with changing intensities in the y channels, per
% each half of the arena and rotation in the x channels.

    pattern.x_num = 192;
    pattern.y_num = 5;
    pattern.num_panels = 120;
    pattern.gs_val = 3;
    pattern.row_compression = 1;

    % 24 panels in a circle -> 192 columns, 5 panel high
    Pats = zeros(5, 192, pattern.x_num, pattern.y_num);
    
    y = 0; size = 8; %8 pix wide for each
    % Give the intensities as two pairs, L1 L2 and R1 R2
    for intensity = {[4 2 7 4],[4 2 7 7], [4 2 0 0], [7 4 7 7], [7 4 0 0]}
        y = y+1;    
        reps = 192/(size*4);
        % Make each half of the pattern.        
        Pats(:,:,1,y) = [repmat([intensity{1}(1)*ones(5,size) intensity{1}(2)*ones(5,size)],1,reps),...
                         repmat([intensity{1}(3)*ones(5,size) intensity{1}(4)*ones(5,size)],1,reps)];
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

    str = [directory_name '\Pattern_05_8_pix_stripes_two_diff_intensities'];
    save(str, 'pattern');