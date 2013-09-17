%
% EyeTrackingSample
%

% *************************************************************************
%
% Test setup
%
% *************************************************************************

cd /Volumes/davinci/MATLAB/TobiiDataCollect/
cd bin
clc 
clear all
close all

SetExpParams; % picture folder, time lapse
SetCalibParams; % calibration parameters, including secondary screen size
addpath('functions');
addpath('lib');
addpath('../tetio');  

% *************************************************************************
%
% Initialization and connection to the Tobii Eye-tracker
%
% *************************************************************************
 
disp('Initializing tetio...');
tetio_init();

% Set to tracker ID to the product ID of the tracker you want to connect to.
trackerId = 'TX300-010102210592';

%   FUNCTION "SEARCH FOR TRACKERS" IF NOTSET
if (strcmp(trackerId, 'NOTSET'))
	warning('tetio_matlab:EyeTracking', 'Variable trackerId has not been set.'); 
	disp('Browsing for trackers...');

	trackerinfo = tetio_getTrackers();
	for i = 1:size(trackerinfo,2)
		disp(trackerinfo(i).ProductId);
	end

	tetio_cleanUp();
	error('Error: the variable trackerId has not been set. Edit the EyeTrackingSample.m script and replace "NOTSET" with your tracker id (should be in the list above) before running this script again.');
end

fprintf('Connecting to tracker "%s"...\n', trackerId);
tetio_connectTracker(trackerId)
	
currentFrameRate = tetio_getFrameRate;
fprintf('Frame rate: %d Hz.\n', currentFrameRate);

% *************************************************************************
%
% Input test subject's information
% Name, gender, age, etc.
%
% *************************************************************************

subjectInfo = getSubjectInfo();

% *************************************************************************
%
% Select a viewing task
%
% *************************************************************************
fprintf('Please select a viewing task:\n');
fprintf('1. Free viewing\n2. Preference\n3. Memorize\n');
prompt = 'input the task number: ';
taskType = input(prompt);
if(taskType == 1)
    % free viewing function
    [leftEyeAll, rightEyeAll, timeStampAll, imgInfo] = freeViewDataCollect(Calib,SETTING);
elseif(taskType == 2)
    % Preference function
    [leftEyeAll, rightEyeAll, timeStampAll, imgInfo] = preferDataCollect(Calib,SETTING);

elseif(taskType == 3)
    error('under construction');
end

% *************************************************************************
%
% Save experiment result
%
% *************************************************************************
if(~exist('../data','dir'))
    mkdir('../','data');
end
savefile = sprintf('../data/gaze_%s_task#%d.mat',subjectInfo{1}, taskType );
save(savefile,'subjectInfo','leftEyeAll','rightEyeAll','timeStampAll','imgInfo','-v7.3');

disp('Program finished.');
