%% Make figure for short telethon 2011 - for Card Lab
% because of noise, must change parse_tf_data line to be * 3 tolerance...
% coarse_differences  = find(abs(diff(encoded_signal > ANALOGTOLERANCE*10)));

make_data = 0;

destination_dir = '/Users/stephenholtz/Desktop/card_lab_analysis';

% Import females
data_dir = '/Users/stephenholtz/Desktop/card_lab/card_lab_females/';

if make_data
    dirs = dir(data_dir);
    for i = 4:numel(dirs)
        geno_dir = fullfile(data_dir,dirs(i).name);
        females.(['geno_' dirs(i).name(10:11)]) = tfAnalysis.ExpSet(tfAnalysis.import(geno_dir,'all'));    
    end
end

% Import males
data_dir = '/Users/stephenholtz/Desktop/card_lab/card_lab_males/';

if make_data
    dirs = dir(data_dir);
    for i = 4:numel(dirs)
        geno_dir = fullfile(data_dir,dirs(i).name);
        males.(['geno_' dirs(i).name(10:11)]) = tfAnalysis.ExpSet(tfAnalysis.import(geno_dir,'all'));    
    end
end


if make_data
    
    mkdir(destination_dir);

    save(fullfile(destination_dir,'females'),'females');
    save(fullfile(destination_dir,'males'),'males');

end

%% Make the figures comparing the short telethon experiment
if 0
load('/Users/stephenholtz/Desktop/card_lab_analysis/males.mat')
load('/Users/stephenholtz/Desktop/card_lab_analysis/females.mat')
end

% Names of genotypes
geno_names{1} = {'geno_1a'};
geno_names{2} = {'geno_1b'};
geno_names{3} = {'geno_1c'};
geno_names{4} = {'geno_2a'};
geno_names{5} = {'geno_2b'};
geno_names{6} = {'geno_2c'};
geno_names{7} = {'geno_3a'};
geno_names{8} = {'geno_3b'};
geno_names{9} = {'geno_3c'};

short_geno_names{1} = 'GF split, UAS-DTI; CSA';
short_geno_names{2} = 'GF split, tdTmto; UAS-DTI';
short_geno_names{3} = 'GF split, CS';
short_geno_names{4} = 'GF split pJFRC2, UAS-DTI; CSA';
short_geno_names{5} = 'GF split pJFRC2, tdTmto; UAS-DTI';
short_geno_names{6} = 'GF split pJFRC2, CS';
short_geno_names{7} = 'GF split pJFRC12, UAS-DTI; CSA';
short_geno_names{8} = 'GF split pJFRC12, tdTmto; UAS-DTI';
short_geno_names{9} = 'GF split pJFRC12, CS';

% Males
comparison_groups{1,1}    = [1,2,3];
comparison_groups{1,2}    = [4,5,6];
comparison_groups{1,3}    = [7,8,9];

comparison_groups{2,1}    = [1,4,7];
comparison_groups{2,2}    = [2,5,8];
comparison_groups{2,3}    = [3,6,9];

% Females
comparison_groups{3,1}    = [1,2,3];
comparison_groups{3,2}    = [4,5,6];
comparison_groups{3,3}    = [7,8,9];

comparison_groups{4,1}   = [1,4,7];
comparison_groups{4,2}   = [2,5,8];
comparison_groups{4,3}   = [3,6,9];

% Males Vs Females
comparison_groups{5,1} = 1:9;
% comparison_groups{5,2} = [2];
% comparison_groups{5,3} = [3];
% comparison_groups{5,4} = [4];
% comparison_groups{5,5} = [5];
% comparison_groups{5,6} = [6];
% comparison_groups{5,7} = [7];
% comparison_groups{5,8} = [8];
% comparison_groups{5,9} = [9];

mycolormap = {[.25 .35 0],[1 .1 0],[.5 0 .5],...
              [0 .5 .5],[0 .95 .1],[0 1 1],...
              [1 .5 .25],[.5 .25 1],[1 0 1]};


