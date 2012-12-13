%% Est. data subsets (via folders)

a = 1;

switch a
    case 1

        geno_names{1} = 'gmr_OL0001_gal80ts_kir21';
        geno_names{2} = 'gmr_OL0004_gal80ts_kir21';
        geno_names{3} = 'gmr_OL0008_gal80ts_kir21';
        geno_names{4} = 'gmr_OL0011_gal80ts_kir21';
        geno_names{5} = 'gmr_OL0013_gal80ts_kir21';
        geno_names{6} = 'gmr_OL0016_gal80ts_kir21';
        geno_names{7} = 'gmr_OL0017_gal80ts_kir21';
        geno_names{8} = 'gmr_OL0018_gal80ts_kir21';
        geno_names{9} = 'gmr_OL0020_gal80ts_kir21';
        geno_names{10} = 'gmr_OL0021_gal80ts_kir21';
        geno_names{11} = 'gmr_OL0023_gal80ts_kir21';
        geno_names{12} = 'gmr_OL0025_gal80ts_kir21';
        geno_names{13} = 'gmr_OL0028_gal80ts_kir21';
        geno_names{14} = 'gmr_OL0030_gal80ts_kir21';
        geno_names{15} = 'gmr_OL0031_gal80ts_kir21';
        geno_names{16} = 'gmr_OL0033_gal80ts_kir21';
        geno_names{17} = 'gmr_OL0035_gal80ts_kir21';
        geno_names{18} = 'gmr_OL0038_gal80ts_kir21';

        %data_location = '/Volumes/STEPHEN32SD/telethon_experiment_2012';
        data_location = '/Volumes/lacie-temp-external/vpn_screen/set_2_telethon_experiment_2012';

        
        graph_sets =   {[17 1],...
                        [17 2],...
                        [17 3],...
                        [17 4],...
                        [17 5],...
                        [17 6],...   
                        [17 7],...   
                        [17 8],...  
                        [17 9],...   
                        [17 10],...   
                        [17 11],...   
                        [17 12],...
                        [17 13],...
                        [17 14],...
                        [17 15],...
                        [17 16],...
                        [17 17],...
                        [17 18]};   
    case 2

        geno_names{1} = 'gmr_OL0017_gal80ts_kir21_1';
        geno_names{2} = 'gmr_OL0017_gal80ts_kir21_2';
        geno_names{3} = 'gmr_OL0033_gal80ts_kir21_1';
        geno_names{4} = 'gmr_OL0033_gal80ts_kir21_2';

        data_location = '/Volumes/STEPHEN32SD/telethon_experiment_2012_testing/';
        
        graph_sets = {[1 2],...
                      [3 4]};
end

%% Process the data / data subset

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


if 0
for i = 1:numel(geno_data)
% gather three points for each of the test contrasts used at a given
% temporal frequency
contrast_set = [.09 .27 .45];

stim_set{1} = [1 2 3];
stim_set{2} = [4 5 6];
stim_set{3} = [7 8 9];
stim_set{4} = [10 11 12];
stim_set{5} = [13 14 15];

    for g = 1:numel(stim_set)

        % vel nulling is the 12th set
        condition_numbers = geno_data{i}.grouped_conditions{12}.list(stim_set{g});

        [null_contrast_vals{g} null_contrast_vals_sem{g}] = geno_data{i}.get_trial_data_set(condition_numbers,'lmr','mean','yes','all');

    end

    for g = 1:numel(null_contrast_vals)

        null_contrast_line{g} = cell2mat(null_contrast_vals{g});

        temp_contrast_resp = (cell2mat(null_contrast_vals{g}));

        % Fit a first degree polynomial coef
        fit_vals(g,:) = polyfit(contrast_set',temp_contrast_resp',1);

        % Find the zero crossing point/null contrast
        intercept_val{g} = -1*(fit_vals(g,2)/fit_vals(g,1));
        null_contrast{g} = 1/intercept_val{g};

        % Plot the raw data points  
        raw_plot{g} = [contrast_set;temp_contrast_resp];
        
        % Plot the fit line (for a few more points)
        fit_plot{g} = [[.01 contrast_set .6];polyval(fit_vals(g,:),[.01 contrast_set .6])];

    end
    
    % Make a variable with all the summary data!
    vel_null_summ(i).intercept_val     = intercept_val;
    vel_null_summ(i).null_contrast     = null_contrast;
    vel_null_summ(i).raw_plot          = raw_plot;
    vel_null_summ(i).fit_plot          = fit_plot;
    vel_null_summ(i).fit_vals          = fit_vals;
    vel_null_summ(i).contrast_set      = contrast_set;
    vel_null_summ(i).name              = geno_names{i};
    vel_null_summ(i).N                 = numel(geno_data{i}.experiment);
  
end

% save all of the fields for quick figure making later
save(fullfile(data_location,'vel_null_summ'),'vel_null_summ');
    
end % if 0/1


%% Load data / Make the figure    

load(fullfile(data_location,'vel_null_summ'));
    
