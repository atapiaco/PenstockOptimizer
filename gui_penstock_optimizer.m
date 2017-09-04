 function varargout = gui_penstock_optimizer(varargin)
% GUI_PENSTOCK_OPTIMIZER MATLAB code for gui_penstock_optimizer.fig
%      GUI_PENSTOCK_OPTIMIZER, by itself, creates a new GUI_PENSTOCK_OPTIMIZER or raises the existing
%      singleton*.
%
%      H = GUI_PENSTOCK_OPTIMIZER returns the handle to a new GUI_PENSTOCK_OPTIMIZER or the handle to
%      the existing singleton*.
%
%      GUI_PENSTOCK_OPTIMIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PENSTOCK_OPTIMIZER.M with the given input arguments.
%
%      GUI_PENSTOCK_OPTIMIZER('Property','Value',...) creates a new GUI_PENSTOCK_OPTIMIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_penstock_optimizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_penstock_optimizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_penstock_optimizer

% Last Modified by GUIDE v2.5 21-Jun-2017 21:38:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_penstock_optimizer_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_penstock_optimizer_OutputFcn, ...
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


% --- Executes just before gui_penstock_optimizer is made visible.
function gui_penstock_optimizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_penstock_optimizer (see VARARGIN)

format short g;

axes(handles.logotipo)
matlabImage = imread('logo.png');
image(matlabImage)
axis off
axis image

% Choose default command line output for gui_penstock_optimizer
handles.output = hObject;
push_reset_Callback(hObject, eventdata, handles);
% Update handles structure
guidata(hObject, handles);
push_reset_Callback(hObject, eventdata, handles);
% UIWAIT makes gui_penstock_optimizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = gui_penstock_optimizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function input_nozzlediameter_Callback(hObject, eventdata, handles)
% hObject    handle to input_nozzlediameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'))*1e-3;
if isnan(value)
    set(hObject, 'String', handles.default.Dnoz*1e3);
    errordlg('Input must be a number','Error');
else
    handles.data_input.Dnoz = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_nozzlediameter as text
%        str2double(get(hObject,'String')) returns contents of input_nozzlediameter as a double


% --- Executes during object creation, after setting all properties.
function input_nozzlediameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_nozzlediameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_penstockdiameter_Callback(hObject, eventdata, handles)
% hObject    handle to input_penstockdiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'))*1e-3;
if isnan(value)
    set(hObject, 'String', handles.default.Dp*1e3);
    errordlg('Input must be a number','Error');
else
    handles.data_input.Dp = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_penstockdiameter as text
%        str2double(get(hObject,'String')) returns contents of input_penstockdiameter as a double


% --- Executes during object creation, after setting all properties.
function input_penstockdiameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_penstockdiameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_riverflow_Callback(hObject, eventdata, handles)
% hObject    handle to input_riverflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'))*1e-3;
if isnan(value)
    set(hObject, 'String', handles.default.flow*1e3);
    errordlg('Input must be a number','Error');
else
    handles.data_input.flow = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_riverflow as text
%        str2double(get(hObject,'String')) returns contents of input_riverflow as a double


% --- Executes during object creation, after setting all properties.
function input_riverflow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_riverflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_generationefficiency_Callback(hObject, eventdata, handles)
% hObject    handle to input_generationefficiency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'))*1e-2;
if isnan(value)
    set(hObject, 'String', handles.default.rend*1e2);
    errordlg('Input must be a number','Error');
else
    handles.data_input.rend = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_generationefficiency as text
%        str2double(get(hObject,'String')) returns contents of input_generationefficiency as a double


% --- Executes during object creation, after setting all properties.
function input_generationefficiency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_generationefficiency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in input_penstockmaterial.
function input_penstockmaterial_Callback(hObject, eventdata, handles)
% hObject    handle to input_penstockmaterial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns input_penstockmaterial contents as cell array
%        contents{get(hObject,'Value')} returns selected item from input_penstockmaterial


% --- Executes during object creation, after setting all properties.
function input_penstockmaterial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_penstockmaterial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_minimalpower_Callback(hObject, eventdata, handles)
% hObject    handle to input_minimalpower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'))*1e3;
if isnan(value)
    set(hObject, 'String', handles.default.Pmin*1e-3);
    errordlg('Input must be a number','Error');
else
    handles.data_input.Pmin = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_minimalpower as text
%        str2double(get(hObject,'String')) returns contents of input_minimalpower as a double


% --- Executes during object creation, after setting all properties.
function input_minimalpower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_minimalpower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_maximumflow_Callback(hObject, eventdata, handles)
% hObject    handle to input_maximumflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'))*1e-2;
if isnan(value)
    set(hObject, 'String', handles.default.kappa*1e2);
    errordlg('Input must be a number','Error');
else
    handles.data_input.kappa = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_maximumflow as text
%        str2double(get(hObject,'String')) returns contents of input_maximumflow as a double


% --- Executes during object creation, after setting all properties.
function input_maximumflow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_maximumflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_maximumexcavation_Callback(hObject, eventdata, handles)
% hObject    handle to input_maximumexcavation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'));
if isnan(value)
    set(hObject, 'String', handles.default.Eexc);
    errordlg('Input must be a number','Error');
