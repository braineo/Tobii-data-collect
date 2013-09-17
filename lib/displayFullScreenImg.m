function displayFullScreenImg(fileName,Calib, TapToClose)
global frame
    if nargin < 3
        TapToClose = 1;
    end
    img = imread(fileName);  %# A sample image to display
    img = imresize(img,[Calib.mondims1.height Calib.mondims1.width],'bilinear');
    jimg = im2java(img);
    frame = javax.swing.JFrame;
    frame.setUndecorated(true);
    icon = javax.swing.ImageIcon(jimg);
    label = javax.swing.JLabel(icon);
    frame.getContentPane.add(label);
    frame.pack;
    %screenSize = get(0,'ScreenSize');  %# Get the screen size from the root object
    frame.setSize(Calib.mondims1.width, Calib.mondims1.height);
    frame.setLocation(Calib.mondims1.x,Calib.mondims1.y);
    frame.show;
    if(TapToClose)
        waitforbuttonpress;
        frame.dispose;
    end
    