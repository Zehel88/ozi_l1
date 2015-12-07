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


% --- ������ ������ �����
function pushbutton1_Callback(hObject, eventdata, handles)
clc
% CFN - ��� ���������� �����
% CFP - ���� ���������� �����
[CFN,CFP]=uigetfile('*.*');
% ������ ��� ���������� ����� � ���� ����� ���������
set(handles.edit2,'String',CFN);
% �������� ���� � ���������� �����, ��� ����������� ��� �������������
save('CFP.mat','CFP');
save('CFN.mat','CFN');

function edit2_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- ������ ���������
function pushbutton2_Callback(hObject, eventdata, handles)
clc
% ��������� ������ �� ���������� �����
load('CFP.mat'); load('CFN.mat'); SIE=get(handles.edit2,'String');
% ��������� ������� ������������ � ��������

% ������������� ������������ ��� ��������� ��������� ��������� �������
% ������, ����� ��� ���� ������� ���������, ���� ����������� �����
switch isempty(SIE)
    case 1
%         � ������ ������������ ��������� ��� �� ���������� �����
%         ���������� ��������������
        warndlg('���������� ������ ���������, ���� ������� ����!')
    case 0
       if strcmp(SIE,CFN)
%            � ������ ���������� ����� ���������� ����� � ���������� � ����
%            ����������� �������� ������� ����������� ������ ��� �����
% ��������� ��� ���������� �����
fclose('all');
% ��������� �������� ����
CFI=fopen(strcat(CFP,CFN),'rb');
if CFI==-1
%     ������������� �� ������ �������� ����� � ������ �� ���������
    warndlg('�������� ������ ��� ������ �����!');
else
%   ������ ������ �� ���������� �����  
CF=fread(CFI)';
% ����� ���������
LOS=numel(double(CF));
% ����� ��������
uniCF=unique(double(CF));
LOA=numel(uniCF);
% ���������� ����������� ������� �������
for i=1:LOA
   P(i)=numel(find(double(CF)==uniCF(i)) )/LOS;
end
% ���������� �������� 
H=-sum(P.*log2(P));
% ���������� ������������
% ������������ ��������� � ������ ������������ �������� ������
% ������������� ��������
if H<log2(LOA)
%     ������������ ���������� ����������
Imax=LOS*log2(LOA);
%     ��������� ����������� ���������� � ���������
for i=1:LOA
   I(i)=P(i)*LOS*log2(P(i)); 
end
I=-sum(I);
%     ��������� �������� ������������ ������������
R=(Imax-I)/Imax;
else 
   Imax=LOS*log2(LOA);
   I=Imax;R=0;
end

TTT=[LOS LOA H log2(LOA) Imax I R]';
set(handles.uitable3,'DaTa',TTT);

end
       else
%            � ������ ���������� ����� ���������� ����� � ���������� � ����
%            ����������� �������� ������� ����������� ������ ��� ���������
%            � ����

% ����� ���������
LOS=numel(double(SIE));
% ����� ��������
uniSIE=unique(double(SIE));
LOA=numel(uniSIE);
% ���������� ����������� ������� �������
for i=1:LOA
   P(i)=numel(find(double(SIE)==uniSIE(i)) )/LOS;
end
% ���������� �������� 
H=-sum(P.*log2(P));
% ���������� ������������
% ������������ ��������� � ������ ������������ �������� ������
% ������������� ��������
if H<log2(LOA)
%     ������������ ���������� ����������
Imax=LOS*log2(LOA);
%     ��������� ����������� ���������� � ���������
for i=1:LOA
   I(i)=P(i)*LOS*log2(P(i)); 
end
I=-sum(I);
%     ��������� �������� ������������ ������������
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
%  --- ������� ����
function pushbutton3_Callback(hObject, eventdata, handles)
% CFN2 - ��� ���������� �����
% CFP2 - ���� ���������� �����
[CFN2,CFP2]=uigetfile('*.txt');
% ������ ��� ���������� ����� � ���� ����� ���������
set(handles.edit3,'String',CFN2);
% �������� ���� � ���������� �����, ��� ����������� ��� �������������
save('CFP2.mat','CFP2');
save('CFN2.mat','CFN2');



function edit3_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- ������ �����������
function pushbutton4_Callback(hObject, eventdata, handles)
clc
load('CFN2.mat');load('CFP2.mat');
% ���������� ����������� ����� ������
d=str2double(get(handles.edit4,'String'));
% ��������� ��� ���������� �����
fclose('all');
% ��������� �������� ����
CFI=fopen(strcat(CFP2,CFN2),'rb');
if CFI==-1
%     ������������� �� ������ �������� ����� � ������ �� ���������
    warndlg('�������� ������ ��� ������ �����!');
else
%   ������ ������ �� ��������� �����  
CF=fread(CFI)';
save('message.mat','CF');

% ��������� ������ � ��������� ����
CFbc=dec2bin(CF,8);

% �������� � ��������� ����
CFb='';
for i=1:numel(CFbc(:,1))
   CFb = strcat(CFb,CFbc(i,:));
