classdef janelia_db_interface < handle
    % JANELIA_DB_INTERFACE
    % provides functionality to connect to the mysql database in the Janelia
    % network. Requires the mysql JDBC driver to be working in Matlab (see
    % Matlab doc). 
    % Returns handle to the database object
    %
    % Nikolay Kladt, February 2010
    % encode and decode matrix functions from Fly-Olympiad code.
    % requires database toolbox.
    
    properties
        % DATABASE CREDENTIALS
        dbUser = '';        %'tethered_flightApp';
        dbPass  = '';       %'tfl1ghtW';
        dbDriver = '';      %'com.mysql.jdbc.Driver';
        dataBase = '';      % 'jdbc:mysql://10.40.4.71:3306/tethered_flight' 'jdbc:mysql://localhost:3306/slh'; 
        % HANDLE TO CREATED CONNECTION
        connection
    end
    
    methods
        function obj = janelia_db_interface(username,password,driver,db)
            % CONSTRUCTOR METHOD
            % initialize database connection by passing user,pass,database
            % and driver, then make a connection.
            obj.dbUser = username;
            obj.dbPass = password;
            obj.dataBase = db;
            obj.dbDriver = driver;
            logintimeout(5);
            obj.connection = database('',obj.dbUser,obj.dbPass,obj.dbDriver,obj.dataBase);
        end
        
        function [status,result] = query(obj,query)
            % QUERY perform a SQL query
            % input: valid sql-query
            % output: status of query (1 or Error in SQLQuery: ...), result
            % either empty in case of error or whatever the query results
            % in. result may be cell or var.
            curs = exec(obj.connection, query);
            if curs.Message
                status = ['Error in SQLQuery: ' curs.Message];
                result = [];
            else
                pt = fetch(curs);
                if iscell(pt.Data)
                    result = cell2mat(pt.Data); 
                    status = 1; 
                else
                    result = pt.Data;
                    status = 1;
                end
                            close(curs);       
            end
