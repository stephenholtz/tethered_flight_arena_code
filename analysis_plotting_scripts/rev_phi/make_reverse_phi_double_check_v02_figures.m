function make_reverse_phi_double_check_v02_figures(geno,samples)

    if ~exist('samples','var')
        samples = 1:300;
    end
    % Load em up
    if false
        addpath(genpath('/Users/holtzs/tethered_flight_arena_code'))        
        cd /Users/holtzs/Desktop/reverse_phi_double_check_v02/gmr_11d03ad_gal80ts_kir21/
        gmr_11d03ad_gal80ts_kir21{1} = tfAnalysis.import('/Users/holtzs/Desktop/reverse_phi_double_check_v02/gmr_11d03ad_gal80ts_kir21','all'); %#ok<*UNRCH>
        save('gmr_11d03ad_gal80ts_kir21','gmr_11d03ad_gal80ts_kir21')
    end
    
    if false
        addpath(genpath('/Users/holtzs/tethered_flight_arena_code'))        
        cd /Users/holtzs/Desktop/reverse_phi_double_check_v02/gmr_11d03ad_gal80ts_kir21/
        load('gmr_11d03ad_gal80ts_kir21')
        geno.gmr_11d03ad_gal80ts_kir21 = tfAnalysis.ExpSet(gmr_11d03ad_gal80ts_kir21{1});
    end
    
    geno_fieldnames = fieldnames(geno);
    cd /Users/holtzs/Desktop/reverse_phi_double_check_v02/gmr_11d03ad_gal80ts_kir21/
    
    % pre and post phase delay tuning curve per genotype
    for f = 1:numel(geno_fieldnames)
        tuneFigHand(f) = figure('Name','Tuning Figure Pats vs Pos Funcs','NumberTitle','off','Color',[1 1 1],'Position',[50 50 500 750]);
        grouped_conditions = getfield(geno,geno_fieldnames{f},'grouped_conditions');
        iter = 1;
        subplot(2,1,1)
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all',samples); %#ok<*AGROW>
            end
            
            handle_array(iter) = tfPlot.simple_tuning_curve({[means{:}],[sems{:}],[temp_genotype.grouped_conditions{i}.x_axis]},0);
            title_array{iter} = temp_genotype.grouped_conditions{i}.name;
            means = []; sems = [];
            iter = iter + 1;
        end
        
        legend(handle_array,title_array)
        
        xlabel('Flicker Offset [ms]')
        ylabel('Mean LmR [V]')
        
        subplot(2,1,2)
        for i = 1:numel(grouped_conditions)
            cond_list = grouped_conditions{i}.list;
            for c = 1:numel(cond_list);
                temp_genotype = eval(['geno.' geno_fieldnames{f}]);
                [means{c} sems{c}]= temp_genotype.get_trial_data([cond_list{c}(1),cond_list{c}(2)],'lmr','mean','yes','all',samples);
            end
            phase_diffs = (temp_genotype.grouped_conditions{i}.tf)*(2*pi)*(temp_genotype.grouped_conditions{i}.x_axis/1000);
            tfPlot.simple_tuning_curve({[means{:}],[sems{:}],phase_diffs},0);
            means = []; sems = [];
        end
        
        xlabel('Flicker Offset [rad]')
        ylabel('Mean LmR [V]')
        
        annotation('Textbox',[.3 .85 .6 .15],'String',{'Reverse Phi With Flicker Phase Delay','Patterns VS Position Functions'},'edgecolor','none')
        annotation('Textbox',[.825 .85 .2 .15],'String',['N=' num2str(numel(temp_genotype.experiment))],'edgecolor','none')
        export_fig(tuneFigHand(f),geno_fieldnames{f},'-pdf')
    end


end