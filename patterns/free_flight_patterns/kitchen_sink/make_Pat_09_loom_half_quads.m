% Kitchen Sink Protocol - Pat_09_loom_half_quads
% Loom from one of several places. Either one side, each half or each
% quadrant. . From Dhruv's original screen.

pattern.x_num = 100;
pattern.y_num = 7;
pattern.num_panels = 120;
pattern.gs_val = 1;
pattern.row_compression = 0;

y = 0;
Pats = zeros(40, 192, pattern.x_num, pattern.y_num);

 for quad_types = [1 2 3 4 5 6 7]
    y = y +1;
    l_over_v = 50;
    d = 4.5/(1.25/8); % to convert from inches to pixels (1.25in is the size of a single LED panel)
    t = -1000:10:-10;
    theta = -2*atan(l_over_v./t);
    l = d*tan(theta/2);

    tPats = ones([40, 48, length(t)]);
    tPats(20:21,24:25,1) = 0;
    tPats = repmat(tPats, [1 4 1 1]);
    sel = ones([3,3,1]);

    cur_img = tPats(:,:,1);
    prev_l = 2;

    for i=1:numel(l)
        cur_l = 2*round(l(i));
        if cur_l > prev_l,
            prev_l = cur_l;
            cur_img = imerode(cur_img, sel);
        end
        
        % mask it
        temp = [cur_img(:,1:48), cur_img(:,49:96),cur_img(:,97:145), cur_img(:,146:192)];
        
        Pats(:,:,i,y) = temp ;
    
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
    
str = [directory_name 'Pattern_09_loom_half_quads'];
save(str, 'pattern');
