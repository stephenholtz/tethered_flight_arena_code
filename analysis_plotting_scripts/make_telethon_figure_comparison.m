function [  summary_figure,...
            unilateral_figure,...
            stripe_tracking_figure,...
            velocity_nulling_figure,...
            yaw_thrust_slip_roll_figure,...
            on_off_pattern_figure,...
            rp_contrast_rot_figure] = make_telethon_figure_comparison(experimental,control,varargin)
    % Will take two genotype objects and make a set of figures using tfAnalysis
    % methods comparing the two:
    % [figure_array] = make_telethon_figure_comparison(ushift_9,shift_10);
    % 
    % TODO: style with the varargin and cell arrays somehow working...
    
    if isobject(experimental) && isobject(control)
        disp('Two objects')
    elseif (isobject(experimental) && (iscell(control) && isobject(control(1))))...
                || (isobject(control) && (iscell(experimental) && isobject(experimental(1))))...
                || (((iscell(experimental) && isobject(experimental(1)))) && (iscell(control) && isobject(control(1))))
        disp('At least one cell')
    else
        error('Supply objects!')
    end
    
    
    %% Make Summary Figure
    summary_figure = figure;
    figure_name = 'Summary Figure';
    set(summary_figure,'Numbertitle','off','Name',figure_name,'Color','white');
    
    % HARD CODED FOR NOW NEED TO FIX IN EXPERIMENT METADATA AND REANALYZE!
    rearing_temp = '18';
    shift_temp = '30';
    age_shifted = '1';
    age_unshifted = '3';
    
    e_shift = experimental.temp_shifts;
    for g = 1:numel(e_shift)
        shift_unshift = regexpi(e_shift{g},'\d+.\d+.\d+','match');
        
        pre_converted_times_shifted = (regexpi(shift_unshift{1},'\d+','match'));
        exp_time_shifted_hours(g) = str2num(pre_converted_times_shifted{1})*24 + str2num(pre_converted_times_shifted{2}) + str2num(pre_converted_times_shifted{3})/60;
        
        pre_converted_times_unshifted = (regexpi(shift_unshift{2},'\d+','match'));
        exp_time_unshifted_hours(g) = pre_converted_times_unshifted{1}*24 + str2num(pre_converted_times_unshifted{2}) + str2num(pre_converted_times_unshifted{3})/60;
    end
    avg_exp_time_shifted_hours = mean(exp_time_shifted_hours);
    avg_exp_time_unshifted_hours = mean(exp_time_unshifted_hours);
    
    c_shift = control.temp_shifts;
    for g = 1:numel(c_shift)
        shift_unshift = regexpi(c_shift{g},'\d+.\d+.\d+','match');
        
        pre_converted_times_shifted = (regexpi(shift_unshift{1},'\d+','match'));
        cont_time_shifted_hours(g) = str2num(pre_converted_times_shifted{1})*24 + str2num(pre_converted_times_shifted{2}) + str2num(pre_converted_times_shifted{3})/60;
        
        pre_converted_times_unshifted = (regexpi(shift_unshift{2},'\d+','match'));
        cont_time_unshifted_hours(g) = str2num(pre_converted_times_unshifted{1})*24 + str2num(pre_converted_times_unshifted{2}) + str2num(pre_converted_times_unshifted{3})/60;
    end
    avg_cont_time_shifted_hours = mean(cont_time_shifted_hours);
    avg_cont_time_unshifted_hours = mean(cont_time_unshifted_hours);
    
    annotation(summary_figure, 'textbox',[.035 .885 .1 .1],...
        'String',[figure_name ': ' experimental.chr2 ' & ' experimental.effector],...
        'FontSize',12, 'EdgeColor', 'white')
    
    uitable('Parent',summary_figure, 'Units','normalized',...
            'Position',[.1 .4 .75 .5],'ColumnWidth',{100},...
            'RowName',     {'Line Name','Effector','Number Flies',...
                            'Rearing Temp','Shift Temp',...
                            'Age Shifted', 'Age Unshifted',...
                            'Average Time Shift','Average Time Unshift',...
                            'Color'},...
            'ColumnName',{ 'Shifted','Unshifted'},...
            'Data', {experimental.chr2,                     control.chr2;...
                    experimental.effector,                  control.effector;...
                    num2str(numel(experimental.arenas)),    num2str(numel(control.arenas));...
                    num2str(rearing_temp),                  num2str(rearing_temp);...
                    num2str(shift_temp),                    num2str(rearing_temp);...
                    num2str(age_shifted),                   num2str(age_shifted);...
                    num2str(age_unshifted),                 num2str(age_unshifted);...
                    num2str(avg_exp_time_shifted_hours),    num2str(avg_cont_time_shifted_hours);...
                    num2str(avg_exp_time_unshifted_hours),  num2str(avg_cont_time_unshifted_hours);...
                    'red',                                  'blue'});
    
    % Average WBF, LmR, stripe_fix, etc, comparison below the table 
    
    %wbf
    exp_mean_wbf = mean([experimental.mean_wbf{:}]);
    exp_sem_wbf  = mean([experimental.sem_wbf{:}]);
    exp_sem_p_wbf = exp_mean_wbf + exp_sem_wbf;
    exp_sem_m_wbf = exp_mean_wbf - exp_sem_wbf;               
                
    cont_mean_wbf = mean([control.mean_wbf{:}]);
    cont_sem_wbf  = mean([control.sem_wbf{:}]);
    cont_sem_p_wbf = cont_mean_wbf + cont_sem_wbf;
    cont_sem_m_wbf = cont_mean_wbf - cont_sem_wbf;  
    
    %lmr
    exp_mean_lmr = mean([experimental.mean_lmr{:}]);
    exp_sem_lmr  = mean([experimental.sem_lmr{:}]);
    exp_sem_p_lmr = exp_mean_lmr + exp_sem_lmr;
    exp_sem_m_lmr = exp_mean_lmr - exp_sem_lmr;               
                
    cont_mean_lmr = mean([control.mean_lmr{:}]);
    cont_sem_lmr  = mean([control.sem_lmr{:}]);
    cont_sem_p_lmr = cont_mean_lmr + cont_sem_lmr;
    cont_sem_m_lmr = cont_mean_lmr - cont_sem_lmr;
    
    %stripe fix
    exp_mean_x_pos = ([experimental.mean_x_pos{end}]);
    exp_sem_x_pos  = ([experimental.sem_x_pos{end}]);
    exp_sem_p_x_pos = exp_mean_x_pos + exp_sem_x_pos;
    exp_sem_m_x_pos = exp_mean_x_pos - exp_sem_x_pos;               
                
    cont_mean_x_pos = ([control.mean_x_pos{end}]);
    cont_sem_x_pos  = ([control.sem_x_pos{end}]);
    cont_sem_p_x_pos = cont_mean_x_pos + cont_sem_x_pos;
    cont_sem_m_x_pos = cont_mean_x_pos - cont_sem_x_pos;
    
    %plot them
    axes('Position',[.13 .06 .15 .25]); hold on;
    exp_wbf_plot = errorbar(.75, exp_mean_wbf,exp_sem_m_wbf, exp_sem_p_wbf,'xr');
    cont_wbf_plot = errorbar(1.5, cont_mean_wbf, cont_sem_m_wbf, cont_sem_p_wbf,'xb');
    axis([0 2 0 5])
    title('Mean WBF')
    
    axes('Position',[.32 .06 .15 .25]); hold on;
    exp_lmr_plot = errorbar(.75, exp_mean_lmr, exp_sem_m_lmr, exp_sem_p_lmr,'xr');
    cont_lmr_plot = errorbar(1.5, cont_mean_lmr, cont_sem_m_lmr, cont_sem_p_lmr,'xb');
    axis([0 2 -2 2])
    title('Mean L-R WBA')

    axes('Position',[.56 .06 .075 .25]); hold on;
    confplot(1:numel(exp_mean_x_pos),exp_mean_x_pos,exp_sem_m_x_pos,exp_sem_p_x_pos,'r')
    box off
    title('Mean Stripe-Fix Pos')

    axes('Position',[.69 .06 .075 .25]); hold on;
    confplot(1:numel(cont_mean_x_pos),cont_mean_x_pos,cont_sem_m_x_pos,cont_sem_p_x_pos,'b')
    box off
    
    %% Make Unilateral Figure
    unilateral_figure = figure;
    figure_name = 'Unilateral Figure';
    set(unilateral_figure,'Numbertitle','off','Name',figure_name,'Color','white');
    
    % back to front clockwise motion @30,       @90,        @360 = 
    %                                120/121    124/125     128/129
    [exp.b2f.tf30.avg exp.b2f.tf30.p_sem exp.b2f.tf30.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[120,121]);
    [exp.b2f.tf90.avg exp.b2f.tf90.p_sem exp.b2f.tf90.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[124,125]);
    [exp.b2f.tf360.avg exp.b2f.tf360.p_sem exp.b2f.tf360.m_sem] =...    
        experimental.get_mean_sem_symmetric_conditions('lmr',[128,129]);

    [cont.b2f.tf30.avg cont.b2f.tf30.p_sem cont.b2f.tf30.m_sem] =...
        control.get_mean_sem_symmetric_conditions('lmr',[120,121]);
    [cont.b2f.tf90.avg cont.b2f.tf90.p_sem cont.b2f.tf90.m_sem] =...	
        control.get_mean_sem_symmetric_conditions('lmr',[124,125]);
    [cont.b2f.tf360.avg cont.b2f.tf360.p_sem cont.b2f.tf360.m_sem] =...    
        control.get_mean_sem_symmetric_conditions('lmr',[128,129]);

    % front to back clockwise motion @30,       @90,        @360 =
    %                                122/123    126/127     130/(MISSING)
    [exp.f2b.tf30.avg, exp.f2b.tf30.p_sem, exp.f2b.tf30.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[122,123]);
    [exp.f2b.tf90.avg, exp.f2b.tf90.p_sem, exp.f2b.tf90.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[126,127]);
    [exp.f2b.tf360.avg, exp.f2b.tf360.p_sem, exp.f2b.tf360.m_sem] =...    
        experimental.get_mean_sem(                     'lmr', 130     );
    
    [cont.f2b.tf30.avg, cont.f2b.tf30.p_sem cont.f2b.tf30.m_sem] =...
        control.get_mean_sem_symmetric_conditions('lmr',[122,123]);
    [cont.f2b.tf90.avg, cont.f2b.tf90.p_sem cont.f2b.tf90.m_sem] =...	
        control.get_mean_sem_symmetric_conditions('lmr',[126,127]);
    [cont.f2b.tf360.avg cont.f2b.tf360.p_sem cont.f2b.tf360.m_sem] =...    
        control.get_mean_sem(                     'lmr', 130     );
    
    % plot the b2f and f2b averaged raws
    % top = b2f and f2b,
    % sides(from top down) = 30, 90, 360
    
    %f2b
        % 30
        subplot('Position',[.075 .71 .25 .25]); hold on;
