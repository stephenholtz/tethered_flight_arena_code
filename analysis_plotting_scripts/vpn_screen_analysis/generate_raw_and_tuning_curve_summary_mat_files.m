% generate fig_data_summ.mat files per genotype for making figures of
% subsets of stimuli used.

%% Setup filepaths

% Make sure my file utilities are in place
addpath(genpath('/Users/stephenholtz/matlab-utils'))

% load each genotype
data_location = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/combined_raw_screen_data';

[geno_names,geno_dirs] = returnDirFolderList(data_location);

% use screen_turning_data for normalization values
normalization_file = fullfile(data_location,'..','screen_turning_data');

load(normalization_file);

%% Make fig_data_summ.mat files

% iteratively load in GENOTYPENAME_summary.mat files to populate tuning_curves.mat files.
if 0
    for i = 1:numel(geno_names)

        % Load in *_summary.mat files
        [~,summary_filepath] = returnDirFileList(geno_dirs{i},'_summary.mat');
        load(summary_filepath{1});
        
        % Use an eval...
        geno_data = eval(['tfAnalysis.ExpSet([' geno_names{i} '_summary''])']);

        geno_norm_val = screen_turning_data(i).norm_val;

        % make sure the genotype matches between the curr_norm_val and data loaded!
        disp('Stop if these do not match!')
        disp(screen_turning_data(i).names)
        disp(geno_names{i}); %pause    

        % Make a normalized and non normalized version of everything
        for norm_type = [0 1]

            if norm_type == 0
                curr_norm_val = 1;
                struct_branch_name = 'not_norm';
            else
                curr_norm_val = geno_norm_val;
                struct_branch_name = 'norm';
            end


            %---Velocity nulling data per genotype

            % only do this if the flag exists in this lines metadata!
            [~,experiment_folder_list] = returnDirFolderList(geno_dirs{i});
            metadata_file = fullfile(experiment_folder_list{1},'metadata.mat');
            load(metadata_file)

            if strcmpi(metadata.note,'vel_null_working')
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
                    condition_numbers = geno_data.grouped_conditions{12}.list(stim_set{g});

                    [null_contrast_vals{g}, null_contrast_vals_sem{g}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val); %#ok<*SAGROW>

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

                % Make a variable with all the nulling data
                vel_null_summ.(struct_branch_name).intercept_val     = intercept_val;
                vel_null_summ.(struct_branch_name).null_contrast     = null_contrast;
                vel_null_summ.(struct_branch_name).raw_plot          = raw_plot;
                vel_null_summ.(struct_branch_name).fit_plot          = fit_plot;
                vel_null_summ.(struct_branch_name).fit_vals          = fit_vals;
                vel_null_summ.(struct_branch_name).contrast_set      = contrast_set;
                vel_null_summ.(struct_branch_name).name              = geno_names{i};
                vel_null_summ.(struct_branch_name).N                 = numel(geno_data.experiment);

            else

                % Fill with empties if the line was run in an earlier iteration...
                vel_null_summ.(struct_branch_name).intercept_val     = [];
                vel_null_summ.(struct_branch_name).null_contrast     = [];
                vel_null_summ.(struct_branch_name).raw_plot          = [];
                vel_null_summ.(struct_branch_name).fit_plot          = [];
                vel_null_summ.(struct_branch_name).fit_vals          = [];
                vel_null_summ.(struct_branch_name).contrast_set      = [];
                vel_null_summ.(struct_branch_name).name              = [];
                vel_null_summ.(struct_branch_name).N                 = [];

            end

            %---lmr timeseries, mean lmr, and correlational data for some stimuli in the screen

            % Expansion

            stim_subset = 1:2;

            condition_numbers = geno_data.grouped_conditions{2}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val);

            expansion.avg = cell2mat(avg{i});

            expansion.sem = cell2mat(variance{i});

            expansion.condition_numbers = condition_numbers;
            expansion.stim_subset = stim_subset;
            expansion.name = geno_data.experiment{1}.line_name;
            expansion.num = numel(geno_data.experiment);

            clear avg variance

            % Optomotor, lambda 60

            stim_subset = 5:8;

            condition_numbers = geno_data.grouped_conditions{1}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val);

            optomotor.avg = cell2mat(avg{i});

            optomotor.sem = cell2mat(variance{i});

            optomotor.condition_numbers = condition_numbers;
            optomotor.stim_subset = stim_subset;
            optomotor.name = geno_data.experiment{1}.line_name;
            optomotor.num = numel(geno_data.experiment);

            clear avg variance

            % Contrast

            stim_subset = 1:4;

            condition_numbers = geno_data.grouped_conditions{4}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val);

            contrast.avg = cell2mat(avg{i});

            contrast.sem = cell2mat(variance{i});

            contrast.condition_numbers = condition_numbers;
            contrast.stim_subset = stim_subset;
            contrast.name = geno_data.experiment{1}.line_name;
            contrast.num = numel(geno_data.experiment);

            clear avg variance

            % small_field

            stim_subset = 1:3;

            condition_numbers = geno_data.grouped_conditions{6}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_corr_trial_data_set(condition_numbers,'lmr','x_pos','all');

            small_field.avg = cell2mat(avg{i});

            small_field.sem = cell2mat(variance{i});

            small_field.condition_numbers = condition_numbers;
            small_field.stim_subset = stim_subset;
            small_field.name = geno_data.experiment{1}.line_name;
            small_field.num = numel(geno_data.experiment);

            clear avg variance

            % small_field_raw

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','none','yes','all',curr_norm_val);

            small_field_ts.avg = (avg{i});

            small_field_ts.sem = (variance{i});

            small_field_ts.condition_numbers = condition_numbers;
            small_field_ts.stim_subset = stim_subset;
            small_field_ts.name = geno_data.experiment{1}.line_name;
            small_field_ts.num = numel(geno_data.experiment);

            clear avg variance

            % other tracking small_field dark on bright
            stim_subset = 4:6;

            condition_numbers = geno_data.grouped_conditions{6}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_corr_trial_data_set(condition_numbers,'lmr','x_pos','all');

            small_field_donb.avg = cell2mat(avg{i});

            small_field_donb.sem = cell2mat(variance{i});

            small_field_donb.condition_numbers = condition_numbers;
            small_field_donb.stim_subset = stim_subset;
            small_field_donb.name = geno_data.experiment{1}.line_name;
            small_field_donb.num = numel(geno_data.experiment);

            clear avg variance

            % small_field_ts with dark on dark on bright

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','none','yes','all',curr_norm_val);

            small_field_donb_ts.avg = (avg{i});

            small_field_donb_ts.sem = (variance{i});

            small_field_donb_ts.condition_numbers = condition_numbers;
            small_field_donb_ts.stim_subset = stim_subset;
            small_field_donb_ts.name = geno_data.experiment{1}.line_name;
            small_field_donb_ts.num = numel(geno_data.experiment);

            clear avg variance

            %other tracking grating
            stim_subset = 7:9;

            condition_numbers = geno_data.grouped_conditions{6}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_corr_trial_data_set(condition_numbers,'lmr','x_pos','all');

            small_field_grat.avg = cell2mat(avg{i});

            small_field_grat.sem = cell2mat(variance{i});

            small_field_grat.condition_numbers = condition_numbers;
            small_field_grat.stim_subset = stim_subset;
            small_field_grat.name = geno_data.experiment{1}.line_name;
            small_field_grat.num = numel(geno_data.experiment);

            clear avg variance

            % grating raw ts

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','none','yes','all',curr_norm_val);

            small_field_grat_ts.avg = (avg{i});

            small_field_grat_ts.sem = (variance{i});

            small_field_grat_ts.condition_numbers = condition_numbers;
            small_field_grat_ts.stim_subset = stim_subset;
            small_field_grat_ts.name = geno_data.experiment{1}.line_name;
            small_field_grat_ts.num = numel(geno_data.experiment);

            clear avg variance

            % osc stim
            stim_subset = 1:4;

            condition_numbers = geno_data.grouped_conditions{14}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val);

            osc_stim.avg = cell2mat(avg{i});

            osc_stim.sem = cell2mat(variance{i});

            osc_stim.condition_numbers = condition_numbers;
            osc_stim.stim_subset = stim_subset;
            osc_stim.name = geno_data.experiment{1}.line_name;
            osc_stim.num = numel(geno_data.experiment);

            clear avg variance

            % osc_raw

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','none','yes','all',curr_norm_val);

            osc_stim_ts.avg = (avg{i});

            osc_stim_ts.sem = (variance{i});

            osc_stim_ts.condition_numbers = condition_numbers;
            osc_stim_ts.stim_subset = stim_subset;
            osc_stim_ts.name = geno_data.experiment{1}.line_name;
            osc_stim_ts.num = numel(geno_data.experiment);
            
            clear avg variance
            
            
            % Flow Oscillations
            
            stim_subset = [2 3 4 6];

            condition_numbers = geno_data.grouped_conditions{11}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val);

            flow.avg = cell2mat(avg{i});

            flow.sem = cell2mat(variance{i});

            flow.condition_numbers = condition_numbers;
            flow.stim_subset = stim_subset;
            flow.name = geno_data.experiment{1}.line_name;
            flow.num = numel(geno_data.experiment);

            clear avg variance

            % ts flow data

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','none','yes','all',curr_norm_val);

            flow_ts.avg = (avg{i});

            flow_ts.sem = (variance{i});

            flow_ts.condition_numbers = condition_numbers;
            flow_ts.stim_subset = stim_subset;
            flow_ts.name = geno_data.experiment{1}.line_name;
            flow_ts.num = numel(geno_data.experiment);
            
            clear avg variance
            
            % Reverse-Phi
            
            stim_subset = 1:6;

            condition_numbers = geno_data.grouped_conditions{5}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val);

            rp.avg = cell2mat(avg{i});

            rp.sem = cell2mat(variance{i});

            rp.condition_numbers = condition_numbers;
            rp.stim_subset = stim_subset;
            rp.name = geno_data.experiment{1}.line_name;
            rp.num = numel(geno_data.experiment);

            clear avg variance

            % ts rp data

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','none','yes','all',curr_norm_val);

            rp_ts.avg = (avg{i});

            rp_ts.sem = (variance{i});

            rp_ts.condition_numbers = condition_numbers;
            rp_ts.stim_subset = stim_subset;
            rp_ts.name = geno_data.experiment{1}.line_name;
            rp_ts.num = numel(geno_data.experiment);
            
            clear avg variance            
            
            % Progressive
            
            stim_subset = 1:3;

            condition_numbers = geno_data.grouped_conditions{8}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val);

            prog.avg = cell2mat(avg{i});

            prog.sem = cell2mat(variance{i});

            prog.condition_numbers = condition_numbers;
            prog.stim_subset = stim_subset;
            prog.name = geno_data.experiment{1}.line_name;
            prog.num = numel(geno_data.experiment);

            clear avg variance

            % ts prog data

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','none','yes','all',curr_norm_val);

            prog_ts.avg = (avg{i});

            prog_ts.sem = (variance{i});

            prog_ts.condition_numbers = condition_numbers;
            prog_ts.stim_subset = stim_subset;
            prog_ts.name = geno_data.experiment{1}.line_name;
            prog_ts.num = numel(geno_data.experiment);
            
            clear avg variance            
            
            % Regressive
            
            stim_subset = 1:3;

            condition_numbers = geno_data.grouped_conditions{7}.list(stim_subset);

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','mean','yes','all',curr_norm_val);

            reg.avg = cell2mat(avg{i});

            reg.sem = cell2mat(variance{i});

            reg.condition_numbers = condition_numbers;
            reg.stim_subset = stim_subset;
            reg.name = geno_data.experiment{1}.line_name;
            reg.num = numel(geno_data.experiment);

            clear avg variance

            % ts reg data

            [avg{i}, variance{i}] = geno_data.get_trial_data_set(condition_numbers,'lmr','none','yes','all',curr_norm_val);

            reg_ts.avg = (avg{i});
            
            reg_ts.sem = (variance{i});

            reg_ts.condition_numbers = condition_numbers;
            reg_ts.stim_subset = stim_subset;
            reg_ts.name = geno_data.experiment{1}.line_name;
            reg_ts.num = numel(geno_data.experiment);
            
            clear avg variance
            
            % Save tuning_curves.mat with quick data, should be < 300 Mb
            tuning_curves.(struct_branch_name).expansion = expansion;
            tuning_curves.(struct_branch_name).contrast = contrast;
            tuning_curves.(struct_branch_name).optomotor = optomotor;
            tuning_curves.(struct_branch_name).small_field = small_field;
            tuning_curves.(struct_branch_name).small_field_ts = small_field_ts;
            tuning_curves.(struct_branch_name).small_field_donb = small_field_donb;
            tuning_curves.(struct_branch_name).small_field_donb_ts = small_field_donb_ts;
            tuning_curves.(struct_branch_name).small_field_grat = small_field_grat;
            tuning_curves.(struct_branch_name).small_field_grat_ts = small_field_grat_ts;
            tuning_curves.(struct_branch_name).osc_stim = osc_stim;
            tuning_curves.(struct_branch_name).osc_stim_ts = osc_stim_ts;
            tuning_curves.(struct_branch_name).flow = flow;
            tuning_curves.(struct_branch_name).flow_ts = flow_ts;
            tuning_curves.(struct_branch_name).rp = rp;
            tuning_curves.(struct_branch_name).rp_ts = rp_ts;
            tuning_curves.(struct_branch_name).prog = prog;
            tuning_curves.(struct_branch_name).prog_ts = prog_ts;
            tuning_curves.(struct_branch_name).reg = reg;
            tuning_curves.(struct_branch_name).reg_ts = reg_ts;            
        end
        
        % populate the final structure
        fig_data_summ(i).tuning_curves = tuning_curves;
        fig_data_summ(i).vel_null_summ = vel_null_summ;    
        fig_data_summ(i).norm_vals     = screen_turning_data(i);
        fig_data_summ(i).geno_name     = geno_names{i};
        
        % clean up the variables, the hard way
        clear summary_filepath *_summary tuning_curves vel_null_summ
        clear *_ts expansion contrast optomotor osc_* small_field small_field*
        clear intercept_val null_contrast raw_plot fit_plot fit_vals contrast_set

    end
    
    save(fullfile(data_location,'..','fig_data_summ'),'fig_data_summ');
    
    save(fullfile(data_location,'..','failsafe_pre_avg_fig_data_summ'),'fig_data_summ');
    
    clear fig_data_summ
