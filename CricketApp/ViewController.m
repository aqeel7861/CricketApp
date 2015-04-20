//
//  ViewController.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 26/10/2014.
//  Copyright (c) 2014 Aqeel Rafiq. All rights reserved.
//


//this is the the storyboard that loads intially when the app is run

//this is where libaries are imported

#import "ViewController.h" //import the h class

@interface ViewController ()

@end

@implementation ViewController





//This allows the user to connect to the Drills View Controller



-(IBAction)Drills:(id)sender;




{
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //this is the name of the storyboard (https://www.youtube.com/watch?v=QhNdvCE9jVg) so main.storyboard
    UIViewController * DrillStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"Drills"]; //this is what the drills view controller is called so it allows connect to the drills controller
    [self presentViewController:DrillStoryboard animated:YES completion:nil]; //presents the drills view controller
    
    
    
}


//creating My videos button

-(IBAction)MyVideos:(id)sender;


{
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //this is the main storyboard the first storyboard that loads
    UIViewController * MyVideosStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"MyVideos"];
    [self presentViewController:MyVideosStoryboard animated:YES completion:nil];
}
//

-(IBAction)Tutorial:(id)sender;


{
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; //this is the main storyboard the first storyboard that loads
    UIViewController * MyVideosStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"TutorialofApp"];
    [self presentViewController:MyVideosStoryboard animated:YES completion:nil];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //this is what happens when the storyboard loads so here is the code that creates the background and the formatting of the webpage
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CarlGreenidge.jpg"]];
    background.frame = self.view.bounds;
    [[self view] addSubview:background]; //creates a background image of type UIImage

 
    
    
    UIButton * MyVideos =[UIButton buttonWithType:UIButtonTypeCustom];//created a UI button
    MyVideos.frame=CGRectMake(60, 230, 200, 50);//Button is then added to the app with coordinates
    [MyVideos addTarget:self action:@selector(MyVideos:)forControlEvents:UIControlEventTouchUpInside];
    [MyVideos setBackgroundImage:[UIImage imageNamed:@"MV.png"] forState:UIControlStateNormal];
    [self.view addSubview:MyVideos]; //then add it as a subview to the main view
    
    
    UIButton * Drills =[UIButton buttonWithType:UIButtonTypeCustom];//creates the Drills button
    Drills.frame=CGRectMake(60, 300, 200, 50);// The button is then added to the app with coordinates
    [Drills addTarget:self action:@selector(Drills:)forControlEvents:UIControlEventTouchUpInside];
    [Drills setBackgroundImage:[UIImage imageNamed:@"D.png"] forState:UIControlStateNormal];
    [self.view addSubview:Drills]; //then add it as a subview
    
    
    UIButton * tutorial =[UIButton buttonWithType:UIButtonTypeCustom];//creates the Drills button
    tutorial.frame=CGRectMake(60, 370, 200, 50);// The button is then added to the app with coordinates
    [tutorial addTarget:self action:@selector(Tutorial:)forControlEvents:UIControlEventTouchUpInside];
    [tutorial setBackgroundImage:[UIImage imageNamed:@"Tutorial.png"] forState:UIControlStateNormal];
    [self.view addSubview:tutorial]; //then add it as a subview
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