%         confplot(1:numel(cont.f2b.tf30.avg),cont.f2b.tf30.avg,cont.f2b.tf30.m_sem,cont.f2b.tf30.p_sem,'b')
%         confplot(1:numel(exp.f2b.tf30.avg),exp.f2b.tf30.avg,exp.f2b.tf30.m_sem,exp.f2b.tf30.p_sem,'r')
        plot(1:numel(cont.f2b.tf30.avg),cont.f2b.tf30.avg,'b')
        plot(1:numel(exp.f2b.tf30.avg),exp.f2b.tf30.avg,'r')
        title('Front to Back Clockwise')
        ylabel('30 Degrees/s')        
        % 90
        subplot('Position',[.075 .38 .25 .25]); hold on;
%         confplot(1:numel(cont.f2b.tf90.avg),cont.f2b.tf90.avg,cont.f2b.tf90.m_sem,cont.f2b.tf90.p_sem,'b')        
%         confplot(1:numel(exp.f2b.tf90.avg),exp.f2b.tf90.avg,exp.f2b.tf90.m_sem,exp.f2b.tf90.p_sem,'r')
        plot(1:numel(cont.f2b.tf90.avg),cont.f2b.tf90.avg,'b')
        plot(1:numel(exp.f2b.tf90.avg),exp.f2b.tf90.avg,'r')
        ylabel('90 Degrees/s')
        % 360
        subplot('Position',[.075 .05 .25 .25]); hold on;
%         confplot(1:numel(cont.f2b.tf360.avg),cont.f2b.tf360.avg,cont.f2b.tf360.m_sem,cont.f2b.tf360.p_sem,'b')        
%         confplot(1:numel(exp.f2b.tf360.avg),exp.f2b.tf360.avg,exp.f2b.tf360.m_sem,exp.f2b.tf360.p_sem,'r')
        plot(1:numel(cont.f2b.tf360.avg),cont.f2b.tf360.avg,'b');
        plot(1:numel(exp.f2b.tf360.avg),exp.f2b.tf360.avg,'r');
        ylabel('360 Degrees/s')
        
        %b2f
        % 30
        subplot('Position',[.4 .71 .25 .25]); hold on;
