% Kitchen Sink Protocol - Pat_03_horizon_movements
% Make equally spaced horizontal stripes. UP/DOWN in the X Polarity in Y.

    pattern.x_num = 41;
    pattern.y_num = 4;
    pattern.num_panels = 120;
    pattern.gs_val = 1;
    pattern.row_compression = 0;

    % 24 panels in a circle -> 192 columns, 5 panel high
    Pats = zeros(40, 192, pattern.x_num, pattern.y_num);
    tPats = []; temp = [];
    
    shift_vec = sort([round(linspace(0,40,96))]);
    shift_vec = [shift_vec fliplr(shift_vec)];
            
    for y = [1 2 3 4]
        width = 192;
        height = 40;
        if y == 1 || y == 3;
            mult = [1 0];
        elseif y == 2 || y == 4;
            mult = [0 1];
        end
        
        if y == 3
            tPats = repmat([mult(1)*ones(height*2,width); mult(2)*ones(height*2,width)]',1,1)'; 
            for g = size(tPats,2):-1:1
               tPats(:,g) = circshift(tPats(:,1),-shift_vec(g)); 
            end
        elseif y == 4
            tPats = repmat([mult(1)*ones(height*2,width); mult(2)*ones(height*2,width)]',1,1)'; 
            for g = size(tPats,2):-1:1
               tPats(:,g) = circshift(tPats(:,1),-shift_vec(g)); 
            end
            
        else
            tPats = repmat([mult(1)*ones(height,width); mult(2)*ones(height,width)]',1,2)'; 
        end
            
        for g = 1:pattern.x_num;
            temp =  circshift(tPats,-g+1);
            Pats(:,:,g,y) = temp(1:40,1:192);
%             imagesc(Pats(:,:,g,y));
%             pause;
            temp = [];
        end
        
        tPats = [];
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

    str = [directory_name 'Pattern_03_horizon_movements'];
    save(str, 'pattern');