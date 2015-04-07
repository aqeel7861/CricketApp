//
//  AutomaticVideoProcessing2.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 06/04/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

#import "AutomaticVideoProcessing2.h"

@interface AutomaticVideoProcessing2 ()

@end

@implementation AutomaticVideoProcessing2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self->internetController = [[InternetController alloc] init];
    
    //set background
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CarlGreenidge.jpg"]];
    background.frame = self.view.bounds;
    [[self view] addSubview:background];
    
    
    //text to be displayed below video describing the video
    
    UIImageView * header =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShoulderRotation.png"]];
    header.frame=CGRectMake(50,350,220,100);
    [self.view addSubview:header];
    
    
    
    //back button
    
    UIButton * Back =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    Back.frame=CGRectMake(230, 500, 60, 40);//positioning of the button
    [Back addTarget:self action:@selector(BackButton:)forControlEvents:UIControlEventTouchUpInside];
    [Back setBackgroundImage:[UIImage imageNamed:@"back button.png"] forState:UIControlStateNormal];
    [self.view addSubview:Back];
    
    //file is preloaded and kept in app (quicker this way)
    
    NSString *filename = @"ShoulderRotationDrill.mov";
    videoFilename = filename;
    
    NSString * MovieLocation= [[NSBundle mainBundle]pathForResource:@"ShoulderRotationDrill"ofType:@"mov"];//Details of the video location this is connected to the button
    
    NSURL * url = [NSURL fileURLWithPath:MovieLocation];
    
    mpc = [[MPMoviePlayerController alloc]initWithContentURL:url];
    
    [mpc setMovieSourceType:MPMovieSourceTypeFile];
    
    //set the dimensions for the video
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.width;
    [mpc.view setFrame:CGRectMake(10,30,screenWidth-20,screenHeight-50)];
    mpc.controlStyle = MPMovieControlStyleEmbedded;
    
    [[self view]addSubview:mpc.view];
    
    [mpc play ];
    
    lines = [[NSMutableArray alloc] init];
    videoState = 1;
    [self mediaLoop];
}

//this method is used to determine at what points in the video to draw the lines
//code helps support functionality of telling the user when to draw the lines



-(void)mediaLoop
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ { //this calls the following code on the next update
        
        double time = mpc.currentPlaybackTime;
        if( videoState == 1 )
        {
            if( time > 3.0 )
            {
                [self PlayVideoProcessing1];
            }
        }

        
        if( mpc.playbackState == MPMoviePlaybackStatePlaying )
        {
            [self mediaLoop]; //if the video still playing calls the fucntion again the reason the function is not called directly it will go into an endless loop
        }
        
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






//used to add a circle
-(void)PlayVideoProcessing1

    
   
    {
        //determines where the circle will be drawn on the mpc 130 and 85
        UIImageView *linetool = [[UIImageView alloc] initWithFrame:CGRectMake(130,85,50,50)];
        linetool.image = [UIImage imageNamed:@"circle.gif"];
        linetool.alpha=1.5;
        [[self view] addSubview:linetool];
    }
    

    


-(IBAction)BackButton:(id)sender;

{
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//declares the main storyboard
    UIViewController * MainStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"Main"]; //load main storyboard
    
    [self presentViewController:MainStoryboard animated:YES completion:nil]; //present the first storyboard
    
}



@end
