global Calib

%screensize = get(0,'Screensize');
Calib.mondims1.x = -1920;%screensize(1);
Calib.mondims1.y = 0;%screensize(2);
Calib.mondims1.width = 1920;%screensize(3);
Calib.mondims1.height = 1080;%screensize(4);

Calib.MainMonid = 1; 
Calib.TestMonid = 1;

Calib.points.x = [0.1 0.9 0.5 0.9 0.1];  % X coordinates in [0,1] coordinate system 
Calib.points.y = [0.1 0.1 0.5 0.9 0.9];  % Y coordinates in [0,1] coordinate system
% switch to display coordinate
Calib.titleBarWidth = 20;
Calib.points.realy = ((Calib.mondims1.height-Calib.titleBarWidth).* Calib.points.y ...
    + Calib.titleBarWidth)/Calib.mondims1.height;

Calib.points.n = size(Calib.points.x, 2); % Number of calibration points
Calib.bkcolor = [0.85 0.85 0.85]; % background color used in calibration process
Calib.fgcolor = [0 0 1]; % (Foreground) color used in calibration process
Calib.fgcolor2 = [1 0 0]; % Color used in calibratino process when a second foreground color is used (Calibration dot)
Calib.BigMark = 25; % the big marker 
Calib.TrackStat = 25; % 
Calib.SmallMark = 7; % the small marker
Calib.delta = 200; % Moving speed from point a to point b
Calib.resize = 1; % To show a smaller window
Calib.NewLocation = get(gcf,'position');


