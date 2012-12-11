function fix_free_flight_metadata(experiment_folder,field,value)
%function fix_free_flight_metadata(experiment_folder[string],field[string],value[string])
% Fix free flight metadata files iteratively! It will replace the value of
% the field after the semicolon with the value passed.

testing_flag = 0; %Write a metadata_TEST.txt file instead of overwriting the old one!
exp_trial_folders = dir(fullfile(experiment_folder,'*-*')); % All trials have a dash in them
close all force

    % Iterate over all the trial folders in an experiment
    for trial = 1:numel(exp_trial_folders)
        
        metadata_file=fullfile(experiment_folder,exp_trial_folders(1).name,'metadata.txt');
        if ~exist(metadata_file,'file'); error('Metadata file does not exist'); end

        fid = fopen(metadata_file,'r');
        if (fid == -1); error('File open error'); end

        i = 1;
        text_array{i} = fgets(fid); %#ok<*AGROW>
        while text_array{i} ~= -1
            i = i+1;
            text_array{i} = fgets(fid);
        end
        
        fclose(fid);
        fprintf('Read file %s\n',metadata_file);
        
        % Now replace the proper field's cell array with the value passed.
        found_ind = [];
        for i = 1:numel(text_array)
            found = (strfind(text_array{i},field));
            if sum(found)
                found_ind = [found_ind i];
            end
        end

        if numel(found_ind) > 1
            error('found too many field matches!')
        end

        temp_text = regexp(text_array{found_ind},'\:\s','split');
        fprintf('Text line = %s \nReplacing "%s" with "%s" \n',text_array{found_ind}(1:end-2),temp_text{2}(1:end-2),value)
        text_array{found_ind} = [temp_text{1} char(58) char(32) value char(32) char(13) char(10)];

        fprintf('Writing...');
                
        if testing_flag
            metadata_file = [metadata_file(1:end-4) '_TEST.txt']; %#ok<*UNRCH>
            fprintf('to test file...');
        end
        
        % Open a file and write to it
        fid = fopen(metadata_file,'w');
        
        for i = 1:numel(text_array)
            fwrite(fid,text_array{i});
        end
        
        fclose(fid);
        
        fprintf(' Done!\n')
    end
end