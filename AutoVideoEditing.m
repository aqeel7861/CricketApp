//
//  AutoVideoEditing.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 06/04/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

#import "AutoVideoEditing.h"
#import "Shapes.h"
#import <Social/Social.h> //this allows the user to tweet from the app
#import "Shape.h"

@interface AutoVideoEditing ()

@end

@implementation AutoVideoEditing

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    circleTool.hidden = true;
    squareTool.hidden = true;
    linetool.hidden = true;
    
    
    //black box for the traffic light system
    UIImageView *trafficlightbox = [[UIImageView alloc] initWithFrame:CGRectMake(75, 450, 180, 60)];
    trafficlightbox.backgroundColor = [UIColor blackColor];
    trafficlightbox.alpha=1.0;
    [self.view addSubview:trafficlightbox];
    //adding the traffic lights using UImageView
   
     redlight =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red.png"]];
    redlight.frame=CGRectMake(85,455,50,50);
    [self.view addSubview:redlight];
    
    amberlight =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amber.png"]];
    amberlight.frame=CGRectMake(140,455,50,50);
    [self.view addSubview:amberlight];
    
    greenlight =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green.png"]];
    greenlight.frame=CGRectMake(195,455,50,50);
    [self.view addSubview:greenlight];
    
    [self updateLoop];
    
}


-(void)makePalleteBox
{
    //add box to place objects on pallet
    UIImageView *palletbox = [[UIImageView alloc] initWithFrame:CGRectMake(40, 295, 240, 140)];
    palletbox.backgroundColor = [UIColor greenColor];
    palletbox.alpha=1.0;
    [self.view addSubview:palletbox];
}


-(IBAction)BackButton:(id)sender;
{
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//declares the main storyboard
    
    UIViewController * MainStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"Main"]; //load main storyboard
    
    [self presentViewController:MainStoryboard animated:YES completion:nil]; //present the first storyboard
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//trafficlight system
-(void)updateLoop
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ { //this calls the following code
        
        NSTimeInterval currentSystemTime = [NSDate timeIntervalSinceReferenceDate];
        double timePassed = currentSystemTime - lastSystemTime;
        lastSystemTime = currentSystemTime;
        
        // Makes the lights flash
        [self updateLightsFlash:timePassed];
        
        
        [self updateLoop];
    }];
}


