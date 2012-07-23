
 clearvars -EXCEPT -REGEXP aaa
 
flicker_offsets = [0 1 2 3];

pattern.x_num = 48; 	% 12 frames before repeat 
pattern.y_num = length(flicker_offsets); 		
pattern.num_panels = 48;
pattern.gs_val = 3;
pattern.row_compression = 1;

Pats = zeros(4, 96, pattern.x_num, pattern.y_num); 	%initializes the array with zeros

% make grating patterns, periods are 120 and 60 degrees, using all 8 gscale values

% Setting frames in Y channel
for j = 1:pattern.y_num
Pats(:, :, 1, j) = repmat([3*ones(4,4), 6*ones(4,4)], 1,12);
end

% Setting frames in X channel
for i =1:pattern.y_num
  for j = 2:pattern.x_num % accounting for each frame in x except frame 1
    if mod(j,6) == 0
        Pats(:,:,j,i) = ShiftMatrix(Pats(:,:,j-2,i),1,'r','y'); % use ShiftMatrixPats to rotate stripe image
    else
        Pats(:,:,j,i) = Pats(:,:,j-1,i);
    end
    
  end
end
    
for j = 1:length(flicker_offsets)
    j
    flicks = [];unflicks = [];
    for ko = [6 12+6 6+12*2 6+12*3]
    flick = ko+flicker_offsets(j):ko+flicker_offsets(j)+(pattern.x_num/8)-1;
    
    for ii = 1:length(flick)
        if flick(ii)>pattern.x_num
            flick(ii) = flick(ii)-pattern.x_num;
        end
    end
    
    flicks = [flicks flick];
    end
    
  for kk = flicks
    Ind_6 = find(Pats(:,:,kk,j) == 6);
    [I,J] = ind2sub([4 24],Ind_6);
    
    for k = 1:length(I)
          Pats(I(k),J(k),kk,j) = 0;
    end
        
  end
  
end
% 

pattern.Pats = Pats;
        new_controller_48_panel_map =   [12  8  4 11  7  3 10  6  2  9  5  1;
                                         24 20 16 23 19 15 22 18 14 21 17 13;
                                         36 32 28 35 31 27 34 30 26 33 29 25;
                                         48 44 40 47 43 39 46 42 38 45 41 37];

pattern.Panel_map = new_controller_48_panel_map;
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = Make_pattern_vector(pattern);
name = 'Pattern_002_2_phasediffs_48_4wide_after_rotation';
save_dir = '/Users/holtzs/tethered_flight_arena_code/patterns/reverse_phi_double_check_patterns';
pat_path = fullfile(save_dir,name);
save(pat_path, 'pattern');
