function varargout = main(varargin)
% MAIN MATLAB code for main.fig
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
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main


%+-----------------------------------------------------------------------+
%|                        Variáveis                                      |
%+-----------------------------------------------------------------------+

quitGame = false;
gameOver = false;
theta = [];
x=[];
y=[];
xmira=[0];
ymira=[0];
click_x=[];
click_y=[];
tmax =[];
xmax =[];
dt =[];
t =[];
xy_max =[];
xypig_max =[];
vx=[];
vy=[];
vfinal=[];
g=9.81;
v = 50;
vxpig=[];
%posição do alvo
pig_y = 1;
pig_x = 180;

%+-----------------------------------------------------------------------+
%|                        funcoes do tiro                                      |
%+-----------------------------------------------------------------------+

function fisica
    theta=pi*theta/180;
    tmax=(2*v/g)*sin(theta);
    xmax=tmax*v*cos(theta);
    dt=tmax/100;
    t=0:dt:tmax-dt;
    x=(v*cos(theta)).*t;
    y=(v*sin(theta)).*t-g*.5*t.^2;

    % Checar Limites
    xy_max = [max(x) max(y)];
    xypig_max = [max([x pig_x]) max([y pig_y])];
    % break

    vx=x/(cos(theta).*t.^2);
    vy=(.5*g*t.^2+y)/(sin(theta).*t);
    vfinal=sqrt(vx.^2+vy.^2);
    % plotar(x,y,pig_x,pig_y)
    vxpig=pig_x./(t.*cos(theta));
    vypig=(.5*g*t.^2+pig_y)/(sin(theta).*t);
    vpig=sqrt(vxpig.^2+vypig.^2);
end

function atirar
    for i = 1 :length(t)
        %image([x(i)-5 x(i)],[y(i)-5 y(i)], projetil);
        plot(x(i),y(i),'o','LineWidth',1,'MarkerEdgeColor','r')

        if i == length(t)
            plot(x(i),y(i),'*r', 'MarkerSize', 10, 'LineWidth', 2) % Bird splat!
        end
        
        axis([0,max([x,pig_x]),0,max([y,pig_y])])
        hold on

        plot(pig_x,pig_y,'-go', 'MarkerSize', 10, 'LineWidth', 5)
        collision(i) = 0;
        if abs(y(i)-pig_y)<2 && abs(x(i)-pig_x)<2
            plot(x(i),y(i),'*g', 'MarkerSize', 40, 'LineWidth', 15) % Pig explodes!
            collision (i) = 1;
        end
        plot(xlim, [0 0], '-k');
        axis equal;
        M(i)=getframe;
        hold off
        pig_hit = find(collision == 1);
    end
end %shoot

%+-----------------------------------------------------------------------+
%|                        funcoes da mira                                      |
%+-----------------------------------------------------------------------+

function pega_pontos
    [click_x, click_y] = ginput(1);
end

function add_pontos
    xmira = [ xmira; click_x];
    ymira = [ ymira; click_y];
end

%%% ajustar uma reta pelo MMQ
function plota
    A=[ones(size(xmira)) xmira]; % só 1 na primeira coluna

    c=A\ymira; % solução de Ac=y representa reta ya_j=c_1+c_2 x_j
    ya= c(1)+c(2)*xmira;
    plot(xmira,ymira,'r*', xmira,ya,'b');
    axis([0 10 0 10]);

    % calcular angulo
    theta = radtodeg(atan(c(2)))
    %theta = atan2(norm(cross(d,f)), dot(d,f))

    % calcular resíduo
    yaux=A*c;
    res=ymira-yaux;
    ResiduoMMQ=res'*res; % res transposto * res
end





% Last Modified by GUIDE v2.5 30-Nov-2015 04:09:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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

% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to main (see VARARGIN)

    % Choose default command line output for main
    handles.output = hObject;

    % Update handles structure

    guidata(hObject, handles);

    while ~quitGame
        pega_pontos;
        add_pontos;
        axes(handles.axesangulo);
        plota;
        set(handles.angulobox, 'String', theta);
        fisica;
        axes(handles.axesatirar);
        atirar;
    end

    % UIWAIT makes main wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% Get default command line output from handles structure
varargout{1} = handles.output;
end

end %main
