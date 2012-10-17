% Make figure for expansion stimulus protocol

%% Load the data from the correct sources
%data_location = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_gal80ts_kir21';
%data_location = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_uas-shi-ts';
%data_location = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_pJFRC100';
data_location = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/exp_shift_gmr_48a08ad_29g11dbd_pJFRC100';

set = tfAnalysis.ExpSet(tfAnalysis.import(data_location,'all'));

%% Show the expansion response with raw traces



data_set = set.get_trial_data(1,'lmr','none','no','none');

[averages, variance] = process_multi_rep_expansion_data(data);



%
% $x^2+e^{\pi i}$
% 
%   for x = 1:10
% 
% <<FILENAME.PNG>>
% 
% # ITEM1
% 
% * ITEM1
% 
%  <http://www.mathworks.com _ | *PREFORMATTED
% SECTION TITLE
% DESCRIPTIVE TEXT
%  TEXT* | _ >
% 
% * ITEM2
% 
% # ITEM2
% 
% 
%       disp(x)
%   end
% 






