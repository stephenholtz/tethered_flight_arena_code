% Pos func for Pattern_02_single_free_stripe_and_focusing_stim_pattern

% 6, 10 element shifts of 5 pix each
pix = 59:63;
pos45(1:2:(numel(pix)*2)) = pix(1:numel(pix));
pos45(2:2:(numel(pix)*2)) = pix(1:numel(pix));

pix = 39:-1:35;
neg45(1:2:(numel(pix)*2)) = pix(1:numel(pix));
neg45(2:2:(numel(pix)*2)) = pix(1:numel(pix));

pix = 71:75;
pos90(1:2:(numel(pix)*2)) = pix(1:numel(pix));
pos90(2:2:(numel(pix)*2)) = pix(1:numel(pix));

pix = 27:-1:23;
neg90(1:2:(numel(pix)*2)) = pix(1:numel(pix));
neg90(2:2:(numel(pix)*2)) = pix(1:numel(pix));

pix = 83:87;
pos135(1:2:(numel(pix)*2)) = pix(1:numel(pix));
pos135(2:2:(numel(pix)*2)) = pix(1:numel(pix));

pix = 15:-1:11;
neg135(1:2:(numel(pix)*2)) = pix(1:numel(pix));
neg135(2:2:(numel(pix)*2)) = pix(1:numel(pix));

% 'focusing stimulus', 50 elements
contraction = 191:-1:142;
expansion = 142:191;

% functions

func = [expansion pos45... 
        expansion neg45...
        expansion pos90...
        expansion neg90...
        expansion pos135...
        expansion neg135...
        expansion];

func = [func repmat(func(numel(func)),1,50)];

cd('R:\slh_database\functions\20111107\')
save('position_function_01_4pix_4stepSwipes_with_focused_expansion_front2back','func')

clear func
func = [contraction pos45... 
        contraction neg45...
        contraction pos90...
        contraction neg90...
        contraction pos135...
        contraction neg135...
        contraction];

func = [func repmat(func(numel(func)),1,50)];

cd('R:\slh_database\functions\20111107\')
save('position_function_02_4pix_4stepSwipes_with_focused_contraction_front2back','func')



func = [expansion expansion expansion expansion];

func = [func repmat(func(numel(func)),1,50)];

cd('R:\slh_database\functions\20111107\')
save('position_function_03_4pix_back2front_expansion','func')

func = [contraction contraction contraction contraction];

func = [func repmat(func(numel(func)),1,50)];

cd('R:\slh_database\functions\20111107\')
save('position_function_04_4pix_front2back_contraction','func')