for i = 1:numel(geno_names)

    for gender = 1:2

        if gender == 1;
            geno_data{1} = males.(geno_names{i}{1});
            sex = 'male';
        elseif gender == 2;
            geno_data{1} = females.(geno_names{i}{1});
            sex = 'female';
        end

        % Unilateral

        condition_numbers = geno_data{1}.grouped_conditions{1}.list;

        [avg{i}, variance{i}] = geno_data{1}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all'); %#ok<*SAGROW>

        unilat.(sex){i}.avg = cell2mat(avg{i});

        unilat.(sex){i}.sem = cell2mat(variance{i});

        unilat.(sex){i}.condition_numbers = condition_numbers;
        unilat.(sex){i}.name = geno_data{1}.experiment{1}.line_name;
        unilat.(sex){i}.full_name = geno_data{1}.experiment{1}.fly_tag;    
        unilat.(sex){i}.num = numel(geno_data{1}.experiment);

        % Low Contrast Optomotor

        condition_numbers = geno_data{1}.grouped_conditions{2}.list;

        [avg{i}, variance{i}] = geno_data{1}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all'); %#ok<*SAGROW>

        lc.(sex){i}.avg = cell2mat(avg{i});

        lc.(sex){i}.sem = cell2mat(variance{i});

        lc.(sex){i}.condition_numbers = condition_numbers;
        lc.(sex){i}.name = geno_data{1}.experiment{1}.line_name;
        lc.(sex){i}.full_name = geno_data{1}.experiment{1}.fly_tag;    
        lc.(sex){i}.num = numel(geno_data{1}.experiment);

        % Reverse Phi

        condition_numbers = geno_data{1}.grouped_conditions{3}.list;

        [avg{i}, variance{i}] = geno_data{1}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all'); %#ok<*SAGROW>

        rp.(sex){i}.avg = cell2mat(avg{i});

        rp.(sex){i}.sem = cell2mat(variance{i});

        rp.(sex){i}.condition_numbers = condition_numbers;
        rp.(sex){i}.name = geno_data{1}.experiment{1}.line_name;
        rp.(sex){i}.full_name = geno_data{1}.experiment{1}.fly_tag;    
        rp.(sex){i}.num = numel(geno_data{1}.experiment);
        
 
        % Stripe Tracking

        condition_numbers = geno_data{1}.grouped_conditions{4}.list;

        [avg{i}, variance{i}] = geno_data{1}.get_corr_trial_data_set(condition_numbers,'lmr','x_pos','all');

        st.(sex){i}.avg = cell2mat(avg{i});

        st.(sex){i}.sem = cell2mat(variance{i});

        st.(sex){i}.condition_numbers = condition_numbers;
        st.(sex){i}.name = geno_data{1}.experiment{1}.line_name;
        st.(sex){i}.num = numel(geno_data{1}.experiment);
               
    end
    
end
for gender = 1:2
    
    if gender == 1
        sex = 'male';
    else 
        sex = 'female';
    end
    
    tuning_curves.unilat.(sex) =  unilat.(sex);
    tuning_curves.lc.(sex)     =  lc.(sex);
    tuning_curves.rp.(sex)     =  rp.(sex);
    tuning_curves.st.(sex)     =  st.(sex);

end

if 1

for i = 1:(size(comparison_groups,1)-1)

