//
//  MyVideosViewController.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 03/11/2014.
//  Copyright (c) 2014 Aqeel Rafiq. All rights reserved.
//

#import "DrillsViewController.h" //import the h class automatically
#import "InternetController.h" // and imports the internet controller class 

@interface DrillsViewController ()

@end

@implementation DrillsViewController

//explain this

- (IBAction)getVideo:(UIButton *)sender {
    
    [internetController getVideosList:^(NSMutableData *data, NSString *filename){
        if( data != nil )
        {
            NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
            [self displayDataInTableView:stringData];
        }
    }];
}

//explain this


-(void)playVideo:(NSString*)filename
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


//does this work? No IBACTION to this 
-(void)saveDownloadedVideo:(NSMutableData*)data filename:(NSString*)filename
{
    if( filename != nil && data != nil )
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
        bool success = false;
        @try
        {
            success = [data writeToFile:fullPath atomically:true];
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
            // Report error? Delete file and redownload?
        }
    }
    else
    {
        // Something bad happend
    }
}


-(void)PlayDownloadedVideo:(NSString*)filename
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
    
    NSURL * url = [NSURL fileURLWithPath:fullPath];
    
    MPMoviePlayerViewController *mpc = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
    [mpc.moviePlayer setMovieSourceType:MPMovieSourceTypeFile];
    
    [mpc.view setFrame:CGRectMake(10,10,100,100)];
    
    [mpc.moviePlayer setFullscreen:YES];
    [mpc.moviePlayer play];
    
    [self presentMoviePlayerViewControllerAnimated:mpc];
}



-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self->internetController = [[InternetController alloc] init];
    
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CarlGreenidge.jpg"]];
    background.frame = self.view.bounds;
    [[self view] addSubview:background];
    
    
 
    
    
    
    UIButton * selectDrill =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    selectDrill.frame=CGRectMake(60, 200, 200, 50);//positioning of the button
    [selectDrill addTarget:self action:@selector(getVideo:)forControlEvents:UIControlEventTouchUpInside];
    [selectDrill setBackgroundImage:[UIImage imageNamed:@"Selectadrill.png"] forState:UIControlStateNormal];
    [self.view addSubview:selectDrill];
    
    
    UIButton * VP1 =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    VP1.frame=CGRectMake(60, 260, 200, 50);//positioning of the button
    [VP1 addTarget:self action:@selector(VideoProcessing1:)forControlEvents:UIControlEventTouchUpInside];
    [VP1 setBackgroundImage:[UIImage imageNamed:@"VP1.png"] forState:UIControlStateNormal];
    [self.view addSubview:VP1];
    
    UIButton * VP2 =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    VP2.frame=CGRectMake(60, 320, 200, 50);//positioning of the button
    [VP2 addTarget:self action:@selector(VideoProcessing2:)forControlEvents:UIControlEventTouchUpInside];
    [VP2 setBackgroundImage:[UIImage imageNamed:@"VP2.png"] forState:UIControlStateNormal];
    [self.view addSubview:VP2];
    
    UIButton * VP3 =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    VP3.frame=CGRectMake(60, 380, 200, 50);//positioning of the button
    [VP3 addTarget:self action:@selector(VideoProcessing3:)forControlEvents:UIControlEventTouchUpInside];
    [VP3 setBackgroundImage:[UIImage imageNamed:@"VP3.png"] forState:UIControlStateNormal];
    [self.view addSubview:VP3];
    
    UIButton * VP4 =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    VP4.frame=CGRectMake(60, 440, 200, 50);//positioning of the button
    [VP4 addTarget:self action:@selector(VideoProcessing4:)forControlEvents:UIControlEventTouchUpInside];
    [VP4 setBackgroundImage:[UIImage imageNamed:@"VP4.png"] forState:UIControlStateNormal];
    [self.view addSubview:VP4];
    
    
    UIButton * Back =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    Back.frame=CGRectMake(230, 30, 60, 40);//positioning of the button
    [Back addTarget:self action:@selector(BackButton:)forControlEvents:UIControlEventTouchUpInside];
    [Back setBackgroundImage:[UIImage imageNamed:@"back button.png"] forState:UIControlStateNormal];
    [self.view addSubview:Back];
    
    
    

    
    
}





