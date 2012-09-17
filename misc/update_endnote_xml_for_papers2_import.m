% update_endnote_xml_for_papers2_import.m
% This will fix the paths in the endnote xml file so that Papers2 can
% import them across platforms and regardless of location. To be compiled
% and run or cd to the folder and run from matlab 2012a.
% 
% DO NOT CHANGE ANY OF THE PDF FILE NAMES! Let Papers2 do this after
% the import. Allowed to change the name of the xml file, however.
%
% This relies on two functions from the file exchange: struct2xml and
% xml2struct these are included here commented for completeness
%
% SLH 2012

% Relies on being in the correct directory
new_article_path = pwd;
xml_file = dir(fullfile(pwd,'*.xml'));

% Check for the xml file, import if exists
if isempty(xml_file); errordlg({'XML file not found in directory!',new_article_path}); return; end
doc = xml2struct(xml_file(1).name);

% iterate over all papers, seems to crash after 1k papers...
if numel(doc.xml.records.record) > 1
    for i = 1:numel(doc.xml.records.record)

        % Use new file location (and name)
        doc.xml.records.record{i}.database.Attributes.path = fullfile(new_article_path,xml_file(1).name);
        doc.xml.records.record{i}.database.Attributes.name = xml_file(1).name;

        % Use new article location
        old_article_loc = doc.xml.records.record{i}.urls.pdf_dash_urls.url.style.Text;
        [~,article_name,article_extension] = fileparts(old_article_loc);
        doc.xml.records.record{i}.urls.pdf_dash_urls.url.style.Text = ...
            fullfile('file://localhost/',new_article_path,[article_name article_extension]);
    end