%         confplot(1:numel(cont.b2f.tf30.avg),cont.b2f.tf30.avg,cont.b2f.tf30.m_sem,cont.b2f.tf30.p_sem,'b')
%         confplot(1:numel(exp.b2f.tf30.avg),exp.b2f.tf30.avg,exp.b2f.tf30.m_sem,exp.b2f.tf30.p_sem,'r')
        plot(1:numel(cont.b2f.tf30.avg),cont.b2f.tf30.avg,'b')
        plot(1:numel(exp.b2f.tf30.avg),exp.b2f.tf30.avg,'r')
        title('Back to Front Clockwise')
        % 90
        subplot('Position',[.4 .38 .25 .25]); hold on;
%         confplot(1:numel(cont.b2f.tf90.avg),cont.b2f.tf90.avg,cont.b2f.tf90.m_sem,cont.b2f.tf90.p_sem,'b')        
%         confplot(1:numel(exp.b2f.tf90.avg),exp.b2f.tf90.avg,exp.b2f.tf90.m_sem,exp.b2f.tf90.p_sem,'r')
        plot(1:numel(cont.b2f.tf90.avg),cont.b2f.tf90.avg,'b')
        plot(1:numel(exp.b2f.tf90.avg),exp.b2f.tf90.avg,'r')
        % 360
        subplot('Position',[.4 .05 .25 .25]); hold on;
