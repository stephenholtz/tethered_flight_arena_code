% Make comparison across all genotypes for turning figure

geno_names{1} = 'gmr_OL0017_gal80ts_kir21_1';
geno_names{2} = 'gmr_OL0017_gal80ts_kir21_2';
geno_names{3} = 'gmr_OL0033_gal80ts_kir21_1';
geno_names{4} = 'gmr_OL0033_gal80ts_kir21_2';

data_location = '/Volumes/STEPHEN32SD/telethon_experiment_2012_testing/';

if 0
    
    for g = 1:numel(geno_names)
        file_name = [];
        stable_dir_name = dir(fullfile(data_location,[geno_names{g},'*']));
        location = fullfile(data_location,stable_dir_name.name);
        file_name = dir(fullfile(location,'*summary.mat'));
        
        if exist(fullfile(location,file_name.name),'file')
            load(fullfile(location,file_name.name));
            fprintf(['Loaded: ' num2str(g) ' of ' num2str(numel(geno_names)) '\n']);
        else
            disp('no processed summary data!')
        end
        
        geno_data{g} = tfAnalysis.ExpSet(eval(file_name.name(1:end-4))); %#ok<*AGROW>

    end
    
end

% Make comparison across all genotypes for turning figure
% Gather the tuning curve data points into a mat file for both the velocity
% standard turning and the contrast stuff
if 0

for i = 1:numel(geno_names)
    
    
    stable_dir_name = dir(fullfile(data_location,[geno_names{i},'*']));
    location = fullfile(data_location,stable_dir_name.name);
            
    % Expansion
    
    stim_subset = 1:2;
    
    condition_numbers = geno_data{i}.grouped_conditions{2}.list(stim_subset);

    [avg{i} variance{i}] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all');

    expansion{i}.avg = cell2mat(avg{i});

    expansion{i}.sem = cell2mat(variance{i});
    
    expansion{i}.condition_numbers = condition_numbers;
    expansion{i}.stim_subset = stim_subset;
    expansion{i}.name = geno_data{i}.experiment{1}.line_name;
    expansion{i}.num = numel(geno_data{i}.experiment);
        
    % Optomotor, lambda 60
    
    stim_subset = 5:8;

    condition_numbers = geno_data{i}.grouped_conditions{1}.list(stim_subset);

    [avg{i} variance{i}] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all');

    optomotor{i}.avg = cell2mat(avg{i});

    optomotor{i}.sem = cell2mat(variance{i});
    
    optomotor{i}.condition_numbers = condition_numbers;
    optomotor{i}.stim_subset = stim_subset;
    optomotor{i}.name = geno_data{i}.experiment{1}.line_name;
    optomotor{i}.num = numel(geno_data{i}.experiment);
    
    % Contrast
    
    stim_subset = 1:4;
    
    condition_numbers = geno_data{i}.grouped_conditions{4}.list(stim_subset);
    
    [avg{i} variance{i}] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all');
    
    contrast{i}.avg = cell2mat(avg{i});

    contrast{i}.sem = cell2mat(variance{i});
    
    contrast{i}.condition_numbers = condition_numbers;
    contrast{i}.stim_subset = stim_subset;
    contrast{i}.name = geno_data{i}.experiment{1}.line_name;
    contrast{i}.num = numel(geno_data{i}.experiment);
    
    % small_field
    
    stim_subset = 1:3;
    
    condition_numbers = geno_data{i}.grouped_conditions{6}.list(stim_subset);
    
    [avg{i} variance{i}] = geno_data{i}.get_corr_trial_data_set(condition_numbers,'lmr','x_pos','all');
    
    small_field{i}.avg = cell2mat(avg{i});

    small_field{i}.sem = cell2mat(variance{i});
    
    small_field{i}.condition_numbers = condition_numbers;
    small_field{i}.stim_subset = stim_subset;
    small_field{i}.name = geno_data{i}.experiment{1}.line_name;
    small_field{i}.num = numel(geno_data{i}.experiment);

end

tuning_curves.expansion = expansion;
tuning_curves.contrast = contrast;
tuning_curves.optomotor = optomotor;
tuning_curves.small_field = small_field;

save(fullfile(data_location,'tuning_curves_saved'),'tuning_curves')

end


if 1

ONLY_CONTROLS = 0;

load(fullfile(data_location,'tuning_curves_saved'));
    
graph_sets = {[1 2],...
              [3 4]};

          
mycolormap = {[.5 .5 0],[.5 0 0],[.5 0 .5],[0 .5 .5],[.9 .25 .25]};

