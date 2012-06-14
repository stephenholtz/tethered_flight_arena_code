%% Position functions simple sweep back and forth for following

initPos = 48;

dunk = make_sine_wave_function(2, 100, 1);

startSwipe = dunk*3+initPos;
func = [48 48 48 48 48];
for g = [0 0 0 0] %five times
    func = [func (startSwipe + g)];                                        %#ok<*AGROW>
end

real_t90 = numel(func);

func = [func repmat(func(numel(func)),1,numel(func)*5)];

func = round(func);

cd('R:\slh_database\functions\20111031\')
save('position_function_90_125deg_s_1pos_3pix_amp','func')