%         confplot(1:numel(cont.b2f.tf360.avg),cont.b2f.tf360.avg,cont.b2f.tf360.m_sem,cont.b2f.tf360.p_sem,'b')        
%         confplot(1:numel(exp.b2f.tf360.avg),exp.b2f.tf360.avg,exp.b2f.tf360.m_sem,exp.b2f.tf360.p_sem,'r')
        plot(1:numel(cont.b2f.tf360.avg),cont.b2f.tf360.avg,'b');
        plot(1:numel(exp.b2f.tf360.avg),exp.b2f.tf360.avg,'r');

    
    % f2b and b2f integrated extraction
    % back to front clockwise motion @30,       @90,        @360 = 
    %                                120/121    124/125     128/129
    [exp.b2f.tf30.i.avg, exp.b2f.tf30.i.p_sem, exp.b2f.tf30.i.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('integrated_lmr_response',[120,121]);
    [exp.b2f.tf90.i.avg, exp.b2f.tf90.i.p_sem, exp.b2f.tf90.i.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('integrated_lmr_response',[124,125]);
    [exp.b2f.tf360.i.avg, exp.b2f.tf360.i.p_sem, exp.b2f.tf360.i.m_sem] =...    
        experimental.get_mean_sem_symmetric_conditions('integrated_lmr_response',[128,129]);

    [cont.b2f.tf30.i.avg, cont.b2f.tf30.i.p_sem, cont.b2f.tf30.i.m_sem] =...
        control.get_mean_sem_symmetric_conditions('integrated_lmr_response',[120,121]);
    [cont.b2f.tf90.i.avg, cont.b2f.tf90.i.p_sem, cont.b2f.tf90.i.m_sem] =...	
        control.get_mean_sem_symmetric_conditions('integrated_lmr_response',[124,125]);
    [cont.b2f.tf360.i.avg, cont.b2f.tf360.i.p_sem, cont.b2f.tf360.i.m_sem] =...    
        control.get_mean_sem_symmetric_conditions('integrated_lmr_response',[128,129]);

    % front to back clockwise motion @30,       @90,        @360 =
    %                                122/123    126/127     130/(MISSING)
    [exp.f2b.tf30.i.avg, exp.f2b.tf30.i.p_sem, exp.f2b.tf30.i.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('integrated_lmr_response',[122,123]);
    [exp.f2b.tf90.i.avg, exp.f2b.tf90.i.p_sem, exp.f2b.tf90.i.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('integrated_lmr_response',[126,127]);
    [exp.f2b.tf360.i.avg, exp.f2b.tf360.i.p_sem, exp.f2b.tf360.i.m_sem] =...    
        experimental.get_mean_sem(                     'integrated_lmr_response', 130     );
    
    [cont.f2b.tf30.i.avg, cont.f2b.tf30.i.p_sem cont.f2b.tf30.i.m_sem] =...
        control.get_mean_sem_symmetric_conditions('integrated_lmr_response',[122,123]);
    [cont.f2b.tf90.i.avg, cont.f2b.tf90.i.p_sem cont.f2b.tf90.i.m_sem] =...	
        control.get_mean_sem_symmetric_conditions('integrated_lmr_response',[126,127]);
    [cont.f2b.tf360.i.avg cont.f2b.tf360.i.p_sem cont.f2b.tf360.i.m_sem] =...    
        control.get_mean_sem(                     'integrated_lmr_response', 130     );
    
    % plot f2b and b2f values - integrated.
        % 30
        subplot('Position',[.71 .71 .15 .25]); hold on;
        errorbar(1,cont.b2f.tf30.i.avg,cont.b2f.tf30.i.m_sem,cont.b2f.tf30.i.p_sem,'b')
        errorbar(1.1,exp.b2f.tf30.i.avg,exp.b2f.tf30.i.m_sem,exp.b2f.tf30.i.p_sem,'r')
        errorbar(2,cont.f2b.tf30.i.avg,cont.f2b.tf30.i.m_sem,cont.f2b.tf30.i.p_sem,'b')
        errorbar(2.1,exp.f2b.tf30.i.avg,exp.f2b.tf30.i.m_sem,exp.f2b.tf30.i.p_sem,'r')        
        title('LmR response integration')
        % 90
        subplot('Position',[.71 .38 .15 .25]); hold on;
        errorbar(1,cont.b2f.tf90.i.avg,cont.b2f.tf90.i.m_sem,cont.b2f.tf90.i.p_sem,'b')
        errorbar(1.1,exp.b2f.tf90.i.avg,exp.b2f.tf90.i.m_sem,exp.b2f.tf90.i.p_sem,'r')
        errorbar(2,cont.f2b.tf90.i.avg,cont.f2b.tf90.i.m_sem,cont.f2b.tf90.i.p_sem,'b')
        errorbar(2.1,exp.f2b.tf90.i.avg,exp.f2b.tf90.i.m_sem,exp.f2b.tf90.i.p_sem,'r')       
        % 360
        subplot('Position',[.71 .05 .15 .25]); hold on;
        errorbar(1,cont.b2f.tf360.i.avg,cont.b2f.tf360.i.m_sem,cont.b2f.tf360.i.p_sem,'b')
        errorbar(1.1,exp.b2f.tf360.i.avg,exp.b2f.tf360.i.m_sem,exp.b2f.tf360.i.p_sem,'r')
        errorbar(2,cont.f2b.tf360.i.avg,cont.f2b.tf360.i.m_sem,cont.f2b.tf360.i.p_sem,'b')
        errorbar(2.1,exp.f2b.tf360.i.avg,exp.f2b.tf360.i.m_sem,exp.f2b.tf360.i.p_sem,'r')       
        
    % f2b and b2f t 1/2 extraction
    
    % back to front clockwise motion @30,       @90,        @360 = 
    %                                120/121    124/125     128/129
    [exp.b2f.tf30.thalf.avg, exp.b2f.tf30.thalf.p_sem, exp.b2f.tf30.thalf.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[120,121]);
    [exp.b2f.tf90.thalf.avg, exp.b2f.tf90.thalf.p_sem, exp.b2f.tf90.thalf.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[124,125]);
    [exp.b2f.tf360.thalf.avg, exp.b2f.tf360.thalf.p_sem, exp.b2f.tf360.thalf.m_sem] =...    
        experimental.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[128,129]);

    [cont.b2f.tf30.thalf.avg, cont.b2f.tf30.thalf.p_sem, cont.b2f.tf30.thalf.m_sem] =...
        control.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[120,121]);
    [cont.b2f.tf90.thalf.avg, cont.b2f.tf90.thalf.p_sem, cont.b2f.tf90.thalf.m_sem] =...	
        control.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[124,125]);
    [cont.b2f.tf360.thalf.avg, cont.b2f.tf360.thalf.p_sem, cont.b2f.tf360.thalf.m_sem] =...    
        control.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[128,129]);

    % front to back clockwise motion @30,       @90,        @360 =
    %                                122/123    126/127     130/(MISSING)
    [exp.f2b.tf30.thalf.avg, exp.f2b.tf30.thalf.p_sem, exp.f2b.tf30.thalf.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[122,123]);
    [exp.f2b.tf90.thalf.avg, exp.f2b.tf90.thalf.p_sem, exp.f2b.tf90.thalf.m_sem] =...
        experimental.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[126,127]);
    [exp.f2b.tf360.thalf.avg, exp.f2b.tf360.thalf.p_sem, exp.f2b.tf360.thalf.m_sem] =...    
        experimental.get_mean_sem(                     'time_to_half_max_lmr', 130     );
    
    [cont.f2b.tf30.thalf.avg, cont.f2b.tf30.thalf.p_sem cont.f2b.tf30.thalf.m_sem] =...
        control.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[122,123]);
    [cont.f2b.tf90.thalf.avg, cont.f2b.tf90.thalf.p_sem cont.f2b.tf90.thalf.m_sem] =...	
        control.get_mean_sem_symmetric_conditions('time_to_half_max_lmr',[126,127]);
    [cont.f2b.tf360.thalf.avg cont.f2b.tf360.thalf.p_sem cont.f2b.tf360.thalf.m_sem] =...    
        control.get_mean_sem(                     'time_to_half_max_lmr', 130     );
    % plot f2b and b2f values - integrated.
        
        % 30
        subplot('Position',[.86 .71 .15 .25]); hold on;
        errorbar(1,cont.b2f.tf30.thalf.avg,cont.b2f.tf30.thalf.m_sem,cont.b2f.tf30.thalf.p_sem,'b')
        errorbar(1.1,exp.b2f.tf30.thalf.avg,exp.b2f.tf30.thalf.m_sem,exp.b2f.tf30.thalf.p_sem,'r')
        errorbar(2,cont.f2b.tf30.thalf.avg,cont.f2b.tf30.thalf.m_sem,cont.f2b.tf30.thalf.p_sem,'b')
        errorbar(2.1,exp.f2b.tf30.thalf.avg,exp.f2b.tf30.thalf.m_sem,exp.f2b.tf30.thalf.p_sem,'r')        
        title('Time to 1/2 max')
        % 90
        subplot('Position',[.86 .38 .15 .25]); hold on;
        errorbar(1,cont.b2f.tf90.thalf.avg,cont.b2f.tf90.thalf.m_sem,cont.b2f.tf90.thalf.p_sem,'b')
        errorbar(1.1,exp.b2f.tf90.thalf.avg,exp.b2f.tf90.thalf.m_sem,exp.b2f.tf90.thalf.p_sem,'r')
        errorbar(2,cont.f2b.tf90.thalf.avg,cont.f2b.tf90.thalf.m_sem,cont.f2b.tf90.thalf.p_sem,'b')
        errorbar(2.1,exp.f2b.tf90.thalf.avg,exp.f2b.tf90.thalf.m_sem,exp.f2b.tf90.thalf.p_sem,'r')       
        % 360
        subplot('Position',[.86 .05 .15 .25]); hold on;
        errorbar(1,cont.b2f.tf360.thalf.avg,cont.b2f.tf360.thalf.m_sem,cont.b2f.tf360.thalf.p_sem,'b')
        errorbar(1.1,exp.b2f.tf360.thalf.avg,exp.b2f.tf360.thalf.m_sem,exp.b2f.tf360.thalf.p_sem,'r')
        errorbar(2,cont.f2b.tf360.thalf.avg,cont.f2b.tf360.thalf.m_sem,cont.f2b.tf360.thalf.p_sem,'b')
        errorbar(2.1,exp.f2b.tf360.thalf.avg,exp.f2b.tf360.thalf.m_sem,exp.f2b.tf360.thalf.p_sem,'r')       
        
    %% Make stripe tracking figure
    
    stripe_tracking_figure = figure;
    figure_name = 'Stripe Tracking';
    set(stripe_tracking_figure,'Numbertitle','off','Name',figure_name,'Color','white');

    % FREQ           -  1hz         3hz             5hz
    % dark on bright -  84/85       86/87           88/89
    % bright on dark -  90/91       92/93           94/95
    % square wave gra-  96/97       98/99           100/101

    [exp.donb.hz1.x] = ...
        experimental.get_mean_sem('x_pos',84);
    [exp.donb.hz3.x] = ...
        experimental.get_mean_sem('x_pos',86);
    [exp.donb.hz5.x] = ...
        experimental.get_mean_sem('x_pos',88);
    
    [exp.donb.hz1.avg] =...
         experimental.get_mean_sem_symmetric_conditions('lmr',[84,85]);
    [exp.donb.hz3.avg] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[86,87]);
    [exp.donb.hz5.avg] =...    
        experimental.get_mean_sem_symmetric_conditions('lmr',[88,89]);
    [cont.donb.hz1.avg] =...
        control.get_mean_sem_symmetric_conditions('lmr',[84,85]);
    [cont.donb.hz3.avg] =...
        control.get_mean_sem_symmetric_conditions('lmr',[86,87]);
    [cont.donb.hz5.avg] =...    
        control.get_mean_sem_symmetric_conditions('lmr',[88,89]);

    % plot the dark on bright/bright on dark/square wave
    
    % donb
        % 1hz
        subplot('Position',[.06 .70 .23 .25]); hold on;
        plot(1:numel(cont.donb.hz1.avg),cont.donb.hz1.avg,'b')
        plot(1:numel(exp.donb.hz1.avg),exp.donb.hz1.avg,'r')
        title('Dark Stripe on Bright')
        ylabel('1 Hz')
        % 3hz
        subplot('Position',[.06 .40 .23 .25]); hold on;
        plot(1:numel(cont.donb.hz3.avg),cont.donb.hz3.avg,'b')
        plot(1:numel(exp.donb.hz3.avg),exp.donb.hz3.avg,'r')
        ylabel('3 Hz')
        % 5hz
        subplot('Position',[.06 .12 .23 .25]); hold on;
        plot(1:numel(cont.donb.hz5.avg),cont.donb.hz5.avg,'b');
        plot(1:numel(exp.donb.hz5.avg),exp.donb.hz5.avg,'r');
        ylabel('5 Hz')

    [exp.bond.hz1.x] = ...
        experimental.get_mean_sem('x_pos',90);
    [exp.bond.hz3.x] = ...
        experimental.get_mean_sem('x_pos',92);
    [exp.bond.hz5.x] = ...
        experimental.get_mean_sem('x_pos',94);
    
    [exp.bond.hz1.avg] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[90,91]);
    [exp.bond.hz3.avg] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[92,93]);
    [exp.bond.hz5.avg] =...    
        experimental.get_mean_sem_symmetric_conditions('lmr',[94,95]);
    [cont.bond.hz1.avg] =...
        control.get_mean_sem_symmetric_conditions('lmr',[90,91]);
    [cont.bond.hz3.avg] =...
        control.get_mean_sem_symmetric_conditions('lmr',[92,93]);
    [cont.bond.hz5.avg] =...    
        control.get_mean_sem_symmetric_conditions('lmr',[94,95]);

    % plot the dark on bright/bright on dark/square wave
    
    % bond
        % 1hz
        subplot('Position',[.40 .70 .23 .25]); hold on;
        plot(1:numel(cont.bond.hz1.avg),cont.bond.hz1.avg,'b')
        plot(1:numel(exp.bond.hz1.avg),exp.bond.hz1.avg,'r')
        title('Bright Stripe on Dark')
        ylabel('1 Hz')        
        % 3hz
        subplot('Position',[.40 .40 .23 .25]); hold on;
        plot(1:numel(cont.bond.hz3.avg),cont.bond.hz3.avg,'b')
        plot(1:numel(exp.bond.hz3.avg),exp.bond.hz3.avg,'r')
        ylabel('3 Hz')
        % 5hz
        subplot('Position',[.40 .12 .23 .25]); hold on;
        plot(1:numel(cont.bond.hz5.avg),cont.bond.hz5.avg,'b');
        plot(1:numel(exp.bond.hz5.avg),exp.bond.hz5.avg,'r');
        ylabel('5 Hz')

    [exp.grat.hz1.x] = ...
        experimental.get_mean_sem('x_pos',96);
    [exp.grat.hz3.x] = ...
        experimental.get_mean_sem('x_pos',98);
    [exp.grat.hz5.x] = ...
        experimental.get_mean_sem('x_pos',100);
        
    [exp.grat.hz1.avg] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[96,97]);
    [exp.grat.hz3.avg] =...
        experimental.get_mean_sem_symmetric_conditions('lmr',[98,99]);
    [exp.grat.hz5.avg] =...    
        experimental.get_mean_sem_symmetric_conditions('lmr',[100,101]);
    [cont.grat.hz1.avg] =...
        control.get_mean_sem_symmetric_conditions('lmr',[96,97]);
    [cont.grat.hz3.avg] =...
        control.get_mean_sem_symmetric_conditions('lmr',[98,99]);
    [cont.grat.hz5.avg] =...    
        control.get_mean_sem_symmetric_conditions('lmr',[100,101]);

    % plot the dark on bright/bright on dark/square wave
    
    % grat
        % 1hz
        subplot('Position',[.75 .70 .23 .25]); hold on;
        plot(1:numel(cont.grat.hz1.avg),cont.grat.hz1.avg,'b')
        plot(1:numel(exp.grat.hz1.avg),exp.grat.hz1.avg,'r')
        title('Square Wave Grating')
        ylabel('1 Hz')        
        % 3hz
        subplot('Position',[.75 .40 .23 .25]); hold on;
        plot(1:numel(cont.grat.hz3.avg),cont.grat.hz3.avg,'b')
        plot(1:numel(exp.grat.hz3.avg),exp.grat.hz3.avg,'r')
        ylabel('3 Hz')
        % 5hz
        subplot('Position',[.75 .12 .23 .25]); hold on;
        plot(1:numel(cont.grat.hz5.avg),cont.grat.hz5.avg,'b');
        plot(1:numel(exp.grat.hz5.avg),exp.grat.hz5.avg,'r');
        ylabel('5 Hz')        

