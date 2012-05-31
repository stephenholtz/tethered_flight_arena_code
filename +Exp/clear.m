% clear will reset the daq and delete the file in the default save place

% For unixy output
string_length = 60;
string = ('Resetting daq with daqreset');
string = [string, repmat(' ',1,(string_length-numel(string) - 2))];
fprintf(string)
daqreset;
fprintf('[Done]\n')	

location = 'C:\\tf_tmpfs\\9001.daq';
string = (['Checking for file at ',location]);
string = [string, repmat(' ',1,(string_length-numel(string)))];
fprintf(string)

[status result] = dos(['ls ', location]);
	if strfind(result,'No such file or directory')
		fprintf('[Failed]\n')
		return
	else
		fprintf('[Done]\n')
	end
	
string = (['Deleting file at ',location]);
string = [string, repmat(' ',1,(string_length-numel(string)))];
fprintf(string)
[status result] = dos(['rm ', location]);
fprintf('[Done]\n')

		