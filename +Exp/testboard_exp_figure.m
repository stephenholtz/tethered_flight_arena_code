function varargout = testboard_exp_figure(varargin)
%TESTBOARD_EXP_FIGURE M-file for testboard_exp_figure.fig
%      TESTBOARD_EXP_FIGURE, by itself, creates a new TESTBOARD_EXP_FIGURE or raises the existing
%      singleton*.
%
%      H = TESTBOARD_EXP_FIGURE returns the handle to a new TESTBOARD_EXP_FIGURE or the handle to
%      the existing singleton*.
%
%      TESTBOARD_EXP_FIGURE('Property','Value',...) creates a new TESTBOARD_EXP_FIGURE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to testboard_exp_figure_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TESTBOARD_EXP_FIGURE('CALLBACK') and TESTBOARD_EXP_FIGURE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TESTBOARD_EXP_FIGURE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testboard_exp_figure

% Last Modified by GUIDE v2.5 17-Feb-2012 13:02:16

% Begin initialization code - DO NOT EDIT unless you are really cool
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testboard_exp_figure_OpeningFcn, ...
                   'gui_OutputFcn',  @testboard_exp_figure_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before testboard_exp_figure is made visible.
function testboard_exp_figure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for testboard_exp_figure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testboard_exp_figure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testboard_exp_figure_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in initialize_experiment.
function initialize_experiment_Callback(hObject, eventdata, handles)
% hObject    handle to initialize_experiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in abortexperiment.
function abortexperiment_Callback(hObject, eventdata, handles)
% hObject    handle to abortexperiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in startrecording.
function startrecording_Callback(hObject, eventdata, handles)
% hObject    handle to startrecording (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in check_conditions.
function check_conditions_Callback(hObject, eventdata, handles)
% hObject    handle to check_conditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkmetadata.
function checkmetadata_Callback(hObject, eventdata, handles)
% hObject    handle to checkmetadata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkprotocolitems.
function checkprotocolitems_Callback(hObject, eventdata, handles)
% hObject    handle to checkprotocolitems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buzzcheckbox.
function buzzcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to buzzcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of buzzcheckbox


% --- Executes on button press in beaboss.
function beaboss_Callback(hObject, eventdata, handles)
% hObject    handle to beaboss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of beaboss


% --- Executes on button press in emailpostbuzzcheckbox.
function emailpostbuzzcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to emailpostbuzzcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of emailpostbuzzcheckbox


% --- Executes on button press in emailatendcheckbox.
function emailatendcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to emailatendcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of emailatendcheckbox



function emailaddressbox_Callback(hObject, eventdata, handles)
% hObject    handle to emailaddressbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of emailaddressbox as text
%        str2double(get(hObject,'String')) returns contents of emailaddressbox as a double


% --- Executes during object creation, after setting all properties.
function emailaddressbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to emailaddressbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in displayconditions.
function displayconditions_Callback(hObject, eventdata, handles)
% hObject    handle to displayconditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of displayconditions
