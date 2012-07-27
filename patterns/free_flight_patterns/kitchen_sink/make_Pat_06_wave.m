% Kitchen Sink Protocol - Pat_06_wave
% Makes a wave that moves clockwise in X (and inverts polarity in Y)

    pattern.x_num = 192;
    pattern.y_num = 2;
    pattern.num_panels = 120;
    pattern.gs_val = 1;
    pattern.row_compression = 0;

    % 24 panels in a circle -> 192 columns, 5 panel high
    Pats = zeros(40, 192, pattern.x_num, pattern.y_num);
    tPats = []; temp = [];
    y = 0;
    
    total_length = 192;
    total_height = 40;
    height = total_height*.75;
    
    % Discretize a sine wave and scale it to 3/4 the height of the arena
    sine_wave = (sin(0:(2*pi/(total_length-1)):2*pi))*height/2 + height/2;
    sine_wave = floor(sine_wave) + ceil((total_height-height)/2);
    
    for polarity = [1 2]
        for col = 1:numel(sine_wave)
            if polarity ==1
                    on = 1; off = 0;
            else
                    on = 0; off = 1;
            end
            Pats(:,col,1,polarity) = [ on*ones(40-sine_wave(col),1) ; off*ones(sine_wave(col),1)];
        end
    end
    
    for y = 1:pattern.y_num;
        for g = 1:pattern.x_num;
            Pats(:,:,g,y) = circshift(Pats(:,:,1,y)',g-1)';
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

    str = [directory_name 'Pattern_06_wave'];
    save(str, 'pattern');