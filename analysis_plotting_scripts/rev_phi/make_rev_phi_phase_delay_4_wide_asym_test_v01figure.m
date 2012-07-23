function make_rev_phi_phase_delay_4_wide_asym_test_v01figure(fig_type,geno)
% make reverse phi phase delay figures, uses ExpSet

% Load things in if needed...
a = 0; b = 0; c = 0;

if a == 1
    cd /Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_asym_test_v01
    gmr_11d03ad_gal80ts_kir21  = tfAnalysis.import('/Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_asym_test_v01/gmr_11d03ad_gal80ts_kir21','all');
    save('gmr_11d03ad_gal80ts_kir21','gmr_11d03ad_gal80ts_kir21')
end

if b == 1
    cd /Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_asym_test_v01
    load('gmr_11d03ad_gal80ts_kir21')    
end

if c == 1;
    geno.gmr_11d03ad_gal80ts_kir21  = tfAnalysis.ExpSet(gmr_11d03ad_gal80ts_kir21);
end

cd /Users/holtzs/Desktop/rev_phi_phase_delay_4_wide_asym_test_v01_figures

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
        iter = 1;
        subplot(2,4,[1 2 3 4])
        for i = 1:numel(grouped_conditions)
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
        title(temp_genotype.grouped_conditions{1}.polarity)
        legend(handle_array,title_array)
        xlabel('Flicker Offset [ms]')
        %ylabel('\Sigma LmR [V]')
        ylabel('Mean LmR [V]')
        %set(gca,'XLim',[-64 64]);
        iter = 1;
        subplot(2,4,[5 6 7 8])
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
            end
            phase_diffs = (temp_genotype.grouped_conditions{i}.tf)*(2*pi)*(temp_genotype.grouped_conditions{i}.x_axis/1000);
            tfPlot.simple_tuning_curve({[means{:}],[sems{:}],phase_diffs},0);
            iter = iter + 1;
            means = []; sems = [];
        end
        
        xlabel('Flicker Offset [rad]')
        ylabel('\Sigma LmR [V]') 
        %set(gca,'XLim',[-.23 .23],'Xticklabel','');
        set(gca,'Xticklabel','');
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
        
        subplot_mat = [1:35,...
                       36:70];
        
        subplot_iter = 0;
        for i = 1:numel(grouped_conditions)
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
                        ylabel('.75 Hz Polarity 0')
                        axis on
                    case 36
                        ylabel('.75 Hz Polarity 1')
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
    title('Standard Reverse Phi')
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
    export_fig(gcf,['standard_oop_rev_phi_'  geno_fieldnames{f}],'-pdf')
    
    % Make the 'zero crossing' figure
    
    for f = 1:numel(geno_fieldnames)
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            % Get the points for one speed of the before flicker conditions
            for c = 1:median(1:numel(cond_list))+1;
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means(c) sems(c)] = temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all');
                x_values(c) = temp_genotype.grouped_conditions{i}.x_axis(c);
            end
            means = means(2:end);sems = sems(2:end);x_values = x_values(2:end);
            % Do splines on means and +/- sems
            b_zero_cross(f).x_interpolant=min(x_values):.25:max(x_values); %#ok<*AGROW>
            b_zero_cross(f).splined_means = spline(x_values,means,b_zero_cross(f).x_interpolant);
            b_zero_cross(f).splined_sems_p = spline(x_values,means+sems,b_zero_cross(f).x_interpolant);
            b_zero_cross(f).splined_sems_m = spline(x_values,means-sems,b_zero_cross(f).x_interpolant);
            
            % Find the zeros of the splines and then plot them to sanity
            % check!
            [~,min_ind]=min(abs(b_zero_cross(f).splined_means));
            b_zero_cross(f).mean(i) = b_zero_cross(f).x_interpolant(min_ind);
            
            [~,min_ind_p]=min(abs(b_zero_cross(f).splined_sems_p));
            b_zero_cross(f).sem_p(i) = b_zero_cross(f).x_interpolant(min_ind_p);
            
            [~,min_ind_m]=min(abs(b_zero_cross(f).splined_sems_m));                    
            b_zero_cross(f).sem_m(i)  = b_zero_cross(f).x_interpolant(min_ind_m);
            b_x_axis_vals(i) = temp_genotype.grouped_conditions{i}.tf;

            means = []; sems = []; x_values = []; c = 0;
            for c_iter = 1+median(1:numel(cond_list)):numel(cond_list);
                c = c + 1;
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means(c) sems(c)] = temp_genotype.get_trial_data([cond_list{c_iter}(1),cond_list{c_iter}(2)],'lmr','mean','yes','all');
                x_values(c) = temp_genotype.grouped_conditions{i}.x_axis(c_iter);
            end
            
            means = means(1:end-2);sems = sems(1:end-2);x_values = x_values(1:end-2);
            % Do splines on means and +/- sems
            a_zero_cross(f).x_interpolant=min(x_values):.25:max(x_values);
            a_zero_cross(f).splined_means = spline(x_values,means,a_zero_cross(f).x_interpolant);
            a_zero_cross(f).splined_sems_p = spline(x_values,means+sems,a_zero_cross(f).x_interpolant);
            a_zero_cross(f).splined_sems_m = spline(x_values,means-sems,a_zero_cross(f).x_interpolant);
            
            % Find the zeros of the splines and then plot them to sanity
            % check!
            [~,min_ind]=min(abs(a_zero_cross(f).splined_means));
            a_zero_cross(f).mean(i)  = a_zero_cross(f).x_interpolant(min_ind);
            
            [~,min_ind_p]=min(abs(a_zero_cross(f).splined_sems_p));
            a_zero_cross(f).sem_p(i)      = a_zero_cross(f).x_interpolant(min_ind_p);
                 
            [~,min_ind_m]=min(abs(a_zero_cross(f).splined_sems_m));                    
            a_zero_cross(f).sem_m(i)  = a_zero_cross(f).x_interpolant(min_ind_m);
            a_x_axis_vals(i) = temp_genotype.grouped_conditions{i}.tf;
                
            
            %Explanatory plot for data to come
                figure('Name',[num2str(i) ' Hz Zero Crossing Point ',geno_fieldnames{f}],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);
                subplot(2,3,1)
            %     plot(b_zero_cross(f).x_interpolant,b_zero_cross(f).splined_sems_m); hold all
            %     plot(x_values,means-sems); hold on
            %     plot(b_zero_cross(f).sem_p(i),b_zero_cross(f).splined_sems_m(min_ind_p),'o')
            %     
                plot(a_zero_cross(f).x_interpolant,a_zero_cross(f).splined_sems_m); hold all
                plot(x_values,means-sems); hold on
                plot(a_zero_cross(f).sem_p(i),a_zero_cross(f).splined_sems_m(min_ind_p),'o')    

                title('SEM -, spline and zero crossing')
                ylabel('LMR Means')

                subplot(2,3,2)
            %     plot(b_zero_cross(f).x_interpolant,b_zero_cross(f).splined_means);hold all
            %     plot(x_values,means); hold on            
            %     plot(b_zero_cross(f).mean(i),b_zero_cross(f).splined_means(min_ind),'o')

                plot(a_zero_cross(f).x_interpolant,a_zero_cross(f).splined_means);hold all
                plot(x_values,means); hold on            
                plot(a_zero_cross(f).mean(i),a_zero_cross(f).splined_means(min_ind),'o')

                title('Mean , spline and zero crossing')

                subplot(2,3,3)
            %     plot(b_zero_cross(f).x_interpolant,b_zero_cross(f).splined_sems_p); hold all
            %     plot(x_values,means+sems); hold on            
            %     plot(b_zero_cross(f).sem_p(i),b_zero_cross(f).splined_sems_p(min_ind_p),'o')

                plot(a_zero_cross(f).x_interpolant,a_zero_cross(f).splined_sems_p); hold all
                plot(x_values,means+sems); hold on            
                plot(a_zero_cross(f).sem_p(i),a_zero_cross(f).splined_sems_p(min_ind_p),'o')

                title('SEM +, spline and zero crossing')

                subplot(2,3,[4 5 6])
                hold all
            %     plot(x_values,means);        
            %     plot(b_zero_cross(f).x_interpolant,b_zero_cross(f).splined_means); hold on
            %     plot(b_zero_cross(f).mean(i),b_zero_cross(f).splined_means(min_ind),'o')
                hold all
                plot(a_zero_cross(f).x_interpolant,a_zero_cross(f).splined_means); hold on
                plot(a_zero_cross(f).mean(i),a_zero_cross(f).splined_means(min_ind),'o')
                hold all
            %     plot(b_zero_cross(f).x_interpolant,b_zero_cross(f).splined_sems_p,'--'); hold on
            %     plot(b_zero_cross(f).sem_p(i),b_zero_cross(f).splined_sems_p(min_ind_p),'o')
            %     hold all
                plot(a_zero_cross(f).x_interpolant,a_zero_cross(f).splined_sems_p,'--'); hold on
                plot(a_zero_cross(f).sem_p(i),a_zero_cross(f).splined_sems_p(min_ind_p),'o')    
                hold all
            %     plot(b_zero_cross(f).x_interpolant,b_zero_cross(f).splined_sems_m,'--'); hold on
            %     plot(b_zero_cross(f).sem_m(i),b_zero_cross(f).splined_sems_m(min_ind_m),'o')
            %     hold all
                plot(a_zero_cross(f).x_interpolant,a_zero_cross(f).splined_sems_m,'--'); hold on
                plot(a_zero_cross(f).sem_m(i),a_zero_cross(f).splined_sems_m(min_ind_m),'o')

                xlabel('Flicker Motion offset [ms]')
                title('Zero Crossing and Likely Error Determined...')
                
                annotation('Textbox',[.3 .85 .6 .15],'String',[ num2str(i) ' Hz Zero Crossing: ',geno_fieldnames{i} '  N = ',num2str(numel(temp_genotype.experiment))],'edgecolor','none','Interpreter','none')
                export_fig(gcf,[ num2str(i) 'hz_zero_point_cross_'  geno_fieldnames{f}],'-pdf')
                
        end
        % Plot each genotypes tf's zero crossing
        % handle_array(i) = tfPlot.simple_tuning_curve({[a_zero_cross(f).mean],[a_zero_cross(f).mean]-[a_zero_cross(f).sem_p],[b_x_axis_vals{:}]},0);
        %title_array{i} = temp_genotype.grouped_conditions{i}.name;
    end
    
    % Zero cross for all temp freq: before
    sumFigHand(2) = figure('Name','Summary Zero Crossing Point','NumberTitle','off','Color',[1 1 1],'Position',[50 50 750 750]);    
    subplot(2,3,1)
    for f = 1:numel(b_zero_cross)
        tfPlot.simple_tuning_curve({[b_zero_cross(f).mean],[b_zero_cross(f).mean]-[b_zero_cross(f).sem_p],b_x_axis_vals},0.01,false);
        hold all
    end
    %set(gca,'Xticklabel',x_axis_names)
    box off
    title('Zero Point Cross: Fick Before Motion')
    ylabel('Abs Val of zero crossing value for flicker offset [ms]')
    xlabel('Stim Temporal Frequency')
    
    % Zero cross for all temp freq: after
    subplot(2,3,2)
    
    for f = 1:numel(a_zero_cross)
        tfPlot.simple_tuning_curve({[a_zero_cross(f).mean],[a_zero_cross(f).mean]-[a_zero_cross(f).sem_p],a_x_axis_vals},0.01,false);
        hold all
    end
    box off
    title('Zero Point Cross: Fick After Motion')
    l_hand=legend(geno_fieldnames);
    set(l_hand,'Position',[0.65 0.775 0.3 0.18],'Interpreter','none');
    % Make a comparison of zero crossing before vs after for each temp freq
    % 1 Hz
    subplot(2,3,4)
    for f = 1:numel(a_zero_cross)
        hz_stim_ind = 1;
        tfPlot.simple_tuning_curve({abs([b_zero_cross(f).mean(hz_stim_ind) a_zero_cross(f).mean(hz_stim_ind)]),abs([b_zero_cross(f).mean(hz_stim_ind)-b_zero_cross(f).sem_p(hz_stim_ind), a_zero_cross(f).mean(hz_stim_ind)-a_zero_cross(f).sem_p(hz_stim_ind)]),[1 2]},.015);
        hold all
    end
    box off
    set(gca,'xticklabel',{'','b','a',''})
    ylabel('Abs Val of zero crossing value for flicker offset [ms]')
    xlabel('Flicker Phase')
    title('Before vs After: 1 Hz')
    
    % 2 Hz
    subplot(2,3,5)
    for f = 1:numel(a_zero_cross)    
        hz_stim_ind = 2;
        tfPlot.simple_tuning_curve({abs([b_zero_cross(f).mean(hz_stim_ind) a_zero_cross(f).mean(hz_stim_ind)]),abs([b_zero_cross(f).mean(hz_stim_ind)-b_zero_cross(f).sem_p(hz_stim_ind), a_zero_cross(f).mean(hz_stim_ind)-a_zero_cross(f).sem_p(hz_stim_ind)]),[1 2]},.015);
        hold all
    end
    box off    
    set(gca,'xticklabel',{'','b','a',''})    
    title('Before vs After: 2 Hz')

    % 3 Hz
    subplot(2,3,6)
    for f = 1:numel(a_zero_cross)    
        hz_stim_ind = 3;
        tfPlot.simple_tuning_curve({abs([b_zero_cross(f).mean(hz_stim_ind) a_zero_cross(f).mean(hz_stim_ind)]),abs([b_zero_cross(f).mean(hz_stim_ind)-b_zero_cross(f).sem_p(hz_stim_ind), a_zero_cross(f).mean(hz_stim_ind)-a_zero_cross(f).sem_p(hz_stim_ind)]),[1 2]},.015);
        hold all    
    end
    box off    
    set(gca,'xticklabel',{'','b','a',''})    
    title('Before vs After: 3 Hz')

    annotation('Textbox',[.3 .85 .6 .15],'String','Reverse Phi Zero Point Crossing Across Gal4 Lines','edgecolor','none')    
    export_fig(gcf,'zero_point_cross_summary','-pdf')
    
end

end