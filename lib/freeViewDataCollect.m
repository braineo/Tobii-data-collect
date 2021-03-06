function [leftEyeAll, rightEyeAll, timeStampAll, imgInfo] = freeViewDataCollect(Calib,SETTING)
% function freeViewDataCollect(Calib,SETTING) % for test
% *************************************************************************
%
% Collect gaze under free viewing
%
% *************************************************************************

DISPLAYNUM = 2;
expRestartOffset = 1; 
% If the program freezes and need to continue the experiment, offset this
% number to start from where it stopped
calibrateTracker(Calib);

img = imreadResize(SETTING.instructionFreeImage, Calib);
fullscreen(img, DISPLAYNUM);
pause(SETTING.restRemindTimeInSecond);
stimfolder = SETTING.freeStimfolder;
files=dir(fullfile(stimfolder,'*.jpg'));    
[filenames{1:size(files,1)}] = deal(files.name);

% divide into subset (in case that program freezes)
subsetSize = SETTING.restAfterViewImgNum;
subsetNum = ceil(length(filenames)/subsetSize);
imgIdx = cell(1,subsetNum);
shuffelOrder = randperm(length(filenames));
for i = 1:(subsetNum-1)
    imgIdx{i} = shuffelOrder(1+(i-1)*subsetSize:i*subsetSize);
end
imgIdx{subsetNum} = shuffelOrder(i*subsetSize+1:end);
if(exist('tmp','dir'))
    rmdir('tmp','s');
    mkdir('tmp');
else
    mkdir('tmp');
end
save('./tmp/subset.mat','imgIdx','-v7.3');

viewedImgNum = 0;

for subseti = expRestartOffset:subsetNum
    for i = imgIdx{subseti}

        if(~mod(viewedImgNum,SETTING.restAfterViewImgNum) && viewedImgNum~=0)
            % rest
            img = imreadResize(SETTING.restImage, Calib);
            fullscreen(img, DISPLAYNUM);
            % save progress data
            savefile = sprintf('./tmp/gaze_set#%d.mat',subseti-1);
            save(savefile,'leftEyeAll','rightEyeAll','timeStampAll','imgInfo','subseti','-v7.3');
            pause(SETTING.restRemindTimeInSecond);
            closescreen;
            tetio_stopTracking;
            waitforbuttonpress; % pause, press any key when ready to start
            calibrateTracker(Calib);
        end

        img = imreadResize(SETTING.intervalImage, Calib);
        fullscreen(img, DISPLAYNUM);
        pause(SETTING.gazeResetTimeInSeconds);

        img = imreadResize(strcat(stimfolder,filenames{i}), Calib);
        fullscreen(img, DISPLAYNUM);
        % read gaze data
        tetio_startTracking;
        [leftEye, rightEye, timeStamp] = ...
            DataCollect(SETTING.durationInSeconds, SETTING.frameRate);
        tetio_stopTracking;
        
        leftEyeAll{i} = leftEye;
        rightEyeAll{i} = rightEye;
        timeStampAll{i} = timeStamp;
        imgInfo{i}.fileName = filenames{i};
        imgInfo{i}.folder = stimfolder;

        viewedImgNum = viewedImgNum + 1;
    end
end
closescreen;

tetio_disconnectTracker; 
tetio_cleanUp;