-(void)updateLightsFlash:(double)timePassed
{
    const double timeIntervalFlash=0.5;
    if (redLightFlashing)
    {
        redLightTimer += timePassed;
        
        if(redLightTimer > timeIntervalFlash)
        {
            redLightTimer-=timeIntervalFlash;
        
            if (redlight.alpha==1.0)
            {
                redlight.alpha =0.0;
            }
            
            else
            {
                redlight.alpha=1.0;
            }
        }
    }
    
    else if (amberLightFlashing)
    {
        amberLightTimer += timePassed;
        double timeIntervalFlash=0.5;
        
        if(amberLightTimer > timeIntervalFlash)
        {
            amberLightTimer-=timeIntervalFlash;
            
            if (amberlight.alpha==1.0)
            {
                amberlight.alpha =0.0;
            }
            
            else
            {
                amberlight.alpha=1.0;
            }
        }
    }
    
    else if  (greenLightFlashing)
    {
        greenLightFlashing += timePassed;
        double timeIntervalFlash=0.5;
        
        if(greenLightFlashing > timeIntervalFlash)
        {
            greenLightFlashing-=timeIntervalFlash;
            
            if (greenlight.alpha==1.0)
            {
                greenlight.alpha =0.0;
            }
            
            else
            {
                greenlight.alpha=1.0;
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( currentPalleteState == DrawingStraight_Line)
    {
        NSArray *touchesArray = [touches allObjects];
        if( [touchesArray count] > 0 )
        {
            UITouch *touch = [touchesArray objectAtIndex:0];
            CGPoint position = [touch locationInView:self.view];
            
            if( [shapes count] == 1 )
            {
                position = [[shapes objectAtIndex:0] getEndPoint];
            }
            
            LineShape *shape = [[LineShape alloc] init:position];
            [self.view addSubview:shape];
            [shapes addObject:shape];
            selectedShape = shape;
            return;
        }
    }
}


-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    [super touchesEnded:touches withEvent:event];
    
    if( currentPalleteState == DrawingStraight_Line )
    {
        if( [shapes count] == 2 )
        {
            [self detectLineAngles];
            currentPalleteState = Pallete_Nothing;
        }
    }
}

-(void)loadShapes
{
    
}


-(void)detectLineAngles
{
    if( [shapes count] == 2)
    {
        LineShape *line1 = (LineShape*)[shapes objectAtIndex:0];
        LineShape *line2 = (LineShape*)[shapes objectAtIndex:1];
        
        // Init the lines
        CGPoint leftLineStart = [line1 getStartPoint];
        CGPoint leftLineEnd = [line1 getEndPoint];
        CGPoint rightLineStart = [line2 getStartPoint];
        CGPoint rightLineEnd = [line2 getEndPoint];
        
        // Sort the lines now to left and right
        if( leftLineStart.x > rightLineStart.x )
        {
            leftLineStart = [line2 getStartPoint];
            leftLineEnd = [line2 getEndPoint];
            rightLineStart = [line1 getStartPoint];
            rightLineEnd = [line1 getEndPoint];
        }
        
        
        //convert lines from screen coordinate system to a normal axis where 0,0 is bottom left
        leftLineStart.y =self.view.bounds.size.height - leftLineStart.y;
        leftLineEnd.y =self.view.bounds.size.height - leftLineEnd.y;
        rightLineStart.y = self.view.bounds.size.height - rightLineStart.y;
        rightLineEnd.y= self.view.bounds.size.height - rightLineEnd.y;
        
        // ensure start is the bottom line if not use a temp variable to swap them
        if (leftLineEnd.y < leftLineStart.y)
        {
            CGPoint temp = leftLineStart;
            leftLineStart = leftLineEnd;
            leftLineEnd= temp;
        }
        
        if (rightLineEnd.y < rightLineStart.y)
        {
            CGPoint temp =rightLineStart;
            rightLineStart =rightLineEnd;
            rightLineEnd= temp;
        }
        
        
        const float angle = angleBetweenLines( leftLineStart, leftLineEnd, rightLineStart, rightLineEnd);
        NSLog(@"THE ANGLE OF THE LINES IS %f", angle);
        
        if( angle < 20.0f )
        {
            greenLightFlashing = true;
        }
        else if( angle < 30.0f )
        {
            amberLightFlashing = true;
        }
        else
        {
            redLightFlashing = true;
        }
    }
}


-(void)eraserPressed
{
    redlight.alpha = 1.0f;
    amberlight.alpha = 1.0f;
    greenlight.alpha = 1.0f;
    greenLightFlashing = false;
    amberLightFlashing = false;
    redLightFlashing = false;
}



//calculate angle between the two lines

float angleBetweenLines(const CGPoint line1Start, const CGPoint line1End, const CGPoint line2Start, const CGPoint line2End)
{
    //each line has a start point and end get angle for it
    const float a =line1End.x -line1Start.x;
    const float b =line1End.y -line1Start.y;
    const float c= line2End.x -line2Start.x;
    const float d= line2End.y- line2Start.y;
    
    //calculate angle in radians
    const float rads = acosf( ( ( a*c) + (b*d))/ (( sqrt( a*a + b*b)) * (sqrtf(c*c + d*d))));
    
    return ( ( 180.0f* rads) / M_PI);
    
//    const float rads = acosf( ( ( a*c ) + ( b*d ) ) / ( ( sqrtf( a*a + b*b ) ) * ( sqrtf( c*c + d*d ) ) ) );
    
}

//apply clamp rotation to ensure angle stays between 0-360

float clampRotation(float angle)
{
    while (angle >= 360.0f)
        
    {
        angle -= 360.0f;
    }
    
    while (angle < 0.0f)
    {
        
        angle +=360.0f;
    }
    
    return angle;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