end

if 1
    count = 0;
    
    % load the figure data summary
    load(fullfile(data_location,'..','fig_data_summ.mat'))
    for i = 1:numel(geno_names)
        % Determine averages for each point in all of the tuning_curves and
        % vel_null_sum substructures for later plotting comparison. 
        for struct_branch_name = {'not_norm','norm'}

            tune_curve_fieldnames = fieldnames(fig_data_summ(i).tuning_curves.(struct_branch_name{1}));
            
            for tune_curve_fieldname = tune_curve_fieldnames'

%                 [fig_data_summ(i).avg_tuning_curves.(struct_branch_name{1}).(tune_curve_fieldname{1}),fig_data_summ(i).sem_tuning_curves.(struct_branch_name{1}).(tune_curve_fieldname{1})] = ...
%                     doAverageOnStruct(fig_data_summ,{['tuning_curves'],[struct_branch_name{1}],[tune_curve_fieldname{1}]});
%                     count = count + 7
                [avg,sem] = doAverageOnStruct(fig_data_summ,{['tuning_curves'],[struct_branch_name{1}],[tune_curve_fieldname{1}]});
                fig_data_summ(i).avg_tuning_curves.(struct_branch_name{1}).(tune_curve_fieldname{1}) = avg.tuning_curves.(struct_branch_name{1}).(tune_curve_fieldname{1});
                fig_data_summ(i).sem_tuning_curves.(struct_branch_name{1}).(tune_curve_fieldname{1}) = sem.tuning_curves.(struct_branch_name{1}).(tune_curve_fieldname{1});
                count = count + 7;
                disp(count)
            end
            
            tune_curve_fieldnames = fieldnames(fig_data_summ(i).vel_null_summ.(struct_branch_name{1}));