else

    % Use new file location (and name)
    doc.xml.records.record.database.Attributes.path = fullfile(new_article_path,xml_file(1).name);
    doc.xml.records.record.database.Attributes.name = xml_file(1).name;

    % Use new article location, some cross platform junk here
    try
        old_article_loc = doc.xml.records.record.pdf_dash_urls.url.style.Text;        
        structure = 1;
    catch
        old_article_loc = doc.xml.records.record.urls.pdf_dash_urls.url.style.Text;
        structure = 2;
    end
    
    [~,~,article_extension] = fileparts(old_article_loc);
    file_parts = regexp(old_article_loc,'/|\','split');    
    article_name = file_parts{end};
    
    if structure == 1;
        doc.xml.records.record.pdf_dash_urls.url.style.Text = ...
            fullfile('file://localhost/',new_article_path,article_name);
    else
        doc.xml.records.record.urls.pdf_dash_urls.url.style.Text = ...
            fullfile('file://localhost/',new_article_path,article_name);        
    end
    
end

% move old xml file to 'old_xml_file'
mkdir('old_xml_file')
movefile(xml_file(1).name,'old_xml_file')
struct2xml(doc,xml_file(1).name)

clear all force

% function varargout = struct2xml( s, varargin )
% %Convert a MATLAB structure into a xml file 
% % [ ] = struct2xml( s, file )
% % xml = struct2xml( s )
% %
% % A structure containing:
% % s.XMLname.Attributes.attrib1 = "Some value";
% % s.XMLname.Element.Text = "Some text";
% % s.XMLname.DifferentElement{1}.Attributes.attrib2 = "2";
% % s.XMLname.DifferentElement{1}.Text = "Some more text";
% % s.XMLname.DifferentElement{2}.Attributes.attrib3 = "2";
% % s.XMLname.DifferentElement{2}.Attributes.attrib4 = "1";
% % s.XMLname.DifferentElement{2}.Text = "Even more text";
% %
% % Will produce:
% % <XMLname attrib1="Some value">
% %   <Element>Some text</Element>
% %   <DifferentElement attrib2="2">Some more text</Element>
% %   <DifferentElement attrib3="2" attrib4="1">Even more text</DifferentElement>
% % </XMLname>
% %
% % Please note that the following strings are substituted
% % '_dash_' by '-', '_colon_' by ':' and '_dot_' by '.'
% %
% % Written by W. Falkena, ASTI, TUDelft, 27-08-2010
% % On-screen output functionality added by P. Orth, 01-12-2010
% % Multiple space to single space conversion adapted for speed by T. Lohuis, 11-04-2011
% % Val2str subfunction bugfix by H. Gsenger, 19-9-2011
%     
%     if (nargin ~= 2)
%         if(nargout ~= 1 || nargin ~= 1)
%             error(['Supported function calls:' sprintf('\n')...
%                    '[ ] = struct2xml( s, file )' sprintf('\n')...
%                    'xml = struct2xml( s )']);
%         end
%     end
% 
%     if(nargin == 2)
%         file = varargin{1};
% 
%         if (isempty(file))
%             error('Filename can not be empty');
%         end
% 
%         if (isempty(strfind(file,'.xml')))
%             file = [file '.xml'];
%         end
%     end
%     
%     if (~isstruct(s))
%         error([inputname(1) ' is not a structure']);
%     end
%     
%     if (length(fieldnames(s)) > 1)
%         error(['Error processing the structure:' sprintf('\n') 'There should be a single field in the main structure.']);
%     end
%     xmlname = fieldnames(s);
%     xmlname = xmlname{1};
%     
%     %substitute special characters
%     xmlname_sc = xmlname;
%     xmlname_sc = strrep(xmlname_sc,'_dash_','-');
%     xmlname_sc = strrep(xmlname_sc,'_colon_',':');
%     xmlname_sc = strrep(xmlname_sc,'_dot_','.');
% 
%     %create xml structure
%     docNode = com.mathworks.xml.XMLUtils.createDocument(xmlname_sc);
% 
%     %process the rootnode
%     docRootNode = docNode.getDocumentElement;
% 
%     %append childs
%     parseStruct(s.(xmlname),docNode,docRootNode,[inputname(1) '.' xmlname '.']);
% 
%     if(nargout == 0)
%         %save xml file
%         xmlwrite(file,docNode);
%     else
%         varargout{1} = xmlwrite(docNode);
%     end  
% end
% 
% % ----- Subfunction parseStruct -----
% function [] = parseStruct(s,docNode,curNode,pName)
%     
%     fnames = fieldnames(s);
%     for i = 1:length(fnames)
%         curfield = fnames{i};
%         
%         %substitute special characters
%         curfield_sc = curfield;
%         curfield_sc = strrep(curfield_sc,'_dash_','-');
%         curfield_sc = strrep(curfield_sc,'_colon_',':');
%         curfield_sc = strrep(curfield_sc,'_dot_','.');
%         
%         if (strcmp(curfield,'Attributes'))
%             %Attribute data
%             if (isstruct(s.(curfield)))
%                 attr_names = fieldnames(s.Attributes);
%                 for a = 1:length(attr_names)
%                     cur_attr = attr_names{a};
%                     
%                     %substitute special characters
%                     cur_attr_sc = cur_attr;
%                     cur_attr_sc = strrep(cur_attr_sc,'_dash_','-');
%                     cur_attr_sc = strrep(cur_attr_sc,'_colon_',':');
%                     cur_attr_sc = strrep(cur_attr_sc,'_dot_','.');
%                     
%                     [cur_str,succes] = val2str(s.Attributes.(cur_attr));
%                     if (succes)
%                         curNode.setAttribute(cur_attr_sc,cur_str);
%                     else
%                         disp(['Warning. The text in ' pName curfield '.' cur_attr ' could not be processed.']);
%                     end
%                 end
%             else
%                 disp(['Warning. The attributes in ' pName curfield ' could not be processed.']);
%                 disp(['The correct syntax is: ' pName curfield '.attribute_name = ''Some text''.']);
%             end
%         elseif (strcmp(curfield,'Text'))
%             %Text data
%             [txt,succes] = val2str(s.Text);
%             if (succes)
%                 curNode.appendChild(docNode.createTextNode(txt));
%             else
%                 disp(['Warning. The text in ' pName curfield ' could not be processed.']);
%             end
%         else
%             %Sub-element
%             if (isstruct(s.(curfield)))
%                 %single element
%                 curElement = docNode.createElement(curfield_sc);
%                 curNode.appendChild(curElement);
%                 parseStruct(s.(curfield),docNode,curElement,[pName curfield '.'])
%             elseif (iscell(s.(curfield)))
%                 %multiple elements
%                 for c = 1:length(s.(curfield))
%                     curElement = docNode.createElement(curfield_sc);
%                     curNode.appendChild(curElement);
%                     if (isstruct(s.(curfield){c}))
%                         parseStruct(s.(curfield){c},docNode,curElement,[pName curfield '{' num2str(c) '}.'])
%                     else
%                         disp(['Warning. The cell ' pName curfield '{' num2str(c) '} could not be processed, since it contains no structure.']);
%                     end
%                 end
%             else
%                 %eventhough the fieldname is not text, the field could
%                 %contain text. Create a new element and use this text
%                 curElement = docNode.createElement(curfield_sc);
%                 curNode.appendChild(curElement);
%                 [txt,succes] = val2str(s.(curfield));
%                 if (succes)
%                     curElement.appendChild(docNode.createTextNode(txt));
%                 else
%                     disp(['Warning. The text in ' pName curfield ' could not be processed.']);
%                 end
%             end
%         end
%     end
% end
% 
% %----- Subfunction val2str -----
% function [str,succes] = val2str(val)
%     
%     succes = true;
%     str = [];
%     
%     if (isempty(val))
%         return; %bugfix from H. Gsenger
%     elseif (ischar(val))
%         %do nothing
%     elseif (isnumeric(val))
%         val = num2str(val);
%     else
%         succes = false;
%     end
%     
%     if (ischar(val))
%         %add line breaks to all lines except the last (for multiline strings)
%         lines = size(val,1);
%         val = [val char(sprintf('\n')*[ones(lines-1,1);0])];
%         
%         %transpose is required since indexing (i.e., val(nonspace) or val(:)) produces a 1-D vector. 
%         %This should be row based (line based) and not column based.
%         valt = val';
%         
%         remove_multiple_white_spaces = true;
%         if (remove_multiple_white_spaces)
%             %remove multiple white spaces using isspace, suggestion of T. Lohuis
%             whitespace = isspace(val);
%             nonspace = (whitespace + [zeros(lines,1) whitespace(:,1:end-1)])~=2;
%             nonspace(:,end) = [ones(lines-1,1);0]; %make sure line breaks stay intact
%             str = valt(nonspace');
%         else
%             str = valt(:);
%         end
%     end
% end

% function [ s ] = xml2struct( file )
% %Convert xml file into a MATLAB structure
% % [ s ] = xml2struct( file )
% %
% % A file containing:
% % <XMLname attrib1="Some value">
% %   <Element>Some text</Element>
% %   <DifferentElement attrib2="2">Some more text</Element>
% %   <DifferentElement attrib3="2" attrib4="1">Even more text</DifferentElement>
% % </XMLname>
% %
% % Will produce:
% % s.XMLname.Attributes.attrib1 = "Some value";
% % s.XMLname.Element.Text = "Some text";
% % s.XMLname.DifferentElement{1}.Attributes.attrib2 = "2";
% % s.XMLname.DifferentElement{1}.Text = "Some more text";
% % s.XMLname.DifferentElement{2}.Attributes.attrib3 = "2";
% % s.XMLname.DifferentElement{2}.Attributes.attrib4 = "1";
% % s.XMLname.DifferentElement{2}.Text = "Even more text";
% %
% % Please note that the following characters are substituted
% % '-' by '_dash_', ':' by '_colon_' and '.' by '_dot_'
% %
% % Written by W. Falkena, ASTI, TUDelft, 21-08-2010
% % Attribute parsing speed increased by 40% by A. Wanner, 14-6-2011
% % Added CDATA support by I. Smirnov, 20-3-2012
% %
% % Modified by X. Mo, University of Wisconsin, 12-5-2012
% 
%     if (nargin < 1)
%         clc;
%         help xml2struct
%         return
%     end
%     
%     if isa(file, 'org.apache.xerces.dom.DeferredDocumentImpl') || isa(file, 'org.apache.xerces.dom.DeferredElementImpl')
%         % input is a java xml object
%         xDoc = file;
%     else
%         %check for existance
%         if (exist(file,'file') == 0)
%             %Perhaps the xml extension was omitted from the file name. Add the
%             %extension and try again.
%             if (isempty(strfind(file,'.xml')))
%                 file = [file '.xml'];
%             end
%             
%             if (exist(file,'file') == 0)
%                 error(['The file ' file ' could not be found']);
%             end
%         end
%         %read the xml file
%         xDoc = xmlread(file);
%     end
%     
%     %parse xDoc into a MATLAB structure
%     s = parseChildNodes(xDoc);
%     
% end
% 
% % ----- Subfunction parseChildNodes -----
% function [children,ptext,textflag] = parseChildNodes(theNode)
%     % Recurse over node children.
%     children = struct;
%     ptext = struct; textflag = 'Text';
%     if hasChildNodes(theNode)
%         childNodes = getChildNodes(theNode);
%         numChildNodes = getLength(childNodes);
% 
%         for count = 1:numChildNodes
%             theChild = item(childNodes,count-1);
%             [text,name,attr,childs,textflag] = getNodeData(theChild);
%             
%             if (~strcmp(name,'#text') && ~strcmp(name,'#comment') && ~strcmp(name,'#cdata_dash_section'))
%                 %XML allows the same elements to be defined multiple times,
%                 %put each in a different cell
%                 if (isfield(children,name))
%                     if (~iscell(children.(name)))
%                         %put existsing element into cell format
%                         children.(name) = {children.(name)};
%                     end
%                     index = length(children.(name))+1;
%                     %add new element
%                     children.(name){index} = childs;
%                     if(~isempty(fieldnames(text)))
%                         children.(name){index} = text; 
%                     end
%                     if(~isempty(attr)) 
%                         children.(name){index}.('Attributes') = attr; 
%                     end
%                 else
%                     %add previously unknown (new) element to the structure
%                     children.(name) = childs;
%                     if(~isempty(text) && ~isempty(fieldnames(text)))
%                         children.(name) = text; 
%                     end
%                     if(~isempty(attr)) 
%                         children.(name).('Attributes') = attr; 
%                     end
%                 end
%             else
%                 ptextflag = 'Text';
%                 if (strcmp(name, '#cdata_dash_section'))
%                     ptextflag = 'CDATA';
%                 elseif (strcmp(name, '#comment'))
%                     ptextflag = 'Comment';
%                 end
%                 
%                 %this is the text in an element (i.e., the parentNode) 
%                 if (~isempty(regexprep(text.(textflag),'[\s]*','')))
%                     if (~isfield(ptext,ptextflag) || isempty(ptext.(ptextflag)))
%                         ptext.(ptextflag) = text.(textflag);
%                     else
%                         %what to do when element data is as follows:
%                         %<element>Text <!--Comment--> More text</element>
%                         
%                         %put the text in different cells:
%                         % if (~iscell(ptext)) ptext = {ptext}; end
%                         % ptext{length(ptext)+1} = text;
%                         
%                         %just append the text
%                         ptext.(ptextflag) = [ptext.(ptextflag) text.(textflag)];
%                     end
%                 end
%             end
%             
%         end
%     end
% end
% 
% % ----- Subfunction getNodeData -----
% function [text,name,attr,childs,textflag] = getNodeData(theNode)
%     % Create structure of node info.
%     
%     %make sure name is allowed as structure name
%     name = toCharArray(getNodeName(theNode))';
%     name = strrep(name, '-', '_dash_');
%     name = strrep(name, ':', '_colon_');
%     name = strrep(name, '.', '_dot_');
% 
%     attr = parseAttributes(theNode);
%     if (isempty(fieldnames(attr))) 
%         attr = []; 
%     end
%     
%     %parse child nodes
%     [childs,text,textflag] = parseChildNodes(theNode);
%     
%     if (isempty(fieldnames(childs)) && isempty(fieldnames(text)))
%         %get the data of any childless nodes
%         % faster than if any(strcmp(methods(theNode), 'getData'))
%         % no need to try-catch (?)
%         % faster than text = char(getData(theNode));
%         text.(textflag) = toCharArray(getTextContent(theNode))';
%     end
%     
% end
% 
% % ----- Subfunction parseAttributes -----
% function attributes = parseAttributes(theNode)
%     % Create attributes structure.
% 
%     attributes = struct;
%     if hasAttributes(theNode)
%        theAttributes = getAttributes(theNode);
%        numAttributes = getLength(theAttributes);
% 
%        for count = 1:numAttributes
%             %attrib = item(theAttributes,count-1);
%             %attr_name = regexprep(char(getName(attrib)),'[-:.]','_');
%             %attributes.(attr_name) = char(getValue(attrib));
% 
%             %Suggestion of Adrian Wanner
%             str = toCharArray(toString(item(theAttributes,count-1)))';
%             k = strfind(str,'='); 
%             attr_name = str(1:(k(1)-1));
%             attr_name = strrep(attr_name, '-', '_dash_');
%             attr_name = strrep(attr_name, ':', '_colon_');
%             attr_name = strrep(attr_name, '.', '_dot_');
%             attributes.(attr_name) = str((k(1)+2):(end-1));
%        end
%     end
% end
