panel_com('set_pattern_id',1)
panel_com('set_mode',[0 0])
panel_com('set_position',[1 2])
panel_com('send_gain_bias',[50 0 0 0 ])
panel_com('send_laser_pattern',[ones(1,17) zeros(1,199) ones(1,72)]);
panel_com('start')

panel_com('stop')

% 1:17 yes  18:216 no 217:288 yes
% 261 centered on laser