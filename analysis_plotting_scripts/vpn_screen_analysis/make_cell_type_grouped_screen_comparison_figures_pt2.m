% make_cell_type_grouped_screen_comparison_figures
% 
% Make a cell type set of graphs that has summary data comparing all lines
% that have overlapping expression patterns.

% Load in the data

external = 1;

switch external
    
    case 1
        data_location = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';
        summary_file_location = fullfile(data_location,'..');
        if ~exist('fig_data_summ','var')
            load(fullfile(summary_file_location,'fig_data_summ.mat'))
        end
        figure_location = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/behaviors_by_cell_type_summary_figures';

    case 0

        data_location = '/Users/stephenholtz/local_experiment_copies';
        summary_file_location = data_location;
        if ~exist('fig_data_summ','var')
            load(fullfile(summary_file_location,'fig_data_summ.mat'))
        end
        figure_location = '/Users/stephenholtz/local_experiment_copies/behaviors_by_cell_type_summary_figures';
        
end

% script that makes some useful varialbes but clogs up this script
make_cell_type_groups_varibles;

% Sizes and locations of images
title_pos               = [.05 .9 .5 .1];
legend_pos_n1           = [.52 .9 .25 .1];
legend_pos_c1           = [.67 .97 .02 .02];
legend_pos_n2           = [.72 .9 .25 .1];
legend_pos_c2           = [.845 .97 .02 .02];

images_wide = 5;
images_high = 7;

stim_x_pos = .105:.2:1;%linspace(.1,.7,images_wide);
line_y_pos = linspace(.835,.01,images_high);

image_height = .11;
image_width = .14;

mycolormap = {[.15 .15 .5],[1 .65 0],[238 0 238]/255,[255 99 71]/255,[.5 0 .5]};

