//
//  PalletVideoController.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 23/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

#import "PalletVideoController.h"
#import "Shapes.h"
#import <Social/Social.h> //this allows the user to tweet from the app
#import "Shape.h"


@interface PalletVideoController ()

@end

@implementation PalletVideoController


-(void)dealloc
{
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    self->internetController = [[InternetController alloc] init];
    
    //set background
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CarlGreenidge.jpg"]];
    background.frame = self.view.bounds;
    [[self view] addSubview:background];
    
    UIButton * Back =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    Back.frame=CGRectMake(230, 500, 60, 40);//positioning of the button
    [Back addTarget:self action:@selector(BackButton:)forControlEvents:UIControlEventTouchUpInside];
    [Back setBackgroundImage:[UIImage imageNamed:@"back button.png"] forState:UIControlStateNormal];
    [self.view addSubview:Back];
    
    
    
    //add box to place objects on pallet
    UIImageView *palletbox = [[UIImageView alloc] initWithFrame:CGRectMake(40, 295, 240, 140)];
    palletbox.backgroundColor = [UIColor greenColor];
    palletbox.alpha=1.0;
    [self.view addSubview:palletbox];
    
    currentPalleteState = Pallete_Nothing;
    
    
    //postioning of the pallet
    
    circleTool = [self createTool:@"circle.gif" x:50.0f y:305.0f action:@selector(drawCircleToolbarPressed)];
    squareTool = [self createTool:@"square.gif" x:110.0f y:305.0f action:@selector(squareToolbarPressed)];
    line = [self createTool:@"line.png" x:170.0f y:305.0f action:@selector(straightlinePressed)];
    linetool = [self createTool:@"linetool.png" x:220.0f y:305.0f action:@selector(linePressed)];
    
    
    eraser = [self createTool:@"eraser.png" x:50.0f y:365.0f action:@selector(eraserPressed)];
    facebook = [self createTool:@"facebook.png" x:110.0f y:365.0f action:@selector(postToFacebook:)];
    screenshot = [self createTool:@"screenshot.png" x:170.0f y:365.0f action:@selector(SnapShotclicked:)];
    twitter = [self createTool:@"twitter.png" x:225.0f y:365.0f action:@selector(PosttoTwitter:)];
    
    saveTool = [self createTool:@"savebutton.png" x:90.0f y:450.0f  action:@selector(saveShapes)];
    clearTool = [self createTool:@"resetbutton.png" x:180.0f y:450.0f action:@selector(clearShapes)];
    
    

    //making the images nice and clear using alpha function ios
    saveTool.alpha=1.5;
    clearTool.alpha=1.5;
    circleTool.alpha=1.5;
    squareTool.alpha=1.5;
    linetool.alpha=1.5;
    eraser.alpha=1.5;
    line.alpha=1.5;
    screenshot.alpha=1.5;
    facebook.alpha=1.5;
    twitter.alpha=1.5;
 
    
    //adding a screenshot button
    
    
    
    [self.view setUserInteractionEnabled:true];
    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(respondToPinchGesture:)];
   [self.view addGestureRecognizer:recognizer];
    
    shapes = [[NSMutableArray alloc] init];
    
}



-(void)respondToPinchGesture:(UIPinchGestureRecognizer *)sender {
    
    float lastScale;
    CGPoint lastPoint;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
        lastPoint = [sender locationInView:self];
    }
    

}


-(IBAction)BackButton:(id)sender;

{
    
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//declares the main storyboard
    
    UIViewController * MainStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"Main"]; //load main storyboard
    
    [self presentViewController:MainStoryboard animated:YES completion:nil]; //present the first storyboard
    
}




