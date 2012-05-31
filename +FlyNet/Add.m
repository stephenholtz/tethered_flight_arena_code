classdef Add
    % Add class remaps the class structure from FlightAnalysis to push it
    % to the database.
    % The object passed to the constructor class and its object arrays
    % determines how many fields
    properties (Constant)
        % Several fields are needed in each of the tables. The other fields
        % are type/value combinations listed in the experiment object
        experiment_properties_cols = {'id','experiment_name','assay_type','protocol','date_time','chr2','chr3','effector'};
        trial_properties_cols = {'id','trial_name'};
        data_cols = {'id','data_id','column_count','row_count','data_type'};     
    end
    
    properties (Access = private)
        % Needed for fk (foreign key) references
        experiment_id
        trial_id
        
        
    end
    
    % Debugging properties
    properties
        query_counter
        
    end
    
    methods
        function self = Add(experiment_object)
            % Make the credentials load regardless of location            
            flynet_info = what('FlyNet');
            self.query_counter = 0;
            
            try
                % There may be more than one file (i.e. a backup) of
                % dbCredentials.mat
                if numel(flynet_info.path) > 1
                    flynet_path = flynet_info(1).path;
                else
                    flynet_path = flynet_info.path;
                end
                cred = [flynet_path filesep 'dbCredentials.mat'];
                load(cred);
            catch dbCredErr                
                disp('Cannot find dbCredentials.mat in FlyNet package');
                error(dbCredErr.message);
            end
            db = FlyNet.database_janelia(dbCredentials);
            self.query_counter = self.query_counter+1;
            
            self.experiment_id = FlyNet.Add.get_new_pk(db,'experiment');
            experiment = experiment_object.experiment{1};
            skip = add_experiment(self,db,experiment);
            
            if ~skip
            for i = 1:numel(experiment.trial)
                self.trial_id = FlyNet.Add.get_new_pk(db,'trial');
                add_trial(self,db,experiment.trial{i});
                for g = 1:numel(experiment.trial{i}.data)
                add_data(self,db,experiment.trial{i}.data{g});
                end
            end
            end
        end
        
        function skip = add_experiment(self,db,experiment)
        % Add to the experiment table
            skip = 0;
            res = db.query(['SELECT COUNT(*)'...
                              ' FROM experiment '...
                    ' WHERE experiment_name = "'  experiment.experiment_name '" AND ' ...
                            'assay_type = "'      experiment.assay_type      '" AND ' ...
                            'protocol = "'        experiment.protocol        '" AND ' ...
                            'date_time = "'       experiment.date_time       '" AND ' ...
                            'chr2 = "'            experiment.chr2            '" AND ' ...
                            'chr3 = "'            experiment.chr3            '" AND ' ...
                            'effector = "'        experiment.effector '"']);
            self.query_counter = self.query_counter+1;
            if res ~= 0
                skip = 1;
                str = ['exp:' experiment.experiment_name ' exists in FlyNet!'];
                disp(str);
            else
                str = ['exp:' experiment.experiment_name ' does not exist in FlyNet!'];                
                disp(str);
            end
            if skip == 0;                     
                db.query(['INSERT INTO experiment(  id,' ...
                                                    'experiment_name,'...
                                                    'assay_type,'...
                                                    'protocol,'...
                                                    'date_time,'...
                                                    'chr2,'...
                                                    'chr3,'...
                                                    'effector)'...
                                         'VALUES("' self.experiment_id         '","' ...
                                                    experiment.experiment_name '","' ...
                                                    experiment.assay_type      '","' ...
                                                    experiment.protocol        '","' ...
                                                    experiment.date_time       '","' ...
                                                    experiment.chr2            '","' ...
                                                    experiment.chr3            '","' ...
                                                    experiment.effector '")']);
                self.query_counter = self.query_counter+1;
                
                % The experiment_property table has type/val fields
                fields = properties(experiment);            
                for i = 1:numel(fields)
                if ~sum(strcmp(fields{i},self.experiment_properties_cols)) && ~strcmp(fields{i},'trial')
                experiment_property_pk = FlyNet.Add.get_new_pk(db,'experiment_property');

                [type value] = FlyNet.Add.get_encoded_type_value(db,experiment,fields{i});

                    db.query(['INSERT INTO experiment_property( id,', ...
                                                            'experiment_id,',...
                                                            'type,',...
                                                            'value)',...
                                                ' VALUES("' experiment_property_pk          '","', ...
                                                            self.experiment_id              '","',...
                                                            type    '","',...
                                                            value '")']);    
                end
                end
            end
        end
        
        function add_trial(self,db,trial)
            % Get the latest experiment pk number to increment.
            db.query(['INSERT INTO trial(id,' ...
                                         'experiment_id,'...
                                         'trial_name)'...
                                ' VALUES("' self.trial_id                   '","' ...
                                            self.experiment_id              '","' ...
                                            trial.trial_name                '")']);
            self.query_counter = self.query_counter+1;                                        
            % as long as the names here are the same as in the database,
            % and in the struct/object you pass, no need to map again.
            fields = properties(trial);
            for i = 1:numel(fields)
            if ~sum(strcmp(fields{i},self.trial_properties_cols)) && ~strcmp(fields{i},'data');
            id = FlyNet.Add.get_new_pk(db,'trial_property');
            self.query_counter = self.query_counter+1;
            
            [type value] = FlyNet.Add.get_encoded_type_value(db,trial,fields{i});
            self.query_counter = self.query_counter+1;
            db.query(['INSERT INTO trial_property(id,' ...
                                                'trial_id,'...
                                                'type,'...
                                                'value)'...
                                     'VALUES("' id                          '","' ...
                                                self.trial_id               '","' ...
                                                type                        '","',...
                                                value                       ' ")']);            
            self.query_counter = self.query_counter+1;
            end
            
            end
        end
        
        function add_data(self,db,data)
            fields = properties(data);
            for i = 1:numel(fields)
            if ~sum(strcmp(fields{i},self.data_cols));
            id = FlyNet.Add.get_new_pk(db,'data');
            
            [type value] = FlyNet.Add.get_encoded_type_value(db,data,fields{i});
            self.query_counter = self.query_counter+1;
            
            db.query(['INSERT INTO data        (id,' ...
                                                'experiment_id,'...
                                                'trial_id,'...
                                                'data_id,'...
                                                'column_count,'...
                                                'row_count,'...
                                                'data_type,'...
                                                'type,'...
                                                'value)'...
                                     ' VALUES("' id                        '","', ...
                                                self.experiment_id         '","', ...
                                                self.trial_id              '","', ...
                                                data.data_id                '","', ...
                                                data.column_count          '","', ...
                                                data.row_count             '","', ...
                                                data.data_type             '","', ...
                                                type                       '","',...
                                                value                      ' ")']);            
            self.query_counter = self.query_counter+1;
            end
            end
        end
    end
    
    methods(Static)
        
        function pk = get_new_pk(db,table)
            % returns a new pk for whatever table is queried
            pk = db.query(['SELECT id FROM ' table '  ORDER BY id DESC LIMIT 1']);
            if strcmpi(pk, 'No Data')
                pk = 1;
            else
                pk = pk + 1;
            end            
            pk = num2str(pk);
        end
        
        function pk = get_pk(db,table)
            % returns the pk for whatever table is queried
            pk = db.query(['SELECT id FROM ' table '  ORDER BY id DESC LIMIT 1']);
            if strcmpi(pk, 'No Data')
                error('Unable to retrieve primary key in query')          
            end
            pk = num2str(pk);
        end
        
        function [type value] = get_encoded_type_value(db,struct,field)
                % get type
                type = field;
                % get value
                value = getfield(struct,field);
                [rows, cols] = size(value);
                try
                    if isempty(value); 
                        value = 'null';
                    elseif  ischar(value);
                    elseif  iscell(value) && rows == 1 && isnumeric(value{1});
                        value = [value{:}]*1000;
                        value = db.encode_matrix(value, 'single');
                    elseif  iscell(value) && isnumeric(value{1});
                        value = value{:}*1000;
                        value = db.encode_matrix(value{:}, 'single');
                    elseif iscell(value) && ischar(value{1});
                        value = [value{:}];
                    elseif  isnumeric(value);
                        value = value*1000;
                        value = db.encode_matrix(value, 'single');    
                    else
                        error('Odd value field content');
                    end
                catch encoding_error
                    disp(encoding_error.message)
                    rethrow(encoding_error)
                end
        end
    end
end