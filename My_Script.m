
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%    Clear the Work Space from previous variables   %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %clear the Work Space
        clear;
    %clear The command Window
        clc;
    % Close all figures (except those of imtool.)
        close all; 
    % Close all imtool figures if you have the Image Processing Toolbox.  
        imtool close all;
    % Make sure the workspace panel is showing.
        workspace;  
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%      Intialization      %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Number of people in the previous frame
        ni = 0;   
    % Number of people in the current frame
        nii = 0;
    % Intiallize Webcam and hold it in a variable
        cam = webcam;
    
    % Intiallize Viola-Jones algorithm to detect Faces
        FDetect = vision.CascadeObjectDetector;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%      Working Code       %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while(1)
  
% Take Snap Shots from the video to analyze
I = snapshot(cam);


%Change the Image to Black and white
I_GR = rgb2gray(I);


%Returns Bounding Box values based on number of objects
BB = step(FDetect,I_GR);

% Show RGB Image to be the current FRAME
imshow(I); 



%Make the next changes to the figure
hold on


% For LOOP to PUT boxes arround faces detected by the algorithm
for i = 1:size(BB,1)
  
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    % Position ---> Bounding BOX Position
    % Line Width of the BOX ---> 5
    % Line Style of the BOX ---> _____
    % Box Color --->  RED
    
end


% Save number of faces detected in the algorithm
number = size(BB,1);

%Convert the number of faces into string to be Shown
n_st = string(number);

% Change the STRING containg number of Persons shown on the figure after
% each frame
str = 'Number of Persons:  ' + n_st;


% PUT Title to the FIGURE
title('FIGHT CORONA VIRUS'); 

% Set the Dimensions of BOX 1 Containing number of persons in the picture
dim1 = [.2 .5 .3 .3];

% Draw a rectangle arround Shown Number of persons in the Picture
annotation('textbox',dim1,'LineWidth',5,'LineStyle','-','EdgeColor','b','Color','r','String',str,'fontsize',15,'FitBoxToText','on');
    % Text Box Rectangle
    % line Width --> 5
    % Line Style --> ___
    % Box Color --> Blue
    % Text Color --> RED
    % Text --> str variable
    % Font Size --> 15
    % Fit the BOX to the Boundaries of the TEXT Only
    
    
% Check if number of PEOPLE Exceeds 2, and so send a warning
if number > 1
    dim2 = [.2 .74 .25 .15];
    str2 = 'Large Number! - STAY APART! - STAYSAFE!';
    annotation('textbox',dim2,'LineWidth',5,'LineStyle','-','EdgeColor','b','Color','r','String',str2,'fontsize',15,'FitBoxToText','on');
end
 
% Update Number of people in the current frame
nii = number;

% Check if the number of people in the current frame diffres from the
% previous frame --> then delete the BOXES to bring new
if ni ~= nii
    delete(findall(gcf,'type','annotation'))
end

%Update number of people in the previous frame as it is the end
ni = nii;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
