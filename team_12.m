function varargout = team_12(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @team_12_OpeningFcn, ...
                   'gui_OutputFcn',  @team_12_OutputFcn, ...
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

function team_12_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);


function varargout = team_12_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function upload_Image_Callback(hObject, eventdata, handles)
a=uigetfile({'*.*';'*.tif';'*.png';'*.jbg';'*.bmb';'*.gif';'*.svg';'*.psd';'*.raw'});% read this extensions from my folder
a=imread(a);                     % read Image in variable a
axes(handles.axes1);             % handle image in axis1 (as in buffer)
imshow(a)                        % show in axis1
setappdata(0,'a',a)              % make it global to used in another filters




function grayscale_RGB_Callback(hObject, eventdata, handles)
a=getappdata(0,'a');                % get original(global image)
    if (size(a,3)== 3)              % RGB image (3 colors)
        rgb_2_gray = rgb2gray(a);   % built in func. (convert RGB to gray)
        axes(handles.axes2);        % handle image in axis2 (as in buffer)
        imshow(rgb_2_gray);         % show in axis2 
    else
        msgbox('This image already in grey scale ^_^')   % in case it already in gray scale => (print this message)
        pause(3)                                         % pause 3 sec.
    end







function black_and_white_Callback(hObject, eventdata, handles)
a=getappdata(0,'a');
a_bw=im2bw(a,0.5);  %(0..1), if 1 => (black), 0 => white
axes(handles.axes2);
imshow(a_bw)






function reset_Callback(hObject, eventdata, handles)
a=getappdata(0,'a');
imshow(a);             % show original image







function Exit_Callback(hObject, eventdata, handles)
msgbox('See U Later ^_^')   
pause(3)        
close();        % close winodw of message
close();        % close project



function Negative_Callback(hObject, eventdata, handles)
a=getappdata(0,'a');
IM2=imcomplement(a);    % Built in func. to complement image 
axes(handles.axes2);
imshow(IM2);



function Rotate_Callback(hObject, eventdata, handles)
a=getappdata(0,'a');
rotate=imrotate(a,90);  % % Built in func. to rotate image by 90 degree ( can put any degree )
axes(handles.axes2);
imshow(rotate);





function Equalization_Callback(hObject, eventdata, handles)
a=getappdata(0,'a');
eq=histeq(a);       % apply equalize in original image (as Exambles in section 2) 
axes(handles.axes2);
imshow(eq)







function Resize_Callback(hObject, eventdata, handles)
a=getappdata(0,'a');
rz=imresize(a,0.5);     % decrease size(num. of pixels) of image, Ex: can increase  (1.1 .. 20), decrease(0.9 .. 0.009) 
axes(handles.axes2);
imshow(rz)


function Adjust_Image_Callback(hObject, eventdata, handles)
a=getappdata(0,'a');
adjust=imadjust(a,[0.3,0.6],[0,1]); % stretch histo. from specific range(0.3 .. 0.6) into full range(0 .. 1)
axes(handles.axes2);
imshow(adjust)







function Flip_Callback(hObject, eventdata, handles)
i=getappdata(0,'a');
i2=flipdim(i,2);    % any even Num (if Odd remain the same original image)
axes(handles.axes2);
imshow(i2)


function rgb_color_Callback(hObject, eventdata, handles)
    index = get(handles.rgb_color ,'value');

    a = getappdata(0,'a');

    if(index==1)
        msgbox('please Select RGB Color ...')
        pause(1)
    elseif(index==2)
          if (size(a,3)== 3)
            red=a;
            red(:,:,2:3)=0;
            axes(handles.axes2);
            imshow(red)
          else
            msgbox('apply in RGB Color Only...')
            pause(3) 
          end
    elseif(index==3)
          if (size(a,3)== 3)
            green=a;
            green(:,:,1)=0;
            green(:,:,3)=0;
            axes(handles.axes2);
            imshow(green)
          else
            msgbox('apply in RGB Color Only...')
            pause(3) 
          end
    elseif(index==4)
           if (size(a,3)== 3)
            blue=a;
            blue(:,:,1)=0;
            blue(:,:,2)=0;
            axes(handles.axes2);
            imshow(blue)
          else
            msgbox('apply in RGB Color Only...')
            pause(3) 
           end
    end

