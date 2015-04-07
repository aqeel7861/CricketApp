//
//  Line.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 23/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

//whars the point of this class

#import "LineShape.h"

@implementation LineShape


-(id)init:(CGPoint)startPosition
{
    self = [super init:@"line"];
    
    CGRect newFrame = self.frame;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    newFrame.size.width = screenWidth;
    newFrame.size.height = screenHeight;
    newFrame.origin.x = 0;
    newFrame.origin.y = 0;
    [self setFrame:newFrame];
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = false;
    
    points = [[NSMutableArray alloc] init];
    [points addObject:[NSValue valueWithCGPoint:startPosition]];
    
    return self;
}

-(void)addPoint:(CGPoint)point
{
    [points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

-(void)setEndPoint:(CGPoint)endPoint
{
    int length = [points count];
    if( length > 1 )
    {
        [points removeObjectAtIndex:length-1];
    }
    [self addPoint:endPoint];
}
-(CGPoint)getStartPoint
{
    if( [points count] > 0 )
    {
        return [[points objectAtIndex:0] CGPointValue];
    }
    return CGPointMake( 0.0f, 0.0f );
}
-(CGPoint)getEndPoint
{
    const int count = [points count];
    if( count > 0 )
    {
        return [[points objectAtIndex:count-1] CGPointValue];
    }
    return CGPointMake( 0.0f, 0.0f );
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    if( [points count] > 0 )
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, 2.0f);
        
        CGPoint startPosition = [[points objectAtIndex:0] CGPointValue];
        CGContextMoveToPoint(context, startPosition.x, startPosition.y); //start at this point
        
        for( int i=1; i<[points count]; ++i )
        {
            CGPoint point = [[points objectAtIndex:i] CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y); //draw to this point
        }
        
        // and now draw the Path!
        CGContextStrokePath(context);
    }
}



-(void)save:(NSMutableData *)output
{
    [output appendData:[[NSString stringWithFormat:@"%@,",type] dataUsingEncoding:NSUTF8StringEncoding]];
    for( int i=0; i<[points count]; ++i )
    {
        CGPoint point = [[points objectAtIndex:i] CGPointValue];
        [output appendData:[[NSString stringWithFormat:@"%f,%f,",point.x, point.y] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [output appendData:[[NSString stringWithFormat:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
