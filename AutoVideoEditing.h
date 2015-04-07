//
//  PalletVideoController.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 23/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h> //import the media player into the new view controller2 class
#import "InternetController.h"
#import "PalletVideoController.h"



@interface AutoVideoEditing : PalletVideoController

{
    
    UIImageView * redlight;
    UIImageView * amberlight;
    UIImageView * greenlight;
    
    bool redLightFlashing, amberLightFlashing, greenLightFlashing;
    double redLightTimer, amberLightTimer, greenLightTimer;
    double lastSystemTime;
}
//@property (strong, nonatomic) MPMoviePlayerController *videoController;



-(void)SaveDownloadedVideo;
-(void)updateLoop;




-(IBAction)PosttoTwitter:(id)sender;
-(IBAction)postToFacebook:(id)sender;

-(IBAction)SnapShotclicked:(id)sender;
-(IBAction)addtext:(id)sender;

-(void)playVideo:(NSString*)filename;
-(void)loadShapes;
-(void)saveShapes;


@end