if 1     
    %--Make the figure
    handle(1) = figure('Name','Comparison: Cont Nulling','NumberTitle','off','Color',[1 1 1],'Position',[50 50 1055 755/2],'PaperOrientation','portrait');
    
    for i = 1:numel(graph_sets)
        
        %--Calculate the median of all the curves and use as a control
        for g = 1:19
            all_null_contrast_vals(g,:) = cell2mat(vel_null_summ(graph_sets{g}(2)).null_contrast);
        end
        mean_null_contrast_vals = mean(all_null_contrast_vals);
        
        %--Set up the graph colors
        mycolormap = {[.15 .15 .5],[1 .65 0],[238 0 238]/255,[255 99 71]/255,[.5 0 .5]};

        if numel(graph_sets{i}) == 2
            graph.color{1} = mycolormap{1};
            graph.color{2} = mycolormap{2};
        else
            graph.color{1} = mycolormap{1};
            graph.color{2} = mycolormap{2};
            graph.color{3} = mycolormap{3};
            graph.color{4} = mycolormap{4};                
        end
        
        %--Plot the lines to compare
        plot_position = [.001+.05*i .1 .05 .82];
        subplot('Position',plot_position)
        
        %--Plot a line for every value in the subplot
        temp_freq = [.2 1.3 5.3 10.7 16];
        
        % change to 1:end if comparing specific, otherwise use average
        semilogx(temp_freq,mean_null_contrast_vals,'Color',graph.color{1},'LineWidth',2);
        hold on; box off;

        for g = 2:numel(graph_sets{i})
            null_contrast_vals = cell2mat(vel_null_summ(graph_sets{i}(g)).null_contrast);
            semilogx(temp_freq,null_contrast_vals,'Color',graph.color{g},'LineWidth',2);
        end
        
        %--Set up Axis Labels
        set(gca,'XTick',[1 10],'Xticklabel',{'1', '10'},'LineWidth',1);
        axis([0 20 0 6]);
            
        if i ==1 
            xlabel('Test Stim. Temp. Freq. (Hz)')
            ylabel('1 / null contrast')
        else
            axis off
        end
        
%         %--Set up a legend.
%         l_hand = legend(geno_names{1:4});
%         set(l_hand,'Interpreter','none','Location','Southeast');
        
        % Alternate the height of the genotype name as graph title to make
        % them all fit
        if ~mod(i,2)
            title({'',vel_null_summ(graph_sets{i}(2)).name(5:10)},'interpreter','none','FontSize',10)
        else
            title({vel_null_summ(graph_sets{i}(2)).name(5:10),''},'interpreter','none','FontSize',10)
        end
        
        %--Correctly display the number of flies run.
        n_str =  ['N = ' num2str(vel_null_summ(graph_sets{i}(2)).N)];
        n_position = [plot_position(1) + .02, .1, .05, .15];
        annotation('Textbox','Position',n_position,'String',n_str,'Edgecolor','none');

        clear graph
        
    end
    
    %--Save the figure
    export_fig(handle(1),fullfile(data_location,filesep,'..','vpn_ii_analysis_figures',['vpn_vel_null_large_controls']),'-pdf')
    
    
    % Plot for individual null cont line checking
    if 1
        for i = 1:numel(graph_sets)
            
            handle(1+i) = figure('Name',['Full Cont Null ' vel_null_summ(graph_sets{i}(2)).name(5:10)] ,'NumberTitle','off','Color',[1 1 1],'Position',[50 50 1055 755/2],'PaperOrientation','portrait');
            
            for sp = 1:5

                subplot(1,7,sp)
                plot(vel_null_summ(graph_sets{i}(2)).raw_plot{sp}(1,:),vel_null_summ(graph_sets{i}(2)).raw_plot{sp}(2,:),'.');
                hold all;
                plot([0 .6],[0 0],'--')            
                plot(vel_null_summ(graph_sets{i}(2)).fit_plot{sp}(1,:),vel_null_summ(graph_sets{i}(2)).fit_plot{sp}(2,:),'-');
                plot(vel_null_summ(graph_sets{i}(2)).intercept_val{sp},polyval(vel_null_summ(graph_sets{i}(2)).fit_vals(sp,:),vel_null_summ(graph_sets{i}(2)).intercept_val{sp}),'x');
                axis([0 .6 -10 10])
                set(gca,'XTick',[.1 .3 .5],'Xticklabel',{'.1','.3','.5'},'LineWidth',1);
                
                if sp == 1
                    ylabel('\Sigma LmR')
                    title('tf = 0.3 Hz')
                elseif sp == 2
                    title('tf = 1.3 Hz')
                elseif sp == 3
                    title('tf = 5.3 Hz')
                elseif sp == 4
                    title('tf = 10.7 Hz')
                elseif sp == 5
                    title('tf = 16 Hz')
                end
                
            end
            
            subplot (1,7,[6 7])
            temp_freq = [.2 1.3 5.3 10.7 16];
            null_contrast_vals = cell2mat(vel_null_summ(graph_sets{i}(g)).null_contrast);
            semilogx(temp_freq,null_contrast_vals);
            set(gca,'XTick',[1 10],'Xticklabel',{'1', '10'},'LineWidth',1);
            axis([0 20 0 6]);
            xlabel('Temporal Frequency: Test Stimulus (Hz)')
            ylabel('1 / null contrast')
            title({'',vel_null_summ(graph_sets{i}(2)).name(5:10)},'interpreter','none','FontSize',10)            

            export_fig(handle(i+1),fullfile(data_location,filesep,'..','vpn_ii_analysis_figures',[vel_null_summ(graph_sets{i}(2)).name(5:10) '_vel_null']),'-pdf')
            
        end
    end % if 0/1
end