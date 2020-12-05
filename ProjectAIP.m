function varargout = ProjectAIP(varargin)

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
% Choose default command line output for ProjectAIP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectAIP wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = ProjectAIP_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% after start of program
pause(0.1);
fill_axises(1,hObject, eventdata,handles);

function fill_axises(from,hObject, eventdata, handles)
   for i = from:from+4
       suffix = '.bmp';
       path = [num2str(i), suffix];
       img = im2double(imread(['pictures/',path]));
       axHandle = (handles.(['axes',num2str(mod(i-1,5)+1)]));
       set(axHandle, 'UserData', img);
       imshow(img, 'Parent', axHandle);
    end

% --- Executes on slider movement.
function imageSlider_Callback(hObject, eventdata, handles)
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

% --- Executes on button press in selectAxes1.
function selectAxes1_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes1)
        imh = findobj(handles.axes1, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end


% --- Executes on button press in selectAxes2.
function selectAxes2_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes2)
        imh = findobj(handles.axes2, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end

% --- Executes on button press in selectAxes3.
function selectAxes3_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes3)
        imh = findobj(handles.axes3, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end

% --- Executes on button press in selectAxes4.
function selectAxes4_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes4)
        imh = findobj(handles.axes4, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end

% --- Executes on button press in selectAxes5.
function selectAxes5_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes5)
        imh = findobj(handles.axes5, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end


% --- Executes on button press in algo1.
function algo1_Callback(hObject, eventdata, handles)
% hObject    handle to algo1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     % FIRST try from https://www.mathworks.com/matlabcentral/answers/338296-cars-detection-in-image
     
     %imageFromMainAxes = getimage(handles.mainAxes);
     %result = medfilt2(imageFromMainAxes, [5 5]);
     %SE = strel('disk', 5);
     %imDilated = imdilate(result, SE);
     %imErodet = imerode(result, SE);
     %imDiff = imsubtract(imDilated, imErodet);
     %imDiff1 = mat2gray(imDiff);
     %imDiff2 = conv2(imDiff1, [1 1; 1 1]);
     %imDiff3 = imadjust(imDiff2, [0.4 0.9], [0 1], 1);
     %B = logical(imDiff3);
     %[a1 b1] = size(B);
     %er = imerode(B, strel('line', 60, 8));
     %out1 = imsubtract(B, er);
     %F = imfill(out1, 'holes');
     %H = bwmorph(F, 'thin', 0.5);
     %H = imerode(H, strel('line', 60, 8));
     
     %I = bwareaopen(H, floor((a1/18)*(b1/18)));
     %I(1:floor(.9*a1), 1:2) = 1;
     %I(a1:-1:(a1-20), b1:1:(b1-2)) = 1;
     %Iprops = regionprops(I, 'BoundingBox', 'Image');
     %set(handles.algo1Count,'string', num2str(length(Iprops)));
     %imshow(imageFromMainAxes, 'Parent', handles.mainAxes);
     
     %SECOND try 
     imageFromMainAxes = getimage(handles.mainAxes);
     detector = vision.ForegroundDetector();
      
     for i = 1:35
       suffix = '.bmp';
       path = [num2str(i), suffix];
       img = im2double(imread(['pictures/',path]));
       foreground = step(detector, img);
     end
     
     maskedImage = bsxfun(@times, imageFromMainAxes, cast(foreground, 'like',imageFromMainAxes));
     imshow(maskedImage, 'Parent', handles.mainAxes);
     
  
     