function rgb_color_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function salt_pepper_Callback(hObject, eventdata, handles)
        a = getappdata(0,'a'); 
        noise=imnoise(a,'salt & pepper');   % apply salt&pepper function to make original image Noisy.
        axes(handles.axes2);
        imshow(noise)
        setappdata(0,'noise',noise)


function Gaussian_Callback(hObject, eventdata, handles)
        a=getappdata(0,'a');
        noise=imnoise(a,'gaussian');    % apply gaussian function to make original image Noisy.
        axes(handles.axes2);
        imshow(noise);
        setappdata(0,'noise',noise)

function salt_Callback(hObject, eventdata, handles)
     b=getappdata(0,'a');
     if (size(b,3)== 3)
          b=rgb2gray(b);
     end
     noisy=imnoise(b,'salt & pepper',0.05);
     fun =@(x) max(x(:));
     noise=nlfilter(noisy,[3,3],fun);
     axes(handles.axes2);
     imshow(noise)
     setappdata(0,'noise',noise)

function pepper_Callback(hObject, eventdata, handles)
     b=getappdata(0,'a');
     if (size(b,3)== 3)
         b=rgb2gray(b);
     end
     noisy=imnoise(b,'salt & pepper',0.05);
     fun =@(x) min(x(:));
     noise=nlfilter(noisy,[3,3],fun);
     axes(handles.axes2);
     imshow(noise)
     setappdata(0,'noise',noise)




function speckle_Callback(hObject, eventdata, handles)        
     b=getappdata(0,'a');
     noise=imnoise(b,'speckle');
     axes(handles.axes2);
     imshow(noise)
     setappdata(0,'noise',noise)

function mid_filter_Callback(hObject, eventdata, handles)
    a = getappdata(0,'noise');
    if (size(a,3)== 3) 
        a=rgb2gray(a);
    end
    noisyPic=imnoise(a,'salt & pepper');
    nonNoisyPoc2=medfilt2(noisyPic,[3 3],'symmetric');  % apply mid to solve Noisy image (faile to enhanement it ) ,symmetric = Replicated 
    axes(handles.axes2);
    imshow(nonNoisyPoc2);



% --- Executes on slider movement.
function BrightSlider_Callback(hObject, eventdata, handles)
    data = get(handles.BrightSlider,'Value');   % Slider in range (-255 .. 255), data = value of slider
    a = getappdata(0,'a');
    bright = a + data;                          % original image + value of slider(+Ve or -Ve) 
    axes(handles.axes2);
    imshow(bright);
    
function BrightSlider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end








function edge_detection_Callback(hObject, eventdata, handles)
    a = getappdata(0,'a');
    hmask=fspecial('sobel');     %get matrix of sobel [[1,2,1],[0,0,0],[-1,-2,-1]]
    vmask=hmask';                % [[1,0,-1],[2,0,-2],[3,0,-3]]
    b_h=imfilter(a,hmask,'replicate');  % apply image filter in case horizontal mask, Using replicated padding
    b_v=imfilter(a,vmask,'replicate');  % apply image filter in case vertical mask, Using replicated padding
    grad=b_h+b_v;                       % apply horizontal & vertical together
    axes(handles.axes2);
    imshow(grad);                       % show grad (horizontal & vertical together)



function h_edge_Callback(hObject, eventdata, handles)
    a = getappdata(0,'a');
    hmask=fspecial('sobel');
    b_h=imfilter(a,hmask,'replicate');
    axes(handles.axes2);
    imshow(b_h);                        %show horizontal edge Only


function v_edge_Callback(hObject, eventdata, handles)
    a = getappdata(0,'a');
    hmask=fspecial('sobel');
    vmask=hmask';
    b_v=imfilter(a,vmask,'replicate');
    axes(handles.axes2);
    imshow(b_v);                        %show vertical edge Only


