//
//  Line.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 23/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

//model and the view what it looks like and the psotion of the objects

#import <UIKit/UIKit.h>
#import "Shape.h"

@interface LineShape : Shape
{
    NSMutableArray *points;
}

-(id)init:(CGPoint)startPosition;
-(void)setEndPoint:(CGPoint)point;
-(void)addPoint:(CGPoint)point;

-(void)save:(NSMutableData*)output;

@end
