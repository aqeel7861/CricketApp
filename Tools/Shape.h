//
//  Shape.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 23/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//


//what is this used for?


#import <UIKit/UIKit.h>

@interface Shape : UIView
{
    NSString *type;
}

-(id)init:(NSString*)inType;
-(NSString*)getType;
-(void)remove;

-(void)save:(NSMutableData*)output;

@end