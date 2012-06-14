% Make different contrast comparison patterns, holding one stripe constant
% and sweeping through the other values -- i.e. hold at x and do x vs sweep
% on both sides -- 32 conditions 8 8 || 8 8 
% In this set do it with a background of 1 and sweep between 
pattern.x_num = 49;
pattern.y_num = 32;
pattern.num_panels = 48;
pattern.gs_val = 4;
pattern.row_compression = 1;

bckVals = [15 1];
staticVals = [1 15];
changingVals = 1:2:15;
yVal = 1;
barSize = 4;

% Initialize the Pats matrix
Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

for m = 1:numel(bckVals)
    for dir = 1:2
    for w = 1:numel(changingVals);
        Pats(:,:,1,yVal) = [bckVals(m)*ones(4,96)];
        for colPos = 1:48
        if dir == 1;
        if colPos < barSize
        Pats(:,:,colPos+1,yVal) = [bckVals(m)*ones(4,48-colPos)  changingVals(w)*ones(4,colPos) staticVals(m)*ones(4,colPos) bckVals(m)*ones(4,48-colPos)];
        
        else filler = repmat(bckVals(m)*ones(4,colPos-barSize),1,2);
        Pats(:,:,colPos+1,yVal) = [bckVals(m)*ones(4,48-colPos)   changingVals(w)*ones(4,barSize) filler staticVals(m)*ones(4,barSize) bckVals(m)*ones(4,48-colPos)];
        
        end
        elseif dir == 2;
        if colPos < barSize
        Pats(:,:,colPos+1,yVal) = [bckVals(m)*ones(4,48-colPos) staticVals(m)*ones(4,colPos) changingVals(w)*ones(4,colPos) bckVals(m)*ones(4,48-colPos)];
        
        else filler = repmat(bckVals(m)*ones(4,colPos-barSize),1,2);
        Pats(:,:,colPos+1,yVal) = [bckVals(m)*ones(4,48-colPos) staticVals(m)*ones(4,barSize) filler changingVals(w)*ones(4,barSize) bckVals(m)*ones(4,48-colPos)];
        
        end
        end
        end
    yVal = yVal+1;
    end
    end
end
% % Center all patterns
for g = 1:pattern.y_num;
    for i = 1:pattern.x_num
    Pats(:,:,i,g) = circshift(Pats(:,:,i,g)',-barSize)';
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
directory_name = 'C:\tethered_flight_arena_code\patterns\contrast_sensitivity_patterns\20120109';
str = [directory_name '\Pattern_02_contrast_preference_bars_gs4_sweep_1_15'];
save(str, 'pattern');
