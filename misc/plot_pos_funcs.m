cf = pwd;

range = 1:2500;
%% 4 wide figure
name= '4_wide_min_max_speed_position_function_sanity_check';
figure('name',name);
cd /Users/holtzs/tethered_flight_arena_code/position_functions/rev_phi_phase_delay_4_wide/
%
subplot(3,1,1)
load('position_function_058_lam_8_rev_phi_3Hz_CW_Xchan_400Hz')
plot(func(range),'k'); hold on

load('position_function_060_lam_8_rev_phi_3Hz_Ychan_0ms_after_400Hz')
plot(func(range),'r')
title('position_function_060_lam_8_rev_phi_3Hz_Ychan_0ms_after_400Hz','interpreter','none')


%
subplot(3,1,2)
load('position_function_058_lam_8_rev_phi_3Hz_CW_Xchan_400Hz')
plot(func(range),'k'); hold on

load('position_function_061_lam_8_rev_phi_3Hz_Ychan_2pt5ms_after_400Hz')
plot(func(range),'r')
title('position_function_061_lam_8_rev_phi_3Hz_Ychan_2pt5ms_after_400Hz','interpreter','none')


%
subplot(3,1,3)
load('position_function_058_lam_8_rev_phi_3Hz_CW_Xchan_400Hz')
plot(func(range),'k'); hold on

load('position_function_075_lam_8_rev_phi_3Hz_Ychan_20ms_after_400Hz')
plot(func(range),'r')
title('position_function_075_lam_8_rev_phi_3Hz_Ychan_20ms_after_400Hz','interpreter','none')
saveas(gcf,fullfile(cf,name),'fig')

%% 6 wide figure
name = '6_wide_min_max_speed_position_function_sanity_check';
figure('name',name);
cd /Users/holtzs/tethered_flight_arena_code/position_functions/rev_phi_phase_delay_6_wide/
%
subplot(3,1,1)
load('position_function_058_lam_12_rev_phi_2Hz_CW_Xchan_400Hz')
plot(func(range),'k'); hold on

load('position_function_060_lam_12_rev_phi_2Hz_Ychan_0ms_after_400Hz')
plot(func(range),'r')
title('position_function_060_lam_12_rev_phi_2Hz_Ychan_0ms_after_400Hz','interpreter','none')


%
subplot(3,1,2)
load('position_function_058_lam_8_rev_phi_3Hz_CW_Xchan_400Hz')
plot(func(range),'k'); hold on

load('position_function_070_lam_8_rev_phi_3Hz_Ychan_12pt5ms_before_400Hz')
plot(func(range),'r')
title('position_function_070_lam_8_rev_phi_3Hz_Ychan_12pt5ms_before_400Hz','interpreter','none')

%
subplot(3,1,3)
load('position_function_058_lam_12_rev_phi_2Hz_CW_Xchan_400Hz')
plot(func(range),'k'); hold on

load('position_function_075_lam_12_rev_phi_2Hz_Ychan_20ms_after_400Hz')
plot(func(range),'r')
title('position_function_075_lam_12_rev_phi_2Hz_Ychan_20ms_after_400Hz','interpreter','none')
saveas(gcf,fullfile(cf,name),'fig')