function laplacian_Callback(hObject, eventdata, handles)
    a = getappdata(0,'a');
    w=fspecial('laplacian',0);    %get matrix of Simple laplacian [[0,1,0],[1,-4,1],[0,1,0]]
    d1=imfilter(a,w,'replicate'); % apply image filter in case Laplacian, Using replicated padding
    axes(handles.axes2);
    imshow(d1);


function sharping_Callback(hObject, eventdata, handles)
    a = getappdata(0,'a');
    w=fspecial('laplacian');
    d1=imfilter(a,w,'replicate');
    b=a-d1;                         % Sharping = Original - Laplacian
    axes(handles.axes2);
    imshow(b);



function weighted_smoothing_Callback(hObject, eventdata, handles)
    a = getappdata(0,'a');
    w= [1 2 1; 2 4 2; 1 2 1]*(1/16);    % Weighted filter (1/16)
    a_w=imfilter(a,w,'replicate');
    axes(handles.axes2);
    imshow(a_w);


function Histograms_Callback(hObject, eventdata, handles)
    index = get(handles.Histograms ,'value');

    a = getappdata(0,'a');

    if(index==1)
        msgbox('please Select type of Histogram ...')
        pause(1)
    elseif(index==2)
        if (size(a,3)== 3) 
            axes(handles.axes2)
            imhist(a)       % built in (return histogram of image(RGB or Gray))
        else
            msgbox('apply in RGB Color Only...')
            pause(3)
        end
    elseif(index==3)
        if (size(a,3)== 3) 
            a=rgb2gray(a);
        end
            axes(handles.axes2)
            imhist(a)
    elseif(index==4)
            eq=histeq(a);       % apply equalize in original image (as Exambles in section 2) 
            axes(handles.axes2);
            imhist(eq)
    elseif(index==5)
            adjust=imadjust(a,[0.3,0.6],[0,1]); % stretch histo. from specific range(0.3 .. 0.6) into full range(0 .. 1)
            axes(handles.axes2);
            imhist(adjust)
    end


function Histograms_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_Callback(hObject, eventdata, handles)
     b=getappdata(0,'noise');
     if (size(b,3)== 3)
         b=rgb2gray(b);
     end
     fun =@(x) min(x(:));
     m=nlfilter(b,[3,3],fun);
     axes(handles.axes2);
     imshow(m)


function max_Callback(hObject, eventdata, handles)
     b=getappdata(0,'noise');
     if (size(b,3)== 3)
         b=rgb2gray(b);
     end
     fun =@(x) max(x(:));
     m=nlfilter(b,[3,3],fun);
     axes(handles.axes2);
     imshow(m)


function midian_Callback(hObject, eventdata, handles)
    a = getappdata(0,'noise');
    mF= @(x) median(x(:));
    d = nlfilter(a,[3 3],mF);
    axes(handles.axes2);
    imshow(d);


% --- Executes on button press in Arithmatic_mean.
function Arithmatic_mean_Callback(hObject, eventdata, handles)
    rest = getappdata(0,'a');
    Restore=imrest(rest,'amean',3,3);
    axes(handles.axes2);
    imshow(Restore)


% --- Executes on button press in Geometric_Mean.
function Geometric_Mean_Callback(hObject, eventdata, handles)
 rest = getappdata(0,'a');
 Restore=geomean(rest,3,3);
 axes(handles.axes2);
 imshow(Restore)


% --- Executes on button press in Harmonic_Mean.
function Harmonic_Mean_Callback(hObject, eventdata, handles)
rest = getappdata(0,'a');
Restore = imrest(rest,'hmean',3,3);
axes(handles.axes2);
imshow(Restore)


% --- Executes on button press in Contraharmonic_Mean.
function Contraharmonic_Mean_Callback(hObject, eventdata, handles)
 rest = getappdata(0,'a');
 Restore=imrest(rest,'chmean',3,3,2);
 axes(handles.axes2);
 imshow(Restore)


% --- Executes on button press in Alpha_trimmed.
function Alpha_trimmed_Callback(hObject, eventdata, handles)
 rest = getappdata(0,'a');
 Restore=imrest(rest,'atrimmed',3,3,2);  %its default value is D = 2
 axes(handles.axes2);
 imshow(Restore)
