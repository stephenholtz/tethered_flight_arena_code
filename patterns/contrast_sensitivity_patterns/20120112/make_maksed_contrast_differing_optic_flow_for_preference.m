% Make different contrast comparison patterns, holding one stripe constant
% and sweeping through the other values -- i.e. hold at x and do x vs sweep
% on both sides -- 32 conditions 8 8 || 8 8 In this set do it with a
% background of 1 and sweep between This time the stimulus will be two
% masked boxes of optic flow instead of strips

pattern.x_num = 8;
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
    for side = [1 -1];
    for w = 1:numel(changingVals);
        
        ChangingPatterni(:,:,1) =    repmat(([bckVals(m)*ones(4,4)...
                                     changingVals(w)*ones(4,4)]),1,2);    
        StaticPatterni(:,:,1)   =    repmat(([staticVals(m)*ones(4,4)...
                                     bckVals(m)*ones(4,4)]),1,2);                                
        for RotationAmnt = 0:7
        ChangingPattern(:,:,RotationAmnt+1) = circshift(ChangingPatterni',-side*RotationAmnt)';
        StaticPattern(:,:,RotationAmnt+1) = circshift(StaticPatterni',side*RotationAmnt)';   
        BackgroundPattern(:,:,RotationAmnt+1) = bckVals(m)*ones(4,64); 
        end
        
        clear StaticPatterni ChangingPatterni
        if side == 1;
        Pats(:,17:32,:,yVal) = ChangingPattern;
        Pats(:,57:72,:,yVal) = StaticPattern;
        Pats(:,[1:16 33:56 73:96],:,yVal) = BackgroundPattern;                        
        elseif side == -1;
        Pats(:,17:32,:,yVal) = StaticPattern;
        Pats(:,57:72,:,yVal) = ChangingPattern;
        Pats(:,[1:16 33:56 73:96],:,yVal) = BackgroundPattern;                                
        end
        clear StaticPattrin ChangingPattern
    yVal = yVal+1;        
    end
    end
end

% % Center all patterns
% for g = 1:pattern.y_num;
%     for i = 1:pattern.x_num
%     Pats(:,:,i,g) = circshift(Pats(:,:,i,g)',-barSize)';
%     end
% end


%% complete the LR pattern
pattern.Pats = Pats;
new_controller_48_panel_map =   [12  8  4 11  7  3 10  6  2  9  5  1;
                                 24 20 16 23 19 15 22 18 14 21 17 13;
                                 36 32 28 35 31 27 34 30 26 33 29 25;
                                 48 44 40 47 43 39 46 42 38 45 41 37];
pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);
directory_name = 'C:\tethered_flight_arena_code\patterns\contrast_sensitivity_patterns\20120112';
str = [directory_name '\Pattern_03_masked_contrast_differring_optic_flow_preference_gs4_sweep_1_15'];
save(str, 'pattern');