for f = 1:4
    
    if f == 1
        field = 'optomotor';
    elseif f == 2
        field = 'contrast';
    elseif f == 3
        field = 'expansion';
    else
        field = 'small_field';
    end
    
    handle(1) = figure('Name',['Comparison: ' field],'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1055 755/2],'PaperOrientation','portrait');

    if ONLY_CONTROLS
        g_subset = 1;
    else
        g_subset = 1:numel(graph_sets);
    end
    
    for i = g_subset
        
        yp = (numel(tuning_curves.(field))-3);
        
        if ~ONLY_CONTROLS
            
            plot_position = [.005+.05*i .1 .05 .82];
            
            subplot('Position',plot_position)
            
        end
        
        % calculate the median of all the curves and use as a control....
        %for g = 1:numel(graph_sets{i})
        
        graph.avg{1} = (tuning_curves.(field){graph_sets{i}(1)}.avg);
        graph.variance{1} = (tuning_curves.(field){graph_sets{i}(1)}.sem);
        
        graph.avg{2} = (tuning_curves.(field){graph_sets{i}(2)}.avg);
        graph.variance{2} = (tuning_curves.(field){graph_sets{i}(2)}.sem);

        %end

        for k = graph_sets{1}
            vals(k,:) = tuning_curves.(field){k}.avg;
        end

        min_vals = min(vals);

        max_vals = max(vals);

        clear vals

        len_data_vec = 1:numel(graph.avg{1});

        len_data_vec_no_x_overlap =[(1+(1*eps))*len_data_vec(1) len_data_vec(2:end-1) (1-eps)*len_data_vec(end)];

        sem_transparency_x_vals = [len_data_vec_no_x_overlap, fliplr(len_data_vec_no_x_overlap)];

        sem_transparency_y_vals = [min_vals, fliplr(max_vals)];

        sem_trasnparency_z_vals = -eps*ones(1,numel(sem_transparency_y_vals));

        
        if numel(graph_sets{i}) == 2
            graph.color{1} = [238 0 238]/255;%[.15 .15 .5];  %mycolormap{3};
            graph.color{2} = [255 99 71]/255;%[1 .65 0];     %mycolormap{5};
        else
            graph.color{1} = mycolormap{1};
            graph.color{2} = mycolormap{2};
            graph.color{3} = mycolormap{3};
            graph.color{4} = mycolormap{4};                
        end
        
        graph.handle = handle(1);
        graph.line_width = 2;
        graph.zero_line = 0;
        graph.ylim = [-1 4];
        
        if f == 4
            graph.ylim = [-.5 1];
        end
        
        %tmp_var = graph.variance;
        
        %graph.variance = [];
        
        tfPlot.tuning_curve(graph);
        
%         patch(  'XData',    sem_transparency_x_vals,...
%                 'YData',    sem_transparency_y_vals,...
%                 'ZData',    sem_trasnparency_z_vals,...
%                 'FaceColor', [.85 .85 .85],...
%                 'EdgeColor', 'none');

        
        if i ==1 
            
            ylabel('\Sigma LmR [V]')
            if f == 1
                xlabel('Temporal Frequency')
                set(gca,'XTick',1:4,'Xticklabel',{'.25', '1.5', '4.5', '9'},'LineWidth',2);
            elseif f == 2
                xlabel('Michelson Contrast')
                set(gca,'XTick',1:4,'Xticklabel',{'.23', '.07', '.06', '.24'},'LineWidth',2);
            elseif f ==3
                xlabel('Temporal Frequency')
                if ~ONLY_CONTROLS
                    set(gca,'XTick',1:2,'Xticklabel',{'1', '9'},'LineWidth',2,'XLim',[0 2]);
                else
                    set(gca,'XTick',1:2,'Xticklabel',{'1', '9'},'LineWidth',2);                    
                end
            elseif f == 4
                xlabel('Temporal Frequency')
                ylabel('Correlation')
                set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '5'},'LineWidth',2);
            end

        else
            axis off
        end
        
        if ONLY_CONTROLS
            l_hand = legend(geno_names{1:4});
            
            set(l_hand,'Interpreter','none','Location','Southeast');
            
        end
        
        if ~ONLY_CONTROLS
        if ~mod(i,2)
            if i == 1
                title({'',tuning_curves.(field){graph_sets{i}(2)}.name(5:end)},'interpreter','none','FontSize',10)
            else
                title({'',tuning_curves.(field){graph_sets{i}(2)}.name(5:end)},'interpreter','none','FontSize',10)
            end
        else
            if i == 1
                title({tuning_curves.(field){graph_sets{i}(2)}.name(5:end),''},'interpreter','none','FontSize',10)
            else
                title({tuning_curves.(field){graph_sets{i}(2)}.name(5:end),''},'interpreter','none','FontSize',10)
            end
        end
        
        else
           title(['Controls: ' (field)],'Interpreter','none') 
        end
        
        n_str =  ['N = ' num2str(tuning_curves.(field){graph_sets{i}(2)}.num)];
        
        
        if ~ONLY_CONTROLS
            n_position = [plot_position(1) + .02, .1, .05, .15];

            annotation('Textbox','Position',n_position,'String',n_str,'Edgecolor','none');

        end
        
        clear graph
        
    end
    if ONLY_CONTROLS
        export_fig(handle(1),fullfile(data_location,filesep,'..','vpn_ii_sanity_figures',['vpn_' field 'large_controls']),'-pdf')
    else
        export_fig(handle(1),fullfile(data_location,filesep,'..','vpn_ii_sanity_figures',['vpn_' field 'shaded_w_N']),'-pdf')
    end
end


end