else
    handles.data_input.Eexc = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_maximumexcavation as text
%        str2double(get(hObject,'String')) returns contents of input_maximumexcavation as a double


% --- Executes during object creation, after setting all properties.
function input_maximumexcavation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_maximumexcavation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_elbowcost_Callback(hObject, eventdata, handles)
% hObject    handle to input_elbowcost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'));
if isnan(value)
    set(hObject, 'String', handles.default.Cc);
    errordlg('Input must be a number','Error');
else
    handles.data_input.Cc = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_elbowcost as text
%        str2double(get(hObject,'String')) returns contents of input_elbowcost as a double


% --- Executes during object creation, after setting all properties.
function input_elbowcost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_elbowcost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_maximumsupport_Callback(hObject, eventdata, handles)
% hObject    handle to input_maximumsupport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'));
if isnan(value)
    set(hObject, 'String', handles.default.Esup);
    errordlg('Input must be a number','Error');
else
    handles.data_input.Esup = value;
end
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_maximumsupport as text
%        str2double(get(hObject,'String')) returns contents of input_maximumsupport as a double


% --- Executes during object creation, after setting all properties.
function input_maximumsupport_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_maximumsupport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_import.
function push_import_Callback(hObject, eventdata, handles)
[filename,filepath] = uigetfile('*.xlsx','Save file');
fullpath            = strcat(filepath,filename);
try
    river = xlsread(fullpath);
    handles.data_input.river = river;
    axes(handles.main_axes)
    s = river(:,1);
    h = river(:,2);
    plot(s,h,'.','MarkerSize',.05)
    xlabel('s (m)')
    ylabel('z (m)')
    legend('River',[100 450 0.1 0.2])
    axis equal
    grid ON
    set(handles.push_solve,'Enable','On');
    N = length(s);
	set(handles.output_N,'String',N);
catch me
    errordlg('Error reading file','Error');
    set(handles.output_N,'String',' ');
end
% axis([ 0 river(1,end) 0 300 ]);
% xlabel('xlabel')
% ylabel('ylabel')
guidata(hObject,handles)


function input_riverfilename_Callback(hObject, eventdata, handles)
% hObject    handle to input_riverfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'));
handles.data_input.importfile = value;
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_riverfilename as text
%        str2double(get(hObject,'String')) returns contents of input_riverfilename as a double


% --- Executes during object creation, after setting all properties.
function input_riverfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_riverfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in push_solve.
function push_solve_Callback(hObject, eventdata, handles)
% erase solutions in main plot
axes(handles.main_axes)
cla
s = handles.data_input.river(:,1);
h = handles.data_input.river(:,2);
plot(s,h,'.','MarkerSize',.05)
xlabel('s (m)')
ylabel('z (m)')
legend('River',[100 450 0.1 0.2])
axis equal
grid ON
set(handles.push_solve,'Enable','On');
N = length(s);
set(handles.output_N,'String',N);
% desactivate of buttons
set(handles.push_solve,'String','Solving...');
set(handles.push_solve,'Enable','Off');
set(handles.push_reset,'Enable','Off');
set(handles.push_import,'Enable','Off');
% clear results
set(handles.output_P,'String',' ');
set(handles.output_Q,'String',' ');
set(handles.output_L,'String',' ');
set(handles.output_Nc,'String',' ');
set(handles.output_Hg,'String',' ');
pause(0.2)
results = solver( handles );
handles.results = results;
pause(0.2)

if results.success
    % Plot results
    axes(handles.main_axes)
    hold on
    plot(results.penstock,interp1(s,h,results.penstock),'dk-','LineWidth',1)
    legend('River','Penstock',[100 450 0.1 0.2])
    hold off
    % Write results
    set(handles.output_P,'String',results.P*1e-3);
    set(handles.output_Q,'String',results.Q*1e3);
    set(handles.output_Hg,'String',results.Hg);
    set(handles.output_L,'String',results.L);
    set(handles.output_Nc,'String',results.Nc);
else
    % show error
    errordlg('Optimal solution could not be found','Error');
end

set(handles.push_solve,'String','SOLVE');
set(handles.push_solve,'Enable','On');
set(handles.push_reset,'Enable','On');
set(handles.push_import,'Enable','On');

guidata(hObject,handles)


% --- Executes on button press in push_export.
function push_export_Callback(hObject, eventdata, handles)
status = 1;
set(handles.push_export,'String','Writing file...');
[ filename, filepath ] = uiputfile('*.xlsx','Save file','C:\Report.xlsx');
fullpath = strcat(filepath,filename);
status   = copyfile('templateReport.xlsx',fullpath,'f');
set(handles.push_solve,'Enable','Off');
set(handles.push_import,'Enable','Off');
set(handles.push_reset,'Enable','Off');
if ~status
    % show error
    errordlg('Eportation was''t done','Error');
