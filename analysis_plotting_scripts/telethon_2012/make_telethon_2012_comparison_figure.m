function make_telethon_2012_comparison_figure(geno_data)
%function make_telethon_2012_comparison_figure(destination_folder,varargin)
% 1) function make_telethon_2012_comparison_figure(destination_folder,genotype_1,genotype_2,...)
%
% From the grouped_conds.m file:
%
% The telethon experiment has several condition groups (divided as in the manuscript)
% Most are 2.5 seconds, 9-10 are 3 seconds, 13 is 10 seconds, 14 is 5 seconds.
% 01 - Full Field Rotation
% 02 - Full Field Expansion
% 03 - Lateral Flicker
% 04 - Low Contrast Rotation
% 05 - Reverse-Phi Rotation
% 06 - Stripe Oscillation ('94 degree' stripe/ grating)
% 07 - Regressive Motion
% 08 - Progressive Motion
% 09 - ON/OFF Expansion
% 10 - ON/OFF Sawtooth
% 11 - Optic Flow Oscillation (diff flow fields)
% 12 - Velocity Nulling (Contrast Nulling)
% 13 - Stripe Fixation (Interspersed 3 second and 10 second conditions)
% 14 - Small Object Oscillation (NEW)
% 15 - Empty, to be Motion Coherence (Testing Section...)
%
% Each of these figures will be made
% Trying out a new way for assembling screeny-type-figures

if 0
% My figure testing lines (folder names)
geno_name{1} = 'gmr_26a03dbd_gal80ts_kir21';
geno_name{2} = 'gmr_35d04ad_gal80ts_kir21';
data_location = '/Users/holtzs/Desktop/telethon_experiment_2012';

%--Begin MainFunc--%
for g = 1:numel(geno_name)
    stable_dir_name = dir(fullfile(data_location,[geno_name{g},'*']));
    location = fullfile(data_location,stable_dir_name.name);
    
    if exist(fullfile(location,'processed_data.mat'),'file')
        load(fullfile(location,'processed_data.mat'));
    else
        processed_data = load_data(location);
    end
    
    geno_data{g} = tfAnalysis.ExpSet(processed_data); %#ok<*AGROW>
    
    clear processed_data force
end
end

% Gross global colormap variable
mycolormap = {[.8 0 .8],[.75 .5 .1],[.05 .8 1],[1 0 0],[0 1 0]};

make_all_sub_figures(geno_data)

%mkdir(fullfile(data_location,filesep,'..','analysis_figures'));
%destination_folder = fullfile(data_location,filesep,'..','analysis_figures');

%save_figure(handle,destination_folder,geno_name)

%--Begin SubFuncs--%
    
    function processed_data = load_data(location)
        processed_data = tfAnalysis.import(location,'all');
        save(fullfile(location,'processed_data.mat'),'processed_data')
    end
    
    function make_all_sub_figures(geno_data)
