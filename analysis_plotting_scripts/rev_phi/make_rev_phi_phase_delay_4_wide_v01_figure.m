function make_rev_phi_phase_delay_4_wide_v01_figure(fig_type,geno)
% make reverse phi phase delay figures, uses ExpSet

% Load things in if needed...
a = 0; b = 0; c = 0;

if a == 1
    cd /Users/holtzs/Desktop/rp_pd_temp_dir
    
    gmr_20c11ad_48d11dbd_gal80ts_kir21  = tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_v01/gmr_20c11ad_48d11dbd_gal80ts_kir21','all');
    save('gmr_20c11ad_48d11dbd_gal80ts_kir21','gmr_20c11ad_48d11dbd_gal80ts_kir21')
    gmr_25b02ad_48d11dbd_gal80ts_kir21  = tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_v01/gmr_25b02ad_48d11dbd_gal80ts_kir21','all');
    save('gmr_25b02ad_48d11dbd_gal80ts_kir21','gmr_25b02ad_48d11dbd_gal80ts_kir21') 
    gmr_35a03ad_29g11dbd_gal80ts_kir21  = tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_v01/gmr_35a03ad_29g11dbd_gal80ts_kir21','all');
    save('gmr_35a03ad_29g11dbd_gal80ts_kir21','gmr_35a03ad_29g11dbd_gal80ts_kir21')
    gmr_48a08dbd_gal80ts_kir21          = tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_v01/gmr_48a08dbd_gal80ts_kir21','all');
    save('gmr_48a08dbd_gal80ts_kir21','gmr_48a08dbd_gal80ts_kir21')
    gmr_31c06ad_34g07dbd_gal80ts_kir21  = tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_v01/gmr_31c06ad_34g07dbd_gal80ts_kir21','all');
    save('gmr_31c06ad_34g07dbd_gal80ts_kir21','gmr_31c06ad_34g07dbd_gal80ts_kir21')
    gmr_52h01ad_17c11dbd_gal80ts_kir21  = tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_v01/gmr_52h01ad_17c11dbd_gal80ts_kir21','all');
    save('gmr_52h01ad_17c11dbd_gal80ts_kir21','gmr_52h01ad_17c11dbd_gal80ts_kir21')
end

if b == 1
    cd /Users/holtzs/Desktop/rp_pd_temp_dir
    
    load('gmr_20c11ad_48d11dbd_gal80ts_kir21')
    load('gmr_25b02ad_48d11dbd_gal80ts_kir21') 
    load('gmr_35a03ad_29g11dbd_gal80ts_kir21')
    load('gmr_48a08dbd_gal80ts_kir21');
    load('gmr_31c06ad_34g07dbd_gal80ts_kir21');
    load('gmr_52h01ad_17c11dbd_gal80ts_kir21');
    
end

if c == 1;
    geno.gmr_20c11ad_48d11dbd_gal80ts_kir21  = tfAnalysis.ExpSet(gmr_20c11ad_48d11dbd_gal80ts_kir21);
    geno.gmr_25b02ad_48d11dbd_gal80ts_kir21  = tfAnalysis.ExpSet(gmr_25b02ad_48d11dbd_gal80ts_kir21);
    geno.gmr_35a03ad_29g11dbd_gal80ts_kir21  = tfAnalysis.ExpSet(gmr_35a03ad_29g11dbd_gal80ts_kir21);
    geno.gmr_48a08dbd_gal80ts_kir21          = tfAnalysis.ExpSet(gmr_48a08dbd_gal80ts_kir21);
    geno.gmr_31c06ad_34g07dbd_gal80ts_kir21  = tfAnalysis.ExpSet(gmr_31c06ad_34g07dbd_gal80ts_kir21);
    geno.gmr_52h01ad_17c11dbd_gal80ts_kir21  = tfAnalysis.ExpSet(gmr_52h01ad_17c11dbd_gal80ts_kir21);
    
end

cd /Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_v01_figures

