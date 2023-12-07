function varargout = QR_decode(varargin)
% QR_DECODE MATLAB code for QR_decode.fig
%      QR_DECODE, by itself, creates a new QR_DECODE or raises the existing
%      singleton*.
%
%      H = QR_DECODE returns the handle to a new QR_DECODE or the handle to
%      the existing singleton*.
%
%      QR_DECODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QR_DECODE.M with the given input arguments.
%
%      QR_DECODE('Property','Value',...) creates a new QR_DECODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QR_decode_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QR_decode_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QR_decode

% Last Modified by GUIDE v2.5 16-Oct-2022 06:38:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QR_decode_OpeningFcn, ...
                   'gui_OutputFcn',  @QR_decode_OutputFcn, ...
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


% --- Executes just before QR_decode is made visible.
function QR_decode_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QR_decode (see VARARGIN)

% Choose default command line output for QR_decode
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject, 'center');

% UIWAIT makes QR_decode wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = QR_decode_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pilihButton.
function pilihButton_Callback(hObject, eventdata, handles)
% hObject    handle to pilihButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% menampilkan menu browse image

if ~exist('GambarQR', 'dir')
    mkdir('GambarQR')
end

[nama_file, nama_folder] = uigetfile('GambarQR\*.jpg;*.png;*.jpeg;*.tiff');

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

axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.sebelumText,'String','Pesan')
set(handles.setelahText,'String','Pesan')
set(handles.kunciEdit,'String','')
set(handles.blurEdit,'String','0')


% --- Executes on button press in decodeQRButton.
function decodeQRButton_Callback(hObject, eventdata, handles)
% hObject    handle to decodeQRButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = handles.Img;
param = str2double(get(handles.blurEdit,'String'));
if param ~= 0
    I = imgaussfilt(I,param);
end
A = im2bw(I,0.5);

msg = readBarcode(A);
if (msg~="")
    axes(handles.axes2)
    imshow(A)
    title('Gambar Setelah proses')
    set(handles.sebelumText,'String',msg);
else
    c = 1 - A;
    %figure, imshow(c);
    msg = readBarcode(c);
    if(msg~="")
        axes(handles.axes2)
        imshow(c)
        title('Gambar Setelah proses')
        set(handles.sebelumText,'String',msg);
    else
        msg = 'Gambar tidak terdeteksi';
        set(handles.sebelumText,'String',msg);
    end
end


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


% --- Executes on button press in decryptButton.
function decryptButton_Callback(hObject, eventdata, handles)
% hObject    handle to decryptButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
l=[char(32), char(33), char(34), char(35), char(36), char(37), char(38), char(39), char(40), char(41), char(42), char(43), char(44), char(45), char(46), char(47), char(48), char(49), char(50), char(51), char(52), char(53), char(54), char(55), char(56), char(57), char(58), char(59), char(60), char(61), char(62), char(63), char(64), char(65), char(66), char(67), char(68), char(69), char(70), char(71), char(72), char(73), char(74), char(75), char(76), char(77), char(78), char(79), char(80), char(81), char(82), char(83), char(84), char(85), char(86), char(87), char(88), char(89), char(90), char(91), char(92), char(93), char(94), char(95), char(96), char(97), char(98), char(99), char(100), char(101), char(102), char(103), char(104), char(105), char(106), char(107), char(108), char(109), char(110), char(111), char(112), char(113), char(114), char(115), char(116), char(117), char(118), char(119), char(120), char(121), char(122), char(123), char(124), char(125), char(126)];
k = get(handles.kunciEdit,'String');
KeySize1=size(k);
KeySize=KeySize1(2);

%jika kunci belum diisi maka program tidak akan berjalan
if k == ""
    return
end

m = get(handles.sebelumText,'String');
WordSize2=size(m);
WordSize=WordSize2(2);

num = WordSize / KeySize;
%ceil = membulatkan bilangan ke atas
intnum = ceil(num)+1;
s3=WordSize-intnum*KeySize;
v=1:s3;
r = '';
for w=1:intnum
        r = append(r,k);
end
k=[[r],[k(v)]];

%---------------------------------------

for i=1:WordSize
vec1(i)=find(l==(m(i)))-1 ; %posisi pesan
vec2(i)=find(l==k(i))-1;    % posisi kunci
end
vec=vec1-vec2+1;
%---------------------------------------

for i=1:WordSize
    if vec(i)<0
        vec(i)=mod(vec(i),95);
    elseif vec(i)==0
        vec(i)=95;
    end
end
%---------------------------------------

for i=1:WordSize
    vecf(i)=l(vec(i));
end
hasil = num2str(vecf);
set(handles.setelahText,'String',hasil)



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



function blurEdit_Callback(hObject, eventdata, handles)
% hObject    handle to blurEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blurEdit as text
%        str2double(get(hObject,'String')) returns contents of blurEdit as a double


% --- Executes during object creation, after setting all properties.
function blurEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blurEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
