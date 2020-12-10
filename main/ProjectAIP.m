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
     imageFromMainAxes = getimage(handles.mainAxes);
     imageFromMainAxesFiltered = imgaussfilt(imageFromMainAxes,4);
     detector = vision.ForegroundDetector();
     blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, 'CentroidOutputPort', false, 'AreaOutputPort', false, 'MinimumBlobArea', 300);
     se = strel('square', 5);
      
     for i = 1:35
       suffix = '.bmp';
       path = [num2str(i), suffix];
       img = im2double(imread(['pictures/',path]));
       img = imgaussfilt(img,4);
       foreground = step(detector, img);
     end
    
     foreground = step(detector, imageFromMainAxesFiltered);
     filteredForeground = imdilate(foreground, se);
     bbox = step(blobAnalysis, filteredForeground);
     result = insertShape(imageFromMainAxes, 'Rectangle', bbox);
     imshow(result, 'Parent', handles.mainAxes);
     numberOfCars = size(bbox, 1);
     disp(numberOfCars);
     set(handles.algo1Count,'string', num2str(numberOfCars));

     
% --- Executes on button press in algo2.
function algo2_Callback(hObject, eventdata, handles)
    Background = im2double(imread('pictures/background.bmp'));
    imageFromMainAxes = im2double(getimage(handles.mainAxes));
    object = abs(imageFromMainAxes - Background);
    I = object;
    I(I > 0.27) = 1;
    I(I <= 0.27) = 0;
    bw = bwareaopen(I, 65);
   % figure;
   % imshow(bw);
   
 %  conc = strel('rectangle', [5, 7]);
 %  gi = imdilate(bw, conc);
 %  conc1 = strel('rectangle',[7,5]);
 %  ge=imerode(gi,conc1);
 %  gdiff = imsubtract(gi,ge);
%   figure;
 %  imshow(gdiff);
 %  gdiff2 = conv2(gdiff,[1 1; 1 1]);
 %  figure;
 %  imshow(gdiff2);
 %  gdiff3 = imadjust(gdiff2,[0.4 0.9], [0 1], 1);
 %  figure;
 %  imshow(gdiff3);

   % SES = strel('rectangle', [5, 3]);
   % test = imopen(bw, SES);
   % SES2 = strel('rectangle', [3, 5]);
   % test2 = imopen(test, SES2);
   % figure;
   % imshow(test2);
    
    SE2 = strel('rectangle', [8, 3]);
    dil2 = imdilate(bw, SE2);
    SE = strel('rectangle', [3, 8]);
    dil = imdilate(dil2, SE);
    
  %  figure;
  %  imshow(dil);
    
    SE1 = strel('rectangle', [5, 3]);
    SE2 = strel('rectangle', [3, 5]);
    clo = imclose(dil, SE1);
    clo3 = imclose(clo, SE2);
  %  figure;
  %  imshow(clo3);
    
    str = strel('square', 6);
    clo2 = imerode(clo3, str);
  %  figure;
  %  imshow(clo2);

    blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, 'CentroidOutputPort', false, 'AreaOutputPort', false, 'MinimumBlobArea', 300);
    bbox = step(blobAnalysis, clo2);
    result = insertShape(imageFromMainAxes, 'Rectangle', bbox); 
    imshow(result, 'Parent', handles.mainAxes);
    