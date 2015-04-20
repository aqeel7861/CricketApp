//
//  Line.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 23/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

//Used for the line shape as line shape has different methods to that of the circle square etc

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

-(CGPoint)getStartPoint;
-(CGPoint)getEndPoint;

@end
