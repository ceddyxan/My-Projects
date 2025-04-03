function varargout = MAIN(varargin)
% MAIN MATLAB code for MAIN.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MAIN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MAIN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MAIN_OpeningFcn, ...
    'gui_OutputFcn',  @MAIN_OutputFcn, ...
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


% --- Executes just before MAIN is made visible.
function MAIN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MAIN (see VARARGIN)

% Choose default command line output for MAIN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MAIN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MAIN_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FILE_Callback(hObject, eventdata, handles)
% hObject    handle to FILE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OPEN_Callback(hObject, eventdata, handles)
% hObject    handle to OPEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fn, pn]=uigetfile('*.jpg;*.png');
a=[pn fn];
b=imread(a);
handles.b=b;
axes(handles.axes5);
imshow(b);
guidata(hObject,handles);
% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ON_Callback(hObject, eventdata, handles)
% hObject    handle to ON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mkdir('C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TestDatabase');
axes(handles.axes5);
vid = videoinput('winvideo',1);
handles.vid=vid;
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands'); %The value of the NumberOfBands property indicates the number of color bands in the data returned by getsnapshot, getdata, and peekdata
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid,hImage);
img = getsnapshot(vid);
axes(handles.axes6);
imshow(img);
guidata(hObject,handles);
FDetect=vision.CascadeObjectDetector('FrontalFaceCART');
BB=step(FDetect,img);
axes(handles.axes7);
imshow(img);
hold on
for i=1:size(BB,1)
    rectangle('position',BB(i,:),'Linewidth',1,'Linestyle','-','Edgecolor','g');
end
hold off
N=size(BB,1);
handles.N=N;
counter=1;
for i=1:N
    face=imcrop(img,BB(i,:));
    savenam = strcat('C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TestDatabase\' ,num2str(counter), '.jpg'); %this is where and what your image will be saved
    baseDir  = 'C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TestDatabase\';
    %     baseName = 'image_';
    newName  = [baseDir num2str(counter) '.jpg'];
    handles.face=face;
    while exist(newName,'file')
        counter = counter + 1;
        newName = [baseDir num2str(counter) '.jpg'];
    end
    fac=imresize(face,[240,320]);
    imwrite(fac,newName);
    axes(eval(['handles.axes', num2str(i)]));
    imshow(face);
    guidata(hObject,handles);
    pause(5);
end


% --------------------------------------------------------------------
function OFF_Callback(hObject, eventdata, handles)
% hObject    handle to OFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
off=handles.vid;
delete(off);





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future verclcsion of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --------------------------------------------------------------------
function EXIT_Callback(hObject, eventdata, handles)
% hObject    handle to EXIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in RECOGNITION.
function RECOGNITION_Callback(hObject, eventdata, handles)
% hObject    handle to RECOGNITION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rec=handles.N;
TrainDatabasePath = 'C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TrainDatabase\';
TestDatabasePath = 'C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TestDatabase\';
v=rec;
for j = 1:v
    TestImage  = num2str(j);
    s=strcat('a',TestImage);
    TestImage = strcat(TestDatabasePath,'\',char( TestImage),'.jpg');
    T = CreateDatabase(TrainDatabasePath);
    [m, A, Eigenfaces] = EigenfaceCore(T);
    [OutputName,Recognized_index] = Recognition(TestImage, m, A, Eigenfaces);
    SelectedImage = strcat(TrainDatabasePath,'\',  OutputName);
    SelectedImage = imread(SelectedImage);
    axes(eval(['handles.axes', num2str(s)]));
    imshow(SelectedImage);
    switch Recognized_index

    end
end




% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in VIEWPROFILE.
function VIEWPROFILE_Callback(hObject, eventdata, handles)
% hObject    handle to VIEWPROFILE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function TESTON_Callback(hObject, eventdata, handles)
% hObject    handle to TESTON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes5);
vid = videoinput('winvideo',1);
handles.vid=vid;
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid,hImage);
guidata(hObject,handles);


% --------------------------------------------------------------------
function TESTOFF_Callback(hObject, eventdata, handles)
% hObject    handle to TESTOFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
off=handles.vid;
delete(off);


% --------------------------------------------------------------------
function PREVIEW_Callback(hObject, eventdata, handles)
% hObject    handle to PREVIEW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ADDPHOTO_Callback(hObject, eventdata, handles)
% hObject    handle to ADDPHOTO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function ADD_Callback(hObject, eventdata, handles)
% hObject    handle to ADD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mkdir('C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TrainDatabase');
for ind=1:3
    axes(handles.axes5);
    vid = videoinput('winvideo',1);
    handles.vid=vid;
    vidRes = get(vid, 'VideoResolution');
    nBands = get(vid, 'NumberOfBands');
    hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
    preview(vid,hImage);
    img = getsnapshot(vid);
    axes(handles.axes6);
    imshow(img);
    guidata(hObject,handles);
    FDetect=vision.CascadeObjectDetector('FrontalFaceCART');
    %htextinsface = vision.TextInserter('Text', 'face   : %2d', 'Location',  [5 2],'Font', 'Courier New','FontSize', 14);
    BB=step(FDetect,img);
    axes(handles.axes7);
    imshow(img);
    hold on
    for i=1:size(BB,1)
        rectangle('position',BB(i,:),'Linewidth',3,'Linestyle','-','Edgecolor','g');
    end
    hold off
    N=size(BB,1);
    handles.N=N;
    counter=1;
    for i=1:N
        face=imcrop(img,BB(i,:));
        savenam = strcat('C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TrainDatabase\' ,num2str(counter), '.jpg'); %this is where and what your image will be saved
        baseDir  = 'C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TrainDatabase\';
        %     baseName = 'image_';
        newName  = [baseDir num2str(counter) '.jpg'];
        handles.face=face;
        while exist(newName,'file')
            counter = counter + 1;
            newName = [baseDir num2str(counter) '.jpg'];
        end
        fac=imresize(face,[240,320]);
        imwrite(fac,newName);
        %axes(handles.axes14);
        axes(eval(['handles.axes', num2str(i)]));
        imshow(face);
        guidata(hObject,handles);
        pause(2);
    end
    delete(vid);
end


% --------------------------------------------------------------------
function REMOVE_Callback(hObject, eventdata, handles)
% hObject    handle to REMOVE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rmdir('C:\Users\Ceddy\Desktop\data\Face Rec\Face Rec - Copy\TestDatabase','s')



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('C:\Windows\System32\DriverStore\FileRepository\bth.inf_amd64_neutral_a1e8f56d586ec10b\fsquirt.exe');