handle(i) = figure('Name',['Comparison: ' num2str(i)],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050 750],'PaperOrientation','portrait');

    for k = 1:size(comparison_groups{i},2)

        % Get figure name correct
        if i < 3
            sex = 'male';
        elseif i < 5
            sex = 'female';
        end
        
        cols = 5;
        rows = numel(comparison_groups{i});

        graph_offset = (1-1)*cols + (k-1)*cols;
        
        subplot(rows,cols,1+graph_offset)
        % B2F and F2B
            for g = 1:numel(comparison_groups{i,k})

                geno_num = comparison_groups{i,k}(g);

                graph.avg{g} = tuning_curves.unilat.(sex){geno_num}.avg;
                graph.variance{g} = tuning_curves.unilat.(sex){geno_num}.sem;
                graph.color{g} = mycolormap{geno_num};
            end

            graph.zero_line = 0; graph.line_width = 2;

            tfPlot.tuning_curve(graph);

            xlabel('Direction')
            
            clear graph geno_str
            
            
            if i == 1 || i == 2
                annotation('textbox',[.45 .89 .3 .1],'FontSize',14,'String','Males, all Genotypes','EdgeColor','none')
                
            elseif i == 3 || i == 4
                annotation('textbox',[.45 .89 .3 .1],'FontSize',14,'String','Females, all Genotypes','EdgeColor','none')
                
            end
            
            if i == 1 || i == 3
                if k == 1
                ylabel('1: GF split')
                elseif graph_offset <5
                ylabel('2: GF+pJFRC2')
                elseif graph_offset <14
                ylabel('3: GF+pJFRC12')
                end
            elseif i == 2 || i == 4
                if k == 1
                ylabel('a: UAS-DTI/Cyo; CSA')
                elseif graph_offset <5
                ylabel('b: 1x0-tdTmto/CyO; UAS-DTI/TM6B')
                elseif graph_offset <14
                ylabel('c: BB''s CS')
                end
            end
            
        subplot(rows,cols,2+graph_offset)
        % Low and High Contrast Rotation
            for g = 1:numel(comparison_groups{i,k})

                geno_num = comparison_groups{i,k}(g);

                graph.avg{g} = tuning_curves.lc.(sex){geno_num}.avg;
                graph.variance{g} = tuning_curves.lc.(sex){geno_num}.sem;
                graph.color{g} = mycolormap{geno_num};
            end

            graph.zero_line = 0; graph.line_width = 2;

            tfPlot.tuning_curve(graph);
            
            ylabel('L-R Amp')
            
            xlabel('Contrast')
            
            clear graph geno_str            

        subplot(rows,cols,3+graph_offset)
        % Reverse Phi
            for g = 1:numel(comparison_groups{i,k})

                geno_num = comparison_groups{i,k}(g);

                graph.avg{g} = tuning_curves.rp.(sex){geno_num}.avg;
                graph.variance{g} = tuning_curves.rp.(sex){geno_num}.sem;
                graph.color{g} = mycolormap{geno_num};
            end

            graph.zero_line = 0; graph.line_width = 2;

            tfPlot.tuning_curve(graph);

            xlabel('Speed')
            
            clear graph geno_str            

        subplot(rows,cols,4+graph_offset)
        % Dark Stripe, bright stripe, square wave grating

            figure_name = [];

            for g = 1:numel(comparison_groups{i,k})
                
                geno_num = comparison_groups{i,k}(g);
                
                graph.avg{g} = tuning_curves.st.(sex){geno_num}.avg;
                graph.variance{g} = tuning_curves.st.(sex){geno_num}.sem;
                graph.color{g} = mycolormap{geno_num};

            end

            graph.zero_line = 0; graph.line_width = 2;

            tfPlot.tuning_curve(graph);

            ylabel('Correlation')
            xlabel('Stripe')
            
            clear graph geno_str

        for g = 1:numel(comparison_groups{i,k})
            geno_num = comparison_groups{i,k}(1);
        
            geno_str(g) = short_geno_names(geno_num);
            
        end     
        
        l_hand = legend(geno_str,'Location','SouthEastOutside','Interpreter','none');            

    end
annotation('textbox', [.01 .01 .8 .05],'String','N = 5-8',...
    'EdgeColor','none');

saveas(gcf, fullfile(destination_dir,['Comparison: ' num2str(i)]),'fig');
export_fig(gcf, fullfile(destination_dir,['Comparison: ' num2str(i)]),'-pdf');

end

end


% Male female comparison figure

if 1

i = 5;
sex_name = 'males_vs_females';

handle(i) = figure('Name',['Comparison: ' num2str(i)],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1050 750],'PaperOrientation','portrait');