%          make_full_field_rotation(geno_data)    % DONE
%          make_full_field_expansion(geno_data)   % DONE
%          make_lateral_flicker(geno_data)        % DONE
%          make_low_contrast_rotation(geno_data)  % DONE
%          make_reverse_phi_rotation(geno_data)   % DONE
%          make_stripe_oscillation(geno_data)     % DONE
%          make_regressive_motion(geno_data)      % DONE
%          make_progressive_motion(geno_data)     % DONE
%          make_on_off_expansion(geno_data)       % DONE
%          make_on_off_sawtooth(geno_data)        % DONE
%          make_optic_flow_oscillation(geno_data) % DONE
%          make_velocity_nulling(geno_data)      % NEED TO DESTROY SELF
%          make_stripe_fixation(geno_data)       % DONE
          make_small_object_oscillation(geno_data) %
    end
    
    function handle = make_full_field_rotation(geno_data)
        
        handle = setup_figure(3);
        
        graph_type = 1;
        
        cond_num = 1;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
                
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(1:4);
        list{2} = geno_data{1}.grouped_conditions{cond_num}.list(5:8);
        list{3} = geno_data{1}.grouped_conditions{cond_num}.list(9:12);
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam(1);
        lam{2} = geno_data{1}.grouped_conditions{cond_num}.lam(5);
        lam{3} = geno_data{1}.grouped_conditions{cond_num}.lam(9);
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf(1:4);
        tf{2} = geno_data{1}.grouped_conditions{cond_num}.tf(5:8);
        tf{3} = geno_data{1}.grouped_conditions{cond_num}.tf(9:12);
        
        dps{1} = geno_data{1}.grouped_conditions{cond_num}.dps(1:4);
        dps{2} = geno_data{1}.grouped_conditions{cond_num}.dps(5:8);
        dps{3} = geno_data{1}.grouped_conditions{cond_num}.dps(9:12);
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
        
    end
    
    function handle = make_full_field_expansion(geno_data)
        
        handle = setup_figure(4);
        
        graph_type = 1;        
        
        cond_num = 2;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(1:2);
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam(1:2);
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf(1:2);
        
        dps{1} = geno_data{1}.grouped_conditions{cond_num}.dps(1:2);
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
    end
    
    function handle = make_lateral_flicker(geno_data)
        
        handle = setup_figure(5);
        
        graph_type = 1;        
        
        cond_num = 3;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(1);
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam(1);
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf(1);
        
        dps{1} = 0;
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
        
    end
    
    function handle = make_low_contrast_rotation(geno_data)
        
        handle = setup_figure(4);

        graph_type = 1;        
        
        cond_num = 4;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
                
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(1:4);
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam(1);
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf(1:4);
        
        dps{1} = geno_data{1}.grouped_conditions{cond_num}.dps(1:4);

        mc{1} = geno_data{1}.grouped_conditions{cond_num}.mc(1:4);        
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
        
        xlabel('Michelson Contrast')
        set(gca,'XTick',1:numel(tf{1}),'Xticklabel',mc{1},'LineWidth',1);
        
    end
    
    function handle = make_reverse_phi_rotation(geno_data)
        
        handle = setup_figure(3);
        
        graph_type = 1;
        
        cond_num = 5;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(1:3);
        list{2} = geno_data{1}.grouped_conditions{cond_num}.list(4:6);
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam(1);
        lam{2} = geno_data{1}.grouped_conditions{cond_num}.lam(4);
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf(1:3);
        tf{2} = geno_data{1}.grouped_conditions{cond_num}.tf(4:6);
        
        dps{1} = geno_data{1}.grouped_conditions{cond_num}.dps(1:3);
        dps{2} = geno_data{1}.grouped_conditions{cond_num}.dps(4:6);
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
        
    end
    
    function handle = make_stripe_oscillation(geno_data)
        
        handle = setup_figure(3);
        
        graph_type = 2;
        
        cond_num = 6;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(1:3);
        list{2} = geno_data{1}.grouped_conditions{cond_num}.list(4:6);
        list{3} = geno_data{1}.grouped_conditions{cond_num}.list(7:9);
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam(1);
        lam{2} = geno_data{1}.grouped_conditions{cond_num}.lam(4);
        lam{3} = geno_data{1}.grouped_conditions{cond_num}.lam(7);        
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.hz_osc(1:3);
        tf{2} = geno_data{1}.grouped_conditions{cond_num}.hz_osc(4:6);
        tf{3} = geno_data{1}.grouped_conditions{cond_num}.hz_osc(7:9);        
        
        dps{1} = geno_data{1}.grouped_conditions{cond_num}.dps(1:3);
        dps{2} = geno_data{1}.grouped_conditions{cond_num}.dps(4:6);
        dps{3} = geno_data{1}.grouped_conditions{cond_num}.dps(7:9);
        
        type{1} = geno_data{1}.grouped_conditions{cond_num}.type(1:3);
        type{2} = geno_data{1}.grouped_conditions{cond_num}.type(4:6);
        type{3} = geno_data{1}.grouped_conditions{cond_num}.type(7:9);
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data,'lmr','x_pos',type);
    
    end
    
    function handle = make_regressive_motion(geno_data)
        
        handle = setup_figure(4);
        
        graph_type = 1;
        
        cond_num = 7;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list;
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam;
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf;
        
        dps{1} = geno_data{1}.grouped_conditions{cond_num}.dps;
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
        
    end
    
    function handle = make_progressive_motion(geno_data)
        
        handle = setup_figure(4);
        
        graph_type = 1;
        
        cond_num = 8;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list;
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam;
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf;
        
        dps{1} = geno_data{1}.grouped_conditions{cond_num}.dps;
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
        
    end
    
    function handle = make_on_off_expansion(geno_data)
        
        handle = setup_figure(4);
        
        graph_type = 1;
        
        cond_num = 9;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list;
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam;
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf;
        
        dps{1} = zeros(1,numel(tf{1}));
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
        
        set(gca,'XTick',1:numel(tf{1}),'Xticklabel',{'ON','OFF'},'LineWidth',1);
    end
    
    function handle = make_on_off_sawtooth(geno_data)
        
        handle = setup_figure(4);
        
        graph_type = 1;
        
        cond_num = 10;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list;
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam;
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf;
        
        dps{1} = zeros(1,numel(tf{1}));
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
    
        set(gca,'XTick',1:numel(tf{1}),'Xticklabel',{'ON','OFF'},'LineWidth',1);

    end
    
    function handle = make_optic_flow_oscillation(geno_data)
        
        % lmr figure
        handle = setup_figure(4);
        
        graph_type = 2;
        
        cond_num = 11;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])     
        
        % stims for lmr
        
        lmr_inds = [2 3 4 6];
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(lmr_inds);
                
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf(lmr_inds);
        
        type{1} = geno_data{1}.grouped_conditions{cond_num}.type(lmr_inds);        
        
        dps{1} = zeros(1,numel(tf{1}));
        
        lam{1} = zeros(1,numel(tf{1}));   
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data,'lmr','x_pos',type);    
        
        % wbf figure
        handle = setup_figure(4);
        
        graph_type = 2;
        
        cond_num = 11;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])        
        
        % stims for wbf
        
        wbf_inds = [4 5];
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(wbf_inds);
                
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf(wbf_inds);
        
        type{1} = geno_data{1}.grouped_conditions{cond_num}.type(wbf_inds);        
        
        dps{1} = zeros(1,numel(tf{1}));
        
        lam{1} = zeros(1,numel(tf{1}));   
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data,'wbf','x_pos',type);
        
    end
    
    function handle = make_velocity_nulling(geno_data)
        
        cond_num = 12;
        
        handle = setup_figure(4);
        
        graph_type = 1;
                
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list;
        
        lam{1} = geno_data{1}.grouped_conditions{cond_num}.lam;
        
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.tf;
        
        dps{1} = zeros(1,numel(tf{1}));
        
        handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data);
        
    end
    
    function handle = make_stripe_fixation(geno_data)
        
        cond_num = 13;
        
        handle = setup_figure(5);
                
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(1);
        
        % PLOT FOR STRIPE FIXATION

        % Each stripe fix duration (a new subplot)
        for k = 1:numel(list)

            subplot(1,numel(list),k);
            hold all

            % Each genotype (a new line/curve)
            for i = 1:numel(geno_data)

                for j = 1:numel(list{k})

                    [curve_mean curve_sem] = geno_data{i}.get_trial_data(list{k}{j},'x_pos','none','no',1);

                end

                % Need to calculate actual bounds!
                min_val = 4.2;
                max_val = 5.8;

                for n = 1:size(curve_mean,1)
                    pos_fixation(n) = sum((curve_mean(n,:) > min_val) & (curve_mean(n,:) < max_val))/numel(curve_mean(n,:));
                end

                fixation_idx = 100*mean(pos_fixation);
                fixation_idx_sem = 100*std(pos_fixation)/(numel(pos_fixation))^(1/2);
                
                clear pos_fixation
                
                h = tfPlot.simple_tuning_curve({fixation_idx, fixation_idx_sem});
                set(h,'Color',mycolormap{i},'LineWidth',1)

            end

            title([geno_data{1}.grouped_conditions{cond_num}.name])
            xlabel('')
            ylabel('Fixation Index')
            set(gca,'ylim',[0 100])

        end
                
    end
    
    function handle = make_small_object_oscillation(geno_data)
        
        cond_num = 14;
        
        handle = setup_figure(3);
        
        graph_type = 2;
        
        set(handle,'Name',[geno_data{1}.grouped_conditions{cond_num}.name ': ' geno_data{1}.experiment{1}.line_name])
        
        list{1} = geno_data{1}.grouped_conditions{cond_num}.list(1);
        list{2} = geno_data{1}.grouped_conditions{cond_num}.list(2);
        list{3} = geno_data{1}.grouped_conditions{cond_num}.list(3);
        list{4} = geno_data{1}.grouped_conditions{cond_num}.list(4);
                
        tf{1} = geno_data{1}.grouped_conditions{cond_num}.pos_deg(1);
        tf{2} = geno_data{1}.grouped_conditions{cond_num}.pos_deg(2);
        tf{3} = geno_data{1}.grouped_conditions{cond_num}.pos_deg(3);
        tf{4} = geno_data{1}.grouped_conditions{cond_num}.pos_deg(4);        
        
        type{1} = geno_data{1}.grouped_conditions{cond_num}.bar_size(1);
        type{2} = geno_data{1}.grouped_conditions{cond_num}.bar_size(2);
        type{3} = geno_data{1}.grouped_conditions{cond_num}.bar_size(3);
        type{4} = geno_data{1}.grouped_conditions{cond_num}.bar_size(4);        
        
        type{1} = geno_data{1}.grouped_conditions{cond_num}.pos_deg(1);
        type{2} = geno_data{1}.grouped_conditions{cond_num}.pos_deg(2);
        type{3} = geno_data{1}.grouped_conditions{cond_num}.pos_deg(3);
        type{4} = geno_data{1}.grouped_conditions{cond_num}.pos_deg(4);
        
        lam{1} = zeros(1,numel(tf{1}));
        
        dps{1} = zeros(1,numel(tf{1}));

        
        %handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data,'lmr','x_pos',type);
    
        
        % This is too different to use the do_plot function on...
        
        % Each of the different position/bar height combos
        for k = 1:4
            
            % [ 45 degrees long k=1 ]  [ 45 degrees short k=2 ]
            % [ 00 degrees long k=3 ]  [ 00 degrees short k=4 ]
            
            subplot(2,2,k)
            
            for i = 1:numel(geno_data)
                
                [curve_mean(j) curve_sem(j)] = geno_data{i}.get_trial_data(list{k}{j},'lmr','trapz','yes','all');
            
            end
        end
        
    end

    function handle = do_plot(graph_type,cond_num,list,tf,dps,lam,geno_data,varargin)
        
        switch graph_type
            
            case 1
                
                % PLOT FOR REGULAR TUNING CURVE
                
                % Each spatial frequency (a new subplot)
                for k = 1:numel(list)
                    
                    subplot(1,numel(list),k);
                    hold all
                    
                    % Each genotype (a new line/curve)
                    for i = 1:numel(geno_data)
                        
                        % Each condition within the tuning curve (points in the line)
                        for j = 1:numel(list{k})
                            
                            [curve_mean(j) curve_sem(j)] = geno_data{i}.get_trial_data(list{k}{j},'lmr','trapz','yes','all');
                            
                            geno_data{i}.experiment{1}.line_name;
                            
                        end
                        
                        h = tfPlot.simple_tuning_curve({curve_mean, curve_sem});
                        set(h,'Color',mycolormap{i},'LineWidth',1)
                    end
                    
                    for x = 1:numel(tf{k})
                        x_label{x} = [num2str(tf{k}(x))  ' (' num2str(dps{k}(x)) ')'];
                    end
                    
                    set(gca,'XTick',1:numel(tf{k}),'Xticklabel',x_label,'LineWidth',1);
                    clear x_label
                    
                    title([geno_data{1}.grouped_conditions{cond_num}.name '\lambda :' num2str(lam{k}) '\circ'])
                    xlabel('Temporal Frequency (\circ/s)')
                    ylabel('\Sigma LmR [V]')
                    
                end 
                
            case 2
                
                % PLOT FOR CORRELATED STIM AND WING BEATS!
                
                daq_channel_1 = varargin{1};
                
                daq_channel_2 = varargin{2};
                
                x_label_source = varargin{3};
                
                % Each spatial frequency (a new subplot)
                for k = 1:numel(list)
                    
                    subplot(1,numel(list),k);
                    hold all
                    
                    % Each genotype (a new line/curve)
                    for i = 1:numel(geno_data)

                        % Each condition within the tuning curve (points in the line)
                        for j = 1:numel(list{k})
                            
                            [curve_mean(j) curve_sem(j)] = geno_data{i}.get_corr_trial_data(list{k}{j},daq_channel_1,daq_channel_2,'all');
                            
                        end
                        
                        h = tfPlot.simple_tuning_curve({curve_mean, curve_sem});
                        set(h,'Color',mycolormap{i},'LineWidth',1)
                    end
                    
                    for x = 1:numel(x_label_source{k})
                        if iscell(x_label_source{1}(:))
                            x_label{x} = x_label_source{1}{x};
                        else
                            x_label{x} = x_label_source{x};
                        end
                    end
        
                    xlabel('Oscillating Stim')
                    set(gca,'XTick',1:numel(tf{1}),'Xticklabel',x_label,'LineWidth',1);

                    title([geno_data{1}.grouped_conditions{cond_num}.name '\lambda :' num2str(lam{k}) '\circ'])
                    ylabel(['Correlation ' daq_channel_1 '+' daq_channel_2],'Interpreter','none')
                    
                end
                
        end
        
        handle = gcf;
        
    end
    
    function handle = setup_figure(type)
        switch type
            case 1
                handle = figure('NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050 750],'PaperOrientation','landscape');
            case 2
                handle = figure('NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050/2 750],'PaperOrientation','landscape');
            case 3
                handle = figure('NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050 750/2],'PaperOrientation','landscape');
            case 4
                handle = figure('NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050/2 750/2],'PaperOrientation','landscape');
            case 5
                handle = figure('NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050/4 750/2],'PaperOrientation','landscape');
        end
    end

    function handle = add_legend_with_n(geno_data)
        
        for i = 1:numel(geno_data)
            
            N{i} = num2str(numel(geno_data{i}.experiment));
            
            name{i} = geno_data{i}.experiment{1}.line_name;
            
            n_name{i} = [name{i} 'N=' N{i}];
            
        end
        
        legend(n_name{:})
        
    end

    function save_figure(handle,destination_folder,names)
        if numel(names) == 2
            saveas(handle,fullfile(destination_folder,[names{1}(4:end) '_vs_' names{2}(4:end)]),'.pdf')
        elseif numel(names) == 1
            saveas(handle,fullfile(destination_folder,names{1}(4:end)),'.pdf')            
        else
            error('saving this number of genotypes is not supported...')
        end
        % export fig
    end

end