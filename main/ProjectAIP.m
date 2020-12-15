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

function id = getIndex
global idx;
id = idx;

function setIndex(id)
global idx;
idx = id;

function mAp = getMaP
global map;
mAp = map;

function setMaP(mAp)
global map;
map = mAp;

function ap = getAP50
global ap50;
ap = ap50;

function setAP50(ap)
global ap50;
ap50 = ap;

function idx = getId
global id;
idx = id;

function setId(idx)
global id;
id = idx;

function fill_axises(from,hObject, eventdata, handles)
   to = from+4;
   idx = 1;
   for i = from:to
       suffix = '.bmp';
       path = [num2str(i), suffix];
       img = im2double(imread(['pictures/',path]));
       axHandle = (handles.(['axes',num2str(idx)]));
       set(axHandle, 'UserData', img);
       imshow(img, 'Parent', axHandle);
       idx = idx + 1; 
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
        setIndex(0);
        imh = findobj(handles.axes1, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end


% --- Executes on button press in selectAxes2.
function selectAxes2_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes2)
        setIndex(1);
        imh = findobj(handles.axes2, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end

% --- Executes on button press in selectAxes3.
function selectAxes3_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes3)
        setIndex(2);
        imh = findobj(handles.axes3, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end

% --- Executes on button press in selectAxes4.
function selectAxes4_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes4)
        setIndex(3);
        imh = findobj(handles.axes4, 'type', 'image');
        img = get(imh, 'CData');
        imshow(img, 'Parent', handles.mainAxes);
    else
       warndlg('Incorect Input, Please Select An Image!','Warning');
    end

% --- Executes on button press in selectAxes5.
function selectAxes5_Callback(hObject, eventdata, handles)
    if ~isempty(handles.axes5)
        setIndex(4);
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
    set(handles.algo1Count,'string', num2str(numberOfCars));
     
    sliderValue = get(handles.imageSlider, 'Value');
    round = floor(sliderValue);
    index = round + getIndex;
    if ~isempty(getId)        
        index = getId;
    end
    data = load(['./ground-truth/',num2str(index),'.mat']);
    groundTruthBbox = data.gTruth.LabelData.Car{1,1};
    result = calculateIoU(groundTruthBbox, bbox);
    AP50 = calculateAP(result, 0.5);
    set(handles.ap50_algo1,'string', num2str(AP50));
    mAp = calculateMAP(result);
    set(handles.map_algo1,'string', num2str(mAp));
    if ~isempty(getId) 
        setMaP(mAp);
        setAP50(AP50);
    end
    
% --- Executes on button press in algo2.
function algo2_Callback(hObject, eventdata, handles)
    Background = im2double(imread('pictures/background.bmp'));
    imageFromMainAxes = im2double(getimage(handles.mainAxes));
    object = abs(imageFromMainAxes - Background);
    I = object;
    I(I > 0.22) = 1;
    I(I <= 0.22) = 0;
    bw = bwareaopen(I, 45);
    
    blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, 'CentroidOutputPort', false, 'AreaOutputPort', false, 'MinimumBlobArea', 300);
    bbox = step(blobAnalysis, bw);
    result = insertShape(imageFromMainAxes, 'Rectangle', bbox); 
    imshow(result, 'Parent', handles.mainAxes);
    
    numberOfCars = size(bbox, 1);
    set(handles.BSText0,'string', num2str(numberOfCars));
    
    sliderValue = get(handles.imageSlider, 'Value');
    round = floor(sliderValue);
    index = round + getIndex;
    if ~isempty(getId)        
        index = getId;
    end
    data = load(['./ground-truth/',num2str(index),'.mat']);
    groundTruthBbox = data.gTruth.LabelData.Car{1,1};
    result = calculateIoU(groundTruthBbox, bbox);
    AP50 = calculateAP(result, 0.5);
    set(handles.ap50_algo2,'string', num2str(AP50));
    mAp = calculateMAP(result);
    set(handles.map_algo2,'string', num2str(mAp));

    if ~isempty(getId) 
        setMaP(mAp);
        setAP50(AP50);
    end
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

    %blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, 'CentroidOutputPort', false, 'AreaOutputPort', false, 'MinimumBlobArea', 300);
    %bbox = step(blobAnalysis, clo2);
    %result = insertShape(imageFromMainAxes, 'Rectangle', bbox); 
    %imshow(result, 'Parent', handles.mainAxes);
    
function script(hObject, eventdata, handles)
    global algo;
    from = 1;
    to = 35;
    mAp = [];
    ap50 = [];
    indices = [];
    for i =from:to
        suffix = '.bmp';
        path = [num2str(i), suffix];
        img = im2double(imread(['pictures/',path]));
        imshow(img, 'Parent', handles.mainAxes);   
        setId(i);
        if algo == 0
            algo2_Callback(hObject, eventdata, handles);
        else
            algo1_Callback(hObject, eventdata, handles);
        end
        mAp = [mAp getMaP];
        ap50 = [ap50 getAP50];
        indices = [indices i];
    end
    
    figure;
    plot(indices, mAp);
    res1 = (sum(mAp) / 35);
    disp("mAp-sum" + res1)
    xticks(1:35);
    xlabel("Image number");
    ylabel("mAP");
    if algo == 0
        title("mAP Background Substraction");
    else
        title("mAP Foreground Detector");
    end
    
    figure;
    plot(indices, ap50);
    res2 = (sum(ap50) / 35);
    disp("ap50-sum" + res2)
    xticks(1:35);
    xlabel("Image number");
    ylabel("AP50");
    if algo == 0
        title("AP50 Background Substraction");
    else
        title("AP50 Foreground Detector");
    end
    
    % destroy global variable
    clearvars;
    
% --- Executes on button press in resultAlgo1.
function resultAlgo1_Callback(hObject, eventdata, handles)
global algo;
algo = 1;
script(hObject, eventdata, handles);

% --- Executes on button press in resultAlgo2.
function resultAlgo2_Callback(hObject, eventdata, handles)
global algo;
algo = 0;
script(hObject, eventdata, handles);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
clearvars;
clear all;