-(Shape*)getClosestShape:(NSSet*)touches
{
    NSArray *touchesArray = [touches allObjects];
    for( uint i=0; i<[touchesArray count]; ++i )
    {
        UITouch *touch = [touchesArray objectAtIndex:i];
        CGPoint position = [touch locationInView:self.view];
        
        for( uint j=0; j<[shapes count]; ++j )
        {
            Shape *itr = [shapes objectAtIndex:j];
            
            float fatFingers = 10.0f;
            
            float hWidth = itr.frame.size.width*0.5f;
            float hHeight = itr.frame.size.height*0.5f;
            float minX = itr.frame.origin.x - hWidth;
            float minY = itr.frame.origin.y - hHeight;
            float maxX = itr.frame.origin.x + hWidth;
            float maxY = itr.frame.origin.y + hHeight;
            
            if( position.x+fatFingers > minX && position.x-fatFingers < maxX )
            {
                if( position.y+fatFingers > minY && position.y-fatFingers < maxY )
                {
                    return itr;
                }
            }
        }
    }
    return nil;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( currentPalleteState == Drawing_Line )
    {
        NSArray *touchesArray = [touches allObjects];
        if( [touchesArray count] > 0 )
        {
            UITouch *touch = [touchesArray objectAtIndex:0];
            CGPoint position = [touch locationInView:self.view];
            
            LineShape *shape = [[LineShape alloc] init:position];
            [self.view addSubview:shape];
            [shapes addObject:shape];
            selectedShape = shape;
            return;
        }
    }
    
    
    //added code
    else if( currentPalleteState == DrawingStraight_Line)
    {
        NSArray *touchesArray = [touches allObjects];
        if( [touchesArray count] > 0 )
        {
            UITouch *touch = [touchesArray objectAtIndex:0];
            CGPoint position = [touch locationInView:self.view];
            
            LineShape *shape = [[LineShape alloc] init:position];
            [self.view addSubview:shape];
            [shapes addObject:shape];
            selectedShape = shape;
            return;
        }
    }
    
    else if( currentPalleteState == Pallete_Nothing )
    {
        //previous code
        selectedShape = [self getClosestShape:touches];
    }
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   if( currentPalleteState == Drawing_Line )
    {
        NSArray *touchesArray = [touches allObjects];
        if( [touchesArray count] > 0 )
        {
            LineShape *shape = (LineShape*)selectedShape;
            UITouch *touch = [touchesArray objectAtIndex:0];
            CGPoint position = [touch locationInView:self.view];
            
            // SWITCH BETWEEN STRAIGHT AND SQUIGGLY
            [shape addPoint:position];
            return;
        }
        
    }
    
    else if (currentPalleteState == DrawingStraight_Line)
    {
        NSArray *touchesArray = [touches allObjects];
        if( [touchesArray count] > 0 )
        {
            
            LineShape *shape = (LineShape*)selectedShape;
            UITouch *touch = [touchesArray objectAtIndex:0];
            CGPoint position = [touch locationInView:self.view];
            
            // SWITCH BETWEEN STRAIGHT AND SQUIGGLY
            //[shape addPoint:position];
            [shape setEndPoint:position];
            return;
        }
        
    }
    
    else if( currentPalleteState == Eraser_Pressed )
    {
        Shape *shape = [self getClosestShape:touches];
        if( shape != nil )
        {
            [shapes removeObject:shape];
            [shape remove];
        }
        return;
    }
    
    else if( selectedShape != nil )
    {
        UIView *shape = selectedShape;
        NSArray *touchesArray = [touches allObjects];
        for( uint i=0; i<[touchesArray count]; ++i )
        {
            UITouch *touch = [touchesArray objectAtIndex:i];
            CGPoint position = [touch locationInView:self.view];
            [shape setFrame:CGRectMake( position.x,position.y, 50, 50)];
            break;
        }
    }
}



-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    if( selectedShape != nil )
    {
        selectedShape = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// Creates a all shape buttons

-(UIImageView*)createTool:(NSString*)icon x:(float)x y:(float)y action:(SEL)action
{
    UIImageView *tool = [[UIImageView alloc] initWithFrame:CGRectMake(x,y,50,50)];
    tool.image =[UIImage imageNamed:icon];
    tool.alpha = 0.5;
    [self.view addSubview:tool];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [tool addGestureRecognizer:recognizer];
    [tool setUserInteractionEnabled:true];
    
    return tool;
}




-(void)drawCircleToolbarPressed
{
    Shape *shape = [[Shape alloc] init:@"circle"];
    [self.view addSubview:shape];
    [shapes addObject:shape];
    
}




-(void)squareToolbarPressed
{
    Shape *squareshape = [[Shape alloc] init:@"square"];
    [self.view addSubview:squareshape];
    [shapes addObject:squareshape];
}




-(void)linePressed
{
    if( currentPalleteState != Drawing_Line )
    {
        currentPalleteState = Drawing_Line;
    }
}

-(void)straightlinePressed
{
    if( currentPalleteState != DrawingStraight_Line )
    {
        currentPalleteState = DrawingStraight_Line;
    }
}


-(void)eraserPressed
{
    if( currentPalleteState == Eraser_Pressed )
    {
        eraser.alpha = 0.5f;
        currentPalleteState = Pallete_Nothing;
        
      
    }
    else
    {
        eraser.alpha = 1.0f;
        currentPalleteState = Eraser_Pressed;
    }
}

//button added

-(void)clearShapes
{
    while( [shapes count]>0 )
    {
        UIView *shape = [shapes lastObject];
        [shapes removeLastObject];
        [shape removeFromSuperview];
        
    }
}


-(void)saveShapes
{
    if( videoFilename != nil )
    {
        NSMutableData *output = [NSMutableData data];
        
        for( uint i=0; i<[shapes count]; ++i )
        {
            Shape *shape = [shapes objectAtIndex:i];
            [shape save:output];
        }
        
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@.shapes", documentsDirectory,videoFilename];
        bool success = false;
        @try
        {
            success = [output writeToFile:fullPath atomically:true];
        }
        @catch(NSException *e)
        {
        }
        
        if( success )
        {
            // Save to server too
        }
    }
}


-(void)playVideo:(NSString*)filename
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,filename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:fullPath] == NO )
    {
        [internetController downloadVideoFromServer:filename withCallback:^(NSMutableData *data, NSString *filename) {
            [self playVideo:filename];
        }];
        return;
    }
    
    // RESET STATE
    // Close current mpc if it's open
    // Delete any shapes currently drawn
    [self clearShapes];
    
    videoFilename = filename;
    NSURL * url = [NSURL fileURLWithPath:fullPath];
    
    bool mpcExists = mpc != nil;
    if( !mpcExists )
    {
        mpc = [[MPMoviePlayerController alloc]initWithContentURL:url];
    }
    
    [mpc setMovieSourceType:MPMovieSourceTypeFile];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.width;
    [mpc.view setFrame:CGRectMake(10,30,screenWidth-20,screenHeight-100)];
    mpc.controlStyle = MPMovieControlStyleEmbedded;
    
    if( !mpcExists )
    {
        [[self view]addSubview:mpc.view];
    }
    
    //[mpc setFullscreen:YES];
    
    [mpc play];
    
    [self loadShapes];
}


