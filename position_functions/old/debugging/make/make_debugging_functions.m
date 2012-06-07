% debugging functions2

initPos = 48;

dunk = make_sine_wave_function(2, 100, 1);

startSwipe = dunk*3+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] %five positions
    func = [func (startSwipe + g)];                                        %#ok<*AGROW>
end
func = round(func);

cd('R:\slh_database\functions\debugging\')
save('position_function_01_125deg_s_5pos_3pix_amp','func')

startSwipe = dunk*4+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] 
    func = [func  (startSwipe + g)];
end
func = round(func);

cd('R:\slh_database\functions\debugging\')
save('position_function_02_125deg_s_5pos_4pix_amp','func')

startSwipe = dunk*6+initPos;
func = [48 48 48 48 48];
for g = [0 -24 0 12 0 0 0 24 0 -12] %five positions
    func = [func  (startSwipe + g)];
end
func = round(func);

cd('R:\slh_database\functions\debugging\')
save('position_function_03_125deg_s_5pos_6pix_amp','func')

func = sort([0:95 0:95]);
   func = [func repmat(func(numel(func)),1,40)];
    
cd('R:\slh_database\functions\debugging\')
save('position_function_04_x_steps_1_to_96cw','func')

func = sort(([0:95 0:95]),'descend'); 
    func = [func repmat(func(numel(func)),1,40)];
cd('R:\slh_database\functions\debugging\')
save('position_function_05_x_steps_96_to_1ccw','func')

func = sort((repmat((38:2:57),1,4)));
cd('R:\slh_database\functions\debugging\')
save('position_function_06_xchan_39to58_each','func')

func = sort((repmat((0:4),1,40)));
cd('R:\slh_database\functions\debugging\')
save('position_function_07_ychan_0to4_40each','func')
