function make_unilat_rev_phi_phase_delay_4_wide_v01_fig(fig_type,geno)
% make reverse phi phase delay figures, uses ExpSet

% Load things in if needed...
a = 0; b = 0; c = 0;

if a == 1
    cd /Users/holtzs/Desktop/unilat_rev_phi_phase_delay_4_wide_v01
    gmr_11d03ad_gal80ts_kir21  = tfAnalysis.import('/Users/holtzs/Desktop/unilat_rev_phi_phase_delay_4_wide_v01/gmr_11d03ad_gal80ts_kir21','all');
    save('gmr_11d03ad_gal80ts_kir21','gmr_11d03ad_gal80ts_kir21')
end

if b == 1
    cd /Users/holtzs/Desktop/unilat_rev_phi_phase_delay_4_wide_v01
    load('gmr_11d03ad_gal80ts_kir21.mat')    
end

if c == 1;
    geno.gmr_11d03ad_gal80ts_kir21  = tfAnalysis.ExpSet(gmr_11d03ad_gal80ts_kir21);
end

cd /Users/holtzs/Desktop/unilat_rev_phi_phase_delay_4_wide_v01/figures

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
        tuneFigHand(f) = figure('Name',['Tuning Figure ', geno_fieldnames{f}],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050 750]);
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        iter = 1;
        subplot(2,2,1)
        for i = [1:3] %numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
            end
            
            handle_array(iter) = tfPlot.simple_tuning_curve({[means{:}],[sems{:}],[temp_genotype.grouped_conditions{i}.x_axis]},0);
            title_array{iter} = temp_genotype.grouped_conditions{i}.name;
            
            iter = iter + 1;
            means = []; sems = [];
        end
        title('Reverse Phi Progressive Motion')
        xlabel('Flicker Offset [ms]')
        ylabel('Mean LmR [V]')
        
        iter = 1;
        subplot(2,2,2)
        for i = [4:6] %numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
            end
            
            handle_array(iter) = tfPlot.simple_tuning_curve({[means{:}],[sems{:}],[1 2]},0);
            title_array{iter} = temp_genotype.grouped_conditions{i}.name;
            
            iter = iter + 1;
            means = []; sems = [];
        end
        title('Standard Phi Progressive Motion')
        set(gca,'XTick',[1 2],'Xticklabel',[temp_genotype.grouped_conditions{i}.contrast]);
        legend(handle_array,title_array,'location','northeastoutside')
        xlabel('Contrast from rev phi parts')
        ylabel('Mean LmR [V]')        
        
        iter = 1;
        subplot(2,2,3)
        for i = [7:9] %numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
            end
            
            tfPlot.simple_tuning_curve({[means{:}],[sems{:}],temp_genotype.grouped_conditions{i}.x_axis},0);
            
            iter = iter + 1;
            means = []; sems = [];
        end
        
        title('Rev Phi Regressive Motion')
        xlabel('Flicker Offset [ms]')

        iter = 1;
        subplot(2,2,4)
        for i = [10:12] %numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
            end
            
            handle_array2(iter) = tfPlot.simple_tuning_curve({[means{:}],[sems{:}],[1 2]},0);
            title_array2{iter} = temp_genotype.grouped_conditions{i}.name;

            iter = iter + 1;
            means = []; sems = [];
        end
        
        legend(handle_array2,title_array2,'location','northeastoutside')
        title('Standard Phi Regressive Motion')
        xlabel('Contrast from rev phi parts')
        set(gca,'XTick',[1 2],'Xticklabel',[temp_genotype.grouped_conditions{i}.contrast]);
        annotation('Textbox',[.3 .85 .6 .15],'String','Reverse Phi With Flicker Phase Delay','edgecolor','none')
        annotation('Textbox',[.825 .85 .2 .15],'String',['N=' num2str(numel(temp_genotype.experiment))],'edgecolor','none')
        export_fig(tuneFigHand(f),geno_fieldnames{f},'-pdf')
    end
end

% average lmr traces per genotype
if raw_lmr_fig_flag
    for f = 1:numel(geno_fieldnames)
        rawFigHand(f) = figure('Name',['Rev Phi Phase Delay Raw Trace Figure ', geno_fieldnames{f}],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        
        subplot_mat = [1:35,...
                       36:70];
        
        subplot_iter = 0;
        for i = 1:numel(grouped_conditions)-2
            cond_list = grouped_conditions{i}.list;
            % Flip the first half of the cond list to make sense for the plot
            % cond_list = [flipud(cond_list(1:ceil(numel(cond_list)/2))); cond_list(ceil(numel(cond_list)/2)+1:end)];
                        
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [mean_lmr sem_lmr] = temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','none','yes','all');
                
                subplot_iter = subplot_iter + 1;
                %subplot(2,35,subplot_mat(subplot_iter))
                switch i
                    case 1
                        subplot('Position',[(.35+subplot_iter)*.0275 .55 1/(42) .35])
                    case 2
                        subplot('Position',[((.35+subplot_iter)-35)*.0275 .15 1/(42) .35])                        
                end
                plot(mean_lmr); hold all; box off; set(gca,'Ylim',[-5 5])
                %tfPlot.simple_timeseries({mean_lmr,mean_lmr+sem_lmr,mean_lmr-sem_lmr});
                set(gca,'Xticklabel',''); axis off
                if sum(subplot_mat(subplot_iter) == [2 18 34 37 53 69])
                    title([num2str(temp_genotype.grouped_conditions{i}.x_axis(c)) 'ms']);
                end
                switch subplot_mat(subplot_iter)
                    case 1
                        ylabel('.75 Hz Progressive (F2B)')
                        axis on
                    case 36
                        ylabel('.75 Hz Regressive (B2F)')
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
        
        
        figure('Name',['Raw Trace Figure ', geno_fieldnames{f}],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
        
        subplot_iter = 0;
        for i = 2:4
            cond_list = grouped_conditions{i}.list;
            % Flip the first half of the cond list to make sense for the plot
            % cond_list = [flipud(cond_list(1:ceil(numel(cond_list)/2))); cond_list(ceil(numel(cond_list)/2)+1:end)];

            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [mean_lmr sem_lmr] = temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','none','yes','all');
                
                subplot_iter = subplot_iter + 1;
                subplot(2,2,subplot_iter)
                
                tfPlot.simple_timeseries({mean_lmr,mean_lmr+sem_lmr,mean_lmr-sem_lmr});
                set(gca,'Xticklabel',''); axis off
                
                title(temp_genotype.grouped_conditions{i}.name(c));
                
                switch subplot_mat(subplot_iter)
                    case 1
                        ylabel('.75 Hz Progressive (F2B)')
                        axis on
                    case 36
                        ylabel('.75 Hz Regressive (B2F)')
                        axis on
                        xlabel('Time [ms]')
                        set(gca,'Xticklabel',{'1','','2',''});
                end
                
                mean_lmr = []; sem_lmr = [];
            end
        end        
        export_fig(rawFigHand(f),['Raw Traces: ' geno_fieldnames{f}],'-pdf','-append')
    end
end

end