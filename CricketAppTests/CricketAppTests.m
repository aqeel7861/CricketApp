//
//  CricketAppTests.m
//  CricketAppTests
//
//  Created by Aqeel Rafiq on 26/10/2014.
//  Copyright (c) 2014 Aqeel Rafiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "InternetController.h"

@interface CricketAppTests : XCTestCase

@end

@implementation CricketAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


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
- (void)testAngles //test the angles in the app
{
    CGPoint l1s = CGPointMake(0.0f, 0.0f);
    CGPoint l1e = CGPointMake(0.0f, 1.0f);
    CGPoint l2s = CGPointMake(0.0f, 0.0f);
    CGPoint l2e = CGPointMake(1.0f, 0.0f);
    
    const float angle = angleBetweenLines(l1s, l1e, l2s, l2e);
    
    if( angle > 89.0f && angle < 91.0f )
    {
        XCTAssert(YES, @"Pass %f ",angle);
    }
    else
    {
        XCTAssert(NO, @"Fail %f", angle);
    }
}

- (void)testgetVideosList {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    
    // This is an example of a functional test case.
    InternetController *internetController = [[InternetController alloc] init];
    [internetController getVideosList:^(NSMutableData *data, NSString *filename){
        if( data != nil )
        {
            NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if( stringData != NULL )
            {
                XCTAssert(YES, @"Pass");
            }
            else
            {
                XCTAssert(NO, @"Fail");
            }
            
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