-(IBAction)VideoProcessing1:(id)sender;

{
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //this is the main storyboard the first storyboard that loads
    UIViewController * AutomaticVideo= [MasterStoryboard instantiateViewControllerWithIdentifier:@"AutomaticVideoProcessing"];
    [self presentViewController:AutomaticVideo animated:YES completion:nil];
   
    
}



-(IBAction)VideoProcessing2:(id)sender;

{
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //this is the main storyboard the first storyboard that loads
    UIViewController * AutomaticVideo2= [MasterStoryboard instantiateViewControllerWithIdentifier:@"AutomaticVideoProcessing2"];
    [self presentViewController:AutomaticVideo2 animated:YES completion:nil];
    
    
}

-(IBAction)VideoProcessing3:(id)sender;

{
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //this is the main storyboard the first storyboard that loads
    UIViewController * AutomaticVideo3= [MasterStoryboard instantiateViewControllerWithIdentifier:@"AutomaticVideoProcessing3"];
    [self presentViewController:AutomaticVideo3 animated:YES completion:nil];
    
    
}


-(IBAction)VideoProcessing4:(id)sender;

{
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //this is the main storyboard the first storyboard that loads
    UIViewController * AutomaticVideo4= [MasterStoryboard instantiateViewControllerWithIdentifier:@"AutomaticVideoProcessing4"];
    [self presentViewController:AutomaticVideo4 animated:YES completion:nil];
    
    
}




-(IBAction)BackButton:(id)sender;

{
    
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//declares the main storyboard
    
    UIViewController * MainStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"Main"]; //load main storyboard
    
    [self presentViewController:MainStoryboard animated:YES completion:nil]; //present the first storyboard
    
}









//savedownloaded video does it work?


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



#pragma mark - Table stuff
-(void)displayDataInTableView:(NSString*)dataString
{
    NSLog(@"%@", dataString);
    
    if( tableData != nil )
    {
        [tableData removeAllObjects];
    }
    else
    {
        tableData = [[NSMutableArray alloc] init];
    }
    
    // Split string by newlines \n
    NSArray *strings = [dataString componentsSeparatedByString:@"\n"];
    
    for( uint i=0; i<[strings count]; ++i )
    {
        NSString *filename = [strings objectAtIndex:i];
        if( filename != nil )
        {
            // Filter .DS_STORE and any file that ends in ".shape"
            
            
            for(NSString *str in tableData)
            {
                if([str isEqualToString:@".DS_Store"])
                {
                    [tableData removeObject:str];
                    
                }
                
                else if ([str isEqualToString:@".shape"])
                {
                    [tableData removeObject:str];
                    
                }
                
            }
            
            [tableData addObject:filename];
            
            
        }
    }
    
    if( tableView == nil)
    {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, screenWidth, screenHeight)];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [self.view addSubview:tableView];
    }
}


// What happens when a cell is pressed
-(void)tableView:(UITableView*)inTableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if( inTableView == tableView )
    {
        const int index = indexPath.row;
        NSString *filename = [tableData objectAtIndex:index];
        
        // IF YOU CAN"T DOWNLOAD a video from the server
        // Goto htdocs folder, and run this command in the videosfolder
        // cd /Applications/xampp/htdocs/videosfolder
        // chmod 777 *
        [self playVideo:filename];
        
        [tableView removeFromSuperview];
        tableView = nil;
    }
}



//making a grouped table for UI purposes



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home.png"]];
    [tableView addSubview:headerView];
    
    return headerView;
}



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
    if (inTableView == tableView) { // your tableView you had before
        if( tableData != nil )
        {
            return [tableData count];
        }
    }
    return 0;
}


// What should be in each cell
- (UITableViewCell *)tableView:(UITableView *)inTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.backgroundView = [[UIView alloc] init];
    [cell.backgroundView setBackgroundColor:[UIColor clearColor]];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (tableView == inTableView) {
        
        // Get the text from the tableData model
        cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    }
    
    return cell;
}




@end
