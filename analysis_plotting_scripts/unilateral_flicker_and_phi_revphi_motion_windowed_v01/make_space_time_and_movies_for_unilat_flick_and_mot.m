% Script to make/save space time diagrams and movies

conditions = unilateral_flicker_and_phi_revphi_motion_windowed_v01;

save_path = '/Users/stephenholtz/Desktop/temp_space_time/unilateral_flicker_and_phi_revphi_motion_windowed_v01';

if ~exist(save_path,'dir')
    mkdir(save_path)
end

for i = 1:(numel(conditions)-1)

    stim_name = ['cond_' num2str(i) '_pfunc_' conditions(i).PatternName(1:(end-4))];

    save_file = fullfile(save_path,stim_name);

    stimulus = tfPlot.arenaSimulation('small',conditions(i));
    std_handle = stimulus.MakeSimpleSpaceTimeDiagram('green');
    snaps_handle = stimulus.MakeSnapshotTimeSeries(10);
    params_handle = stimulus.MakeParametersPage;

    tfPlot.arenaSimulation.SaveSpaceTimeDiagram(save_file,std_handle,params_handle,snaps_handle);
    
    if randsample(1:16,1) == 1
        mov_handle = stimulus.MakeMovie('green',save_file);
    end
    
    close all

end

