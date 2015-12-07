function varargout = ozi_l1_main(varargin)
% OZI_L1_MAIN MATLAB code for ozi_l1_main.fig
%      OZI_L1_MAIN, by itself, creates a new OZI_L1_MAIN or raises the existing
%      singleton*.
%
%      H = OZI_L1_MAIN returns the handle to a new OZI_L1_MAIN or the handle to
%      the existing singleton*.
%
%      OZI_L1_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OZI_L1_MAIN.M with the given input arguments.
%
%      OZI_L1_MAIN('Property','Value',...) creates a new OZI_L1_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ozi_l1_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ozi_l1_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ozi_l1_main

% Last Modified by GUIDE v2.5 13-Nov-2015 17:48:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ozi_l1_main_OpeningFcn, ...
                   'gui_OutputFcn',  @ozi_l1_main_OutputFcn, ...
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


% --- Executes just before ozi_l1_main is made visible.
function ozi_l1_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ozi_l1_main (see VARARGIN)

% Choose default command line output for ozi_l1_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load('CFN2.mat');
if exist('CFN2.mat')
set(handles.edit3,'String',CFN2);
end
% UIWAIT makes ozi_l1_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ozi_l1_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Кнопка выбора файла
function pushbutton1_Callback(hObject, eventdata, handles)
clc
% CFN - имя выбранного файла
% CFP - путь выбранного файла
[CFN,CFP]=uigetfile('*.*');
% Укажем имя выбранного файла в окне ввода сообщения
set(handles.edit2,'String',CFN);
% Сохраним путь к выбранному файлу, для дальнейшего его использования
save('CFP.mat','CFP');
save('CFN.mat','CFN');

function edit2_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Кнопка посчитать
function pushbutton2_Callback(hObject, eventdata, handles)
clc
% Загружаем данные по выбранному файлу
load('CFP.mat'); load('CFN.mat'); SIE=get(handles.edit2,'String');
% Процедура расчета избыточности и энтропии

% Переключатель используется для обработки различных вариантов входных
% данных, таких как либо простое сообщение, либо конкретного файла
switch isempty(SIE)
    case 1
%         В случае невведенного сообщения или не выбранного файла
%         появляется предупреждение
        warndlg('Необходимо ввести сообщение, либо выбрать файл!')
    case 0
       if strcmp(SIE,CFN)
%            В случае совпадения имени выбранного файла с сообщением в поле
%            реализуется сценарий расчета необходимых данных для файла
% Закрываем все предыдущие файлы
fclose('all');
% Открываем желаемый файл
CFI=fopen(strcat(CFP,CFN),'rb');
if CFI==-1
%     Предупреждаем об ошибке открытия файла в случае ее появления
    warndlg('Возникла ошибка при чтении файла!');
else
%   Читаем данные из бьинарного файла  
CF=fread(CFI)';
% Длина сообщения
LOS=numel(double(CF));
% Обьем алфавита
uniCF=unique(double(CF));
LOA=numel(uniCF);
% Нахождение вероятности каждого символа
for i=1:LOA
   P(i)=numel(find(double(CF)==uniCF(i)) )/LOS;
end
% Нахождение энтропии 
H=-sum(P.*log2(P));
% Нахождение избыточности
% Избыточность находится в случае недостижения энтропии своего
% максимального значения
if H<log2(LOA)
%     Максимальное количество информации
Imax=LOS*log2(LOA);
%     Вычисляем колличество информации в сообщении
for i=1:LOA
   I(i)=P(i)*LOS*log2(P(i)); 
end
I=-sum(I);
%     Вычисляем значение коэффициента избыточности
R=(Imax-I)/Imax;
else 
   Imax=LOS*log2(LOA);
   I=Imax;R=0;
end

TTT=[LOS LOA H log2(LOA) Imax I R]';
set(handles.uitable3,'DaTa',TTT);

end
       else
%            В случае совпадения имени выбранного файла с сообщением в поле
%            реализуется сценарий расчета необходимых данных для сообщения
%            в поле

% Длина сообщения
LOS=numel(double(SIE));
% Обьем алфавита
uniSIE=unique(double(SIE));
LOA=numel(uniSIE);
% Нахождение вероятности каждого символа
for i=1:LOA
   P(i)=numel(find(double(SIE)==uniSIE(i)) )/LOS;
end
% Нахождение энтропии 
H=-sum(P.*log2(P));
% Нахождение избыточности
% Избыточность находится в случае недостижения энтропии своего
% максимального значения
if H<log2(LOA)
%     Максимальное количество информации
Imax=LOS*log2(LOA);
%     Вычисляем колличество информации в сообщении
for i=1:LOA
   I(i)=P(i)*LOS*log2(P(i)); 
