% Kitchen Sink Protocol - Pat_07_half_vertical_horizontal_4_8_12
% Make equally spaced horizontal and vertical stripes. UP/DOWN in the X, widths in Y.
% Easiest way is to just make both and line them up.

    pattern.x_num = 192;
    pattern.y_num = 4;
    pattern.num_panels = 120;
    pattern.gs_val = 1;
    pattern.row_compression = 0;
    
    % Horizontal Component
    % 24 panels in a circle -> 192 columns, 5 panel high
    h_Pats = zeros(40, 192, pattern.x_num, pattern.y_num);
    tPats = []; temp = [];
    y = 0;
    for dims = [{4; -2}, {8; 0}, {12; -10}, {24; -16}]
        y = y+1;
        width = 192;
        size = dims{1};
        reps = ceil(40/(size*2));
        tPats = repmat([0*ones(size,width); ones(size,width)]',1,reps)'; 
        % Center them
        offset = dims{2};
        tPats = circshift(tPats,offset);
        
        for g = 1
            temp =  circshift(tPats,-g+1);
            h_Pats(:,:,g,y) = temp(1:40,1:192);
            temp = [];
        end
        tPats = [];
    end
    
    % Vertical component
    
    % 24 panels in a circle -> 192 columns, 5 panel high
    v_Pats = zeros(40, 192, pattern.x_num, pattern.y_num);
    y = 0;
    for dims = [{4; -2}, {8; -4}, {12; -5}, {24; -12}]
        y = y+1;
        size = dims{1};
        offset = dims{2};
        reps = 192/(size*2);
        v_Pats(:,:,1,y) = repmat([0*ones(40,size) 1*ones(40,size)],1,reps); 
        v_Pats(:,:,1,y) = circshift(v_Pats(:,:,1,y)',offset)';
    end
    
    % Combine.
    Pats = zeros(5, 192, pattern.x_num, pattern.y_num);
    for i = 1:pattern.y_num
        Pats(1:40,1:96,1,i) = (v_Pats(1:40,1:96,1,i));
        Pats(1:40,97:192,1,i) = (h_Pats(1:40,97:192,1,i));
        for g = 1:pattern.x_num;
            Pats(:,:,g,i) = circshift(Pats(:,:,1,i)',g-1)';
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
    directory_name = 'C:\Users\holtzs\Desktop\Dropbox\Dropbox\ReiserLab\kitchen_sink\';

    str = [directory_name 'Pattern_07_half_vertical_horizontal_4_8_12'];
    save(str, 'pattern');