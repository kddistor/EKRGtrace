function varargout = EKRGtraceGUI(varargin)
% EKRGTRACEGUI MATLAB code for EKRGtraceGUI.fig
%      EKRGTRACEGUI, by itself, creates a new EKRGTRACEGUI or raises the existing
%      singleton*.
%
%      H = EKRGTRACEGUI returns the handle to a new EKRGTRACEGUI or the handle to
%      the existing singleton*.
%
%      EKRGTRACEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EKRGTRACEGUI.M with the given input arguments.
%
%      EKRGTRACEGUI('Property','Value',...) creates a new EKRGTRACEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EKRGtraceGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EKRGtraceGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EKRGtraceGUI

% Last Modified by GUIDE v2.5 08-Oct-2013 16:58:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EKRGtraceGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @EKRGtraceGUI_OutputFcn, ...
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


% --- Executes just before EKRGtraceGUI is made visible.
function EKRGtraceGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EKRGtraceGUI (see VARARGIN)

% Choose default command line output for EKRGtraceGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EKRGtraceGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = EKRGtraceGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function edit12_Callback(hObject, eventdata, handles)
%   Function to get padlength of the first timepoint.
%   Input should be in integer+1.
%   ex. value of 3 would pad number 00x
global ftpad
ftpad = str2double(get(hObject,'String'))


function edit1_Callback(hObject, eventdata, handles)
%   Function to get point picker file.
%   Input should be the name of the file. 
%   ex. 2013-07-30-c2.txt
global ppoints
ppoints = get(hObject,'String')


function edit2_Callback(hObject, eventdata, handles)
%   Function to get basename of a file
%   Input should be the date and name of trace. In [] below:
%   ex [2013-07-30ekrg]c1xy1t001.tif
global basename
basename = get(hObject,'String')


function edit3_Callback(hObject, eventdata, handles)
%   Function to get the firsttime point to be analyzed.
%   Input should be an integer. in [] below:
%   ex. 2013-07-30ekrgc1xy1t00[1].tif
global firsttime
firsttime = get(hObject,'String')


function edit4_Callback(hObject, eventdata, handles)
%   Function to get the last timepoint
%   Input should be an integer. 
%   ex. 200
global lasttime
lasttime = get(hObject,'String')


function edit15_Callback(hObject, eventdata, handles)
%   Function to get CFP Background Value
%   Input should be an integer.
%   ex. 324
global CFPB
CFPB = str2double(get(hObject,'String'))


function edit16_Callback(hObject, eventdata, handles)
%   Function to get YFP Background Value
%   Input should be an integer.
%   ex. 324
global YFPB
YFPB = str2double(get(hObject,'String'))


function popupmenu1_Callback(hObject, eventdata, handles)
%   Function to get the separator position
%   Choose separator from popup.
%   Three possible choices.
global separator_pos
contents = cellstr(get(hObject,'String'));
separator = contents{get(hObject,'Value')}
separator_list = {'none','-','_'};
separator_pos = strmatch(separator,separator_list)


function popupmenu2_Callback(hObject, eventdata, handles)
%   Function to get order position of inputs.
%   Select order positions from drop menu.
%   Six possible choices.
global order_pos
contents = cellstr(get(hObject,'String'));
order = contents{get(hObject,'Value')}
order_list = {'t...xy...c...','t...c...xy...','xy...t...c...','xy...c...t...','c...xy...t...','c...t...xy...'};
order_pos = strmatch(order,order_list)


function edit6_Callback(hObject, eventdata, handles)
%   Function to get CFP channel name
%   Input should be the name of channel name
%   ex. c1
global ch1n
ch1n = get(hObject,'String')


function edit7_Callback(hObject, eventdata, handles)
%   Function to get YFP channel name
%   Input should be the name of channel name
%   ex. YFP1
global ch2n 
ch2n = get(hObject,'String')


function edit8_Callback(hObject, eventdata, handles)
%   Function to get RFP channel name
%   Input should be the name of channel name
%   ex. RFP001
global ch3n
 ch3n = get(hObject,'String')


