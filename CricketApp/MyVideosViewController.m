//  DrillsViewController.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 03/11/2014.
//  Copyright (c) 2014 Aqeel Rafiq. All rights reserved.
//

//libarries that need to imported
#import "MyVideosViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PalletVideoController.h"
#import "AutoVideoEditing.h"
#import "InternetController.h"


@interface MyVideosViewController ()

{
    //creating an instance variable
}

@end



@implementation MyVideosViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self->internetController = [[InternetController alloc] init]; 
    
    //set background
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CarlGreenidge.jpg"]];
    background.frame = self.view.bounds;
    [[self view] addSubview:background];
    
    

    //Recording Video
    
    UIButton * RecordVideo =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    RecordVideo.frame=CGRectMake(60, 200, 200, 50);//positioning of the button
    [RecordVideo addTarget:self action:@selector(RecordVideo:)forControlEvents:UIControlEventTouchUpInside];
    [RecordVideo setBackgroundImage:[UIImage imageNamed:@"RB.png"] forState:UIControlStateNormal];
    [self.view addSubview:RecordVideo];
    
    //Edit a video using the Notation Interface. Notation interface also refered to as pallat
    
     UIButton * EV1 =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
     EV1.frame=CGRectMake(60, 260, 200, 50);//positioning of the button
     [EV1 addTarget:self action:@selector(selectPalletVideo:)forControlEvents:UIControlEventTouchUpInside];
     [EV1 setBackgroundImage:[UIImage imageNamed:@"EV1.png"] forState:UIControlStateNormal];
     [self.view addSubview:EV1];
    
    //Edit a video using AI
    
    UIButton * EV2 =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    EV2.frame=CGRectMake(60, 320, 200, 50);//positioning of the button
    [EV2 addTarget:self action:@selector(selectAIVideo:)forControlEvents:UIControlEventTouchUpInside];
    [EV2 setBackgroundImage:[UIImage imageNamed:@"EV2.png"] forState:UIControlStateNormal];
    [self.view addSubview:EV2];
    
    
    //back button redirects the user to the start screen
    
    UIButton * Back =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    Back.frame=CGRectMake(230, 30, 60, 40);//positioning of the button
    [Back addTarget:self action:@selector(BackButton:)forControlEvents:UIControlEventTouchUpInside];
    [Back setBackgroundImage:[UIImage imageNamed:@"back button.png"] forState:UIControlStateNormal];
    [self.view addSubview:Back];
    
    //current video loading state is nothing
    
    videoLoadingState = VideoLoading_Nothing;
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




-(IBAction)RecordVideo:(id)sender;
{
    [self captureVideo:nil];
}



// Record Function on iOs

- (IBAction)captureVideo:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.videoURL = info[UIImagePickerControllerMediaURL];
    
    NSString *tempFilename = [[self.videoURL absoluteString] lastPathComponent];
    currentUploadingData = [NSData dataWithContentsOfURL:self.videoURL];
    
   //UIAlert added important to tell the user what format to save the video in
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save Video please add .mov at the end of each video" message:@"Name this video:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
    
    //the picker is then dismissed
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField =  [alertView textFieldAtIndex:0];
    
    NSString *filename = textField.text;
    [internetController uploadVideo:filename fileData:currentUploadingData withCallback:^(NSMutableData *data, NSString *filename) {
        
                    NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"%@", stringData);
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



//table stuff for showing the videos in a table

#pragma mark - Table stuff
-(void)displayDataInTableView:(NSString*)dataString
{
    NSLog(@"%@", dataString);
    
    if( tableDataMyVideos != nil )
    {
        [tableDataMyVideos removeAllObjects];
    }
    else
    {
        tableDataMyVideos = [[NSMutableArray alloc] init];
    }
    
    // Split string by newlines \n
    NSArray *strings = [dataString componentsSeparatedByString:@"\n"];
    
    for( uint i=0; i<[strings count]; ++i )
    {
        NSString *filename = [strings objectAtIndex:i];
        if( filename != nil )
        {
            // Filter .DS_STORE and any file that ends in ".shape" This time it shows the user all the videos to edit including the DRILLS video
            
            
            for(NSString *str in tableDataMyVideos)
            {
                if([str isEqualToString:@".DS_Store"])
                {
                    [tableDataMyVideos removeObject:str];
                    
                }
                
                if ([str isEqualToString:@".shape"])
                {
                    [tableDataMyVideos removeObject:str];
                    
                }
                 if ([str isEqualToString:@"Drill 1 .MOV"])
                {
                    [tableDataMyVideos removeObject:str];
                }
                
                 if ([str isEqualToString:@"Drill 2.MOV"])
                {
                    [tableDataMyVideos removeObject:str];
                }
              
                if ([str isEqualToString:@"Drill 3.MOV"])
                {
                    [tableDataMyVideos removeObject:str];
                }
                
            }
            
            [tableDataMyVideos addObject:filename];
            
            
        }
    }
    
    if( table == nil)
    {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        table = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, screenWidth, screenHeight)];
        table.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        table.delegate = self;
        table.dataSource = self;
        
        [self.view addSubview:table];
    }
}

