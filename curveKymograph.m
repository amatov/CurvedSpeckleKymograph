function sizeCD = curveKymograph(nbSlices,nbImages,path,ext)

% curveKymograph dispay a curved kymograph 
% acording to manual screen point selection
% 
% if there are less than 3 three points selected 
% it runs the kymograph on a straight or vertical line
% 
% if there are 3 or more points selected it fits them 
% to a spline and shows the kymograph along this curve
%
% this function is only applicable to point selections for which
% consequtive points are selected above each other (vertical kymograph)
%
% STEPS:
% 1) choose the first image of a sequence
% 2) choose a filament for the kymograph
% by clicking on severval points of the image
% 3) press ENTER to continue
%
% SYNOPSIS   sizeCD = curveKymograph(nbSlices,nbImages,path,ext)
%
% INPUT      nbSlices   :    Number of slices per image 
%                            (default 5)
%            nbImages   :    Number of images considered 
%                            (default 9)
%            path       :    Image path
%            ext        :    File extension
%            
% OUTPUT     sizeCD     :    Number of points on the curve (rows of the kymograph)
%
% REMARKS    choose nbSlices to be an odd number so it has a middle point
%
% DEPENDENCES   curveKymograph uses { getFilenameBody }
%               curveKymograph is used by { }
%
% Alexandre Matov, November 18th, 2002

if nargin==0
    nbSlices=5;
    nbImages=9;
    path = 'C:\ImagesForKymograph';
    ext = 'tif';
end  

% load first image
[fileName,dirName] = uigetfile('*.tif','Choose the First Image of a Sequence For the Curve Kymograph!');
%fileName = fileName(1:end-6)

if(isa(fileName,'char') & isa(dirName,'char'))
   [I,map]=imread([dirName,fileName]);
   I=double(I);
   I=(I-min(I(:)))/(max(I(:))-min(I(:)));  
else
    return
end
fileName = fileName(1:end-6);
    
% select points
imshow(I,[]);
[rx,ry]=getline;

rx=rx(1:end);  
ry=ry(1:end);
sizerx=size(rx,1); % number of points selected by user

if sizerx==2
    button = questdlg('You have selected only two points!',...
        'Type of Kymograph Preferred','Vertical','Line Profile','Line Profile');
    if strcmp(button,'Vertical')
        disp('Vertical Kymograph Chosen')
        rx(2)=rx(1);
    elseif strcmp(button,'Line Profile')
        disp('Line Profile Chosen')
    end
    
end
% fitting the selected points with a curve
minr=min(ry); 
maxr=max(ry); 

%y-axis 
AB=minr:maxr;          
%x-axis 
CD=spline(ry,rx,AB);  % calculate the splines at each point  

sizeCD=size(CD,2); % number of rows
d=zeros(1,nbSlices*nbImages+1); % number of columns

s=length(num2str(nbImages))+1;% +1 for 3 digits
strg=sprintf('%%.%dd',s); 
aux=fix((nbSlices-1)/2);

h=waitbar(0,'Please wait! The program is creating the kymograph following your selection of points');
for i=1:sizeCD % number of points in the fitting curve (or number of row of the kymograph)
    c=zeros(1,1);
    for k = 1:nbImages 
        indxStr=sprintf(strg,k);
        a1=imread([dirName,fileName,indxStr,'.tif']);
        b1=imcrop(a1,[CD(i)-aux,AB(i),2*aux,0]); % CD 
        c=[c b1];    
    end
    d(i+1,:)=c;
    waitbar(i/sizeCD,h);  
end
close(h);
% figures
imshow(I); % chosen image
hold on
plot(rx,ry,'r*'); % points selected by user
plot(CD,AB,'g-'); % fitting curve
hold off
figure,imshow(d(2:end,2:end),[]); % display kymograph

% results
fprintf('number of images processed %d\n',nbImages);
fprintf('number of slices taken from each image %d\n',nbSlices);
fprintf('number of points on the curve (rows of the kymograph) %d\n',sizeCD);