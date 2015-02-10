function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 08-May-2014 05:15:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% axes 1 = instruction pictures
% axes 2 = image from camera
% text 2 = instruction text
% text 3 = correction text
% text 9 = button for checking
%text 11 = "instruction:""

% pushbutton 1 = check the blocks

% Choose default command line output for gui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

set(handles.axes1,'Visible','off');
set(handles.axes2,'Visible','off');
set(handles.axes3,'Visible','off');
set(handles.text2,'Visible','off');
set(handles.text14,'Visible','off');
set(handles.text15,'Visible','off');
set(handles.text16,'Visible','off');
set(handles.text17,'Visible','off');
set(handles.pushbutton1,'Visible','off');
set(handles.pushbutton8,'Visible','off');
set(handles.text9,'Visible','off');
set(handles.text11,'Visible','off');
handles.instruction_set = cell(3,1);
handles.block_color = cell(3,1);
handles.block_location = cell(3,1);
handles.block_orientation = cell(3,1);
handles.step = 1; %instruction step


[a,map]=imread('button_pyramid.jpg');
[r,c,d]=size(a); 
x=ceil(r/80); 
y=ceil(c/80); 
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.button1,'CData',g);

[a,map]=imread('button_lineup.jpg');
[r,c,d]=size(a); 
x=ceil(r/80); 
y=ceil(c/80); 
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.button2,'CData',g);

[a,map]=imread('button_tower.jpg');
[r,c,d]=size(a); 
x=ceil(r/80); 
y=ceil(c/80); 
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.button3,'CData',g);

% coordinate of bottom blocks [y,x]
handles.center = [765, 619];
handles.left_center = [ 765, 497];
handles.left =  [ 765, 375];
handles.right_center = [765, 740];
handles.right = [765, 866];
handles.second_top = [536, 619];
handles.top = [319, 619];
handles.block_threshold = 100;

guidata(hObject,handles)
% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% vid = videoinput('macvideo', 1, 'YCbCr422_1280x720');
set(handles.text14,'Visible','on');
set(handles.text15,'Visible','on');
vid = videoinput('macvideo', 1, 'ARGB32_1280x960');
src = getselectedsource(vid);
vid.ReturnedColorspace = 'rgb';
vid.FramesPerTrigger = 1;
% preview(vid);
pics=cell(1,20);
for i=1:2
   pause(0.1);
   pics{i}=getsnapshot(vid);
end
im = pics{1};
axes(handles.axes2);
imshow(im);

instructionCheck(hObject,handles, im);

% set(handles.text2, 'String', int2str(handles.block_location{handles.step}(1)) );%handles.instruction_set{handles.step});
% %check color until ok
% %filter image with yellow
% color_filtered = color_filter(im, handles.block_color{handles.step}, handles);
%   % if no color detected, say no yellow box in the position
% if ~any(any(any(color_filtered)))
%   set(handles.text3, 'String', strcat('No box with color ', handles.block_color{handles.step}, ' detected. Put the box as instructed then click again' ))


%   %if detected but not correctly placed, send feedback
% elseif color_filtered((handles.block_location{handles.step}(1) - handles.block_threshold), handles.block_location{handles.step}(2))
%   set(handles.text3, 'String', strcat('Awesome! Please proceed to next step'));

% else
%   set(handles.text3, 'String', strcat(handles.block_color{handles.step}, 'box is detected. Please place it in the right place'));
 
% end

stop(vid);



% --- Executes on button press in button1 for pyramid
function button1_Callback(hObject, eventdata, handles)
handles.goal = 'pyramid';
select_goal(hObject,handles);

% --- Executes on button press in button2 for lineup 
function button2_Callback(hObject, eventdata, handles)
handles.goal = 'lineup';
select_goal(hObject,handles);

% --- Executes on button press in button3 for tower 
function button3_Callback(hObject, eventdata, handles)
handles.goal = 'tower';
select_goal(hObject,handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
handles.step = handles.step + 1;
set(handles.text2, 'String', handles.instruction_set{handles.step});
set(handles.text3,'String',' ');
set(handles.pushbutton8,'Visible','off');
guidata(hObject, handles);

% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
