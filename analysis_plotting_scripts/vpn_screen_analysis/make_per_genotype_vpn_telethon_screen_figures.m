% make_per_genotype_vpn_telethon_screen_figures
% 
% make a figure for each genotype for a look at all of the 'hit heavy'
% stimuli
%

% Make sure my file utilities are in place
addpath(genpath('/Users/stephenholtz/matlab-utils'))

% Set up directories for use
data_location = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';

figure_location = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/per_genotype_summary_figures';

summary_file_location = fullfile(data_location,'..');
if ~exist('fig_data_summ','var')
    load(fullfile(summary_file_location,'fig_data_summ.mat'))
end

% Positions for each figure/figureset
% first row
vel_null_pos    = [.045 .67 .23 .23];
optomotor_pos   = [.33 .67 .15 .23];
contrast_pos    = [.525 .67 .15 .23];
img_pos         = [.7 .62 .3 .3];

% the rest
ts_bond_corr_stripe_pos = [-.05 .46 .1 .12];
ts_donb_corr_stripe_pos = [-.05 .26 .1 .12];
ts_grat_corr_stripe_pos = [-.05 .06 .1 .12];

bond_corr_stripe_pos = [.42 .46 .12 .12];
donb_corr_stripe_pos = [.42 .26 .12 .12];
grat_corr_stripe_pos = [.42 .06 .12 .12];

osc_long_45deg_stim_pos     = [.595 .275 .145 .12];
osc_long_00deg_stim_pos     = [.595 .06 .145 .12];
osc_short_45deg_stim_pos    = [.795 .275 .145 .12];
osc_short_00deg_stim_pos    = [.795 .06 .145 .12];

metadata_textbox_pos = [.575 .45 .38 .15];
title_pos            = [.29 .89 .5 .1];

%for normalization_type = {'not_norm','norm'}
%for geno_iter = 1:numel(fig_data_summ)
normalization_type = {'not_norm'};
geno_iter = 1;   

% Set up the figure
switch normalization_type{1}
    case {'not_norm'}
        figure_name = ['Non-Normalized Summary Results: ' fig_data_summ(geno_iter).geno_name];
    case {'norm'}
        figure_name = ['Normalized Summary Results: ' fig_data_summ(geno_iter).geno_name];
end

handle(geno_iter) = figure('Name',figure_name,'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1000 800],'PaperOrientation','portrait');

% Velocity nulling curve (or blank)
if 1
    if isempty(fig_data_summ(geno_iter).vel_null_summ.(normalization_type{1}).null_contrast)
        subplot('Position',vel_null_pos)
    else
        null_contrast_vals = cell2mat(fig_data_summ(geno_iter).vel_null_summ.(normalization_type{1}).null_contrast);
        avg_null_contrast_vals = null_contrast_vals +.01; %%%% FIX %%%%

        mycolormap = {[.15 .15 .5],[1 .65 0],[238 0 238]/255,[255 99 71]/255,[.5 0 .5]};

        %--Plot a line for every value in the subplot
        temp_freq = [.2 1.3 5.3 10.7 16];

        subplot('Position',vel_null_pos)
        semilogx(temp_freq,null_contrast_vals,'Color',mycolormap{1},'LineWidth',2);
        hold on;
        semilogx(temp_freq,avg_null_contrast_vals,'Color',mycolormap{2},'LineWidth',2);
        box off;
        set(gca,'XTick',[1 10],'Xticklabel',{'1', '10'},'LineWidth',1,'FontSize',14);
        axis([0 20 0 6]);
        xlabel('Test Stim. Temp. Freq. (Hz)')
        ylabel('1 / null contrast')
        title('Velocity Nulling')
    end
end

% Optomotor Response
if 1
    % The genotype
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).optomotor.avg;
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).optomotor.sem;
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).optomotor.avg +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).optomotor.sem +1;
    graph.color{2} = mycolormap{2};
    
    subplot('Position',optomotor_pos)
    
    tfPlot.tuning_curve(graph);
    
    set(gca,'XTick',1:4,'Xticklabel',{'.25', '1.5', '4.5', '9'},'LineWidth',1,'FontSize',14);
    axis([0 5 0 5]);
    xlabel('Temporal Frequency')
    ylabel('Mean LmR [V]')
    title('Optomotor Response')
    box off;
    
end

% Contrast Turning Response
if 1
    % The genotype
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).contrast.avg;
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).contrast.sem;
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).contrast.avg +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).contrast.sem +1;
    graph.color{2} = mycolormap{2};
    
    subplot('Position',contrast_pos)
    
    tfPlot.tuning_curve(graph);

    set(gca,'XTick',1:4,'Xticklabel',{'.23', '.07', '.06', '.24'},'LineWidth',1,'FontSize',14);
    xlabel('Michelson Contrast')    
    ylabel('Mean LmR [V]')
    title('Contrast Turning Resp.')
    axis([0 5 0 5]);    
    box off;
    