-(void)loadShapes
{
    if( videoFilename != nil )
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@.shapes", documentsDirectory,videoFilename];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if( [fileManager fileExistsAtPath:fullPath] )
        {
            NSData *data = [NSData dataWithContentsOfFile:fullPath];
            if( data != nil && [data length] > 0 )
            {
                // Convert NSData to NSString
                NSString *dataString = [NSString stringWithUTF8String:[data bytes]];
                
                // Split string by newlines \n
                NSArray *strings = [dataString componentsSeparatedByString:@"\n"];
                
                for( uint i=0; i<[strings count]; ++i )
                {
                    NSString *shapeDataString = [strings objectAtIndex:i];
                    if( shapeDataString != nil )
                    {
                        // Split each newline by commas
                        NSArray *shapeData = [shapeDataString componentsSeparatedByString:@","];
                        if( [shapeData count] >= 1 )
                        {
                            // First comma = x, Second comma = y, Third comma = width, etc
                            NSString *shapeType = [shapeData objectAtIndex:0];
                            if( [shapeType isEqualToString:@"circle"] )
                            {
                                if( [shapeData count] >= 5 )
                                {
                                    const float x = [[shapeData objectAtIndex:1] floatValue];
                                    const float y = [[shapeData objectAtIndex:2] floatValue];
                                    const float width = [[shapeData objectAtIndex:3] floatValue];
                                    const float height = [[shapeData objectAtIndex:4] floatValue];
                                    Shape *shape = [[Shape alloc] init:@"circle"];
                                    [shape setFrame:CGRectMake( x, y, width, height)];
                                    [self.view addSubview:shape];
                                    [shapes addObject:shape];
                                }
                            }
                            else if( [shapeType isEqualToString:@"square"] )
                            {
                                
                            }
                            else if( [shapeType isEqualToString:@"line"] )
                            {
                                LineShape *shape = nil;
                                
                                int numberOfEntries = [shapeData count];
                                for( int i=1; i<numberOfEntries-1; i+=2 )
                                {
                                    
                                    const float x = [[shapeData objectAtIndex:i+0] floatValue];
                                    const float y = [[shapeData objectAtIndex:i+1] floatValue];
                                    CGPoint point;
                                    point.x = x;
                                    point.y = y;
                                    
                                    if( shape == nil )
                                    {
                                        shape = [[LineShape alloc] init:point];
                                        [self.view addSubview:shape];
                                        [shapes addObject:shape];
                                    }
                                    else
                                    {
                                        [shape addPoint:point];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // Stop the video player and remove it from view
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
    
    // Display a message
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Video Playback" message:@"Just finished the video playback. The video is now removed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}



//capture a screenshot and save to camera roll or upload to twitter or facebook


-(IBAction)SnapShotclicked:(id)sender       //SnapShotclicked is an action for UIButton.
{
    
    // create graphics context with screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    // grab reference to our window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // transfer content into our context
    [window.layer renderInContext:ctx];
    UIImage *screengrab = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageWriteToSavedPhotosAlbum(screengrab, nil, nil, nil);
    
    
    
    
    
}



//tweeting from my app

- (IBAction)PosttoTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Tweeting from the cricket app! :)"];
        
        //
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        UIGraphicsBeginImageContext(screenRect.size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [[UIColor blackColor] set];
        CGContextFillRect(ctx, screenRect);
        
        // grab reference to our window
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        // transfer content into our context
        [window.layer renderInContext:ctx];
        UIImage *screengrab = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        UIImageWriteToSavedPhotosAlbum(screengrab, nil, nil, nil);
        
        
        
        
        [tweetSheet addImage:screengrab];
        //
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


//posting to facebook from my app


- (IBAction)postToFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"First post from my iPhone app"];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}









@end