end
I=-sum(I);
%     Вычисляем значение коэффициента избыточности
R=(Imax-I)/Imax;
else 
   Imax=LOS*log2(LOA);
   I=Imax;R=0;
end

TTT=[LOS LOA H log2(LOA) Imax I R]';
set(handles.uitable3,'DaTa',TTT);

       end
end

%================================================================
%  --- Выбрать файл
function pushbutton3_Callback(hObject, eventdata, handles)
% CFN2 - имя выбранного файла
% CFP2 - путь выбранного файла
[CFN2,CFP2]=uigetfile('*.txt');
% Укажем имя выбранного файла в окне ввода сообщения
set(handles.edit3,'String',CFN2);
% Сохраним путь к выбранному файлу, для дальнейшего его использования
save('CFP2.mat','CFP2');
save('CFN2.mat','CFN2');



function edit3_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Кнопка кодирования
function pushbutton4_Callback(hObject, eventdata, handles)
clc
load('CFN2.mat');load('CFP2.mat');
% Определяем размерность блока данных
d=str2double(get(handles.edit4,'String'));
% Закрываем все предыдущие файлы
fclose('all');
% Открываем желаемый файл
CFI=fopen(strcat(CFP2,CFN2),'rb');
if CFI==-1
%     Предупреждаем об ошибке открытия файла в случае ее появления
    warndlg('Возникла ошибка при чтении файла!');
else
%   Читаем данные из бинарного файла  
CF=fread(CFI)';
save('message.mat','CF');

% Переводим данные к двоичному виду
CFbc=dec2bin(CF,8);

% приводим к строчному виду
CFb='';
for i=1:numel(CFbc(:,1))
   CFb = strcat(CFb,CFbc(i,:));
end
save('ncsignal.mat','CFb');
% делаем набор данных кратному размеру блока данных
if mod(numel(CFb),d)~=0
crat=numel(zeros(1,d-mod(numel(CFb),d)));
    for i=1:crat
       CFb=strcat(num2str(0),CFb);
    end
    save('crat.mat','crat');
else
    crat=0;
    save('crat.mat','crat');
end


CFbH='';
for i=1:d:numel(CFb)
    % Добавляем биты кода Хемминга
    bufH=strcat(CFb(i),'x');
   bufH=strcat(bufH,CFb(i+1:i+3));
   bufH=strcat(bufH,'x');
   bufH=strcat(bufH,CFb(i+4));
   bufH=strcat(bufH,'xx');
%    Находим индексы информационных битов =1
   nz_ind=numel(bufH)+1-find(bufH=='1');
%    Вычисляем значение контрольной суммы
   if ~isempty(nz_ind)
   nz_ind_b=dec2bin(nz_ind,8);
   [nrows,ncols]=(size(nz_ind_b));
   con_sum=nz_ind_b(1,:);
   if nrows>=2
   for k=1:nrows-1
       for j=1:ncols
      con_sum(j)=num2str(xor(str2double(con_sum(1,j)),str2double(nz_ind_b(k+1,j))));
       end
   end
   end

% Вставляем значение контрольной суммы в контрольные биты
   c_ind=find(bufH=='x');
   bufH(c_ind)=con_sum(5:8);
%    Проверка 
chek_ind=numel(bufH)+1-find(bufH=='1');
   chekb=dec2bin(chek_ind,8);
   [ckrows,ckcols]=(size(chekb));
   ch_sum=chekb(1,:);
    for k=1:ckrows-1
       for j=1:ckcols
      ch_sum(j)=num2str(str2double(ch_sum(j)) && str2double(chekb(k+1,j)));
       end
   end


   else
       % Вставляем значение контрольной суммы в контрольные биты
      con_sum='0000' ;
      c_ind=find(bufH=='x');
      bufH(c_ind)=con_sum(1:4);
end
   CFbH=strcat(CFbH,bufH);
end
signal=CFbH;
save('signal.mat','signal');
end



function edit4_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Кнопка раскодирования
function pushbutton5_Callback(hObject, eventdata, handles)
clc
load('signal.mat');
% signal_noise=signal;
% save('signal_noise.mat','signal_noise');

for cou=1:str2double(get(handles.edit5,'String'))
    
pushbutton6_Callback(hObject, eventdata, handles,cou);

if exist('signal_noise.mat')
%    Получаем переданный сигнал
    load('signal_noise.mat');