end

% Add Image
if 1
    subplot('Position',img_pos); 
    subimage(fig_data_summ(geno_iter).img);
    axis off; box off;
end

% Add metadata
if 1
    %optomotor_score = num2str(walking_optomotor_val(geno_iter));
    textbox_string =   {[fig_data_summ(geno_iter).geno_name '            N = ' num2str(fig_data_summ(geno_iter).tuning_curves.not_norm.contrast.num)],...
                       [''],...
                       [fig_data_summ(geno_iter).AD ' ' fig_data_summ(geno_iter).DBD],...
                       [''],...
                       ['Mean Walking Optomotor = ?'],...
                       ['Place Learning Score   = ?']};
    annotation('textbox','position',metadata_textbox_pos,'string',...
                textbox_string,...
                'interpreter','none','EdgeColor',[0 0 0],...
                'fontsize',14);    
            
    annotation('textbox','position',title_pos,'string',figure_name,...
                'interpreter','none','EdgeColor','none','fontsize',15);
    
end

% Raw Stripe Tracking @ 3 speeds for DonB / BonD / Grat
if 1
    
    % Bright Stripe on dark background
    for subset_iter = 1:3
        % The genotype
        graph.avg{1}       = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_ts.avg{subset_iter};
        graph.variance{1}  = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_ts.sem{subset_iter};
        graph.color{1} = mycolormap{2};
        % The average response
        graph.avg{2}       = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_ts.avg{subset_iter};
        graph.variance{2}  = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_ts.sem{subset_iter};
        graph.color{2} = mycolormap{2};

        ts_bond_corr_stripe_pos(1) = ts_bond_corr_stripe_pos(1) + (.11);
        
        subplot('Position',ts_bond_corr_stripe_pos)
        tfPlot.timeseries(graph);

        set(gca,'LineWidth',1,'FontSize',14);
        set(gca,'Ylim',[-7.15 7.15])
        box off; axis off
        
        if subset_iter == 1
            ylabel({'','Stripe Tracking: Bright on Dark'})
            %ylabel('LmR')
            axis on
            title('1 Hz')
        elseif subset_iter == 2
            title('3 Hz')
        elseif subset_iter == 3
            title('5 Hz')            
        end
    end
    
    % Dark stripe on bright backgrouns
    for subset_iter = 1:3
        % The genotype
        graph.avg{1}       = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_donb_ts.avg{subset_iter};
        graph.variance{1}  = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_donb_ts.sem{subset_iter};
        graph.color{1} = mycolormap{2};
        % The average response
        graph.avg{2}       = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_donb_ts.avg{subset_iter};
        graph.variance{2}  = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_donb_ts.sem{subset_iter};
        graph.color{2} = mycolormap{2};

        ts_donb_corr_stripe_pos(1) = ts_donb_corr_stripe_pos(1) + (.11);
        
        subplot('Position',ts_donb_corr_stripe_pos)
        tfPlot.timeseries(graph);

        set(gca,'LineWidth',1,'FontSize',14);
        set(gca,'Ylim',[-7.15 7.15])
        box off; axis off
        
        if subset_iter == 1
            ylabel({'Stripe Tracking: Dark on Bright',''})
            %ylabel('LmR')
            axis on
            title('1 Hz')
        elseif subset_iter == 2
            title('3 Hz')
        elseif subset_iter == 3
            title('5 Hz')            
        end
    end
    
    % Grating
    for subset_iter = 1:3
        % The genotype
        graph.avg{1}       = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_grat_ts.avg{subset_iter};
        graph.variance{1}  = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_grat_ts.sem{subset_iter};
        graph.color{1} = mycolormap{2};
        % The average response
        graph.avg{2}       = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_grat_ts.avg{subset_iter};
        graph.variance{2}  = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_grat_ts.sem{subset_iter};
        graph.color{2} = mycolormap{2};

        ts_grat_corr_stripe_pos(1) = ts_grat_corr_stripe_pos(1) + (.11);
        
        subplot('Position',ts_grat_corr_stripe_pos)
        tfPlot.timeseries(graph);

        set(gca,'LineWidth',1,'FontSize',14);
        set(gca,'Ylim',[-7.15 7.15])
        box off; axis off
        if subset_iter == 1
            ylabel({'','Stripe Tracking: Grating'})
            xlabel('Time')
            %ylabel('LmR')
            axis on
            title('1 Hz')
        elseif subset_iter == 2
            title('3 Hz')
        elseif subset_iter == 3
            title('5 Hz')
        end
    end    
end

