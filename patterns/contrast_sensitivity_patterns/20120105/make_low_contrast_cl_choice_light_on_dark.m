% Make static luminance preference patterns

% Y = 1 is regular light on dark stripe
% Y = 2 is |.9| |1|  |.9|
% Y = 3 is |1|  |.9| |1|
% Y = 4 is |1|  |1|  |1|
% Y = 5 is |1|  |.9| |.8|
% Y = 1:5 - 1 px, 6:10 -2 px etc up to 30
% clear all

pattern.x_num = 96;          % x is all frames of one expansion
pattern.y_num = 80;           % y is different starting positions of expansion, one for each ordinate positin in the arena
pattern.num_panels = 48;     
pattern.gs_val = 4;          % for later mod to reverse phi
pattern.row_compression = 1; % so only make [ L M N O ] with L = 4 (one per panel)


bck = 2; %0
b1 = 10; %1
b2 = 8; %.78 
b3 = 7; %.45

yset = 1:5;
Pats = zeros(4, 96, pattern.x_num, pattern.y_num);

for pxSize = 1:16
gap = 32-pxSize;
nongap = pxSize;
Pats(:,:,1,yset(1)) = [b1*ones(4,pxSize) bck*ones(4,96-pxSize)];
Pats(:,:,1,yset(2)) = [b2*ones(4,pxSize) bck*ones(4,gap) b1*ones(4,pxSize) bck*ones(4,gap) b2*ones(4,pxSize) bck*ones(4,gap)];
Pats(:,:,1,yset(3)) = [b1*ones(4,pxSize) bck*ones(4,gap) b2*ones(4,pxSize) bck*ones(4,gap) b1*ones(4,pxSize) bck*ones(4,gap)];
Pats(:,:,1,yset(4)) = [b1*ones(4,pxSize) bck*ones(4,gap) b1*ones(4,pxSize) bck*ones(4,gap) b1*ones(4,pxSize) bck*ones(4,gap)];
Pats(:,:,1,yset(5)) = [b1*ones(4,pxSize) bck*ones(4,gap) b2*ones(4,pxSize) bck*ones(4,gap) b3*ones(4,pxSize) bck*ones(4,gap)];

for g = min(yset):max(yset);
    for i = 2:pattern.x_num
    Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i-1,g), 1, 'r', 'y'); 
    end
end
% Make the single stripe centered on 1
sstripebaseshift = 44;
ssshift = round(44 - pxSize/2);
for g = min(yset); %to center on panel 3 we need a 3 pixel shift
    for i = 1:pattern.x_num
%     Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), shift, 'r', 'y');
    Pats(:,:,i,g) = circshift(Pats(:,:,i,g)',ssshift)';
    end
end

% Make the 3 stripe conditions centered on 1
baseshift = 12;
shift = round(12 - pxSize/2);
for g = min(yset+1):max(yset); %to center on panel 3 we need a 3 pixel shift
    for i = 1:pattern.x_num
%     Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), shift, 'r', 'y');
    Pats(:,:,i,g) = circshift(Pats(:,:,i,g)',shift)';
    end
end

% Center all patterns on xpos = 49
for g = min(yset):max(yset); %to center on panel 3 we need a 3 pixel shift
    for i = 1:pattern.x_num
%     Pats(:,:,i,g) = ShiftMatrix(Pats(:,:,i,g), shift, 'r', 'y');
    Pats(:,:,i,g) = circshift(Pats(:,:,i,g)',-48)';
    end
end

yset = yset + 5;

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
directory_name = 'C:\tethered_flight_arena_code\patterns\contrast_sensitivity_patterns\20120105';
str = [directory_name '\Pattern_05_low_contrast_cl_choice_light_on_dark'];
save(str, 'pattern');
