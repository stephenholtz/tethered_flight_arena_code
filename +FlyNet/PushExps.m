classdef PushExps
    
    properties (Access = private, Constant = true)
        db_name         = 'flynet';
        db_server_name  = 'clustrix';
        
        db_write_user   = 'flynetApp';
        db_write_pass   = 'flyn3tW';
        
        db_admin_user   = 'flynetAdmin';
        db_admin_pass   = 'flyn3tA';
        
        db_driver       = 'com.mysql.jdbc.Driver';
        db_url          = 'jdbc:mysql://clustrix:3306/flynet';      
        
        AllowDuplicateExps = 0;
        
        experiment_table_cols = {'experiment_name','assay_type','protocol','date_time','line_name','effector'};
        data_table_cols =  {'experiment_id','trial_id','data_id','type','value','column_count','row_count','data_type'};
    end
    
    properties (GetAccess = private, SetAccess = public)
        experiment
    end
    
    properties
        % databse object from the database toolbox
        dbObj
    end
    
    methods
        
        function self = PushExps(varargin)
            % Basically the "main" function
            
            currentFolder = pwd;
            onCleanup(@()cd(currentFolder));
            
            % Deal with varargin
            experiment_folder_path = varargin{1};
            
            % call MakedbObj to create the dbObj
            self.dbObj = FlyNet.PushExps.MakedbObj(self);
            onCleanup(@()clear('self.dbObj'));

            % Generate cell array of experiment locations
            % ( For now just one experiment is loaded )
            
            % Load Experiment into memory
            self.experiment = tfAnalysis.import(experiment_folder_path);            
            self.experiment = self.experiment.experiment;
            
            if self.CheckDupExp && ~self.AllowDuplicateExps
                error('Experiment already exists in database')
            end
            
            % call AddExp with the experiment
            self.AddExp
            
            % call CheckAddExp with the experiment
            
            % delete the Experiment from memory
            
            % call CleanUp to close / delete the dbObj
            self.CleanUp
            
        end
        
        function result = CheckDupExp(self)
            result = 0;
        end
        
        function AddExp(self)
            % Insert the experiment table, return the primary key
            datainsert(self.dbObj,  'experiment',...
                                   self.experiment_table_cols,... % {'experiment_name','assay_type','protocol','date_time','line_name','effector'};
                                   {self.experiment{1}.experiment_name,self.experiment{1}.assay_type,self.experiment{1}.protocol,self.experiment{1}.date_time,self.experiment{1}.line_name,self.experiment{1}.effector});
            % TODO: FIX THIS!
            curs = exec(self.dbObj,'SELECT id FROM flynet.experiment ORDER BY id DESC LIMIT 1;');
            experiment_id = fetch(curs); experiment_id = experiment_id.Data{1};
            
            % Insert the misc experiment metadata, no trial id or data id
            experiment_fields = fieldnames(self.experiment{1});
            remaining_fields = setdiff(experiment_fields,[self.experiment_table_cols, 'trial']);
            
            % Data table:
            % id experiment_id trial_id data_id type value column_count row_count data_type
            
            data_id  = 0;
            trial_id = 0;
            
% % Failed attempts....
% %             datainsert(self.dbObj,  'trial',...
% %                                    {'experiment_id' 'trial_name'},...
% %                                    {experiment_id '0'});
% %
% %             datainsert(self.dbObj,  'data', {'experiment_id', 'trial_id', 'data_id', 'type', 'value', 'column_count', 'row_count', 'data_type'},{2,0,0,'humidity_ambient',63,1,1,'double'});
% % 
% %             curs = exec(self.dbObj,['set foreign_key_checks = 0; load data local infile '...
% %                     ' ''' temp_bulk_file ''' into table flynet.data '...
% %                     'fields terminated by ''\t'' lines terminated '...
% %                     'by ''\n''']);
% %             for field = remaining_fields;
% %                 experiment_data.(field{1}) = getfield(self.experiment{1},field{1});
% %             end
% %             
% %             fastinsert(self.dbObj, 'data', self.data_table_cols,experiment_data);
            
            % there exists no good way to vectorize our generalized type
            % value system as of ver 2012a... writing to txt and uploading
            % is the most effecient
            
            switch computer
                case 'MACI64'
                    try
                        temp_bulk_file = '/Users/holtzs/flynet_bulk_temp.txt';
                    catch
                        temp_bulk_file = '/Users/groverd/flynet_bulk_temp.txt';
                    end
                case {'PCWIN','PCWIN64'}
                    try
                        temp_bulk_file = 'D:\flynet_bulk_temp.txt';
                    catch
                        temp_bulk_file = 'C:\flynet_bulk_temp.txt';
                    end
            end
            
