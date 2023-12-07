function varargout = QR_encode(varargin)
% QR_ENCODE MATLAB code for QR_encode.fig
%      QR_ENCODE, by itself, creates a new QR_ENCODE or raises the existing
%      singleton*.
%
%      H = QR_ENCODE returns the handle to a new QR_ENCODE or the handle to
%      the existing singleton*.
%
%      QR_ENCODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QR_ENCODE.M with the given input arguments.
%
%      QR_ENCODE('Property','Value',...) creates a new QR_ENCODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QR_encode_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QR_encode_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QR_encode

% Last Modified by GUIDE v2.5 15-Oct-2022 21:57:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QR_encode_OpeningFcn, ...
                   'gui_OutputFcn',  @QR_encode_OutputFcn, ...
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


% --- Executes just before QR_encode is made visible.
function QR_encode_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QR_encode (see VARARGIN)

% Choose default command line output for QR_encode
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject, 'center');

% UIWAIT makes QR_encode wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = QR_encode_OutputFcn(hObject, eventdata, handles) 
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
% menampilkan menu browse image
[nama_file, nama_folder] = uigetfile('*.*');

% jika ada nama file yang diplih maka akan mengeksekusi perintah dibawah
% ini

if ~isequal(nama_file,0)
    % membaca file citra rgb
    I = imread(fullfile(nama_folder,nama_file));
    %menampilkan citra rgb pada axes 1
    axes(handles.axes1)
    imshow(I)
    title('Gambar Asal')
    % menyimpan variable img pada lokasi handles agar dapat dipanggil oleh
    % pushbutton yang lain
    handles.Img = I;
    guidata(hObject, handles)
else
    %jika tidak ada nama file yang dipilih maka akan kembali
    return
end



% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.pesanEdit,'String','')
set(handles.kunciEdit,'String','')
set(handles.hasilEdit,'String','')
clc
clear all


% --- Executes on button press in generateButton.
function generateButton_Callback(hObject, eventdata, handles)
% hObject    handle to generateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

javaaddpath('LibraryQR\zxing-1.7-core.jar');
javaaddpath('LibraryQR\zxing-1.7-javase.jar');

pesan = get(handles.hasilEdit,'String');
%jika hasilEdit belum diisi maka program tidak akan berjalan
if pesan == ""
    return
end

test_encode = encode_qr(pesan, [32 32]);

A = imagesc(test_encode);
colormap('gray');




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



function pesanEdit_Callback(hObject, eventdata, handles)
% hObject    handle to pesanEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pesanEdit as text
%        str2double(get(hObject,'String')) returns contents of pesanEdit as a double


% --- Executes during object creation, after setting all properties.
function pesanEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pesanEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


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


% --- Executes on button press in encryptButton.
function encryptButton_Callback(hObject, eventdata, handles)
% hObject    handle to encryptButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
l=[char(32), char(33), char(34), char(35), char(36), char(37), char(38), char(39), char(40), char(41), char(42), char(43), char(44), char(45), char(46), char(47), char(48), char(49), char(50), char(51), char(52), char(53), char(54), char(55), char(56), char(57), char(58), char(59), char(60), char(61), char(62), char(63), char(64), char(65), char(66), char(67), char(68), char(69), char(70), char(71), char(72), char(73), char(74), char(75), char(76), char(77), char(78), char(79), char(80), char(81), char(82), char(83), char(84), char(85), char(86), char(87), char(88), char(89), char(90), char(91), char(92), char(93), char(94), char(95), char(96), char(97), char(98), char(99), char(100), char(101), char(102), char(103), char(104), char(105), char(106), char(107), char(108), char(109), char(110), char(111), char(112), char(113), char(114), char(115), char(116), char(117), char(118), char(119), char(120), char(121), char(122), char(123), char(124), char(125), char(126)];
k = get(handles.kunciEdit,'String');
s11=size(k);
s1=s11(2);

%jika kunci belum diisi maka program tidak akan berjalan
if k == ""
    return
end

m = get(handles.pesanEdit,'String');
s22=size(m);
s2=s22(2);

%jika pesan belum diisi maka program tidak akan berjalan
if m == ""
    return
end

num = s2 / s1;
intnum = ceil(num)+1;
s3=s2-intnum*s1;
v=1:s3;
r = '';
for w=1:intnum
        r = append(r,k);
end
k=[[r],[k(v)]];

%---------------------------------------

for i=1:s2
vec1(i)=find(l==(m(i)))-1 ;
vec2(i)=find(l==k(i))-1; 
end
vec=vec1+vec2+1;
%---------------------------------------

for i=1:s2
    if vec(i)>95
        vec(i)=mod(vec(i),95);
    end
end
%---------------------------------------

for i=1:s2
    vecf(i)=l(vec(i));
end
hasil = num2str(vecf);
set(handles.hasilEdit,'String',hasil)





function hasilEdit_Callback(hObject, eventdata, handles)
% hObject    handle to hasilEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hasilEdit as text
%        str2double(get(hObject,'String')) returns contents of hasilEdit as a double


% --- Executes during object creation, after setting all properties.
function hasilEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hasilEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kunciEdit_Callback(hObject, eventdata, handles)
% hObject    handle to kunciEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kunciEdit as text
%        str2double(get(hObject,'String')) returns contents of kunciEdit as a double


% --- Executes during object creation, after setting all properties.
function kunciEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kunciEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simpanButton.
function simpanButton_Callback(hObject, eventdata, handles)
% hObject    handle to simpanButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fr = getframe(handles.axes1);

if ~exist('GambarQR', 'dir')
    mkdir('GambarQR')
end

[nama_file, nama_folder] = uiputfile('GambarQR\*.jpg;*.png;*.jpeg;*.tiff');
if nama_file == 0
	% jika user klik cancel.
	return;
end
fullFileName = fullfile(nama_folder,nama_file);
imwrite(fr.cdata, fullFileName);
