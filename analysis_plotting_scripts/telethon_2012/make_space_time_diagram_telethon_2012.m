% Script to make/save space time diagrams and movies

conditions = telethon_experiment_2012;

save_path = '/Users/stephenholtz/Desktop/temp_space_time/telethon_experiment_2012';

if ~exist(save_path,'dir')
    mkdir(save_path)
end

make_vids = 1;

for i = [143 139 144 140]
    
    stim_name = ['cond_' num2str(i)];
    
    save_file = fullfile(save_path,stim_name);
    
    stimulus = tfPlot.arenaSimulation('small',conditions(i));
    std_handle = stimulus.MakeSimpleSpaceTimeDiagram('green');
    snaps_handle = stimulus.MakeSnapshotTimeSeries(10);
    params_handle = stimulus.MakeParametersPage;
    
    tfPlot.arenaSimulation.SaveSpaceTimeDiagram(save_file,std_handle,params_handle,snaps_handle);
    
    if make_vids
        mov_handle = stimulus.MakeMovie('green',save_file);
    end
    
    close all
    
end