else
    xlswrite(fullpath,handles.data_input.river,'river','A3');
    s = handles.data_input.river(:,1);
    h = handles.data_input.river(:,2);
    xlswrite(fullpath,handles.results.penstock,'river','C3');
    xlswrite(fullpath,interp1(s,h,handles.results.penstock),'river','D3');
    xlswrite(fullpath,handles.results.Q*1e3,'data','C7');
    xlswrite(fullpath,handles.results.L,'data','C8');
    xlswrite(fullpath,handles.results.Nc,'data','C9');
    xlswrite(fullpath,handles.results.P*1e-3,'data','C6');
end
set(handles.push_solve,'Enable','On');
set(handles.push_import,'Enable','On');
set(handles.push_reset,'Enable','On');
set(handles.push_export,'String','EXPORT');


function input_exportfilename_Callback(hObject, eventdata, handles)
% hObject    handle to input_exportfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject, 'String'));
handles.data_input.exportfile = value;
guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of input_exportfilename as text
%        str2double(get(hObject,'String')) returns contents of input_exportfilename as a double


% --- Executes during object creation, after setting all properties.
function input_exportfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_exportfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function output_Q_Callback(hObject, eventdata, handles)
% hObject    handle to output_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_Q as text
%        str2double(get(hObject,'String')) returns contents of output_Q as a double


% --- Executes during object creation, after setting all properties.
function output_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function output_P_Callback(hObject, eventdata, handles)
% hObject    handle to output_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_P as text
%        str2double(get(hObject,'String')) returns contents of output_P as a double


% --- Executes during object creation, after setting all properties.
function output_P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function output_L_Callback(hObject, eventdata, handles)
% hObject    handle to output_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_L as text
%        str2double(get(hObject,'String')) returns contents of output_L as a double


% --- Executes during object creation, after setting all properties.
function output_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function output_Nc_Callback(hObject, eventdata, handles)
% hObject    handle to output_Nc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_Nc as text
%        str2double(get(hObject,'String')) returns contents of output_Nc as a double


% --- Executes during object creation, after setting all properties.
function output_Nc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_Nc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function output_Hg_Callback(hObject, eventdata, handles)
% hObject    handle to output_Hg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_Hg as text
%        str2double(get(hObject,'String')) returns contents of output_Hg as a double


% --- Executes during object creation, after setting all properties.
function output_Hg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_Hg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function output_N_Callback(hObject, eventdata, handles)
% hObject    handle to output_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_N as text
%        str2double(get(hObject,'String')) returns contents of output_N as a double


% --- Executes during object creation, after setting all properties.
function output_N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function push_reset_Callback(hObject,eventdata, handles)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_penstock_optimizer (see VARARGIN)

% DEFAULT VALUES

handles.default.Dnoz            = 22e-3;
handles.default.Dp              = 20e-2;
handles.default.mat             = 1;
handles.default.flow            = 70e-3;
handles.default.rend            = 0.92;

handles.default.Pmin            = 10e3;
handles.default.kappa           = 0.50;
handles.default.Esup            = 1.0;
handles.default.Eexc            = 0.7;
handles.default.Cc              = 20;
handles.default.importfile      = 'example.xlsx';

% INITIALIZE WITH DEFAULT VALUES

handles.data_input.Dnoz         = handles.default.Dnoz;
handles.data_input.Dp           = handles.default.Dp;
handles.data_input.mat          = handles.default.mat;
handles.data_input.flow         = handles.default.flow;
handles.data_input.rend         = handles.default.rend;

handles.data_input.Pmin         = handles.default.Pmin;
handles.data_input.kappa        = handles.default.kappa;
handles.data_input.Esup         = handles.default.Esup;
handles.data_input.Eexc         = handles.default.Eexc;
handles.data_input.Cc           = handles.default.Cc;
handles.data_input.importfile   = handles.default.importfile;

guidata(hObject, handles);

% INITIALIZE GUIDE VALUES

set(handles.input_nozzlediameter,'String',handles.default.Dnoz*1e3);
set(handles.input_penstockdiameter,'String',handles.default.Dp*1e3);
set(handles.input_riverflow,'String',handles.default.flow*1e3);
set(handles.input_generationefficiency,'String',handles.default.rend*1e2);
set(handles.input_penstockmaterial,'Value',handles.default.mat);

set(handles.input_minimalpower,'String',handles.default.Pmin*1e-3);
set(handles.input_maximumflow,'String',handles.default.kappa*1e2);
set(handles.input_maximumsupport,'String',handles.default.Esup);
set(handles.input_maximumexcavation,'String',handles.default.Eexc);
set(handles.input_elbowcost,'String',handles.default.Cc);

set(handles.output_P,'String',' ');
set(handles.output_Q,'String',' ');
set(handles.output_L,'String',' ');
set(handles.output_Nc,'String',' ');
set(handles.output_Hg,'String',' ');

set(handles.push_solve,'Enable','Off');
set(handles.push_solve,'String','SOLVE');
set(handles.output_N,'String',' ');

% CLEAR MAIN PLOT

axes(handles.main_axes)
cla

% Update handles structure
% guidata(handles.data_input, handles);
guidata(hObject, handles);