//table formatting
-(void)tableView:(UITableView*)inTableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if( inTableView == table )
    {
        const int index = indexPath.row;
        NSString *filename = [tableDataMyVideos objectAtIndex:index];
        [self selectVideo:filename];
        
        [table removeFromSuperview];
        table = nil;
    }
}



//making a grouped table for UI purposes



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home.png"]];
    [tableView addSubview:headerView];
    
    return headerView;
}

//table formattting making it neat

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40.0;
}




// How many rows the table will have
- (NSInteger)tableView:(UITableView *)inTableView numberOfRowsInSection:(NSInteger)section {
    if (table == table) { // your tableView you had before
        if( tableDataMyVideos != nil )
        {
            return [tableDataMyVideos count];
        }
    }
    return 0;
}


// What should be in each cell
- (UITableViewCell *)tableView:(UITableView *)inTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.backgroundView = [[UIView alloc] init];
    [cell.backgroundView setBackgroundColor:[UIColor clearColor]];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (table == inTableView) {
        
        // Get the text from the tableData model
        cell.textLabel.text = [tableDataMyVideos objectAtIndex:indexPath.row];
    }
    
    return cell;
}





//play videos

//notation interface video to know what state it is in
- (IBAction)selectPalletVideo:(UIButton *)sender {
    
    videoLoadingState = VideoLoading_Pallete;
    [self startSelectionOfVideoFromList];
}


-(void)startSelectionOfVideoFromList
{
    [internetController getVideosList:^(NSMutableData *data, NSString *filename){
        if( data != nil )
        {
            NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            [self displayDataInTableView:stringData];
        }
    }];
}


//AI video

- (IBAction)selectAIVideo:(UIButton *)sender {
    
    videoLoadingState = VideoLoading_AI;
    [self startSelectionOfVideoFromList];
}


-(void)selectVideo:(NSString*)filename
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:fullPath] == NO )
    {
        [internetController downloadVideoFromServer:filename withCallback:^(NSMutableData *data, NSString *filename) {
            [self saveDownloadedVideo:data filename:filename];
        }];
    }
    else
    {
        [self PlayDownloadedVideo:filename];
    }
}


//this is important as this saves the video to app memory if the video is already downloaded as a result if it reloaded then the video is fine.

-(void)saveDownloadedVideo:(NSMutableData*)data filename:(NSString*)filename
{
    if( filename != nil && data != nil )
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
        bool success = false;
        @try
        {
            success = [data writeToFile:fullPath atomically:true]; ///the file is then written to app memory
        }
        @catch(NSException *e)
        {
        }
        
        if( success )
        {
            [self PlayDownloadedVideo:filename];
        }
        else
        {
            //error debugging purposes NSLog(@'Error')
        }
    }
    else
    {
        // Something bad happend
    }
}

//this function displays the actual video in the notation interface class or the AI interface class the actual video using the storyboard identified

-(void)PlayDownloadedVideo:(NSString*)filename
{
    if( videoLoadingState == VideoLoading_Pallete )
    {
        UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        PalletVideoController *storyboard = [MasterStoryboard  instantiateViewControllerWithIdentifier:@"PalletVideo"]; //storyboard identifier used here to display the video in the PalletVideoController Class
        
        [self presentViewController:storyboard animated:YES completion:NULL];
        
        [storyboard playVideo:filename];
    }
    else if( videoLoadingState == VideoLoading_AI )
    {
        UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        AutoVideoEditing *storyboard = [MasterStoryboard instantiateViewControllerWithIdentifier:@"AutoVideoEditing"]; //storyboard identifier used here to display the video in the AutoVideoEditing class
        
        [self presentViewController:storyboard animated:YES completion:NULL];
        
        [storyboard playVideo:filename];
    }
}

//the IBAction for back button

-(IBAction)BackButton:(id)sender;

{
    
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//declares the main storyboard
    
    UIViewController * MainStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"Main"]; //load main storyboard
    
    [self presentViewController:MainStoryboard animated:YES completion:nil]; //present the first storyboard
    
}







@end