function edit9_Callback(hObject, eventdata, handles)
%   Function to get miscellaneous channel name
%   Input should be the name of channel name
%   ex. 
global ch4n 
ch4n = get(hObject,'String')


function edit10_Callback(hObject, eventdata, handles)
%   Function to get slide position
%   Input should be the name of the slide position (s1,xy001,etc) 
global slideposition
slideposition = get(hObject,'String')



function pushbutton2_Callback(hObject, eventdata, handles)
%   Function to display the input file based on inputs in gui
global ppoints         
global basename        
global ftime            
global ltime            
global separator_pos        
global order_pos           
global ch1n             
global ch2n             
global ch3n             
global ch4n
global filenameCFP
global filenameYFP
global filenameRFP
global filenameNFP

getNames


function pushbutton1_Callback(hObject, eventdata, handles)
global ppoints         
global basename        
global ftime            
global ltime            
global separator_pos           
global order_pos            
global ch1n             
global ch2n             
global ch3n             
global ch4n
global filenameCFP
global filenameYFP
global filenameRFP
global filenameNFP
global ftpad
global firsttime            
global lasttime             
global svxy                 
global CFPB
global YFPB
global slideposition

[ns, tp]=getNames;
EKRGtraceMod(ppoints, ns, firsttime, lasttime, ftpad, tp, CFPB,YFPB)


function [nameSet, tpos]= getNames()
global ppoints         
global basename        
global ftime            
global ltime            
global separator_pos           
global order_pos          
global ch1n             
global ch2n             
global ch3n             
global ch4n
global filenameCFP
global filenameYFP
global filenameRFP
global filenameNFP
global ftpad
global firsttime            
global lasttime             
global svxy                 
global CFPB
global YFPB
global slideposition

num2str(firsttime);
tstr=['000' num2str(firsttime)];
tstr=tstr((end-(ftpad-1)):end);
ftime=['t' tstr];
switch separator_pos
    case 1
        sepstr='';
    case 2
        sepstr='-';
    case 3
        sepstr='_'
end