% Xcorr Stripe Tracking @ 3 speeds for DonB / BonD / Grat
if 1
    
    % Bright Stripe on dark background
    % The genotype
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field.avg;
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field.sem;
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field.avg +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field.sem +1;
    graph.color{2} = mycolormap{2};    
    
    subplot('Position',bond_corr_stripe_pos)
    tfPlot.tuning_curve(graph);
    
    set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '5'},'LineWidth',1,'FontSize',14);    
    %title('Stripe Tracking: Bright on Dark')
    xlabel('Temporal Frequency')
    ylabel('Correlation')
    
    % Dark stripe on bright background
    % The genotype
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_donb.avg;
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_donb.sem;
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_donb.avg +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_donb.sem +1;
    graph.color{2} = mycolormap{2};    
    
    subplot('Position',donb_corr_stripe_pos)
    tfPlot.tuning_curve(graph);
    
    set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '5'},'LineWidth',1,'FontSize',14);    
    %title('Stripe Tracking: Dark on Bright')
    xlabel('Temporal Frequency')
    ylabel('Correlation')
    
    
    % Grating
    % The genotype
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_grat.avg;
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).small_field_grat.sem;
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_grat.avg +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).small_field_grat.sem +1;
    graph.color{2} = mycolormap{2};    
    
    subplot('Position',grat_corr_stripe_pos)
    tfPlot.tuning_curve(graph);
    
    set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '5'},'LineWidth',1,'FontSize',14);    
    %title('Stripe Tracking: Grating')
    xlabel('Temporal Frequency')
    ylabel('Correlation') 
    
end

% Add other osc_stim raw data
if 1
    % [ 45 degrees long subset_iter=1 ]  [ 45 degrees short subset_iter=2 ]
    % [ 00 degrees long subset_iter=3 ]  [ 00 degrees short subset_iter=4 ]
    
    %45 degree position, long
    subset_iter = 1;
    
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).osc_stim_ts.avg{subset_iter};
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).osc_stim_ts.sem{subset_iter};
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).osc_stim_ts.avg{subset_iter} +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).osc_stim_ts.sem{subset_iter} +1;
    graph.color{2} = mycolormap{2};    
    
    subplot('Position',osc_long_45deg_stim_pos)
    tfPlot.timeseries(graph);
    
    set(gca,'LineWidth',1,'FontSize',14);
    title('Long, 45 Deg Oscillating Stripe')
    ylabel('LmR')

    %45 degree position, short
    subset_iter = 2;
    
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).osc_stim_ts.avg{subset_iter};
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).osc_stim_ts.sem{subset_iter};
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).osc_stim_ts.avg{subset_iter} +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).osc_stim_ts.sem{subset_iter} +1;
    graph.color{2} = mycolormap{2};    
    
    subplot('Position',osc_short_45deg_stim_pos)
    tfPlot.timeseries(graph);
    
    set(gca,'LineWidth',1,'FontSize',14);
    title('Short, 45 Deg Oscillating Stripe')
    ylabel('LmR')    
    
    %00 degree position, long
    subset_iter = 1;
    
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).osc_stim_ts.avg{subset_iter};
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).osc_stim_ts.sem{subset_iter};
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).osc_stim_ts.avg{subset_iter} +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).osc_stim_ts.sem{subset_iter} +1;
    graph.color{2} = mycolormap{2};    
    
    subplot('Position',osc_long_00deg_stim_pos)
    tfPlot.timeseries(graph);
    
    set(gca,'LineWidth',1,'FontSize',14);
    title('Long, 0 Deg Oscillating Stripe')
    xlabel('Time')
    ylabel('LmR')
    
    %00 degree position, short
    subset_iter = 2;
    
    graph.avg{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).osc_stim_ts.avg{subset_iter};
    graph.variance{1} = fig_data_summ(geno_iter).tuning_curves.(normalization_type{1}).osc_stim_ts.sem{subset_iter};
    graph.color{1} = mycolormap{1};
    % The average response
    graph.avg{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).osc_stim_ts.avg{subset_iter} +1;
    graph.variance{2} = fig_data_summ(geno_iter).avg_tuning_curves.(normalization_type{1}).osc_stim_ts.sem{subset_iter} +1;
    graph.color{2} = mycolormap{2};    
    
    subplot('Position',osc_short_00deg_stim_pos)
    tfPlot.timeseries(graph);
    
    set(gca,'LineWidth',1,'FontSize',14);
    title('Short, 0 Deg Oscillating Stripe')
    xlabel('Time')
    ylabel('LmR')    
    
end


% Save the figures
export_fig(handle(geno_iter),fullfile(figure_location,['summary_figure_' fig_data_summ(geno_iter).geno_name]),'-pdf')


% end
% end