switch fig_type
    case 'all'
        tuning_fig_flag     = 1;
        raw_lmr_fig_flag    = 1;
        summ_fig_flag       = 1;
    case {'tune','rose'}
        tuning_fig_flag     = 1;
        raw_lmr_fig_flag    = 0;
        summ_fig_flag       = 0;
    case 'raw'
        tuning_fig_flag     = 0;
        raw_lmr_fig_flag    = 1;
        summ_fig_flag       = 0;   
    case 'summ'
        tuning_fig_flag     = 0;
        raw_lmr_fig_flag    = 0;
        summ_fig_flag       = 1;         
    otherwise
        tuning_fig_flag     = 1; 
        raw_lmr_fig_flag    = 0;
        summ_fig_flag       = 1;
end

% get all of the genotypes from the geno struct
geno_fieldnames = fieldnames(geno);

% pre and post phase delay tuning curve per genotype
if tuning_fig_flag
    for f = 1:numel(geno_fieldnames)
        tuneFigHand(f) = figure('Name',['Tuning Figure ', geno_fieldnames{f}],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 500 750]);
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        
        subplot(2,4,[1 2 3 4])
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
            end
            
            handle_array(i) = tfPlot.simple_tuning_curve({[means{:}],[sems{:}],[temp_genotype.grouped_conditions{i}.x_axis]},0);
            title_array{i} = temp_genotype.grouped_conditions{i}.name;
            means = []; sems = [];
        end
        
        legend(handle_array,title_array)
        xlabel('Flicker Offset [ms]')
        %ylabel('\Sigma LmR [V]')
        ylabel('Mean LmR [V]')
        set(gca,'XLim',[-64 64]);
        
        subplot(2,4,[5 6 7 8])
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
            end
            phase_diffs = (temp_genotype.grouped_conditions{i}.tf)*(2*pi)*(temp_genotype.grouped_conditions{i}.x_axis/1000);
            tfPlot.simple_tuning_curve({[means{:}],[sems{:}],phase_diffs},0);
            means = []; sems = [];
        end
        
        xlabel('Flicker Offset [rad]')
        ylabel('\Sigma LmR [V]') 
        set(gca,'XLim',[-.23 .23],'Xticklabel','');
        
        annotation('Textbox',[.3 .85 .6 .15],'String','Reverse Phi With Flicker Phase Delay','edgecolor','none')
        annotation('Textbox',[.825 .85 .2 .15],'String',['N=' num2str(numel(temp_genotype.experiment))],'edgecolor','none')
        export_fig(tuneFigHand(f),geno_fieldnames{f},'-pdf')
    end
end