% %    Приводим к "блочному виду"
% Находи длинну блока данных + битов Хемминга
sx=(str2double(get(handles.edit4,'String'))+4);
% Определяем кол-во данных блоков
sy=numel(signal_noise)/(str2double(get(handles.edit4,'String'))+4);
% Приводим к блочному виду
SIR=(num2str(reshape(signal_noise,[sx sy])))';

% Запоминаем 
SIR_=SIR;
% Выявляем биты кода ХЕмминга
SIR(:,[2 6 8 9])='x';



for i=1:numel(SIR(:,1))
%    Находим индексы информационных битов = 1
   nz_ind=numel(SIR(i,:))+1-find(SIR(i,:)=='1');


%    Вычисляем значение контрольной суммы
if ~isempty(nz_ind);
% ПОлучаем двоичные значения информационных битов ==1
   nz_ind_b=dec2bin(nz_ind,8);
%    Определяем кол-во дв. цифр и битов в них
   [nrows,ncols]=(size(nz_ind_b));
%    определяем контроьльную сумму как или-не битов
   con_sum=nz_ind_b(1,:);

           if nrows>=2
               for k=1:nrows-1
                       for j=1:ncols
                          con_sum(j)=num2str(xor(str2double(con_sum(1,j)),str2double(nz_ind_b(k+1,j))));
                       end
               end
           end


    % Определяем индексы битов Хемминга
       c_ind=find(SIR(i,:)=='x');       
       con_sum=con_sum(end-3:end);

 
% Заменяем биты Хемминга на контрольную сумму
       SIR(i,c_ind)=con_sum(1:4);
       
 
%    Проверка восстановленный сигнал с полученным
%  SIR(i,:)    
% SIR_(i,:)
% SIR(i,[2 6 8 9])
% SIR_(i,[2 6 8 9])

            if ~strcmp(SIR(i,[2 6 8 9]),SIR_(i,[2 6 8 9]))

                % Определяем индексы несовпадающих элементов
                for ii=[2 6 8 9]
                wr_ind(ii)=xor(str2double(SIR(i,ii)),str2double(SIR_(i,ii)));
                end
            
% Инвертируем индексы
                ind2c=abs(numel(SIR(i,:))-find(wr_ind==1)+1);
               if sum(ind2c)<=numel(SIR(i,:))
% Находим сумму индексов
                ind2c=abs(numel(SIR(i,:))- sum(ind2c)+1);
                
       
                SIR(i,ind2c)=num2str(~(str2double(SIR(i,ind2c))));

               end
             end


else
       % Вставляем значение контрольной суммы в контрольные биты
      con_sum='0000';
% Находим индексы битов Хемминга
      c_ind=find(SIR(i,:)=='x');
% Заменяем биты Хемминга на значения контрольной суммы
      SIR(i,c_ind)=con_sum(1:4);

end


end


% Удаляем биты Хемминга
resS='';
for e=1:numel(SIR(:,1))
bufS=SIR(e,:);
bufS([2 6 8 9])='';
resS=strcat(resS,bufS);
end
% reshape(resS,[5 7])'

% Удаляем лишние биты
load('crat.mat');

resS(1:crat)='';
resS=reshape(resS,[8 (numel(resS)/8)])';


mess(cou,:)=(bin2dec(resS)');
char(mess);

else
   warndlg('Сперва кодируйте сигнал') ;
end

load('signal_noise2.mat','signal_noise2');

qq=reshape(signal_noise2,[8 numel(signal_noise2)/8])';
nc_S(cou,:)=bin2dec(qq)';

end   % cou


% Построение графиков
axes(handles.axes2);
char(mess(end,:));
load('message.mat'); 
for i=1:cou
    err_nc(i)=numel(find(eq(CF,nc_S(i,:))==0));
err(i)=numel(find(eq(CF,mess(i,:))==0));
end

plot(1:numel(err),err);grid on;
xlabel({'Кол-во измененных бит','кодированного файла'});
ylabel('Кол-во испорченных символов');

axes(handles.axes1)
plot(1:numel(err_nc),err_nc);grid on;
xlabel({'Кол-во измененных бит','некодированного файла'});
ylabel('Кол-во испорченных символов');

% --- Кнопка добавления шума
function pushbutton6_Callback(hObject, eventdata, handles,cou)
if exist('signal.mat')
    load('signal.mat');
    load('ncsignal.mat');
    cou
   signal_noise=add_noise(signal,cou);
   signal_noise2=add_noise(CFb,cou);
   
%    [signal_noise signal_noise2]=add_noise(signal,CFb,cou);
   save('signal_noise.mat','signal_noise');
   save('signal_noise2.mat','signal_noise2');
else
   warndlg('Сперва сгенерируйте сигнал') ;
end




function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
