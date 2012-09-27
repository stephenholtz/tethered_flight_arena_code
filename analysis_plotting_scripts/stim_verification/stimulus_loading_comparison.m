%% Stim verification script

exp_loc_1 = '/Users/holtzs/Desktop/stim_verification/reverse_phi_double_check_v02/gmr_48a08dbd_gal80ts_kir21/20120925T150145/';

data_1 = daqread(fullfile(exp_loc_1,'raw_data.daq'));

exp_1 = tfAnalysis.ExpSet(tfAnalysis.import(exp_loc_1));

%% exp_1.grouped_conditions{4}
%       name: 'Func 0.75 Hz'
%         tf: 0.7500
%     x_axis: [1x21 double]
%       list: {1x21 cell}
%

pre_55 = exp_1.grouped_conditions{4}.list{6};

post_55 = exp_1.grouped_conditions{4}.list{15};

pre_data = exp_1.get_trial_data(pre_55(1),'wbf','none','no','none');
pre_y_data = exp_1.get_trial_data(pre_55(1),'y_pos','none','no','none');
pre_x_data = exp_1.get_trial_data(pre_55(1),'x_pos','none','no','none');


post_data = exp_1.get_trial_data(post_55(1),'wbf','none','no','none');
post_y_data = exp_1.get_trial_data(post_55(1),'y_pos','none','no','none');
post_x_data = exp_1.get_trial_data(post_55(1),'x_pos','none','no','none');

%%

clf; hold all;


plot((pre_data'-4))
plot((pre_y_data'-8)/2)
plot((pre_x_data'-8)/2)


plot((post_data'+4))
plot((post_y_data'+8)/2)
plot((post_x_data'+8)/2)



%% SECOND EXPERIMENT

exp_loc_2 = '/Users/holtzs/Desktop/stim_verification/reverse_phi_high_speed_verification_v01/gmr_26a03dbd_gal80ts_kir21/amp_filt_2';

exp_1 = tfAnalysis.ExpSet(tfAnalysis.import(exp_loc_2));


%%

pre_82 = exp_1.grouped_conditions{1}.list{1};

post_82 = exp_1.grouped_conditions{1}.list{7};

pre_data = exp_1.get_trial_data(pre_82(1),'wbf','none','no','none');
pre_y_data = exp_1.get_trial_data(pre_82(1),'y_pos','none','no','none');
pre_x_data = exp_1.get_trial_data(pre_82(1),'x_pos','none','no','none');


post_data = exp_1.get_trial_data(post_82(1),'wbf','none','no','none');
post_y_data = exp_1.get_trial_data(post_82(1),'y_pos','none','no','none');
post_x_data = exp_1.get_trial_data(post_82(1),'x_pos','none','no','none');


%%

clf; hold all;


plot((pre_data'-4))
plot((pre_y_data'-8)/2)
plot((pre_x_data'-8)/2)


plot((post_data'+4))
plot((post_y_data'+8)/2)
plot((post_x_data'+8)/2)
