//
//  MyVideosViewController.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 03/11/2014.
//  Copyright (c) 2014 Aqeel Rafiq. All rights reserved.
//

#import "PalletVideoController.h"
#import <UIKit/UIKit.h> //internet 
#import "InternetController.h"
#import <MediaPlayer/MediaPlayer.h> //import the media player into the new view controller2 class


@interface MyVideosViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    InternetController *internetController;
    NSData *currentUploadingData;
    

    
    NSMutableArray * tableDataMyVideos;
    UITableView *table;
    
    //creating two new views
    
    UIView *headerView;
    UIView * footerView;
    
    //for grouped table
    InternetController * internetControllerMyvideos;
    
    
}



@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (nonatomic, strong) PalletVideoController *storyboard;



-(IBAction)captureVideo:(id)sender;
-(IBAction)BackButton:(id)sender;
-(IBAction)PlayVideo:(id)sender;
-(void)playVideo:(NSString*)filename;

-(IBAction)GetVideos:(id)sender;//used to output the videos in the folder
-(IBAction)autovideo:(id)sender;//used to output the videos in the folder

@end