%             [fig_data_summ(i).avg_vel_null_summ.(struct_branch_name{1}).(tune_curve_fieldname{1}),fig_data_summ(i).sem_vel_null_summ.(struct_branch_name{1}).(tune_curve_fieldname{1})] = ...
%                 doAverageOnStruct(fig_data_summ,{['vel_null_summ'],[struct_branch_name{1}]});
%                 count = count + 7
                [avg,sem] = doAverageOnStruct(fig_data_summ,{['vel_null_summ'],[struct_branch_name{1}]});
                fig_data_summ(i).avg_vel_null_summ.(struct_branch_name{1}) = avg.vel_null_summ.(struct_branch_name{1});
                fig_data_summ(i).sem_vel_null_summ.(struct_branch_name{1}) = sem.vel_null_summ.(struct_branch_name{1});
                count = count + 7;
                disp(count)
        end
    end
    
    save(fullfile(data_location,'..','fig_data_summ'),'fig_data_summ');
    
end

if 0
    
    % load the figure data summary
    load(fullfile(data_location,'..','fig_data_summ.mat'))
    
    % Add an image path and image for later plotting
    image_location = fullfile(data_location,'..','screen_images');
    [img_names,img_filepaths] = returnDirFileList(image_location);
    
    screen_name_file = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/vpn_screen_names';
    load(screen_name_file);
    
    for i = 1:numel(geno_names)

        line_name = fig_data_summ(i).geno_name(1:7);
            
        fig_data_summ(i).img_name = [];
        fig_data_summ(i).img = [];
            
        for kk = 1:numel(img_names)
            vpn_screen_name_ind = 1;
            for name_iter = 1:numel(vpn_screen_names.Stablelinename)
                if ~isempty(strfind(lower(line_name),lower(vpn_screen_names.Stablelinename{name_iter})))
                    vpn_screen_name_ind = name_iter;
                end
            end

            if sum(strfind(img_names{kk},'C1-MAX')) && sum(strfind(img_names{kk},'fA02b')) && sum(strfind(img_names{kk},vpn_screen_names.AD{vpn_screen_name_ind}(1:5))) && sum(strfind(img_names{kk},vpn_screen_names.DBD{vpn_screen_name_ind}(1:5)))
                
                fig_data_summ(i).img_name = img_names{kk};
                fig_data_summ(i).img = imread(img_filepaths{kk},'jpg');
                fig_data_summ(i).AD = vpn_screen_names.AD{vpn_screen_name_ind};
                fig_data_summ(i).DBD = vpn_screen_names.DBD{vpn_screen_name_ind};
            end
        end

    end
    
    save(fullfile(data_location,'..','fig_data_summ'),'fig_data_summ');    
end


if 0
    
    % load the figure data summary
    load(fullfile(data_location,'..','fig_data_summ.mat'))

    pl_name_file = '/Volumes/lacie-temp-external/curated_vpn_telethon_2012_screen/place_learning_scores';
    load(pl_name_file);
    
    for i = 1:numel(geno_names)

        line_name = fig_data_summ(i).geno_name(1:7);
        vpn_screen_name_ind = 0;
        
        for kk = 1:numel(place_learning_scores.Stablelinename)
            if ~isempty(strfind(lower(line_name),lower(place_learning_scores.Stablelinename{kk})))
                vpn_screen_name_ind = kk;
            end
        end
        if ~vpn_screen_name_ind
            fig_data_summ(i).PLI = NaN;
            fig_data_summ(i).mean_turn_vel = NaN;
        else
            fig_data_summ(i).PLI = place_learning_scores.meanPLI(vpn_screen_name_ind);
            fig_data_summ(i).mean_turn_vel = place_learning_scores.meanturnvelocity(vpn_screen_name_ind);
        end

    end
    
    save(fullfile(data_location,'..','fig_data_summ'),'fig_data_summ');    
end
