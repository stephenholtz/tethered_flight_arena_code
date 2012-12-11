% update_endnote_xml_for_papers2_import.m
% This will fix the paths in the endnote xml file so that Papers2 can
% import them across platforms and regardless of location. To be compiled
% and run or cd to the folder and run from matlab 2012a.
% 
% DO NOT CHANGE ANY OF THE PDF FILE NAMES! Let Papers2 do this after
% the import. Allowed to change the name of the xml file, however.
%
% SLH 2012

% Relies on being in the correct directory
new_article_path = pwd;
xml_file = dir(fullfile(pwd,'*.xml'));

% Check for the xml file
if isempty(xml_file); errordlg({'XML file not found in directory!',new_article_path}); return; end

% If all (or any) of the pdfs in the folder are inside of folders, this
% will copy them out
folder_contents = dir(new_article_path);
for i = 1:numel(folder_contents)
    if folder_contents(i).isdir && ~(strcmp(folder_contents(i).name,'.') || strcmp(folder_contents(i).name,'..'))
        inner_files = dir(fullfile(new_article_path,folder_contents(i).name));
        for k = 1:numel(inner_files)
            if ~inner_files(k).isdir
                copyfile(fullfile(new_article_path,folder_contents(i).name,inner_files(k).name),...
                         fullfile(new_article_path,inner_files(k).name));
            end
        end
    end
end

% Read in the file
xml_file_loc = fullfile(new_article_path,xml_file.name);
xml_fid = fopen(xml_file_loc);
xml_text = fgets(xml_fid);
while ~feof(xml_fid)
    xml_text = [xml_text fgets(xml_fid)];
end
fclose(xml_fid);

% Replace the database names (for practice, was not really needed, but
% people might like to change the file name for some reason).
dbn1 = '(<database name="|<databasename=")(?<db_name_1>\w+)(\.(?i)xml")';
[mat, tok_dbn1] = regexp(xml_text,dbn1,'match','tokens');
xml_text = regexprep(xml_text,mat,[tok_dbn1{1}{1}, xml_file.name(1:end-4), tok_dbn1{1}{3}]);

dbn2 = '(\.(?i)xml">)(?<db_name_2>\w+)(\.(?i)xml</database>)';
[mat, tok_dbn2] = regexp(xml_text,dbn2,'match','tokens');
xml_text = regexprep(xml_text,mat,[tok_dbn2{1}{1}, xml_file.name(1:end-4), tok_dbn2{1}{3}]);

% Replace the database path
dbp = '(path="file://localhost|path=")([^">]+)(\.(?i)xml">)';
[mat, tok_dbp] = regexp(xml_text,dbp,'match','tokens');

% I am not sure if this is a difference that matters:
% replacement_string = [tok_dbp{1}{1}, xml_file_loc(1:end-4), tok_dbp{1}{3}];
if isunix
    replacement_string = ['path="file://localhost', xml_file_loc(1:end-4), tok_dbp{1}{3}];
else
    replacement_string = ['path="', xml_file_loc(1:end-4), tok_dbp{1}{3}];    
end

xml_text = regexprep(xml_text,regexptranslate('escape',mat{1}),replacement_string);

% Replace the article file locations (pdf,doc,docx,rtf) html doesn't work
ap = '[^"](file://localhost/|path=")([^">]+)(\.pdf|\.doc|\.docx|\.rtf)';
[mat, tok_ap] = regexp(xml_text,ap,'match','tokens');

for i = 1:numel(mat)
    % fileparts function does not work very well across platforms...
    file_parts_windows = regexp(tok_ap{i}{2},'\','split');
    file_parts_unix = regexp(tok_ap{i}{2},'/','split'); 
    
    % This logic is confusing.
    if sum(strfind(file_parts_windows{end},'/'));
        article_name = file_parts_unix{end};
    else
        article_name = file_parts_windows{end};
    end
    
    % Different versions of Papers use different XML tags
    if isunix
        new_article_loc = fullfile(new_article_path, article_name);
        new_article_loc = new_article_loc(2:end);
    else
        new_article_loc = fullfile(new_article_path, article_name);
    end
    
    xml_text = regexprep(xml_text,regexptranslate('escape',mat{i}),['>',tok_ap{i}{1}, new_article_loc , tok_ap{i}{3}]);
end

% Save over a new xml file.
xml_fid = fopen(xml_file_loc,'w');
res = fprintf(xml_fid,'%s',xml_text);
if ~res; errordlg({'Unable to write to xml file!',xml_file_loc}); end
fclose(xml_fid);