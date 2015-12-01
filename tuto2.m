function varargout = tuto2(varargin)
% TUTO2 MATLAB code for tuto2.fig
%      TUTO2, by itself, creates a new TUTO2 or raises the existing
%      singleton*.
%
%      H = TUTO2 returns the handle to a new TUTO2 or the handle to
%      the existing singleton*.
%
%      TUTO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUTO2.M with the given input arguments.
%
%      TUTO2('Property','Value',...) creates a new TUTO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tuto2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tuto2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tuto2

% Last Modified by GUIDE v2.5 30-Nov-2015 09:35:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tuto2_OpeningFcn, ...
                   'gui_OutputFcn',  @tuto2_OutputFcn, ...
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


% --- Executes just before tuto2 is made visible.
function tuto2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tuto2 (see VARARGIN)

imshow ('src/tuto2.png')
% Choose default command line output for tuto2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tuto2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tuto2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
tuto3
close(tuto2)