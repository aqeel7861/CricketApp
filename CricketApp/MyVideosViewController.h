//
//  MyVideosViewController.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 03/11/2014.
//  Copyright (c) 2014 Aqeel Rafiq. All rights reserved.
// This class was used for the my videos in this file variable and method declarations are declared

#import "PalletVideoController.h"
#import <UIKit/UIKit.h> //internet 
#import "InternetController.h"
#import <MediaPlayer/MediaPlayer.h> //import the media player into the new view controller2 class


@interface MyVideosViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    InternetController *internetController; //used for methods in internet controller see report
    NSData *currentUploadingData;
    

    
    NSMutableArray * tableDataMyVideos;
    UITableView *table;
    
    //creating two new views
    
    UIView *headerView;
    UIView * footerView;
    
    //for grouped table
    InternetController * internetControllerMyvideos;
    
    //video loading state used for debugging purposes to keep track of state
    
    enum VideoLoadingState
    {
        VideoLoading_Nothing,
        VideoLoading_Pallete,
        VideoLoading_AI
    };
    enum VideoLoadingState videoLoadingState;
}



@property (strong, nonatomic) NSURL *videoURL;

//actions and methods for buttons and videos 

-(IBAction)captureVideo:(id)sender;
-(IBAction)BackButton:(id)sender;
-(IBAction)PlayVideo:(id)sender;
-(void)selectVideo:(NSString*)filename;

-(IBAction)GetVideos:(id)sender;//used to output the videos in the folder
-(IBAction)selectAIVideo:(id)sender;//used to output the videos in the folder

@end
