% make some quick plots!

if ~exist('tuning_curves','var')
    data_location = '/Users/stephenholtz/local_experiment_copies/ON_OFF_set_v02';
    load(fullfile(data_location,'tuning_curves'));
end
%

figure

type_1 = 'min_mot_ON_76';
type_2 = 'min_mot_OFF_76';

my_colormap     = {[30 144 255]/255,[255 165 0]/255,[238 0 238]/255,[0 238 0]/255,[255 44 44]/255};

for i = 1:5
    subplot(1,5,i)
    
    graph.avg{1} = (tuning_curves.butter_offset.(type_1).avg_ts{i});
    graph.variance{1} = (tuning_curves.butter_offset.(type_1).sem_ts{i});
    graph.color{1} = my_colormap{1};
    graph.avg{2} = (tuning_curves.butter_offset.(type_2).avg_ts{i});
    graph.variance{2} = (tuning_curves.butter_offset.(type_2).sem_ts{i});
    graph.color{2} = my_colormap{2};
    
    tfPlot.timeseries(graph)
    
    %plot(tuning_curves.butter.(type_1).avg_ts{i},'linewidth',2)
    hold all
    %plot(tuning_curves.butter.(type_2).avg_ts{i},'linewidth',2)
    
    plot(tuning_curves.raw.(type_1).x_avg_ts{i}(21:end)/20,'linewidth',1)
    
    axis([0 600 -.6 .6])
end

lh=legend(type_1,type_2,'xavg');
set(lh,'interpreter','none','location','southoutside')