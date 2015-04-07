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



@interface PalletVideoController : UIViewController

{
    InternetController *internetController;
    
    MPMoviePlayerController * mpc;
    
    enum PalleteState 
    {
        Pallete_Nothing,
        Drawing_Circle,
        Drawing_Square,
        Drawing_Line,
        DrawingStraight_Line,
        Eraser_Pressed
    };
    
    enum PalleteState currentPalleteState;
    
    
    //background for pallet
    
    
    UIImageView *facebook;
    UIImageView *screenshot;
    UIImageView *twitter;
    
    UIImageView *circleTool;
    UIImageView * squareTool;
    UIImageView *clearTool;
    UIImageView * linetool;
    UIImageView * eraser;
    UIImageView * straightline;
    UIImageView * line;
    UIImageView *saveTool;
    UIImageView * tempDrawImage;
    UIView *view;
    
    
    
    
    
    UITextField* comments;
    
    
    UIView *selectedShape;
    NSMutableArray *shapes;
    
    NSString *videoFilename;
}
@property (strong, nonatomic) MPMoviePlayerController *videoController;



-(void)SaveDownloadedVideo;




-(IBAction)PosttoTwitter:(id)sender;
-(IBAction)postToFacebook:(id)sender;

-(IBAction)SnapShotclicked:(id)sender;
-(IBAction)addtext:(id)sender;

-(void)playVideo:(NSString*)filename;
-(void)loadShapes;
-(void)saveShapes;


@end