%                             close(curs);       
        end 
        
        function [encoded, data_type] = encode_matrix(obj,data, data_type)
            %ENCODE_MATRIX Convert a 2-D matrix to a string.
            %   ENCODE_MATRIX(M), where M is a matrix, returns a string representation of
            %   M that is as compact as possible without losing any precision.  The
            %   elements of the matrix are formatted at a fixed width to allow indexing
            %   into the string.  The format and precision of the elements are determined
            %   by the contents of the matrix.
            %
            %   ENCODE_MATRIX(M, T), where T is a string, behaves the same as
            %   ENCODE_MATRIX(M) except that the format and precision are specified by
            %   the type T.  Valid values for T are 'double', 'single', 'half', 'int8',
            %   'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64' and 'uint64'.

            % Half-precision float
            % - sign character
            % - 5 decimal digits to capture full precision (11 bits)
            % - exponent needs up to 4, e.g. "e-12"
            % - one character delimiter
            % = 12 characters per float (compared to 2 bytes native)
            % 
            % Single-precision float
            % - sign character
            % - 9 decimal digits to capture full precision (24 bits)
            % - exponent needs up to 5, e.g. "e-123"
            % - one character delimiter
            % = 17 characters per float (compared to 4 bytes native)
            % 
            % Double-precision float
            % - sign character
            % - 17 decimal digits to capture full precision (53 bits)
            % - exponent needs up to 6, e.g. "e-1234"
            % - one character delimiter
            % = 26 characters per float (compared to 8 bytes native)
            %
            % Byte
            % - sign character
            % - 3 decimal digits to capture full range (8 bits)
            % - one character delimiter
            % = 5 characters per int (compared to 1 bytes native)
            %
            % Integer
            % - sign character
            % - 5 decimal digits to capture full range (16 bits)
            % - one character delimiter
            % = 7 characters per int (compared to 2 bytes native)
            %
            % Long
            % - sign character
            % - 10 decimal digits to capture full range (32 bits)
            % - one character delimiter
            % = 12 characters per long (compared to 4 bytes native)
            %
            % Long long
            % - sign character
            % - 20 decimal digits to capture full range (64 bits)
            % - one character delimiter
            % = 22 characters per long long (compared to 8 bytes native)

            if ~isnumeric(data)
                error('only numeric data is supported');
            else
            if nargin < 2
                % Determine the type of data to encode.
                if isa(data, 'double')
                    data_type = 'double';
                elseif isa(data, 'single')
                    data_type = 'single';
                else
                    % Find the most compact representation of the integer data.
                    data_min = min(data);
                    data_mag = max(abs([data_min max(data)]));
                    if data_min < 0
                        for bits = [8 16 32 64]
                            if data_mag < 2^(bits - 1)
                                data_type = sprintf('int%d', bits);
                                break
                            end
                        end
                    else
                        for bits = [8 16 32 64]
                            if data_mag < 2^bits
                                data_type = sprintf('uint%d', bits);
                                break
                            end
                        end
                    end
                end
            end

            [rows, cols] = size(data);
            if strcmp(data_type, 'double')
                str_format = '%25.16e ';
                format_width = 26;
            elseif strcmp(data_type, 'single')
                str_format = '%16.8e ';
                format_width = 17;
            elseif strcmp(data_type, 'half')
                str_format = '%11.4e ';
                format_width = 12;
            else
                % It's an integer format.
                if strcmp(data_type, 'int8')
                    str_format = '%4d ';
                    format_width = 5;
                elseif strcmp(data_type, 'uint8')
                    str_format = '%3d ';
                    format_width = 4;
                elseif strcmp(data_type, 'int16')
                    str_format = '%6d ';
                    format_width = 7;
                elseif strcmp(data_type, 'uint16')
                    str_format = '%5d ';
                    format_width = 6;
                elseif strcmp(data_type, 'int32')
                    str_format = '%11d ';
                    format_width = 12;
                elseif strcmp(data_type, 'uint32')
                    str_format = '%10d ';
                    format_width = 11;
                elseif strcmp(data_type, 'int64')
                    str_format = '%21d ';
                    format_width = 22;
                elseif strcmp(data_type, 'uint64')
                    str_format = '%20d ';
                    format_width = 21;
                else
                    error(['Cannot encode matrices with type ''' data_type '''']);
                end
                % Make sure the data is integer or sprintf will still show fractional digits.
                % TBD: Raise an error if the data will be truncated?  For
                %      example, 300 @ uint8 = 255.  Will only happen when user
                %      specifies the type.
                if ~isinteger(data)
                    eval(strcat('data = ', data_type, '(data);'));
                end
            end
        
            % Pre-allocate the array.
            row_width = format_width * cols;
            buffer(1, rows * row_width) = ' ';
        
            % Build each row.
            % TBD: Would it be faster to do a single sprintf call for the
            %      entire matrix and then insert CR's at the right places?
            for r = 1:rows
                start_pos = (r - 1) * row_width + 1;
                end_pos = start_pos + row_width - 1;
                buffer(1, start_pos:end_pos) = sprintf(str_format, data(r, :));
                buffer(1, end_pos) = char(13);
            end
            encoded = buffer;
            end
        end
        
        function decoded = decode_matrix(obj,data, data_type)
 %DECODE_MATRIX Convert a string to a 2-D matrix.
%   DECODE_MATRIX(S, T), where S and T are strings, returns the matrix that
%   was encoded in the string by encode_matrix.  T specifies the type of
%   data in the matrix and must be one of 'double', 'single', 'half',
%   'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64' and
%   'uint64'.

    if ~ischar(data)
        error('The data passed to decode_matrix must be a string generated by encode_matrix.');
    elseif ~strcmp(data(end), char(13))
        error('The data passed to decode_matrix must be terminated by a newline.');
    else
        if any(strcmp(data_type, {'double', 'single'}))
            str_format = '%e';
        elseif strcmp(data_type, 'half')
            % MATLAB doesn't have a half precision type so use single
            % instead.
            str_format = '%e';
            data_type = 'single';
        elseif any(strcmp(data_type, {'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64', 'uint64'}))
            str_format = '%d';
        else
            error(['Cannot decode matrices with type ''' data_type '''']);
        end
        
        decoded = sscanf(data, str_format);
        rows = length(strfind(data, char(13)));
        cols = length(decoded) / rows;
        if fix(cols) ~= cols
            error('The data does not represent a full matrix.');
        end
        decoded = reshape(decoded, cols, rows)';
        if ~strcmp(data_type, 'double')
            eval(strcat('decoded = ', data_type, '(decoded);'))
        end
    end
end
    end
end