for normalization_type = {'norm'} %{'not_norm','norm'}
    
    switch normalization_type{1}
        case {'not_norm'}
            figure_name_stem = 'Non-Normalized - ';
        case {'norm'}
            figure_name_stem = 'Normalized - ';
    end
    
    for cell_type_group = 1:numel(cell_type_groups)
        
        x_position_iter = 0;
        
        % Make the figure for each cell_type_group
        figure_name{1} = [figure_name_stem ' All Hit Behaviors Cell Type: ' num2str(cell_type_groups(cell_type_group).main_cell_type) ];
        handle(1) = figure('Name',figure_name{1},'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1000 800],'PaperOrientation','portrait');
        figure_description{1} = ['all_hit_behaviors_cell_type_' num2str(cell_type_groups(cell_type_group).main_cell_type) ];
        
        % For each cell type there should be a column (with a max of 4)
        for line = 1:numel(cell_type_groups(cell_type_group).stable_line_names)
            
            line_name = cell_type_groups(cell_type_group).stable_line_names{line};
            curr_line = 0;
            for i = 1:numel(fig_data_summ)
                if sum(strfind(fig_data_summ(i).geno_name,line_name))
                   curr_line = i;
                end
            end
            
            if curr_line
            
            % The X position is the line
            x_position_iter = x_position_iter + 1;
            y_position_iter = 0;
            
            % Velocity Nulling
            if 1
                
                y_position_iter = y_position_iter + 1;
                
                % Plot the genotypes across the figure, then down
                subplot('Position',[stim_x_pos(x_position_iter) line_y_pos(y_position_iter) image_width image_height])
                
                if isempty(fig_data_summ(curr_line).vel_null_summ.(normalization_type{1}).null_contrast)
                    text(5,3,'No Data')
                else
                    null_contrast_vals = cell2mat(fig_data_summ(curr_line).vel_null_summ.(normalization_type{1}).null_contrast);
                    avg_null_contrast_vals = fig_data_summ(1).avg_vel_null_summ.(normalization_type{1}).null_contrast;

                    %--Plot a line for every value in the subplot
                    temp_freq = [.2 1.3 5.3 10.7 16];

                    semilogx(temp_freq,null_contrast_vals,'Color',mycolormap{1},'LineWidth',2);
                    hold on;
                    
                    semilogx(temp_freq,avg_null_contrast_vals,'Color',mycolormap{2},'LineWidth',2);
                    box off;
                end
                
                title(fig_data_summ(curr_line).geno_name(1:end-14),'Interpreter','none','FontWeight','Demi')
                
                set(gca,'XTick',[1 10],'Xticklabel',{'1', '10'},'LineWidth',1);
                
                if y_position_iter == numel(cell_type_groups(cell_type_group).stable_line_names)
                    xlabel({'Test Stim.',' Temp. Freq. (Hz)'})
                end
                
                if x_position_iter == 1
                    ylabel('1 / null contrast')
                end
                
                axis([0 20 0 6]);


            end
            
            % Prog
            if 1

                y_position_iter = y_position_iter + 1;

                subplot('Position',[stim_x_pos(x_position_iter) line_y_pos(y_position_iter) image_width image_height])
                
                % The genotype
                graph.avg{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).prog.avg;
                graph.variance{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).prog.sem;
                graph.color{1} = mycolormap{1};
                
                % The average response
                graph.avg{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).prog.avg;
                graph.variance{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).prog.sem;
                graph.color{2} = mycolormap{2};

                tfPlot.tuning_curve(graph);

                set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '5'},'LineWidth',1);
                set(gca,'Ylim',[-4 4])
                box off;
                
                if y_position_iter == numel(cell_type_groups(cell_type_group).stable_line_names)
                    xlabel('Temp Freq')
                end
                
                if x_position_iter == 1
                    ylabel('Mean L-R WBA')
                end
                
                if ~(x_position_iter == 1)
                    axis off;
                end
            end

            % Reg
            if 1

                y_position_iter = y_position_iter + 1;
                
                subplot('Position',[stim_x_pos(x_position_iter) line_y_pos(y_position_iter) image_width image_height])

                % The genotype
                % The genotype
                graph.avg{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).reg.avg;
                graph.variance{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).reg.sem;
                graph.color{1} = mycolormap{1};
                % The average response
                graph.avg{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).reg.avg;
                graph.variance{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).reg.sem;
                graph.color{2} = mycolormap{2};

                tfPlot.tuning_curve(graph);

                set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '9'},'LineWidth',1);
                set(gca,'Ylim',[-3.5 3.5])
                box off;
                
                if y_position_iter == numel(cell_type_groups(cell_type_group).stable_line_names)
                    xlabel('Temp Freq')
                end

                if x_position_iter == 1
                    ylabel('Mean L-R WBA')
                end

                if ~(x_position_iter == 1)
                    axis off;
                end

            end
            
            % rp
            if 1
                
                y_position_iter = y_position_iter + 1;
                
                subplot('Position',[stim_x_pos(x_position_iter) line_y_pos(y_position_iter) image_width image_height])

                % The genotype
                graph.avg{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).small_field_grat.avg;
                graph.variance{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).small_field_grat.sem;
                graph.color{1} = mycolormap{1};
                % The average response
                graph.avg{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).small_field_grat.avg;
                graph.variance{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).small_field_grat.sem;
                graph.color{2} = mycolormap{2};

                tfPlot.tuning_curve(graph);

                set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '9'},'LineWidth',1);
                set(gca,'Ylim',[-3.5 3.5])
                box off;
                
                if y_position_iter == numel(cell_type_groups(cell_type_group).stable_line_names)
                    xlabel('Temp Freq')
                end

                if x_position_iter == 1
                    ylabel('Mean L-R WBA')
                end

                if ~(x_position_iter == 1)
                    axis off;
                end
                
            end

            % Flow ts 1
            if 1
                
                y_position_iter = y_position_iter + 1;
                
                subplot('Position',[stim_x_pos(x_position_iter) line_y_pos(y_position_iter) image_width image_height])

                % The genotype
                graph.avg{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).flow_ts.avg{3};
                graph.variance{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).flow_ts.sem{3};
                graph.color{1} = mycolormap{1};
                % The average response
                graph.avg{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).flow_ts.avg(5001:7500);
                graph.variance{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).flow_ts.sem(5001:7500);
                graph.color{2} = mycolormap{2};
                
                tfPlot.timeseries(graph);

                set(gca,'XTick',1:5, 'Xticklabel',{'1','2', '3','4','5'},'LineWidth',1);
                set(gca,'Ylim',[-3.5 3.5])
                box off;

                if y_position_iter == numel(cell_type_groups(cell_type_group).stable_line_names)
                    xlabel('Time (s)')
                end
                
                if x_position_iter == 1
                    ylabel('L-R WBA')
                end

                if ~(x_position_iter == 1)
                    axis off;
                end
                
            end
            
            % Flow ts 2
            if 1
                
                y_position_iter = y_position_iter + 1;
                
                subplot('Position',[stim_x_pos(x_position_iter) line_y_pos(y_position_iter) image_width image_height])

                % The genotype
                graph.avg{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).flow_ts.avg{4};
                graph.variance{1} = fig_data_summ(curr_line).tuning_curves.(normalization_type{1}).flow_ts.sem{4};
                graph.color{1} = mycolormap{1};
                % The average response
                graph.avg{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).flow_ts.avg(7501:10000);
                graph.variance{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).flow_ts.sem(7501:10000);
                graph.color{2} = mycolormap{2};
                
                tfPlot.timeseries(graph);

                set(gca,'XTick',1:5, 'Xticklabel',{'1','2', '3','4','5'},'LineWidth',1);
                set(gca,'Ylim',[-3.5 3.5])
                box off;

                if y_position_iter == numel(cell_type_groups(cell_type_group).stable_line_names)
                    xlabel('Time (s)')
                end
                
                if x_position_iter == 1
                    ylabel('L-R WBA')
                end

                if ~(x_position_iter == 1)
                    axis off;
                end
                
            end
            
            % Images
            if 1
                
                y_position_iter = y_position_iter + 1;
                
                subplot('Position',[stim_x_pos(x_position_iter)  line_y_pos(y_position_iter) image_width image_height])
                if strcmpi(fig_data_summ(curr_line).geno_name(1:3),'gmr')
                    plot(1:10,1:10,'k'); hold on
                    text(5,3,'No Image')
                else
                    subimage(fig_data_summ(curr_line).img);
                end
                
                axis off; box off;
            end
            
            else
                disp(line_name) 
            end
        end
        
            % Add title and legendish thing

            subplot('Position',legend_pos_c1)
            rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{1});
            box off; axis off;

            subplot('Position',legend_pos_c2)
            rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{2});
            box off; axis off;

            annotation('textbox','position',title_pos,'string',figure_name{1},...
                        'interpreter','none','EdgeColor','none','fontsize',15,'fontweight','bold');
            
            annotation('textbox','position',legend_pos_n1,'string','Genotype (x Kir2.1)',...
                'interpreter','none','EdgeColor','none','fontsize',15);
            
            annotation('textbox','position',legend_pos_n2,'string','Screen Average',...
                'interpreter','none','EdgeColor','none','fontsize',15);        
            
            annotation('textbox',[0.01 line_y_pos(1) image_width/2 image_height],...
                'string',{'Vel','Null'},'edgecolor','none','Fontsize',14)
                      
            annotation('textbox',[0.01 line_y_pos(2) image_width/2 image_height],...
                'string',{'Prog','Motion'},'edgecolor','none','Fontsize',14)
            
            annotation('textbox',[0.01 line_y_pos(3) image_width/2 image_height],...
                'string',{'Reg','Motion'},'edgecolor','none','Fontsize',14)

            annotation('textbox',[0.01 line_y_pos(4) image_width/2 image_height],...
                'string',{'Rev-','Phi','Motion'},'edgecolor','none','Fontsize',14)                    

            annotation('textbox',[0.01 line_y_pos(5) image_width/2 image_height],...
                'string',{'Side-','Slip','Flow'},'edgecolor','none','Fontsize',14)  

            annotation('textbox',[0.01 line_y_pos(6) image_width/2 image_height],...
                'string',{'Yaw','Flow','Offset'},'edgecolor','none','Fontsize',14)
            
            annotation('textbox',[0.01 line_y_pos(7) image_width/2 image_height],...
                'string',{'GFP','Images'},'edgecolor','none','Fontsize',14)        
                
        % Save the figures
        if 1
            % Save individual figures
            
            export_fig(gcf,fullfile(figure_location,[normalization_type{1} '_summary_figure_2_' figure_description{1}]),'-pdf')
            close all
%             % Save all figures appended to each other
%             for i = 1:numel(figure_description)
%                 export_fig(handle(i),fullfile(figure_location,['combined_' normalization_type{1} '_summary_figure']),'-pdf', '-append')
%             end
        end
    
    
    end
    
end