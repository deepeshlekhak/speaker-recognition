%-------------------------speaker Verification figure----------------------
%Ashok Sharma Paudel, Deepesh Lekhak, Keshav Bashayal, Sushma shrestha
%--------------------------------------------------------------------------


function varargout = verification(varargin)
% VERIFICATION M-file for verification.fig
%      VERIFICATION, by itself, creates a new VERIFICATION or raises the existing
%      singleton*.
%
%      H = VERIFICATION returns the handle to a new VERIFICATION or the handle to
%      the existing singleton*.
%
%      VERIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VERIFICATION.M with the given input arguments.
%
%      VERIFICATION('Property','Value',...) creates a new VERIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before verification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to verification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help verification

% Last Modified by GUIDE v2.5 01-May-2013 23:07:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @verification_OpeningFcn, ...
                   'gui_OutputFcn',  @verification_OutputFcn, ...
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


% --- Executes just before verification is made visible.
function verification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to verification (see VARARGIN)

% Choose default command line output for verification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes verification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = verification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global a;
global p;
try
   fid=fopen('total.txt','r');
        total=fscanf(fid,'%d');
        for i=1:total
            j=int2str(i);
             
            s=['gmm/',j,'.txt'];
    fid=fopen(s,'r');
 q=fread(fid,'*char');
 q=q';
 
fclose(fid);
             if strcmp(q,p.ans)==1
                 p.m=i;
             end
        end
data=getaudiodata(a.r);
ceps=featureExtract(data,22050);
j=p.m;
j=int2str(j);
s=['gmm/',j,'.mat'];
o=load(s);
m=o.m;
v=o.v;
w=o.w;
[d,f]=size(ceps);
log_lp = zeros(d,4); % for storing log(p(x|j)*p(j))
 
    
for n=1:d
    for k=1:4
        log_lp(n,k) = log( mvnpdf(ceps(n,:), m(k,:), v(:,:,k)) );
        log_lp(n,k) = log_lp(n,k) + log( w(1, k) );
    end
end
 sumt = logsumexp(log_lp,2);
  sss =sum(sumt );
  if abs(sss)<30000
  
    output='Sorry Access is denied.';
  else
     output=['welcome! ',p.ans];
 end
   

set(handles.text1,'string',output);
catch 
    me=lasterr();
    errordlg(me);
end


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);

figure(welcome);


