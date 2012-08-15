% make short telethon figure
% i.e.
pal_loc = '/Users/holtzs/Desktop/gynandro_short_telethon_experiment_2012/pal_DL_pal';
if 0
pal_DL = tfAnalysis.import(pal_loc,'all');
cd(pal_loc); save('pal_DL','pal_DL');
end

load(fullfile(pal_loc,'pal_DL.mat'));
pal_DL_set = tfAnalysis.ExpSet(pal_DL);

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

%
figHand(1) = figure('Name','PAL DL Unilateral Motion','NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
tfPlot.simple_timeseries({b2f',b2f'+b2fe',b2f'-b2fe'}); 
hold all
tfPlot.simple_timeseries({f2b',f2b'+f2be',f2b'-f2be'});
legend('back to front','sem','front to back','sem');
annotation('Textbox',[.825 .85 .2 .15],'String',['N=' num2str(numel(pal_DL_set.experiment))],'edgecolor','none')
title('Unilateral Motion')
xlabel('Time [ms]')
ylabel('LmR WBA [V]')
export_fig(gcf,'PAL_Fig1')

figHand(2) = figure('Name','PAL DL Optomotor / Rev Phi','NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
tfPlot.simple_timeseries({lc_rot_1',lc_rot_1'+lc_rot_1e',lc_rot_1'-lc_rot_1e'});
hold all;
tfPlot.simple_timeseries({lc_rot_2',lc_rot_2'+lc_rot_2e',lc_rot_2'-lc_rot_2e'});
hold all;
tfPlot.simple_timeseries({rp_rot',rp_rot'+rp_rote',rp_rot'-rp_rote'});
legend('low contrast','sem','high contrast','sem','reverse phi','sem');
annotation('Textbox',[.825 .85 .2 .15],'String',['N=' num2str(numel(pal_DL_set.experiment))],'edgecolor','none')
title('Optomotor / Reverse Phi')
xlabel('Time [ms]')
ylabel('LmR WBA [V]')
export_fig(gcf,'PAL_Fig2')

figHand(3) = figure('Name','Stripe Tracking','NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
subplot(3,1,1)
tfPlot.simple_timeseries({neg_c_stripe',neg_c_stripe'+neg_c_stripee',neg_c_stripe'-neg_c_stripee'});
title('Dark Stripe Tracking')
ylabel('LmR WBA [V]')
xlabel('Time [ms]')
subplot(3,1,2)
tfPlot.simple_timeseries({pos_c_stripe',pos_c_stripe'+pos_c_stripee',pos_c_stripe'-pos_c_stripee'});
title('Bright Stripe Tracking')
ylabel('LmR WBA [V]')
subplot(3,1,3)
tfPlot.simple_timeseries({square_grating',square_grating'+square_gratinge',square_grating'-square_gratinge'});
annotation('Textbox',[.825 .85 .2 .15],'String',['N=' num2str(numel(pal_DL_set.experiment))],'edgecolor','none')
title('Grating Tracking')

ylabel('LmR WBA [V]')
export_fig(gcf,'PAL_Fig3')