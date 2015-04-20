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

//notation interface


@interface PalletVideoController : UIViewController

{
    InternetController *internetController;
    
    MPMoviePlayerController * mpc;
    
    enum PalleteState 
    {
        Pallete_Nothing,
        Drawing_Line,
        DrawingStraight_Line,
        Eraser_Pressed
    };
    
    enum PalleteState currentPalleteState;
    
    
    //background for pallet
    
    
    //imageviews used for buttons
    
    UIImageView *facebook;
    UIImageView *screenshot;
    UIImageView *twitter;
    
    UIImageView *circleTool;
    UIImageView * squareTool;
    UIImageView *clearTool;
    UIImageView * straightlinetool;
    UIImageView * linetool;
    UIImageView * eraser;
    UIImageView * straightline;
    UIImageView *saveTool;
    UIImageView * tempDrawImage;
    UIView *view;
    
    
    
    
    
    
    
    UIView *selectedShape;
    NSMutableArray *shapes;
    
    NSString *videoFilename;
}
@property (strong, nonatomic) MPMoviePlayerController *videoController;



-(void)SaveDownloadedVideo;


//IBACTION BUTTONS 

-(IBAction)PosttoTwitter:(id)sender;
-(IBAction)postToFacebook:(id)sender;

-(IBAction)SnapShotclicked:(id)sender;
-(IBAction)addtext:(id)sender;

-(void)playVideo:(NSString*)filename;
-(void)loadShapes;
-(void)saveShapes;


@end
