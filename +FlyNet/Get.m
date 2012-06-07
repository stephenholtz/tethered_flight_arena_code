classdef Get
    %GET loads experiments back into class structure for analysis
    %   Needs to be a handle to hold all of the value classes 
    %   Rough functionality, needs refinement -- probably the most
    %   confusing code in the whole lot
    %   logic needs to be added on both ends to dynamically add properties
    
    properties (Access = private)        
        experiment_properties_cols = {'id','experiment_name','assay_type','protocol','date_time','chr2','chr3','effector'};
        trial_properties_cols = {'id','trial_name'};
        trial_cols = {'id', 'experiment_id'};
        data_cols = {'id','data_id','column_count','row_count','data_type'};     
    end
    
    properties
        % Use a placeholder during the construction, then assign it to this
        % property.
        experiment
    end
    
    methods
        function self = Get(db, exp_pks, trial_pks)

            % Populate these experiment classes from the top down.
            % (experiment > trial (if selected) > data)
                
            for i = 1:numel(exp_pks)
                
                % SET UP EXPERIMENT CLASS
                % unsure about getting the first fields back....!!!
                exp_fields = db.query(['SHOW FIELDS FROM experiment']);
                exp_fields = {exp_fields{:,1}};
                
                % Create assay agnostic function calls for the assay specific class
                % structures. Error out if more than one assay type returns
                or_string = ([' "' num2str(exp_pks(1)) '"']);
                for o = 2:numel(exp_pks); or_string = [orstr, ' OR id = "' num2str(exp_pks(o)) '"']; end
                assay_type = {db.query(['SELECT DISTINCT assay_type FROM experiment WHERE id = ' or_string])};
                if numel(assay_type) > 1; 
                    error('More than one assay type returned for selected protocol'); 
                elseif strcmpi(assay_type{1},'No Data')
                    error('No Data returned when checking for assay type consistency');
                end
                %
                switch assay_type{1}
                    case 'tf'
                        Experiment = eval(['tfAnalysis.Experiment']);
                        Trial      = eval(['tfAnalysis.Trial']);
                        Data       = eval(['tfAnalysis.Data']);
                        
                    case 'ff'
                        Experiment = eval(['ffAnalysis.Experiment']);
                        Trial      = eval(['ffAnalysis.Trial']);
                        Data       = eval(['ffAnalysis.Data']);
                        
                    otherwise
                        error('Unrecognized assay type')
                end
                
                dbexp{i} = Experiment;
                % Populate all fields in top level
                for g = 1:numel(exp_fields);
                    if ~strcmp(num2str(exp_fields{g}),'id')
                    exp_row = db.query(['SELECT ' num2str(exp_fields{g}) ' FROM experiment WHERE id = "' num2str(exp_pks(i)) '"']);                
                    dbexp{i} = setfield(dbexp{i},exp_fields{g},exp_row);
                    end
                end
                
                exp_prop_pks = db.query(['SELECT id FROM experiment_property WHERE experiment_id = "' num2str(exp_pks(i)) '"']);
                for h = 1:numel(exp_prop_pks)
                    % may need to break up or beef up the db connector
                    type = db.query(['SELECT type FROM experiment_property WHERE experiment_id = "' num2str(exp_pks(i)) '" AND id = "' num2str(exp_prop_pks(h)) '"']);
                    value = db.query(['SELECT RTRIM(value) FROM experiment_property WHERE experiment_id = "' num2str(exp_pks(i)) '" AND id = "' num2str(exp_prop_pks(h)) '"']);
                    
                    try
                        dbexp{i} = setfield(dbexp{i}, type, db.decode_matrix(value, 'single'));
                    catch
                        dbexp{i} = setfield(dbexp{i}, type, value);
                    end
                
                end
                
                % SET UP TRIAL CLASS
                trial_fields = db.query(['SHOW FIELDS FROM trial']);
                trial_fields = {trial_fields{:,1}};
                
                if isempty(trial_pks)
                    trial_pks = db.query(['SELECT id FROM trial WHERE experiment_id = "' num2str(exp_pks(i)) '"']);
                end
                
                for a = 1:numel(trial_pks)
                    
                    fprintf('Loading trial %d/%d \n', a, numel(trial_pks));
                    
                    dbexp{i}.trial{a} = Trial;
                    
                    for g = 1:numel(trial_fields);
                        if ~strcmp(num2str(trial_fields{g}),self.trial_cols)
                            trial_row = db.query(['SELECT ' num2str(trial_fields{g}) ' FROM trial WHERE id = "' num2str(trial_pks(a)) '"']);                
                            dbexp{i}.trial{a} = setfield(dbexp{i}.trial{a},trial_fields{g},trial_row);
                        end
                    end
                    
                    trial_prop_pks =  db.query(['SELECT id FROM trial_property WHERE trial_id = "' num2str(trial_pks(a)) '"']);
                    for p = 1:numel(trial_prop_pks)
                        type = db.query(['SELECT type FROM trial_property WHERE trial_id = "' num2str(trial_pks(a)) '" AND id = "' num2str(trial_prop_pks(p)) '"']);
                        value = db.query(['SELECT RTRIM(value) FROM trial_property WHERE trial_id = "' num2str(trial_pks(a)) '" AND id = "' num2str(trial_prop_pks(p)) '"']);
                        
                        try
                            dbexp{i}.trial{a} = setfield(dbexp{i}.trial{a}, type, db.decode_matrix(value, 'single'));
                        catch
                            dbexp{i}.trial{a} = setfield(dbexp{i}.trial{a}, type, value);
                        end
                    end
                    
                    % SET UP DATA CLASS
                    
                    fly_ids = db.query(['SELECT DISTINCT(data_id) FROM data WHERE experiment_id = "' num2str(exp_pks(i)) '" AND trial_id = "' num2str(trial_pks(a)) '"']);
                    
                    for d = 1:numel(fly_ids)   
                        
                        dbexp{i}.trial{a}.data{d} = Data;
                                                                    
                        data_pks = db.query(['SELECT id FROM data WHERE experiment_id = "' num2str(exp_pks(i)) '" AND trial_id = "' num2str(trial_pks(a)) '" AND data_id = "' num2str(fly_ids(d)) '"']);
  
                        for q = 1:numel(data_pks)
                            type = db.query(['SELECT type FROM data WHERE id = "' num2str(data_pks(q)) '"']);
                            value = db.query(['SELECT RTRIM(value) FROM data WHERE id = "' num2str(data_pks(q)) '"']);
                        
                            try 
                                dbexp{i}.trial{a}.data{d} = setfield(dbexp{i}.trial{a}.data{d}, type, db.decode_matrix(value, 'single'));
                            catch
                                dbexp{i}.trial{a}.data{d} = setfield(dbexp{i}.trial{a}.data{d}, type, value);
                            end
                        end
                    end
                end                

            end
            
            if numel(dbexp) > 1
                for a = 1:numel(dbexp)
                    self.experiment{a} = dbexp{a};
                end
            else
            self.experiment = dbexp{:};
            end
            
        end
    end
    
end

