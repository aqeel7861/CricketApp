//
//  TutorialofApp.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 12/04/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

#import "TutorialofApp.h"

@interface TutorialofApp ()

@end

@implementation TutorialofApp

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Tutorial1.png"]];
    _imageView.frame = self.view.bounds;
    [[self view] addSubview:_imageView];
    
    
    UIButton * next =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    next.frame=CGRectMake(20, 25, 60, 40);//positioning of the button
    [next addTarget:self action:@selector(tutorial:)forControlEvents:UIControlEventTouchUpInside];
    [next setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [self.view addSubview:next];

    UIButton * exittutorial =[UIButton buttonWithType:UIButtonTypeCustom];//button type custom
    exittutorial.frame=CGRectMake(20, 80, 60, 40);//positioning of the button
    [exittutorial addTarget:self action:@selector(exittutorial:)forControlEvents:UIControlEventTouchUpInside];
    [exittutorial setBackgroundImage:[UIImage imageNamed:@"ET.png"] forState:UIControlStateNormal];
    [self.view addSubview:exittutorial];
    
    
    // Do any additional setup after loading the view.
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

-(IBAction)exittutorial:(id)sender;

{
    
    UIStoryboard * MasterStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//declares the main storyboard
    UIViewController * MainStoryboard= [MasterStoryboard instantiateViewControllerWithIdentifier:@"Main"]; //load main storyboard
    [self presentViewController:MainStoryboard animated:YES completion:nil]; //present the first storyboard
    
}


//constant loop of 16 images that tells the user how to use the app :)

-(IBAction)tutorial:(id)sender{
    
    if(currentimage == 16){
        currentimage  = 0;
    }
    
    if (currentimage == 0) {
        NSString *strTemp = @"Tutorial1.png";
        currentimage = 1;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    else if (currentimage == 1) {
        NSString *strTemp = @"Tutorial2.png";
        currentimage = 2;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    else if (currentimage == 2) {
        NSString *strTemp = @"tutorial3.png";
        currentimage = 3;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 3) {
        NSString *strTemp = @"Tutorial4.png";
        currentimage = 4;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    else if (currentimage == 4) {
        NSString *strTemp = @"Tutorial5.png";
        currentimage = 5;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 5) {
        NSString *strTemp = @"tutorial6.png";
        currentimage = 6;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 6) {
        NSString *strTemp = @"tutorial7.png";
        currentimage = 7;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
 
    else if (currentimage == 7) {
        NSString *strTemp = @"tutorial8.png";
        currentimage = 8;
        _imageView.image=[UIImage imageNamed:strTemp];
    }

    else if (currentimage == 8) {
        NSString *strTemp = @"tutorial9.png";
        currentimage = 9;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 9) {
        NSString *strTemp = @"tutorial10.png";
        currentimage = 10;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 10) {
        NSString *strTemp = @"tutorial11.png";
        currentimage = 11;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 11) {
        NSString *strTemp = @"tutorial12.png";
        currentimage = 12;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 12) {
        NSString *strTemp = @"tutorial13.png";
        currentimage = 13;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 13) {
        NSString *strTemp = @"tutorial14.png";
        currentimage = 14;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 14) {
        NSString *strTemp = @"tutorial15.png";
        currentimage = 15;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    else if (currentimage == 15) {
        NSString *strTemp = @"tutorial16.png";
        currentimage = 16;
        _imageView.image=[UIImage imageNamed:strTemp];
    }
    
    
}







@end