switch order_pos
    case 1 %t...xy...c...
                filenameCFP = sprintf('%s%s%s%s%s%s.tif', basename, ftime, sepstr, slideposition, sepstr, ch1n)
                filenameYFP = sprintf('%s%s%s%s%s%s.tif', basename, ftime, sepstr, slideposition, sepstr, ch2n)
                filenameRFP = sprintf('%s%s%s%s%s%s.tif', basename, ftime, sepstr, slideposition, sepstr, ch3n)
                filenameNFP = sprintf('%s%s%s%s%s%s.tif', basename, ftime, sepstr, slideposition, sepstr, ch4n)
                preT1 =  length(sprintf('%s%d%s%s%s%s.tif', basename))+1;
                preT2 =  length(sprintf('%s%d%s%s%s%s.tif', basename))+1;
                preT3 =  length(sprintf('%s%d%s%s%s%s.tif', basename))+1;
                preT4 =  length(sprintf('%s%d%s%s%s%s.tif', basename))+1;
                tpos= [preT1; preT2; preT3; preT4];
                nameSet={filenameCFP; filenameYFP; filenameRFP; filenameNFP};        
    case 2 %t...c....xy...
                filenameCFP = sprintf('%s%s%s%s%s%s.tif', basename, ftime, sepstr, ch1n , sepstr, slideposition)
                filenameYFP = sprintf('%s%s%s%s%s%s.tif', basename, ftime, sepstr, ch2n , sepstr, slideposition)
                filenameRFP = sprintf('%s%s%s%s%s%s.tif', basename, ftime, sepstr, ch3n , sepstr, slideposition)
                filenameNFP = sprintf('%s%s%s%s%s%s.tif', basename, ftime, sepstr, ch4n , sepstr, slideposition)
                preT1 =  length(sprintf('%s%s%s%s%s%s.tif', basename))+1;
                preT2 =  length(sprintf('%s%s%s%s%s%s.tif', basename))+1;
                preT3 =  length(sprintf('%s%s%s%s%s%s.tif', basename))+1;
                preT4 =  length(sprintf('%s%s%s%s%s%s.tif', basename))+1;
                tpos= [preT1; preT2; preT3; preT4];
                nameSet={filenameCFP; filenameYFP; filenameRFP; filenameNFP};
    case 3 %xy...t...c...
                filenameCFP = sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ftime, sepstr, ch1n)
                filenameYFP = sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ftime, sepstr, ch2n)
                filenameRFP = sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ftime, sepstr, ch3n)
                filenameNFP = sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ftime, sepstr, ch4n)
                preT1 =  length(sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr))+1;
                preT2 =  length(sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr))+1;
                preT3 =  length(sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr))+1;
                preT4 =  length(sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr))+1;
                tpos= [preT1; preT2; preT3; preT4];
                nameSet={filenameCFP; filenameYFP; filenameRFP; filenameNFP};
    case 4 %xy...c...t...
                filenameCFP = sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ch1n, sepstr, ftime)
                filenameYFP = sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ch2n, sepstr, ftime)
                filenameRFP = sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ch3n, sepstr, ftime)
                filenameNFP = sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ch4n, sepstr, ftime)
                preT1 =  length(sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ch1n, sepstr))+1;
                preT2 =  length(sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ch2n, sepstr))+1;
                preT3 =  length(sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ch3n, sepstr))+1;
                preT4 =  length(sprintf('%s%s%s%s%s%s.tif', basename, slideposition, sepstr, ch4n, sepstr))+1;
                tpos= [preT1; preT2; preT3; preT4];
                nameSet={filenameCFP; filenameYFP; filenameRFP; filenameNFP};
    case 5 %c...xy...t...
                filenameCFP = sprintf('%s%s%s%s%s%s.tif', basename,  ch1n, sepstr, slideposition, sepstr, ftime)
                filenameYFP = sprintf('%s%s%s%s%s%s.tif', basename,  ch2n, sepstr, slideposition, sepstr, ftime)
                filenameRFP = sprintf('%s%s%s%s%s%s.tif', basename,  ch3n, sepstr, slideposition, sepstr, ftime)
                filenameNFP = sprintf('%s%s%s%s%s%s.tif', basename,  ch4n, sepstr, slideposition, sepstr, ftime)
                preT1 =  length(sprintf('%s%s%s%s%s%s.tif', basename,  ch1n, sepstr, slideposition, sepstr))+1;
                preT2 =  length(sprintf('%s%s%s%s%s%s.tif', basename,  ch2n, sepstr, slideposition, sepstr))+1;
                preT3 =  length(sprintf('%s%s%s%s%s%s.tif', basename,  ch3n, sepstr, slideposition, sepstr))+1;
                preT4 =  length(sprintf('%s%s%s%s%s%s.tif', basename,  ch4n, sepstr, slideposition, sepstr))+1;
                tpos= [preT1; preT2; preT3; preT4];
                nameSet={filenameCFP; filenameYFP; filenameRFP; filenameNFP};
    case 6 %c...t...xy...
                filenameCFP = sprintf('%s%s%s%s%s%s.tif', basename,  ch1n, sepstr, ftime, sepstr, slideposition)
                filenameYFP = sprintf('%s%s%s%s%s%s.tif', basename,  ch2n, sepstr, ftime, sepstr, slideposition)
                filenameRFP = sprintf('%s%s%s%s%s%s.tif', basename,  ch3n, sepstr, ftime, sepstr, slideposition)
                filenameNFP = sprintf('%s%s%s%s%s%s.tif', basename,  ch4n, sepstr, ftime, sepstr, slideposition)
                preT1 =  length(sprintf('%s%s%s%s%s%s.tif', basename,  ch1n, sepstr))+1;
                preT2 =  length(sprintf('%s%s%s%s%s%s.tif', basename,  ch2n, sepstr))+1;
                preT3 =  length(sprintf('%s%s%s%s%s%s.tif', basename,  ch3n, sepstr))+1;
                preT4 =  length(sprintf('%s%s%s%s%s%s.tif', basename,  ch4n, sepstr))+1;
                tpos= [preT1; preT2; preT3; preT4];
                nameSet={filenameCFP; filenameYFP; filenameRFP; filenameNFP};

end

% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

