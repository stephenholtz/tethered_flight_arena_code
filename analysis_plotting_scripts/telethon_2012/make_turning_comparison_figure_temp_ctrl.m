% Full scripts for making high resolution tuning curve figures, very easy
% Relies on tfAnalysis.ExpSet

%% Initial variables which all scripts use
data_location = '/Users/stephenholtz/Desktop/high_res_tuning_curves_v01/';

exp_dir = data_location;

geno_names{1} = 'gmr_29g11dbd_gal80ts_kir21';


%% Process initial raw data and save summary.mat files
if 0

    cd(exp_dir);
    genotypes = dir(exp_dir);

    for i = 1:numel(genotypes);
        if ~sum(strcmpi(genotypes(i).name,{'.','..','DS_STORE','thumbs'}))
            if ~sum(strcmpi([genotypes(i).name '_summary'],dir(fullfile(exp_dir,genotypes(i).name))));
                try
                    geno = tfAnalysis.import(fullfile(exp_dir,genotypes(i).name),'all');
                    eval([genotypes(i).name '_summary = geno;'])
                    save(fullfile(exp_dir,genotypes(i).name,[genotypes(i).name '_summary']),[genotypes(i).name '_summary']);
                catch proc_err
                    disp(proc_err)
                    genotypes(i).name
                end
            else
                disp([genotypes(i).name ' already processed'])
            end
        end
    end

    clear genotypes i

end

%% Load in summary files

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
    
    clear g stable_dir_name location file_name

end

%% Use summary files to save specific subsets of data in tuning_curves.mat

if 1

    for i = 1:numel(geno_names)
        
        for condition_set_number = 1:9
            % All of the individual tuning curves to be saved:
            %
            % Full Field Rotation Lambda 30 - cond#1
            % Full Field Rotation Lambda 60 - cond#4
            % Reverse Phi Full Field Rotation Lambda 60 - cond#7
            %
            % Progressive Lambda 30 - cond#2
            % Progressive Lambda 60 - cond#5
            % Progressive Full Field Rotation Lambda 60 - cond#8
            %
            % Regressive Lambda 30 - cond#3
            % Regressive Lambda 60 - cond#6
            % Regressive Reverse Phi Rotation Lambda 60 - cond#9
            
            if      condition_set_number == 1
                        curve_name = 'phi_30';
            elseif  condition_set_number == 2
                        curve_name = 'phi_prog_30';
            elseif  condition_set_number == 3
                        curve_name = 'phi_reg_60';
            elseif  condition_set_number == 4
                        curve_name = 'phi_60';
            elseif  condition_set_number == 5
                        curve_name = 'phi_prog_60';
            elseif  condition_set_number == 6
                        curve_name = 'phi_reg_60';
            elseif  condition_set_number == 7
                        curve_name = 'rev_phi_60';
            elseif  condition_set_number == 8
                        curve_name = 'rev_phi_prog_60';
            elseif  condition_set_number == 9
                        curve_name = 'rev_phi_reg_60';          
            end

            condition_numbers  = geno_data{i}.grouped_conditions{condition_set_number}.list;

            [avg, variance]    = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all');
            
            tuning_curves.(curve_name){i}.avg               = cell2mat(avg);
            tuning_curves.(curve_name){i}.sem               = cell2mat(variance);
            tuning_curves.(curve_name){i}.tf                = geno_data{i}.grouped_conditions{condition_set_number}.tf;
            tuning_curves.(curve_name){i}.speed             = geno_data{i}.grouped_conditions{condition_set_number}.speed;
            tuning_curves.(curve_name){i}.condition_numbers = condition_numbers;
            tuning_curves.(curve_name){i}.name              = geno_data{i}.experiment{1}.line_name;
            tuning_curves.(curve_name){i}.num               = numel(geno_data{i}.experiment);
            
        end
    end

    save(fullfile(data_location,'tuning_curves'),'tuning_curves')
    
    clear curve_name condition_set_number i avg variance
    
end

%% Make a figure from the data in tuning_curves.mat

if 1

    load(fullfile(data_location,'tuning_curves'));
    
    % My colors are always meh...
    mycolormap = {[.5 .5 0],[.5 0 0],[.5 0 .5],[0 .5 .5],[.9 .25 .25]};
    
    % Make a few figures
    for f = 1:3

        if f == 1
            fig_title = 'Full Field';
            curve_set = {'',''};
        elseif f == 2
            fig_title = 'Progressive';
        elseif f == 3
            fig_title = 'Regressive';
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