% average lmr traces per genotype
if raw_lmr_fig_flag
    for f = 1:numel(geno_fieldnames)
        rawFigHand(f) = figure('Name',['Raw Trace Figure ', geno_fieldnames{f}],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        
        subplot_mat = [1:17,...
                       18:34,...
                       35:51];
        
        subplot_iter = 0;
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            % Flip the first half of the cond list to make sense for the plot
            % cond_list = [flipud(cond_list(1:ceil(numel(cond_list)/2))); cond_list(ceil(numel(cond_list)/2)+1:end)];
                        
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [mean_lmr sem_lmr] = temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','none','yes','all');
                
                subplot_iter = subplot_iter + 1;
                subplot(3,17,subplot_mat(subplot_iter))
                tfPlot.simple_timeseries({mean_lmr,mean_lmr+sem_lmr,mean_lmr-sem_lmr});
                set(gca,'Xticklabel',''); axis off
                %if ~sum(subplot_mat(subplot_iter) == [1:9 19:27 37:43])
                   title([num2str(temp_genotype.grouped_conditions{i}.x_axis(c)) 'ms']);
                %end
                switch subplot_mat(subplot_iter)
                    case 1
                        ylabel('1 Hz')
                        axis on
                    case 18
                        ylabel('2 Hz')
                        axis on
                    case 35
                        ylabel('3 Hz')
                        axis on
                        xlabel('Time [ms]')
                        set(gca,'Xticklabel',{'1','','2',''});
                end

                mean_lmr = []; sem_lmr = [];
            end
        end
        
        annotation('Textbox',[.3 .85 .6 .15],'String','Reverse Phi With Flicker Phase Delay','edgecolor','none')
        annotation('Textbox',[.825 .85 .2 .15],'String',['N=' num2str(numel(temp_genotype.experiment))],'edgecolor','none')
        annotation('Textbox',[.2 .825 .8 .15],'String','LmR [V] Over Symmetrical Conditions, Flicker Before and After Motion','edgecolor','none')
        export_fig(rawFigHand(f),['Raw Traces: ' geno_fieldnames{f}],'-pdf')
    end
end

% summary figures across all 
if summ_fig_flag
    % Make a regular and out of phase reverse phi comparison across
    % genotypes
    sumFigHand(1) = figure('Name','RP + RPOOP Summary Figure','NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
    subplot(1,3,1)
    for f = 1:numel(geno_fieldnames)
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        temp_genotype = eval(['geno.' geno_fieldnames{f}]);
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list((numel(grouped_conditions{i}.list)/2)+.5);
            [mean_lmr(i,f) sem_lmr(i,f)] = temp_genotype.get_trial_data([cond_list{1}(1),cond_list{1}(2)],'lmr','mean','yes','all');            
        end
    end
    
    tfPlot.simple_timeseries({mean_lmr,mean_lmr+sem_lmr,mean_lmr-sem_lmr});    
    legend(reshape(reshape(repmat(geno_fieldnames,2,1),numel(geno_fieldnames),2)',numel(geno_fieldnames)*2,1),'Interpreter','none')
    ylabel('\Sigma LmR WBA [V]')
    xlabel('Temporal Frequency [Hz]')
    title('Out of phase flicker: before')
    box off    
    
    % Compare the completely out of phase responses    
    subplot(1,3,2)
    for f = 1:numel(geno_fieldnames)
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        temp_genotype = eval(['geno.' geno_fieldnames{f}]);
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list(1);
            [mean_lmr(i,f) sem_lmr(i,f)] = temp_genotype.get_trial_data([cond_list{1}(1),cond_list{1}(2)],'lmr','mean','yes','all');            
        end
    end
    
    tfPlot.simple_timeseries({mean_lmr,mean_lmr+sem_lmr,mean_lmr-sem_lmr});    
    title('Out of phase flicker: before')
    box off
    
    subplot(1,3,3)
    for f = 1:numel(geno_fieldnames)
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        temp_genotype = eval(['geno.' geno_fieldnames{f}]);
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list(numel(grouped_conditions{i}.list));
            [mean_lmr(i,f) sem_lmr(i,f)] = temp_genotype.get_trial_data([cond_list{1}(1),cond_list{1}(2)],'lmr','mean','yes','all');            
        end
    end
    
    tfPlot.simple_timeseries({mean_lmr,mean_lmr+sem_lmr,mean_lmr-sem_lmr});    
    title('Out of phase flicker: after')
    box off
    
    annotation('Textbox',[.3 .85 .6 .15],'String','Standard and Out of Phase Reverse Phi Across Gal4 Lines','edgecolor','none')
    
    % Make the 'zero crossing' figure
    sumFigHand(2) = figure('Name','Summary Zero Crossing Point','NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
    
    for f = 1:numel(geno_fieldnames)
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            % Get the points for one speed of the before flicker conditions
            for c = 1:median(numel(cond_list));
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means(c) sems(c)]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
                x_values(c) = temp_genotype.grouped_conditions{i}.x_axis(c);
            end
            
            splined_means = spline(x_values,means,min(x_values):max(x_values));
            
            zero_cross.mean(i)  = fzero(splined_means);
            zero_cross.sem(i)   = [];
            %handle_array(i) = tfPlot.simple_tuning_curve({[means{:}],[sems{:}],[temp_genotype.grouped_conditions{i}.x_axis]},0);
            %title_array{i} = temp_genotype.grouped_conditions{i}.name;
            means = []; sems = [];
        end
        % Determine the 
        
    end
    
    % Zero cross for all temp freq: before
    subplot(2,2,1)
    
    title('Zero Point Cross: Fick Before Motion')
    
    % Zero cross for all temp freq: after
    subplot(2,2,2)
    
    title('Zero Point Cross: Fick After Motion')
    
    % Make a comparison of zero crossing before vs after for each temp freq
    % 1 Hz
    subplot(2,3,4)
    
    title('Before vs After: 1 Hz')
    
    % 2 Hz
    subplot(2,3,5)
    
    title('Before vs After: 2 Hz')
    
    % 3 Hz
    subplot(2,3,6)
    
    title('Before vs After: 3 Hz')

    annotation('Textbox',[.3 .85 .6 .15],'String','Reverse Phi Zero Point Crossing Across Gal4 Lines','edgecolor','none')    
    
end

end