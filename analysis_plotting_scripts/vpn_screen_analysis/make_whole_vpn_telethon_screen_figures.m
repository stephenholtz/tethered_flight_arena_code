% make_whole_vpn_telethon_screen_figures
% 
% Make a figure with tuning curves for all lines (also make an appended
% version of this so you can scroll through all of them, with the image on
% the bottom page of it).

% Load in the data
data_location = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';
summary_file_location = fullfile(data_location,'..');
if ~exist('fig_data_summ','var')
    load(fullfile(summary_file_location,'fig_data_summ.mat'))
end
figure_location = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/whole_screen_summary_figures';

% Sizes and locations of images
title_pos               = [.05 .89 .5 .1];
legend_pos_n1           = [.52 .89 .25 .1];
legend_pos_c1           = [.67 .965 .02 .02];
legend_pos_n2           = [.72 .89 .25 .1];
legend_pos_c2           = [.845 .965 .02 .02];

first_location = [-.08 .97 .093 .099];
x_step_size = .12;
y_step_size = .146;

images_wide = 8;
images_high = 7;

mycolormap = {[.15 .15 .5],[1 .65 0],[238 0 238]/255,[255 99 71]/255,[.5 0 .5]};


for normalization_type = {'not_norm','norm'}
    
    switch normalization_type{1}
        case {'not_norm'}
            figure_name_stem = ['All Non-Normalized Results: '];
        case {'norm'}
            figure_name_stem = ['All Normalized Results: '];
    end
    
    % Velocity Nulling
    if 1
        figure_name{1} = [figure_name_stem 'Velocity Nulling'];
        handle(1) = figure('Name',figure_name{1},'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1000 800],'PaperOrientation','portrait');
        figure_description{1} = 'velocity_nulling';
        
        % Plot the genotypes across the figure, then down
        curr_pos = first_location;
        
        for img_iter = 1:numel(fig_data_summ)

            if ~mod(img_iter-1,images_wide)
                % reset the x dim
                curr_pos(1) = first_location(1) + x_step_size;
                
                % change to the y dim
                curr_pos(2) = curr_pos(2) - y_step_size;
                
            else%if img_iter ~= 1
                % add to the x dim
                curr_pos(1) = curr_pos(1) + x_step_size;
                
            end
            
            subplot('Position',curr_pos)
            
            if isempty(fig_data_summ(img_iter).vel_null_summ.(normalization_type{1}).null_contrast)
                text(5,3,'No Data')
            else
                null_contrast_vals = cell2mat(fig_data_summ(img_iter).vel_null_summ.(normalization_type{1}).null_contrast);
                avg_null_contrast_vals = fig_data_summ(1).avg_vel_null_summ.(normalization_type{1}).null_contrast;
                
                %--Plot a line for every value in the subplot
                temp_freq = [.2 1.3 5.3 10.7 16];

                semilogx(temp_freq,null_contrast_vals,'Color',mycolormap{1},'LineWidth',2);
                hold on;
                semilogx(temp_freq,avg_null_contrast_vals,'Color',mycolormap{2},'LineWidth',2);
                box off;
                
            end
            
            title(fig_data_summ(img_iter).geno_name(1:end-14),'Interpreter','none','FontWeight','Demi')
            
            set(gca,'XTick',[1 10],'Xticklabel',{'1', '10'},'LineWidth',1);
            
            if curr_pos(2) < .2
                xlabel({'Test Stim.',' Temp. Freq. (Hz)'})
            end
            
            if curr_pos(1) == (first_location(1) + x_step_size)
                ylabel('1 / null contrast')
            end
            
            axis([0 20 0 6]);
        end
        
        % Add title and legendish thing
        annotation('textbox','position',title_pos,'string',figure_name{1},...
                    'interpreter','none','EdgeColor','none','fontsize',15,'fontweight','bold');

        annotation('textbox','position',legend_pos_n1,'string','Genotype (x Kir2.1)',...
            'interpreter','none','EdgeColor','none','fontsize',15);

        annotation('textbox','position',legend_pos_n2,'string','Screen Average',...
            'interpreter','none','EdgeColor','none','fontsize',15);        

        subplot('Position',legend_pos_c1)
        rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{1});
        box off; axis off;

        subplot('Position',legend_pos_c2)
        rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{2});
        box off; axis off;
        
    end
    
    % Dark on Bright Stripe Tracking
    if 1
        figure_name{2} = [figure_name_stem 'Dark Stripe Tracking'];
        handle(2) = figure('Name',figure_name{2},'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1000 800],'PaperOrientation','portrait');
        figure_description{2} = 'dark_stripe_tracking';
        
        % Plot the genotypes across the figure, then down
        curr_pos = first_location;
        
        for img_iter = 1:numel(fig_data_summ)

            if ~mod(img_iter-1,images_wide)
                % reset the x dim
                curr_pos(1) = first_location(1) + x_step_size;
                
                % change to the y dim
                curr_pos(2) = curr_pos(2) - y_step_size;
                
            else%if img_iter ~= 1
                % add to the x dim
                curr_pos(1) = curr_pos(1) + x_step_size;
                
            end
            
            subplot('Position',curr_pos)
            
            % The genotype
            % The genotype
            graph.avg{1} = fig_data_summ(img_iter).tuning_curves.(normalization_type{1}).small_field.avg;
            graph.variance{1} = fig_data_summ(img_iter).tuning_curves.(normalization_type{1}).small_field.sem;
            graph.color{1} = mycolormap{1};
            % The average response
            graph.avg{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).small_field.avg;
            graph.variance{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).small_field.sem;
            graph.color{2} = mycolormap{2};
            
            tfPlot.tuning_curve(graph);
            
            title(fig_data_summ(img_iter).geno_name(1:end-14),'Interpreter','none','FontWeight','Demi')
            
            set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '5'},'LineWidth',1);
            set(gca,'Ylim',[0 1])
            box off;
            
            if curr_pos(2) < .2
                xlabel('Oscillation Frequency')
            end
            
            if curr_pos(1) == (first_location(1) + x_step_size)
                ylabel('Correlation')
            end
            
            if ~(curr_pos(1) == (first_location(1) + x_step_size)) %&& ~(curr_pos(2) < .2)
                axis off;
            end
            
        end
        
        % Add title and legendish thing
        annotation('textbox','position',title_pos,'string',figure_name{2},...
                    'interpreter','none','EdgeColor','none','fontsize',15,'fontweight','bold');

        annotation('textbox','position',legend_pos_n1,'string','Genotype (x Kir2.1)',...
            'interpreter','none','EdgeColor','none','fontsize',15);

        annotation('textbox','position',legend_pos_n2,'string','Screen Average',...
            'interpreter','none','EdgeColor','none','fontsize',15);        

        subplot('Position',legend_pos_c1)
        rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{1});
        box off; axis off;

        subplot('Position',legend_pos_c2)
        rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{2});
        box off; axis off;

    end
    
    % Bright on Dark Stripe Tracking
    if 1
        figure_name{3} = [figure_name_stem 'Bright Stripe Tracking'];
        handle(3) = figure('Name',figure_name{3},'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1000 800],'PaperOrientation','portrait');
        figure_description{3} = 'bright_stripe_tracking';
        
        % Plot the genotypes across the figure, then down
        curr_pos = first_location;
        
        for img_iter = 1:numel(fig_data_summ)

            if ~mod(img_iter-1,images_wide)
                % reset the x dim
                curr_pos(1) = first_location(1) + x_step_size;
                
                % change to the y dim
                curr_pos(2) = curr_pos(2) - y_step_size;
                
            else%if img_iter ~= 1
                % add to the x dim
                curr_pos(1) = curr_pos(1) + x_step_size;
                
            end
            
            subplot('Position',curr_pos)
            
            % The genotype
            % The genotype
            graph.avg{1} = fig_data_summ(img_iter).tuning_curves.(normalization_type{1}).small_field_donb.avg;
            graph.variance{1} = fig_data_summ(img_iter).tuning_curves.(normalization_type{1}).small_field_donb.sem;
            graph.color{1} = mycolormap{1};
            % The average response
            graph.avg{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).small_field_donb.avg;
            graph.variance{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).small_field_donb.sem;
            graph.color{2} = mycolormap{2};
            
            tfPlot.tuning_curve(graph);
            
            title(fig_data_summ(img_iter).geno_name(1:end-14),'Interpreter','none','FontWeight','Demi')
            
            set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '5'},'LineWidth',1);
            set(gca,'Ylim',[0 1])
            box off;
            
            if curr_pos(2) < .2
                xlabel('Oscillation Frequency')
            end
            
            if curr_pos(1) == (first_location(1) + x_step_size)
                ylabel('Correlation')
            end
            
            if ~(curr_pos(1) == (first_location(1) + x_step_size)) %&& ~(curr_pos(2) < .2)
                axis off;
            end
            
        end
        
        % Add title and legendish thing
        annotation('textbox','position',title_pos,'string',figure_name{3},...
                    'interpreter','none','EdgeColor','none','fontsize',15,'fontweight','bold');

        annotation('textbox','position',legend_pos_n1,'string','Genotype (x Kir2.1)',...
            'interpreter','none','EdgeColor','none','fontsize',15);

        annotation('textbox','position',legend_pos_n2,'string','Screen Average',...
            'interpreter','none','EdgeColor','none','fontsize',15);        

        subplot('Position',legend_pos_c1)
        rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{1});
        box off; axis off;

        subplot('Position',legend_pos_c2)
        rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{2});
        box off; axis off;

    end
    
    % Grating Tracking
    if 1
        figure_name{4} = [figure_name_stem 'Grating Tracking'];
        handle(4) = figure('Name',figure_name{4},'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1000 800],'PaperOrientation','portrait');
        figure_description{4} = 'grating_tracking';

        % Plot the genotypes across the figure, then down
        curr_pos = first_location;
        
        for img_iter = 1:numel(fig_data_summ)

            if ~mod(img_iter-1,images_wide)
                % reset the x dim
                curr_pos(1) = first_location(1) + x_step_size;
                
                % change to the y dim
                curr_pos(2) = curr_pos(2) - y_step_size;
                
            else%if img_iter ~= 1
                % add to the x dim
                curr_pos(1) = curr_pos(1) + x_step_size;
                
            end
            
            subplot('Position',curr_pos)
            
            % The genotype
            % The genotype
            graph.avg{1} = fig_data_summ(img_iter).tuning_curves.(normalization_type{1}).small_field_grat.avg;
            graph.variance{1} = fig_data_summ(img_iter).tuning_curves.(normalization_type{1}).small_field_grat.sem;
            graph.color{1} = mycolormap{1};
            % The average response
            graph.avg{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).small_field_grat.avg;
            graph.variance{2} = fig_data_summ(1).avg_tuning_curves.(normalization_type{1}).small_field_grat.sem;
            graph.color{2} = mycolormap{2};
            
            tfPlot.tuning_curve(graph);
            
            title(fig_data_summ(img_iter).geno_name(1:end-14),'Interpreter','none','FontWeight','Demi')
            
            set(gca,'XTick',1:3,'Xticklabel',{'1', '3', '5'},'LineWidth',1);
            set(gca,'Ylim',[0 1])
            box off;
            
            if curr_pos(2) < .2
                xlabel('Oscillation Frequency')
            end
            
            if curr_pos(1) == (first_location(1) + x_step_size)
                ylabel('Correlation')
            end
            
            if ~(curr_pos(1) == (first_location(1) + x_step_size)) %&& ~(curr_pos(2) < .2)
                axis off;
            end
            
        end
        
        % Add title and legendish thing
        annotation('textbox','position',title_pos,'string',figure_name{4},...
                    'interpreter','none','EdgeColor','none','fontsize',15,'fontweight','bold');

        annotation('textbox','position',legend_pos_n1,'string','Genotype (x Kir2.1)',...
            'interpreter','none','EdgeColor','none','fontsize',15);

        annotation('textbox','position',legend_pos_n2,'string','Screen Average',...
            'interpreter','none','EdgeColor','none','fontsize',15);        

        subplot('Position',legend_pos_c1)
        rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{1});
        box off; axis off;

        subplot('Position',legend_pos_c2)
        rectangle('Position',[1 1 1 1],'EdgeColor','none','FaceColor',mycolormap{2});
        box off; axis off;

    end
    
    % Images
    if 1
        figure_name{5} = [figure_name_stem 'Images'];
        handle(5) = figure('Name',figure_name{5},'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1000 800],'PaperOrientation','portrait');
        figure_description{5} = 'images';
        % Plot the genotypes across the figure, then down
        curr_pos = first_location;
        
        for img_iter = 1:numel(fig_data_summ)

            if ~mod(img_iter-1,images_wide)
                % reset the x dim
                curr_pos(1) = first_location(1) + x_step_size;
                
                % change to the y dim
                curr_pos(2) = curr_pos(2) - y_step_size;
                
            else%if img_iter ~= 1
                % add to the x dim
                curr_pos(1) = curr_pos(1) + x_step_size;
                
            end
            
            subplot('Position',curr_pos)
            if strcmpi(fig_data_summ(img_iter).geno_name(1:3),'gmr')
                plot(1:10,1:10,'k'); hold on
                text(5,3,'No Image')
            else
                subimage(fig_data_summ(img_iter).img);
            end
            
            axis off; box off;
            title(fig_data_summ(img_iter).geno_name(1:end-14),'Interpreter','none','FontWeight','Demi')
        end
        annotation('textbox','position',title_pos,'string',figure_name{5},...
                    'interpreter','none','EdgeColor','none','fontsize',15,'fontweight','bold');
                
    end

    % Save the figures
    if 1
        % Save individual figures
        for i = 1:numel(figure_description)
            export_fig(handle(i),fullfile(figure_location,[normalization_type{1} '_summary_figure_' figure_description{i}]),'-pdf')
        end

        % Save all figures appended to each other
        for i = 1:numel(figure_description)
            export_fig(handle(i),fullfile(figure_location,['combined_' normalization_type{1} '_summary_figure']),'-pdf', '-append')
        end
    end
    
    
    
end