%Make_8_wide_3_vertical_stripe_pattern_shift_60

n_stripes = 3; % Number of vertical stripes

if not(mod(24,n_stripes)) == 0
    disp('Number of stripes needs to be divisible by 24');
else
    pattern.x_num = 192;
    pattern.y_num = 1; % There is no vertical motion; only one frame is needed
    pattern.num_panels = 120; % This is the number of unique Panel IDs required.
    pattern.gs_val = 2; % This pattern will be binary , so grey scale code is 1;
    pattern.row_compression = 1;

    % 24 panels in a circle -> 192 columns, 5 panel high
    InitPat = 3*ones(5,192); %initializes the array with zeros

    for i = 1:n_stripes
        n = 0;
        panel = (i-1)*8 + 1;
        col = (panel-1)*8 + 1;
        InitPat(1:5,col:col+8-1) = n*ones(5,8);
    end    
        
    Pats = zeros(5, 192, pattern.x_num, pattern.y_num);

    for g = 1:pattern.x_num;
        Pats(:,:,g,1) = circshift((InitPat'),g)';
    end
    
    pattern.Pats = Pats;

    pattern.Panel_map = [120 116 112 108 104 100 119 115 111 107 103 99 118 114 110 106 102 98 117 113 109 105 101 97;...
                        96 92 88 84 80 76 95 91 87 83 79 75 94 90 86 82 78 74 93 89 85 81 77 73;...                    
                        72 68 64 60 56 52 71 67 63 59 55 51 70 66 62 58 54 50 69 65 61 57 53 49;...
                        48 44 40 36 32 28 47 43 39 35 31 27 46 42 38 34 30 26 45 41 37 33 29 25;...
                        24 20 16 12 8 4 23 19 15 11 7 3 22 18 14 10 6 2 21 17 13 9 5 1];

    pattern.BitMapIndex = process_panel_map(pattern);
    pattern.data = make_pattern_vector(pattern);
    directory_name = 'C:\tethered_flight_arena_code\patterns\free_flight_patterns\20111209';

    str = [directory_name '\Pattern_01_wide_3_vertical_stripe_same_contrast'];
    save(str, 'pattern');
end

clear pattern str InitPat

n_stripes = 3; % Number of vertical stripes

if not(mod(24,n_stripes)) == 0
    disp('Number of stripes needs to be divisible by 24');
else
    pattern.x_num = 192;
    pattern.y_num = 1; % There is no vertical motion; only one frame is needed
    pattern.num_panels = 120; % This is the number of unique Panel IDs required.
    pattern.gs_val = 2; % This pattern will be binary , so grey scale code is 1;
    pattern.row_compression = 1;

    % 24 panels in a circle -> 192 columns, 5 panel high
    InitPat = 3*ones(5,192); %initializes the array with zeros

    for i = 1:n_stripes
        if i == 1 || i == 3; n = 1; else n = 0; end
        panel = (i-1)*8 + 1;
        col = (panel-1)*8 + 1;
        InitPat(1:5,col:col+8-1) = n*ones(5,8);
    end    
        
    Pats = zeros(5, 192, pattern.x_num, pattern.y_num);

    for g = 1:pattern.x_num;
        Pats(:,:,g,1) = circshift((InitPat'),g)';
    end
    
    pattern.Pats = Pats;

    pattern.Panel_map = [120 116 112 108 104 100 119 115 111 107 103 99 118 114 110 106 102 98 117 113 109 105 101 97;...
                        96 92 88 84 80 76 95 91 87 83 79 75 94 90 86 82 78 74 93 89 85 81 77 73;...                    
                        72 68 64 60 56 52 71 67 63 59 55 51 70 66 62 58 54 50 69 65 61 57 53 49;...
                        48 44 40 36 32 28 47 43 39 35 31 27 46 42 38 34 30 26 45 41 37 33 29 25;...
                        24 20 16 12 8 4 23 19 15 11 7 3 22 18 14 10 6 2 21 17 13 9 5 1];

    pattern.BitMapIndex = process_panel_map(pattern);
    pattern.data = make_pattern_vector(pattern);
    directory_name = 'C:\tethered_flight_arena_code\patterns\free_flight_patterns\20111209';

    str = [directory_name '\Pattern_02_wide_3_vertical_stripe_diff_contrast'];
    save(str, 'pattern');
end
