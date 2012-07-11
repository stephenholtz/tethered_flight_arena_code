% make short telethon figure
% i.e.
% pal_DL = tfAnalysis.import('/Users/holtzs/Desktop/gynandro_short_telethon_experiment_2011/pal_DL_pal','all');
% pal_DL_set = tfAnalysis.ExpSet(pal_DL);

% b2f L [R]
[b2f b2fe] = pal_DL_set.get_trial_data([1,2],'lmr','none','yes','all');
% f2b R [L]
[f2b f2be] = pal_DL_set.get_trial_data([3,4],'lmr','none','yes','all');
% .06 low contrast rot CW [CCW]
[lc_rot_1 lc_rot_1e] = pal_DL_set.get_trial_data([5,6],'lmr','none','yes','all');
% .24 low contrast rot CW [CCW]
[lc_rot_2 lc_rot_2e] = pal_DL_set.get_trial_data([7,8],'lmr','none','yes','all');
% reverse phi CW [CCW]
[rp_rot rp_rote] = pal_DL_set.get_trial_data([9,10],'lmr','none','yes','all');
% dark stripe 3 Hz sine wave stripe track [different phase]
[neg_c_stripe neg_c_stripee] = pal_DL_set.get_trial_data([11,12],'lmr','none','yes','all');
% bright stripe 3 Hz sine wave stripe track [different phase]
[pos_c_stripe pos_c_stripee] = pal_DL_set.get_trial_data([13,14],'lmr','none','yes','all');
% square wave grating 3 Hz sine wave stripe track [different phase]
[square_grating square_gratinge] = pal_DL_set.get_trial_data([15,16],'lmr','none','yes','all');
