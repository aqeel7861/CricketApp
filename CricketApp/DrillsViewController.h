//  DrillsViewController.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 03/11/2014.
//  Copyright (c) 2014 Aqeel Rafiq. All rights reserved.
//

//libaries that are imported 

#import <UIKit/UIKit.h> //UIKit needed
#import <MediaPlayer/MediaPlayer.h> //this is the ios Media to get videos
#import <MobileCoreServices/MobileCoreServices.h> //
#import "InternetController.h" //to make an internet connection

@interface DrillsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource> //what is this for?
{
    NSMutableArray *tableData;
    UITableView *tableView;
    
    //creating two new views
    
    UIView *headerView;
    UIView * footerView;
    
    //for grouped table
    InternetController *internetController;
}


@property (strong, nonatomic) NSURL *videoURL; //videoURL of the video
@property (strong, nonatomic) MPMoviePlayerController *videoController;

//the methods IBActions etc 
-(IBAction)BackButton:(id)sender;
-(IBAction)VideoProcessing1:(id)sender;
-(IBAction)VideoProcessing2:(id)sender;
-(IBAction)VideoProcessing3:(id)sender;
-(IBAction)VideoProcessing4:(id)sender;




-(IBAction)PlayVideo:(id)sender;
-(void)SaveDownloadedVideo;



@end

