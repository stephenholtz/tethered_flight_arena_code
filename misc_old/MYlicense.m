function [varargout] = MYlicense(varargin)
% overloaded license function for my own needs

if strcmp(varargin{1},'test')
    varargout{1} = 1;
else
    varargout = license(varargin);
end