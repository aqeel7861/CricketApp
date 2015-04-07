//
//  AutomaticVideoProcessing.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 11/02/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InternetController.h"
#import <MediaPlayer/MediaPlayer.h> //import the media player into the new view controller2 class

#import "Shapes.h"

@interface AutomaticVideoProcessing4 : UIViewController

{
    
    InternetController *internetController;
    
    MPMoviePlayerController * mpc;
    
    NSString *videoFilename;
    
    NSMutableArray *lines;
    int videoState;
}



@end
