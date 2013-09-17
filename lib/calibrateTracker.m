% *************************************************************************
%
% Calibration of a participant
%
% *************************************************************************
function calibrateTracker(Calib)
disp('Starting TrackStatus');
% Display the track status window showing the participant's eyes (to position the participant).
TrackStatus(Calib); % Track status window will stay open until user key press.
disp('TrackStatus stopped');

disp('Starting Calibration workflow');
% Perform calibration
HandleCalibWorkflow(Calib);
disp('Calibration workflow stopped');

close all