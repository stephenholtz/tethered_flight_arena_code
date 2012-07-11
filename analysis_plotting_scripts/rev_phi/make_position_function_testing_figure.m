% Make position function sanity check figure.

%%
% load position_function_020_lam_8_rev_phi_1Hz_CW_Xchan_400Hz
% original_position_func=func;
% 
% test_4_wide_set = tfAnalysis.ExpSet(tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide/gmr_48a08dbd_gal80ts_kir21','all'));
% zero_pos_conds=test_4_wide_set.grouped_conditions{2}.list{9};
% 
% [pos_1hz pos_1hz_err] = test_4_wide_set.get_trial_data(zero_pos_conds(1),'x_pos','none','no','all');

%%
figure('Name','Position function (used @ 400 Hz) sanity check','Color',[1 1 1])
subplot(2,1,1)
plot(original_position_func,'r')
title({'Original position function','Period = 8'})

subplot(2,1,2)
plot(pos_1hz,'b')
title({'Position function in X channel at 400Hz (3 trials averaged)','Verified 1 Hz'})

% subplot(2,1,2)
% a=original_position_func(1:1201);
% a([2 3],:) = [a; a]; a = a(:)';
% plot(a,'r'); hold on
% plot(pos_1hz)
% title('Warp overlay of first three function periods')