end
save('ncsignal.mat','CFb');
% ������ ����� ������ �������� ������� ����� ������
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
    % ��������� ���� ���� ��������
    bufH=strcat(CFb(i),'x');
   bufH=strcat(bufH,CFb(i+1:i+3));
   bufH=strcat(bufH,'x');
   bufH=strcat(bufH,CFb(i+4));
   bufH=strcat(bufH,'xx');
%    ������� ������� �������������� ����� =1
   nz_ind=numel(bufH)+1-find(bufH=='1');
%    ��������� �������� ����������� �����
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

% ��������� �������� ����������� ����� � ����������� ����
   c_ind=find(bufH=='x');
   bufH(c_ind)=con_sum(5:8);
%    �������� 
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
       % ��������� �������� ����������� ����� � ����������� ����
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


% --- ������ ��������������
function pushbutton5_Callback(hObject, eventdata, handles)
clc
load('signal.mat');
% signal_noise=signal;
% save('signal_noise.mat','signal_noise');

for cou=1:str2double(get(handles.edit5,'String'))
    
pushbutton6_Callback(hObject, eventdata, handles,cou);

if exist('signal_noise.mat')
%    �������� ���������� ������
    load('signal_noise.mat');
% %    �������� � "�������� ����"
% ������ ������ ����� ������ + ����� ��������
sx=(str2double(get(handles.edit4,'String'))+4);
% ���������� ���-�� ������ ������
sy=numel(signal_noise)/(str2double(get(handles.edit4,'String'))+4);
% �������� � �������� ����
SIR=(num2str(reshape(signal_noise,[sx sy])))';

% ���������� 
SIR_=SIR;
% �������� ���� ���� ��������
SIR(:,[2 6 8 9])='x';



for i=1:numel(SIR(:,1))
%    ������� ������� �������������� ����� = 1
   nz_ind=numel(SIR(i,:))+1-find(SIR(i,:)=='1');


%    ��������� �������� ����������� �����
if ~isempty(nz_ind);
% �������� �������� �������� �������������� ����� ==1
   nz_ind_b=dec2bin(nz_ind,8);
%    ���������� ���-�� ��. ���� � ����� � ���
   [nrows,ncols]=(size(nz_ind_b));
%    ���������� ������������ ����� ��� ���-�� �����
   con_sum=nz_ind_b(1,:);

           if nrows>=2
               for k=1:nrows-1
                       for j=1:ncols
                          con_sum(j)=num2str(xor(str2double(con_sum(1,j)),str2double(nz_ind_b(k+1,j))));
                       end
               end
           end


    % ���������� ������� ����� ��������
       c_ind=find(SIR(i,:)=='x');       
       con_sum=con_sum(end-3:end);

 
% �������� ���� �������� �� ����������� �����
       SIR(i,c_ind)=con_sum(1:4);
       
 
%    �������� ��������������� ������ � ����������
%  SIR(i,:)    
% SIR_(i,:)
% SIR(i,[2 6 8 9])
% SIR_(i,[2 6 8 9])

            if ~strcmp(SIR(i,[2 6 8 9]),SIR_(i,[2 6 8 9]))

                % ���������� ������� ������������� ���������
                for ii=[2 6 8 9]
                wr_ind(ii)=xor(str2double(SIR(i,ii)),str2double(SIR_(i,ii)));
                end
            
% ����������� �������
                ind2c=abs(numel(SIR(i,:))-find(wr_ind==1)+1);
               if sum(ind2c)<=numel(SIR(i,:))
% ������� ����� ��������
                ind2c=abs(numel(SIR(i,:))- sum(ind2c)+1);
                
       
                SIR(i,ind2c)=num2str(~(str2double(SIR(i,ind2c))));

               end
             end


else
       % ��������� �������� ����������� ����� � ����������� ����
      con_sum='0000';
% ������� ������� ����� ��������
      c_ind=find(SIR(i,:)=='x');
% �������� ���� �������� �� �������� ����������� �����
      SIR(i,c_ind)=con_sum(1:4);

end


end


% ������� ���� ��������
resS='';
for e=1:numel(SIR(:,1))
bufS=SIR(e,:);
bufS([2 6 8 9])='';
resS=strcat(resS,bufS);
end
% reshape(resS,[5 7])'

% ������� ������ ����
load('crat.mat');

resS(1:crat)='';
resS=reshape(resS,[8 (numel(resS)/8)])';


mess(cou,:)=(bin2dec(resS)');
char(mess);

else
   warndlg('������ ��������� ������') ;
end

load('signal_noise2.mat','signal_noise2');

qq=reshape(signal_noise2,[8 numel(signal_noise2)/8])';
nc_S(cou,:)=bin2dec(qq)';

end   % cou


% ���������� ��������
axes(handles.axes2);
char(mess(end,:));
load('message.mat'); 
for i=1:cou
    err_nc(i)=numel(find(eq(CF,nc_S(i,:))==0));
err(i)=numel(find(eq(CF,mess(i,:))==0));
end

plot(1:numel(err),err);grid on;
xlabel({'���-�� ���������� ���','������������� �����'});
ylabel('���-�� ����������� ��������');

axes(handles.axes1)
plot(1:numel(err_nc),err_nc);grid on;
xlabel({'���-�� ���������� ���','��������������� �����'});
ylabel('���-�� ����������� ��������');

% --- ������ ���������� ����
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
   warndlg('������ ������������ ������') ;
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