%             fid = fopen(temp_bulk_file,'w');
%             curs = exec(self.dbObj,'SELECT id FROM flynet.data ORDER BY id DESC LIMIT 1;');
%             id = fetch(curs); id = id.Data{1};
%            
%             for field = remaining_fields;
%                 temp_data = getfield(self.experiment{1},field{1});
%                 id = id + 1;
%                 switch class(temp_data)
%                     case 'char'
%                         fprintf(fid,'%d \t %d \t %d \t %d \t %s \t %s \t %d \t %d \t %s \n',id,experiment_id,trial_id,data_id,field{1},temp_data,size(temp_data,2),size(temp_data,1),class(temp_data));
%                     case 'double'
%                         fprintf(fid,'%d \t %d \t %d \t %d \t %s \t %d \t %d \t %d \t %s \n',id,experiment_id,trial_id,data_id,field{1},temp_data,size(temp_data,2),size(temp_data,1),class(temp_data));
%                 end
%             end
%             
%             fclose(fid);
%             
%             curs = exec(self.dbObj,['load data local infile '...
%                     ' ''' temp_bulk_file ''' into table flynet.data '...
%                     'fields terminated by ''\t'' lines terminated '...
%                     'by ''\n''']);
%                 
%             if ~isempty(curs.Message)
%                 disp(curs.Message)
%                 error('Failed writing database from text file...')
%             end
            
            % Iterate over the trials
            text_file_write_handle = tic;
            fid = fopen(temp_bulk_file,'w');
            for trial_num = 1:numel(self.experiment{1}.trial)

                curs = exec(self.dbObj,'SELECT id FROM flynet.data ORDER BY id DESC LIMIT 1;');
                id = fetch(curs); id = id.Data{1};
                
                % Add the trial name from the trial level first
%                 trial_name_type = 'trial_name';
%                 trial_name = self.experiment{1}.trial{trial_num}.trial_name;
%                 fprintf(fid,'%d \t %d \t %d \t %d \t %s \t %s \t %d \t %d \t %s \n',id,experiment_id,trial_id,data_id,trial_name_type,trial_name,size(trial_name,2),size(trial_name,1),class(trial_name));
%                 id = id + 1;
                data_fields = fieldnames(self.experiment{1}.trial{trial_num});
                data_fields = setdiff(data_fields,'data'); % ignore this dude
                
                for field = data_fields(:)';
                    temp_data = getfield(self.experiment{1}.trial{trial_num},field{1});
                    id = id + 1;
                    switch class(temp_data)
                        case 'char'
                            fprintf(fid,'%d \t %d \t %d \t %d \t %s \t %s \t %d \t %d \t %s \n',id,experiment_id,trial_id,data_id,field{1},temp_data,size(temp_data,2),size(temp_data,1),class(temp_data));
                        case 'double'
                            fprintf(fid,'%d \t %d \t %d \t %d \t %s \t %d \t %d \t %d \t %s \n',id,experiment_id,trial_id,data_id,field{1},temp_data,size(temp_data,2),size(temp_data,1),class(temp_data));
                    end
                end
                
                for data_ind = 1:numel(self.experiment{1}.trial{trial_num}.data)
                    data_fields = fieldnames(self.experiment{1}.trial{trial_num}.data{data_ind});
%                         try
                    for field = data_fields(:)';
                        if self.experiment{1}.trial{trial_num}.data{data_ind}.isvalid
                        temp_data = getfield(self.experiment{1}.trial{trial_num}.data{data_ind},field{1});
                        id = id + 1;
                            switch class(temp_data)
                                case 'char'
                                    fprintf(fid,'%d \t %d \t %d \t %d \t %s \t %s \t %d \t %d \t %s \n',id,experiment_id,trial_id,data_id,field{1},temp_data,size(temp_data,2),size(temp_data,1),class(temp_data));
                                case 'double'
                                    fprintf(fid,'%d \t %d \t %d \t %d \t %s \t %d \t %d \t %d \t %s \n',id,experiment_id,trial_id,data_id,field{1},temp_data,size(temp_data,2),size(temp_data,1),class(temp_data));
                            end
                        end
                    end
%                     catch
%                         toc(text_file_write_handle)
%                         toc(text_file_write_handle)
%                     end
                end
            end
            fclose(fid);
            toc(text_file_write_handle)
            
            % Insert the trial data (no data id) and data (with data id)
            curs = exec(self.dbObj,['load data local infile '...
                    ' ''' temp_bulk_file ''' into table flynet.data '...
                    'fields terminated by ''\t'' lines terminated '...
                    'by ''\n''']);
            
            if ~isempty(curs.Message)
                disp(curs.Message)
                error('Failed writing database from text file...')
            end            

        end
        
        function CleanUp(self)
        end
        
    end
    
    methods (Static)
        function dbObj = MakedbObj(PushExpsObj)
            % Make sure the path to the connector is added to the java path
            flynet_info = what('FlyNet'); % Will possibly return two locs..
            dbConnPath = fullfile(flynet_info.path, 'database_files', 'mysql-connector-java-5.1.13', 'mysql-connector-java-5.1.13-bin.jar');
            javaaddpath(dbConnPath);
            
            % Create the database object
            dbObj = database(PushExpsObj.db_name,...
                        PushExpsObj.db_write_user,...
                        PushExpsObj.db_write_pass,...
                        PushExpsObj.db_driver,...                
                        PushExpsObj.db_url);
        end
    end
    
end