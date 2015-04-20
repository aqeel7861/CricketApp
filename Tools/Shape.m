//
//  Shape.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 23/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//


//used to create the shapes of this ap

#import "Shape.h"

@implementation Shape


-(id)init:(NSString*)inType
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.width;
    
    self = [super initWithFrame:CGRectMake( screenWidth*0.5, screenHeight*0.5, 50, 50)];
    
    self->type = inType;
    if( [type isEqualToString:@"circle"] )
    {
        UIImageView *linetool = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,50)]; //size 50,50
        linetool.image = [UIImage imageNamed:@"circle.gif"]; //shapes image found in resources folder
        linetool.alpha=1.5;
        [self addSubview:linetool];
    }
    else if( [type isEqualToString:@"square"] ) //square shape will take the color yellos
    {
        self.backgroundColor = [UIColor yellowColor];
    }
    else if( [type isEqualToString:@"line"] ) //used for the line shape
    {
    }
    
    return self;
}

-(NSString*)getType
{
    return self->type;
}

-(void)remove
{
    [self removeFromSuperview]; //used for eraser tool
}


-(void)save:(NSMutableData *)output
{
    CGRect frame = self.frame;
    [output appendData:[[NSString stringWithFormat:@"%@,%f,%f,%f,%f\n",type,frame.origin.x, frame.origin.y, frame.size.width, frame.size.height] dataUsingEncoding:NSUTF8StringEncoding]];
}//used to save the shapes button avaliable in app

@end

