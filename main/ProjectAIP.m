function varargout = ProjectAIP(varargin)
% PROJECTAIP MATLAB code for ProjectAIP.fig
%      PROJECTAIP, by itself, creates a new PROJECTAIP or raises the existing
%      singleton*.
%
%      H = PROJECTAIP returns the handle to a new PROJECTAIP or the handle to
%      the existing singleton*.
%
%      PROJECTAIP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTAIP.M with the given input arguments.
%
%      PROJECTAIP('Property','Value',...) creates a new PROJECTAIP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProjectAIP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectAIP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProjectAIP

% Last Modified by GUIDE v2.5 26-Nov-2020 23:04:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectAIP_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectAIP_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before ProjectAIP is made visible.
function ProjectAIP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjectAIP (see VARARGIN)

% Choose default command line output for ProjectAIP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectAIP wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = ProjectAIP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% after start of program
pause(0.1);
fill_axises(1,hObject, eventdata,handles);

function fill_axises(from,hObject, eventdata, handles)
    array = ["@axes1_ButtonDownFcn";"@axes2_ButtonDownFcn";"@axes3_ButtonDownFcn";
            "@axes4_ButtonDownFcn";"@axes5_ButtonDownFcn"];
    for i = from:from+4
       img = im2double(imread(i+".bmp"));
       disp(i);
       axHandle = (handles.(['axes',num2str(mod(i-1,5)+1)]));
       set(axHandle, 'UserData', img);
       axesChild = imshow(img, 'Parent', axHandle);
     %  set(axesChild, 'HitTest', 'off'); 
     %  axis('off');
       set(axesChild, 'ButtonDownFcn', array(mod(i-1,5)+1));
     %  set(axesChild, 'ButtonDownFcn', {array(mod(i-1,5)+1), handles});
    end

% --- Executes on slider movement.
function imageSlider_Callback(hObject, eventdata, handles)
% hObject    handle to imageSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
sliderValue = get(handles.imageSlider, 'Value');
round = floor(sliderValue);
fill_axises(round, hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function imageSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
disp('calll');
%orig = get(handles.axes1, 'UserData');
%imshow(orig, 'Parent',handles.mainAxis);
%set(handles.mainAxis, 'UserData', orig);

% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function axesImage_ButtonDownFcn(hObject, eventdata, handles)
disp("calll 2");

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% Hint: place code in OpeningFcn to populate axes1

% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
disp('axes2  was clicked');
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
