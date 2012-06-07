% This is a short attempt at a small 'world' for controller debugging and
% possibly a learning paradigm

% Pattern will be 3x as 'big' as an arena
pattern.x_num = 288;
pattern.y_num = 3;
pattern.num_panels = 48;
% pattern.gs_val = 4;     
pattern.gs_val = 2;     
pattern.row_compression = 0;

% Safe zone will have some brighter and darker pixels so the flies don't
% give up flying
% sz = [14, 12, 12, 12, 12, 12, 10];
sz = [3 3 3 3 2 2 1 0];

% Three y channels in this iteration:
    % 1: no laser, no zone [to see if there is some bias in random pattern]
    % 2: no laser, yes zone [to check natural avoidance/fixation on the
    % doom zone]
    % 3: yes laser, yes zone [to check for laser's coupling effects];
    
    % Initialize Pats mat, and 
    Pats = zeros(32, 96, pattern.x_num, pattern.y_num);

    % Create the random background from the save zone values sz, the most
    % inefficent way possible!
    sz_pat{1} = reshape(sz([randi(numel(sz),size(Pats,1)*size(Pats,2),1)]),32,96);
    sz_pat{2} = reshape(sz([randi(numel(sz),size(Pats,1)*size(Pats,2),1)]),32,96);
    sz_pat{3} = reshape(sz([randi(numel(sz),size(Pats,1)*size(Pats,2),1)]),32,96);
    
    safe_zone = [sz_pat{1} sz_pat{2} sz_pat{3}];
    
    % Create the doom zone pattern and define the doom zone area
    doom_zone_size = size(safe_zone,2)/6;
    doom_zone_area = doom_zone_size+1:(doom_zone_size*2);
    
    % Now consisting of vertical zig zags!
%     a = 2; b = 12;
    a = 0; b = 3;
    zig = [ a a a a b b b b ]; 
    zig = repmat(zig,1,6);
    ind = 1;
    
    for y = [ 0 1 2 3 4 3 2 1];
            zag(ind,:) = circshift(zig',y)';
            ind = ind + 1;
    end
     doom_zone = repmat(zag,4,1);
     
for pat = 1:3
    % the dw mat that Pats will be masked from
    dw = zeros(32,pattern.x_num,pattern.x_num,pat);
    
    switch pat
        case 1
            dw(:,:,:,pat) = repmat(safe_zone,[1 1 pattern.x_num]);
        case {2,3}
            dw(:,:,:,pat) = repmat(safe_zone,[1 1 pattern.x_num]);
            dw(:,[doom_zone_area],:,pat) = repmat(doom_zone,[1 1 pattern.x_num]);      
    end
        
    for x = 1:pattern.x_num
        dw(:,:,x,pat) = circshift(dw(:,:,x,pat)',(x-1))';
    end
    
    window = 1:96;
    for x = 1:pattern.x_num
        Pats(:,:,x,pat) = dw(:,window,x,pat);
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
pat_name = 'Pattern_02_laser_doom_world_v1';
loc = fullfile('C:','tethered_flight_arena_code','patterns','laser_doom_world','20120113',...
    pat_name);
save(loc, 'pattern');
