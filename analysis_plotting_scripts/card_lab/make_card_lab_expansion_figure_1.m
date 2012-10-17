% make_card_lab_expansion_figure
% This is only a tuning curve for expansion

% Fig 1
% Male vs female for the three genotypes
% 2x3 plot, each plot with one male and one female of one genotype
% Fig 2
% Controls for the genotypes
% males for all three on one subplot, females for all three on second
          
%% Import the data

if 0

    geno_names = {'GF_split_gal4_DTI_CSA',...
                  'GF_split_gal4_DTI',...
                  'GF_split_gal4_CS_bck'};

    % geno_set(1) = MALES
    male_loc = '/Users/stephenholtz/Desktop/card_lab_expansion_v01/male_card_lab_expansion_v01';
    for genotype = geno_names
        geno_sex_location = fullfile(male_loc,genotype);
        geno_set(1).(genotype{1}) = tfAnalysis.ExpSet(tfAnalysis.import(geno_sex_location{1},'all'));
    end
    
    % geno_set(2) = FEMALES
    female_loc = '/Users/stephenholtz/Desktop/card_lab_expansion_v01/female_card_lab_expansion_v01';
    for genotype = geno_names
        geno_sex_location = fullfile(female_loc,genotype);
        geno_set(2).(genotype{1}) = tfAnalysis.ExpSet(tfAnalysis.import(geno_sex_location{1},'all'));
    end
    
    save(fullfile('/Users/stephenholtz/Desktop/card_lab_analysis','geno_set'),'geno_set')

end


%% Make the figures

if 1
    
    destination_dir = '/Users/stephenholtz/Desktop/card_lab_analysis';
    
    % Load the data
    if ~exist('geno_set','var')
        load(fullfile('/Users/stephenholtz/Desktop/card_lab_analysis','geno_set'));
    end

    geno_names = {'GF_split_gal4_DTI_CSA',...
                  'GF_split_gal4_DTI',...
                  'GF_split_gal4_CS_bck'};
	
  better_geno_names = {'GF_split_gal4_DTI',...
                  'GF_split_gal4_DTI_tdTmto',...
                  'GF_split_gal4_CS_ctrl'};

    geno_colors = {[1 .5 .25],[.5 .25 1],[0 1 1]};
              
	condition_numbers = geno_set(1).(geno_names{1}).grouped_conditions{1}.list;
    
    % Fig 1
    fig_1_name = 'Gender Comparison GF Split pJFRC12';
    
    fig_handle(1) = figure('Name',fig_1_name,...
        'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050 750],...
        'PaperOrientation','portrait');
    
    for sub_p = 1:numel(geno_names) % Sub plots are each genotype, 

        genotype = geno_names{sub_p};

        % Males - Lighter color
        [avg, variance] = geno_set(1).(genotype).get_trial_data_set(condition_numbers,'lmr','mean','yes','all'); %#ok<*SAGROW>
        graph.color{1} = geno_colors{sub_p}*.33;
        
        graph.avg{1} = cell2mat(avg);
        graph.variance{1} = cell2mat(variance);
        
        % Females - Darker color
        [avg, variance] = geno_set(2).(genotype).get_trial_data_set(condition_numbers,'lmr','mean','yes','all'); %#ok<*SAGROW>
        graph.color{2} = geno_colors{sub_p}*1;
        
        graph.avg{2} = cell2mat(avg);
        graph.variance{2} = cell2mat(variance);
        
        graph.zero_line = false;
        graph.line_width = 2;
        graph.x_offset = 0;
        
        % Plot
        subplot(1,3,sub_p)

        t_hand = tfPlot.tuning_curve(graph);

        title({better_geno_names{sub_p}, 'Lateral Expansion'},'Interpreter','none')
        
        xlabel('Tempral Frequency (Hz)')

        if sub_p == 1
            ylabel('L-R WBA (V)')
        end

        set(gca,'XTick',1:5,...
            'XTickLabel',geno_set(1).(genotype).grouped_conditions{1}.tf,...
            'XLim',[0 6],...
            'YLim',[0 6.5]);
        
        legend_handle = legend({'male','female'},'Location','SouthEast',...
            'Interpreter','none','EdgeColor',[0 0 0]);    

        clear graph
    end
    
    % annotations
    annotation('textbox',[.44 .895 .3 .1],'FontSize',14,...
        'String',fig_1_name,'EdgeColor','none')

    annotation('textbox', [.88 .88 .8 .05],'String','N = 6',...
    'FontSize',14,'EdgeColor','none');

    % Save figure
    saveas(gcf, fullfile(destination_dir,fig_1_name),'fig');
    export_fig(gcf, fullfile(destination_dir,fig_1_name),'-pdf');


    % Fig 2
    
    fig_2_name = 'Effector Comparison GF Split pJFRC12';
    fig_handle(2) = figure('Name',fig_2_name,...
        'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050 750],...
        'PaperOrientation','portrait');
    
    for sub_p = 1:2 % Sub plots are each sex, 
        
        geno_iter = 1;
        
        for genotype = geno_names;

            % Males - Lighter color / Females - Darker color
            [avg, variance] = geno_set(sub_p).(genotype{1}).get_trial_data_set(condition_numbers,'lmr','mean','yes','all'); %#ok<*SAGROW>
            
            graph.avg{geno_iter} = cell2mat(avg);
            graph.variance{geno_iter} = cell2mat(variance);
            
            if sub_p == 1            
                graph.color{geno_iter} = geno_colors{geno_iter}*.5;
            elseif sub_p == 2
                graph.color{geno_iter} = geno_colors{geno_iter}*1;
            end
            
            graph.zero_line = false;
            graph.line_width = 2;
            graph.x_offset = 0;
            
            geno_iter = geno_iter + 1;

        end
        
        % Plot
        subplot(1,2,sub_p)

        t_hand = tfPlot.tuning_curve(graph);

        xlabel('Tempral Frequency (Hz)')

        if sub_p == 1
            ylabel('L-R WBA (V)')
            title({'Males', 'Lateral Expansion'},'Interpreter','none')
        elseif sub_p ==2
            title({'Females', 'Lateral Expansion'},'Interpreter','none')
        end

        set(gca,'XTick',1:5,...
            'XTickLabel',geno_set(1).(genotype{1}).grouped_conditions{1}.tf,...
            'XLim',[0 6],...
            'YLim',[0 6.5]);
        
        legend_handle = legend(better_geno_names,'Location','SouthEast',...
            'Interpreter','none','EdgeColor',[0 0 0]);    

        clear graph
    end
    
    % annotations
    annotation('textbox',[.44 .895 .3 .1],'FontSize',14,...
        'String',fig_2_name,'EdgeColor','none')

    annotation('textbox', [.88 .88 .8 .05],'String','N = 6',...
    'FontSize',14,'EdgeColor','none');

    % Save figure
    saveas(gcf, fullfile(destination_dir,fig_2_name),'fig');
    export_fig(gcf, fullfile(destination_dir,fig_2_name),'-pdf');

end