for k = 1:9
    
    cols = 5;
    rows = numel(comparison_groups{i,1});

    graph_offset = (1-1)*cols + (k-1)*cols;

    subplot(rows,cols,1+graph_offset)
    % B2F and F2B
        for g = 1:2
            if g == 1
                sex = 'male';
                graph.line_width = 1;
            else
                sex = 'female';
                graph.line_width = 2;
            end
            
            geno_num = comparison_groups{i,1}(k);
            
            graph.avg{g} = tuning_curves.unilat.(sex){geno_num}.avg;
            graph.variance{g} = tuning_curves.unilat.(sex){geno_num}.sem;
            if g == 2
                graph.color{g} = mycolormap{geno_num};
            else
                graph.color{g} = [.15 .15 .15];
            end
            
        end
        
        graph.zero_line = 0;
        
        tfPlot.tuning_curve(graph);
        
        ylabel(geno_names{k},'Interpreter','none')
        
        xlabel('Direction')
        
        clear graph geno_str            

    subplot(rows,cols,2+graph_offset)
    % Low and High Contrast Rotation
        for g = 1:2
            if g == 1
                sex = 'male';
                graph.line_width = 1;
            else
                sex = 'female';
                graph.line_width = 2;
            end

            geno_num = comparison_groups{i,1}(k);

            graph.avg{g} = tuning_curves.lc.(sex){geno_num}.avg;
            graph.variance{g} = tuning_curves.lc.(sex){geno_num}.sem;
            if g == 2
                graph.color{g} = mycolormap{geno_num};
            else
                graph.color{g} = [.15 .15 .15]; 
            end
        end

        graph.zero_line = 0;

        tfPlot.tuning_curve(graph);

        ylabel('L-R Wing Amp')

        xlabel('Contrast')

        clear graph geno_str            

    subplot(rows,cols,3+graph_offset)
    % Reverse Phi
        for g = 1:2
            if g == 1
                sex = 'male';
                graph.line_width = 1;
            else
                sex = 'female';
                graph.line_width = 2;
            end

            geno_num = comparison_groups{i,1}(k);

            graph.avg{g} = tuning_curves.rp.(sex){geno_num}.avg;
            graph.variance{g} = tuning_curves.rp.(sex){geno_num}.sem;
            if g == 2
                graph.color{g} = mycolormap{geno_num};
            else
                graph.color{g} = [.15 .15 .15]; 
            end
        end

        graph.zero_line = 0;

        tfPlot.tuning_curve(graph);

        ylabel('L-R Wing Amp')        
        
        xlabel('Speed')

        clear graph geno_str            

    subplot(rows,cols,4+graph_offset)
    % Dark Stripe, bright stripe, square wave grating
       
        for g = 1:2
            if g == 1
                sex = 'male';
                graph.line_width = 1;
            else
                sex = 'female';
                graph.line_width = 2;
            end

            geno_num = comparison_groups{i,1}(k);

            graph.avg{g} = tuning_curves.st.(sex){geno_num}.avg;
            graph.variance{g} = tuning_curves.st.(sex){geno_num}.sem;
            if g == 2
                graph.color{g} = mycolormap{geno_num};
            else
                graph.color{g} = [.15 .15 .15]; 
            end
        end

        graph.zero_line = 0;
        
        tfPlot.tuning_curve(graph);

        ylabel('Correlation')
        xlabel('Stripe')

        clear graph geno_str
        
        for g = 1:2
            
            geno_num = comparison_groups{i,1}(k);
            
            geno_str(g) = short_geno_names(geno_num);
            
        end
        
        l_hand = legend(geno_str,'Location','SouthEastOutside','Interpreter','none');
end  

saveas(gcf, fullfile(destination_dir,['Comparison: ' num2str(i)]),'fig');
export_fig(gcf, fullfile(destination_dir,['Comparison: ' num2str(i)]),'-pdf');

end

annotation('textbox',[.25 .89 .3 .1],'FontSize',14,'String','Females vs Males, all Genotypes','EdgeColor','none')

annotation('textbox', [.01 .01 .8 .05],'String',['Black are male, colors are females, N = 5-8 for each'],...
    'EdgeColor','none');