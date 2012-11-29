% Make figure for expansion stimulus protocol

%% Load the data from the correct sources
if 0
    
%     % This is a rt motionblind control and a wild type...
%     data_location{1} = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_gal80ts_kir21';
%     data_location{2} = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_pJFRC100';
   
%     % This is a rt motionblind control and a wild type...
%     data_location{1} = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_uas-shi-ts';
%     data_location{2} = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_pJFRC100';

    % This is a rt motionblind control and a wild type...
    data_location{1} = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_pJFRC100_CSMH';
    data_location{2} = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01/gmr_48a08ad_29g11dbd_pJFRC100';


    % This is a shifted version
    for g = 1:numel(data_location)
        g_set{g} = tfAnalysis.ExpSet(tfAnalysis.import(data_location{g},'all'));
    end
end
%% Show the expansion response with raw traces

% Use one of the internal functions from Expg_set to return unaveraged data

get_samples = @(vec)(vec(:));

for g = 1:numel(g_set)
    
    data{g}.raw = g_set{g}.return_multi_experiment_cond_data(1,'lmr',get_samples);
    
    [graph{g}.avg, graph{g}.variance] = process_multi_rep_expansion_data(data{g});
    
end

handle(1) = figure('Name','Shi-TS Turning Response','NumberTitle','off','Color',[1 1 1],'Position',[50 50 755/2 1055],'PaperOrientation','portrait');
mycolormap = {[.15 .15 .5],[1 .65 0],[238 0 238]/255,[255 99 71]/255,[.5 0 .5]};

%--Iterate over each group of turns
num_graph_plots = 2; %numel(graph{1}.avg);

for i = 1:num_graph_plots
    
    subplot(num_graph_plots,1,i)
    
    %--Iterate over each genotype
    for g = 1:numel(graph)
        plot(graph{g}.avg{i},'Color',mycolormap{g},'linewidth',2);
        hold all;
    end
    
    %--g_set up Axis Labels
    box off;
    
    axis([0 12000 -10.1 10.1]);
    
    if i == num_graph_plots
        xlabel('Time (ms)','Fontsize',14)
        ylabel({'LmR (V)',['Grp ' num2str(i)]},'Fontsize',14)
    else
        set(gca,'XColor',[1 1 1],'Ycolor',[1 1 1])
        ylabel(['Grp' num2str(i)],'Color',[0 0 0],'Fontsize',14)
    end
    
    if i == 1
        title('Turning Comparison','Fontsize',14)
    end

    
    % Patch on Exp Right 1
    xdata=[3001:6000 6000:-1:3001];
    ydata=[-10*ones(1,numel(xdata)/2) 10*ones(1,numel(xdata)/2)];
    zdata=-eps*ones(1,numel(ydata));
    
    patch(  'XData',    xdata,...
            'YData',    ydata,...
            'ZData',    zdata,...
            'FaceColor', [.85 .85 .85],...
            'EdgeColor', 'none');
        
    % Patch on Exp Right 2
    patch(  'XData',    xdata+6000,...
            'YData',    ydata,...
            'ZData',    zdata,...
            'FaceColor', [.85 .85 .85],...
            'EdgeColor', 'none');    
end

% Save the figure, manually
temperature = '30C';
comparison = 'pJFRC100CSMH_blue_vs_pJFRC100DL';
save_path = '/Users/stephenholtz/Desktop/expansion_stripe_track_v01_analysis';
export_fig(gcf,fullfile(save_path,['turn_resp_' temperature '_' comparison]),'-pdf')


% for i = 1:numel(graph.avg)
%     
%     min_val=min(graph.avg{i}(1:floor(numel(graph.avg{i})/2)));
%     max_val=max(graph.avg{i}(1:floor(numel(graph.avg{i})/2)));
%     
%     turn_resp(i) = max_val-min_val;
% end
%
% plot(turn_resp)