%     %% Make summary fixation figure    
%     summary_fixation_figure = figure;    
%     figure_name = 'Fixation Summary';
%     set(summary_fixation_figure,'Numbertitle','off','Name',figure_name,'Color','white');
 
    %% Make velocity nulling figure
%     
%     velocity_nulling_figure = figure;
%     figure_name = 'Velocity Nulling';
%     set(velocity_nulling_figure,'Numbertitle','off','Name',figure_name,'Color','white');
%     
    %% Make yaw_thrust_slip_roll_figure 
    yaw_thrust_slip_roll_figure = figure;
    figure_name = 'Misc Optic Flow Figure';
    set(yaw_thrust_slip_roll_figure,'Numbertitle','off','Name',figure_name,'Color','white');
    
    %   Lift      Pitch       Roll        SideSlip        Thrust      Yaw
    %   102/103   104/105     106/107     108/109         110/111     112/(MISSING)
    %   c1        c2          c3          c1              c2          c3
    % LIFT
    [exp.lift.x] = ...
        experimental.get_mean_sem('x_pos',[102]);
    
    [exp.lift.lmr] = ...
        experimental.get_mean_sem_symmetric_conditions('lmr',[102,103]);
    [exp.lift.lag, exp.lift.lag_p_sem, exp.lift.lag_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[102,103]);
    [exp.lift.corr, exp.lift.corr_p_sem, exp.lift.corr_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('corr_x_lmr',[102,103]);
%     [exp.lift.r] = ...
%         experimental.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[102,103]);
%     [exp.lift.l] = ...
%         experimental.get_mean_sem_symmetric_conditions('corr_x_lmr',[102,103]);
%     [exp.lift.l] = ...
%         experimental.get_mean_sem_symmetric_conditions('corr_x_lmr',[102,103]);
      
    [cont.lift.lmr] = ...
        control.get_mean_sem_symmetric_conditions('lmr',[102,103]);
    [cont.lift.lag, cont.lift.lag_p_sem, cont.lift.lag_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[102,103]);
    [cont.lift.corr, cont.lift.corr_p_sem, cont.lift.corr_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('corr_x_lmr',[102,103]);
    
    % PITCH
    [exp.pitch.x] = ...
        experimental.get_mean_sem('x_pos',[104]);
    
    [exp.pitch.lmr] = ...
        experimental.get_mean_sem_symmetric_conditions('lmr',[104,105]);
    [exp.pitch.lag, exp.pitch.lag_p_sem, exp.pitch.lag_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[104,105]);
    [exp.pitch.corr, exp.pitch.corr_p_sem, exp.pitch.corr_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('corr_x_lmr',[104,105]);

    [cont.pitch.lmr] = ...
        control.get_mean_sem_symmetric_conditions('lmr',[104,105]);
    [cont.pitch.lag, cont.pitch.lag_p_sem, cont.pitch.lag_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[104,105]);
    [cont.pitch.corr, cont.pitch.corr_p_sem, cont.pitch.corr_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('corr_x_lmr',[104,105]);
    
    % ROLL
    [exp.roll.x] = ...
        experimental.get_mean_sem('x_pos',[106]);
    
    [exp.roll.lmr] = ...
        experimental.get_mean_sem_symmetric_conditions('lmr',[106,107]);
    [exp.roll.lag, exp.roll.lag_p_sem, exp.roll.lag_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[106,107]);
    [exp.roll.corr, exp.roll.corr_p_sem, exp.roll.corr_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('corr_x_lmr',[106,107]);

    [cont.roll.lmr] = ...
        control.get_mean_sem_symmetric_conditions('lmr',[106,107]);    
    [cont.roll.lag, cont.roll.lag_p_sem, cont.roll.lag_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[106,107]);
    [cont.roll.corr, cont.roll.corr_p_sem, cont.roll.corr_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('corr_x_lmr',[106,107]);
    
    % SIDE SLIP
    [exp.sslip.x] = ...
        experimental.get_mean_sem('x_pos',[108]);
    
    [exp.sslip.lmr] = ...
        experimental.get_mean_sem_symmetric_conditions('lmr',[108,109]);
    [exp.sslip.lag, exp.sslip.lag_p_sem, exp.sslip.lag_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[108,109]);
    [exp.sslip.corr, exp.sslip.corr_p_sem, exp.sslip.corr_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('corr_x_lmr',[108,109]);

    [cont.sslip.lmr] = ...
        control.get_mean_sem_symmetric_conditions('lmr',[108,109]);    
    [cont.sslip.lag, cont.sslip.lag_p_sem, cont.sslip.lag_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[108,109]);
    [cont.sslip.corr, cont.sslip.corr_p_sem, cont.sslip.corr_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('corr_x_lmr',[108,109]);
    
    % THRUST
    [exp.thrust.x] = ...
        experimental.get_mean_sem('x_pos',[110]);
    
    [exp.thrust.lmr] = ...
        experimental.get_mean_sem_symmetric_conditions('lmr',[110,111]);
    [exp.thrust.lag, exp.thrust.lag_p_sem, exp.thrust.lag_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[110,111]);
    [exp.thrust.corr, exp.thrust.corr_p_sem, exp.thrust.corr_m_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('corr_x_lmr',[110,111]);
    
    [cont.thrust.lmr] = ...
        control.get_mean_sem_symmetric_conditions('lmr',[110,111]);
    [cont.thrust.lag, cont.thrust.lag_p_sem, cont.thrust.lag_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('lag_corr_x_lmr',[110,111]);
    [cont.thrust.corr, cont.thrust.corr_p_sem, cont.thrust.corr_m_sem] = ...
        control.get_mean_sem_symmetric_conditions('corr_x_lmr',[110,111]);
    
    % YAW
    [exp.yaw.x] = ...
        experimental.get_mean_sem('x_pos',[112]);
    
    [exp.yaw.lmr] = ...
        experimental.get_mean_sem('lmr',[112]);
    [exp.yaw.lag, exp.yaw.lag_p_sem, exp.yaw.lag_m_sem] = ...
        experimental.get_mean_sem('lag_corr_x_lmr',[112]);
    [exp.yaw.corr, exp.yaw.corr_p_sem, exp.yaw.corr_m_sem] = ...
        experimental.get_mean_sem('corr_x_lmr',[112]);
    
    [cont.yaw.lmr] = ...
        control.get_mean_sem('lmr',[112]);    
    [cont.yaw.lag, cont.yaw.lag_p_sem, cont.yaw.lag_m_sem] = ...
        control.get_mean_sem('lag_corr_x_lmr',[112]);
    [cont.yaw.corr, cont.yaw.corr_p_sem, cont.yaw.corr_m_sem] = ...
        control.get_mean_sem('corr_x_lmr',[112]);

    % PLOT the optic flow LmR Lag(lmr) Corr(lmr)
    
    % Lift
    subplot(4,6,[1 2]); hold on;
    plot(1:numel(cont.lift.lmr),cont.lift.lmr,'b');
    plot(1:numel(exp.lift.lmr),exp.lift.lmr,'r');
    plot(1:numel(exp.lift.x),[exp.lift.x-mean(exp.lift.x)]/(max(exp.lift.x)-mean(exp.lift.x)),'k');
    title('Lift')
    ylabel('LmR [V]')
    
    subplot(4,6,7); hold on;
    errorbar(.5,exp.lift.lag,exp.lift.lag_m_sem,exp.lift.lag_p_sem,'r')
    errorbar(.75,cont.lift.lag,cont.lift.lag_m_sem,cont.lift.lag_p_sem,'b')
    title('Lag')
    
    subplot(4,6,8); hold on;
    errorbar(.5,exp.lift.corr,exp.lift.corr_m_sem,exp.lift.corr_p_sem,'r')
    errorbar(.75,cont.lift.corr,cont.lift.corr_m_sem,cont.lift.corr_p_sem,'b')
    title('Correlation')

    % pitch
    subplot(4,6,[3 4]); hold on;
    plot(1:numel(cont.pitch.lmr),cont.pitch.lmr,'b');
    plot(1:numel(exp.pitch.lmr),exp.pitch.lmr,'r');
    plot(1:numel(exp.pitch.x),[exp.pitch.x-mean(exp.pitch.x)]/(max(exp.pitch.x)-mean(exp.pitch.x)),'k');
    title('Pitch')
    
    subplot(4,6,9); hold on;
    errorbar(.5,exp.pitch.lag,exp.pitch.lag_m_sem,exp.pitch.lag_p_sem,'r')
    errorbar(.75,cont.pitch.lag,cont.pitch.lag_m_sem,cont.pitch.lag_p_sem,'b')
    title('Lag')
    
    subplot(4,6,10); hold on;
    errorbar(.5,exp.pitch.corr,exp.pitch.corr_m_sem,exp.pitch.corr_p_sem,'r')
    errorbar(.75,cont.pitch.corr,cont.pitch.corr_m_sem,cont.pitch.corr_p_sem,'b')
    title('Correlation')
    
    % roll
    subplot(4,6,[5 6]); hold on;
    plot(1:numel(cont.roll.lmr),cont.roll.lmr,'b');
    plot(1:numel(exp.roll.lmr),exp.roll.lmr,'r');
    plot(1:numel(exp.roll.x),[exp.roll.x-mean(exp.roll.x)]/(max(exp.roll.x)-mean(exp.roll.x)),'k');
    title('Roll')
    
    subplot(4,6,11); hold on;
    errorbar(.5,exp.roll.lag,exp.roll.lag_m_sem,exp.roll.lag_p_sem,'r')
    errorbar(.75,cont.roll.lag,cont.roll.lag_m_sem,cont.roll.lag_p_sem,'b')
    title('Lag')
    
    subplot(4,6,12); hold on;
    errorbar(.5,exp.roll.corr,exp.roll.corr_m_sem,exp.roll.corr_p_sem,'r')
    errorbar(.75,cont.roll.corr,cont.roll.corr_m_sem,cont.roll.corr_p_sem,'b')
    title('Correlation')
    
    % Side Slip
    subplot(4,6,[13 14]); hold on;
    plot(1:numel(cont.sslip.lmr),cont.sslip.lmr,'b');
    plot(1:numel(exp.sslip.lmr),exp.sslip.lmr,'r');
    plot(1:numel(exp.sslip.x),[exp.sslip.x-mean(exp.sslip.x)]/(max(exp.sslip.x)-mean(exp.sslip.x)),'k');
    title('Side Slip')
    ylabel('LmR [V]')
    
    subplot(4,6,19); hold on;
    errorbar(.5,exp.sslip.lag,exp.sslip.lag_m_sem,exp.sslip.lag_p_sem,'r')
    errorbar(.75,cont.sslip.lag,cont.sslip.lag_m_sem,cont.sslip.lag_p_sem,'b')
    title('Lag')
    
    subplot(4,6,20); hold on;
    errorbar(.5,exp.sslip.corr,exp.sslip.corr_m_sem,exp.sslip.corr_p_sem,'r')
    errorbar(.75,cont.sslip.corr,cont.sslip.corr_m_sem,cont.sslip.corr_p_sem,'b')
    title('Correlation')

    
    % Thrust
    subplot(4,6,[15 16]); hold on;
    plot(1:numel(cont.thrust.lmr),cont.thrust.lmr,'b');
    plot(1:numel(exp.thrust.lmr),exp.thrust.lmr,'r');
    plot(1:numel(exp.thrust.x),[exp.thrust.x-mean(exp.thrust.x)]/(max(exp.thrust.x)-mean(exp.thrust.x)),'k');
    title('Thrust')
    
    subplot(4,6,21); hold on;
    errorbar(.5,exp.thrust.lag,exp.thrust.lag_m_sem,exp.thrust.lag_p_sem,'r')
    errorbar(.75,cont.thrust.lag,cont.thrust.lag_m_sem,cont.thrust.lag_p_sem,'b')
    title('Lag')
    
    subplot(4,6,22); hold on;
    errorbar(.5,exp.thrust.corr,exp.thrust.corr_m_sem,exp.thrust.corr_p_sem,'r')
    errorbar(.75,cont.thrust.corr,cont.thrust.corr_m_sem,cont.thrust.corr_p_sem,'b')
    title('Correlation') 

    % Yaw
    subplot(4,6,[17 18]); hold on;
    plot(1:numel(cont.yaw.lmr),cont.yaw.lmr,'b');
    plot(1:numel(exp.yaw.lmr),exp.yaw.lmr,'r');
    plot(1:numel(exp.yaw.x),[exp.yaw.x-mean(exp.yaw.x)]/(max(exp.yaw.x)-mean(exp.yaw.x)),'k');
    title('Yaw')
    
    subplot(4,6,23); hold on;
    errorbar(.5,exp.yaw.lag,exp.yaw.lag_m_sem,exp.yaw.lag_p_sem,'r')
    errorbar(.75,cont.yaw.lag,cont.yaw.lag_m_sem,cont.yaw.lag_p_sem,'b')
    title('Lag')
    
    subplot(4,6,24); hold on;
    errorbar(.5,exp.yaw.corr,exp.yaw.corr_m_sem,exp.yaw.corr_p_sem,'r')
    errorbar(.75,cont.yaw.corr,cont.yaw.corr_m_sem,cont.yaw.corr_p_sem,'b')
    title('Correlation') 

    %% Make on_off_pattern_figure    
    on_off_pattern_figure = figure;
    figure_name = 'ON OFF Figure';
    set(on_off_pattern_figure,'Numbertitle','off','Name',figure_name,'Color','white');
    
    % ON-L-Expansion    OFF-L-Expansion     SAW-ON-L    SAW-OFF-L
    % 113/114           115/116             117/118     119/(MISSING)
    
    % on expansion
    [exp.onExp.x] = ...
        experimental.get_mean_sem('x_pos',[113]);
    [exp.onExp.lmr] = ...
        experimental.get_mean_sem_symmetric_conditions('lmr',[113,114]);
    [exp.onExp.int_lmr, exp.onExp.int_lmr_m_sem, exp.onExp.int_lmr_p_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('integrated_lmr_response',[113,114]);

    [cont.onExp.lmr] = ...
        control.get_mean_sem_symmetric_conditions('lmr',[113,114]);
    [cont.onExp.int_lmr, cont.onExp.int_lmr_m_sem, cont.onExp.int_lmr_p_sem] = ...
        control.get_mean_sem_symmetric_conditions('integrated_lmr_response',[113,114]);
    
    % off expansion
    [exp.offExp.x] = ...
        experimental.get_mean_sem('x_pos',[115]);
    [exp.offExp.lmr] = ...
        experimental.get_mean_sem_symmetric_conditions('lmr',[115,116]);
    [exp.offExp.int_lmr, exp.offExp.int_lmr_m_sem, exp.offExp.int_lmr_p_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('integrated_lmr_response',[115,116]);

    [cont.offExp.lmr] = ...
        control.get_mean_sem_symmetric_conditions('lmr',[115,116]);
    [cont.offExp.int_lmr, cont.offExp.int_lmr_m_sem, cont.offExp.int_lmr_p_sem] = ...
        control.get_mean_sem_symmetric_conditions('integrated_lmr_response',[115,116]);

    % saw on expansion
    [exp.sawOnExp.x] = ...
        experimental.get_mean_sem('x_pos',[117]);
    [exp.sawOnExp.lmr] = ...
        experimental.get_mean_sem_symmetric_conditions('lmr',[117,118]);
    [exp.sawOnExp.int_lmr, exp.sawOnExp.int_lmr_m_sem, exp.sawOnExp.int_lmr_p_sem] = ...
        experimental.get_mean_sem_symmetric_conditions('integrated_lmr_response',[117,118]);

    [cont.sawOnExp.lmr] = ...
        control.get_mean_sem_symmetric_conditions('lmr',[117,118]);
    [cont.sawOnExp.int_lmr, cont.sawOnExp.int_lmr_m_sem, cont.sawOnExp.int_lmr_p_sem] = ...
        control.get_mean_sem_symmetric_conditions('integrated_lmr_response',[117,118]);
        
    % saw off expansion
    [exp.sawOffExp.x] = ...
        experimental.get_mean_sem('x_pos',[119]);
    [exp.sawOffExp.lmr] = ...
        experimental.get_mean_sem('lmr',[119]);
    [exp.sawOffExp.int_lmr, exp.sawOffExp.int_lmr_m_sem, exp.sawOffExp.int_lmr_p_sem] = ...
        experimental.get_mean_sem('integrated_lmr_response',[119]);

    [cont.sawOffExp.lmr] = ...
        control.get_mean_sem('lmr',[119]);
    [cont.sawOffExp.int_lmr, cont.sawOffExp.int_lmr_m_sem, cont.sawOffExp.int_lmr_p_sem] = ...
        control.get_mean_sem('integrated_lmr_response',[119]);

    % plot on/off
    subplot(2,6,[1 2]); hold on;
    plot(1:numel(cont.onExp.lmr),cont.onExp.lmr,'b')
    plot(1:numel(exp.onExp.lmr),exp.onExp.lmr,'r')
    plot(1:numel(exp.onExp.x),[exp.onExp.x-mean(exp.onExp.x(5:end))]/max(exp.onExp.x),'k')
    title('On Expansion');
    ylabel('LmR [V]')

    subplot(2,6,[3 4]); hold on;   
    plot(1:numel(cont.offExp.lmr),cont.offExp.lmr,'b')
    plot(1:numel(exp.offExp.lmr),exp.offExp.lmr,'r')
    plot(1:numel(exp.offExp.x),[exp.offExp.x-mean(exp.offExp.x(5:end))]/max(exp.offExp.x),'k')
    title('Off Expansion');
    
    subplot(2,6,[5]); hold on;
    errorbar(.5,cont.onExp.int_lmr,cont.onExp.int_lmr_m_sem,cont.onExp.int_lmr_p_sem,'b');
    errorbar(.75,exp.onExp.int_lmr,exp.onExp.int_lmr_m_sem,exp.onExp.int_lmr_p_sem,'r');
    ylabel('Integrated LmR')
    title('On Expansion');
    
    subplot(2,6,[6]); hold on;
    errorbar(.5,cont.offExp.int_lmr,cont.offExp.int_lmr_m_sem,cont.offExp.int_lmr_p_sem,'b');
    errorbar(.75,exp.offExp.int_lmr,exp.offExp.int_lmr_m_sem,exp.offExp.int_lmr_p_sem,'r');
    title('Off Expansion')
    
    % plot saw on/off
    subplot(2,6,[7 8]); hold on;
    plot(1:numel(cont.sawOnExp.lmr),cont.sawOnExp.lmr,'b')
    plot(1:numel(exp.sawOnExp.lmr),exp.sawOnExp.lmr,'r')
    plot(1:numel(exp.sawOnExp.x),[exp.sawOnExp.x-mean(exp.sawOnExp.x(5:end))]/max(exp.sawOnExp.x),'k')
    title('On Expansion');
    ylabel('LmR [V]')

    subplot(2,6,[9 10]); hold on;   
    plot(1:numel(cont.sawOffExp.lmr),cont.sawOffExp.lmr,'b')
    plot(1:numel(exp.sawOffExp.lmr),exp.sawOffExp.lmr,'r')
    plot(1:numel(exp.sawOffExp.x),[exp.sawOffExp.x-mean(exp.sawOffExp.x(5:end))]/max(exp.sawOffExp.x),'k')
    title('Off Expansion');
    
    subplot(2,6,[11]); hold on;
    errorbar(.5,cont.sawOnExp.int_lmr,cont.sawOnExp.int_lmr_m_sem,cont.sawOnExp.int_lmr_p_sem,'b');
    errorbar(.75,exp.sawOnExp.int_lmr,exp.sawOnExp.int_lmr_m_sem,exp.sawOnExp.int_lmr_p_sem,'r');
    ylabel('Integrated LmR')
    title('On Expansion');
    
    subplot(2,6,[12]); hold on;
    errorbar(.5,cont.sawOffExp.int_lmr,cont.sawOffExp.int_lmr_m_sem,cont.sawOffExp.int_lmr_p_sem,'b');
    errorbar(.75,exp.sawOffExp.int_lmr,exp.sawOffExp.int_lmr_m_sem,exp.sawOffExp.int_lmr_p_sem,'r');
    title('Off Expansion')
    
    %% Make rp_contrast_rot_figure
%     rp_contrast_rot_figure = figure;
%     figure_name = 'Rev Phi + Rotations Figure';
%     set(rp_contrast_rot_figure,'Numbertitle','off','Name',figure_name,'Color','white');
%     
%     
    
end