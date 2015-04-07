//
//  NSObject+InternetController.h
//  CricketApp
//
//  Created by Aqeel Rafiq on 21/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *SERVER_URL; //internet ip address

@protocol DownloadDelegate <NSObject>
- (void)didFinishedDownload:(NSData *)data filename:(NSString *)filename;
@end

@interface InternetController : NSObject
{
    enum DownloadState //list of predefined variables used everytime you call currentDownloadOperation
    {
        Nothing,
        Getting_VideosList,
        Getting_Video,
        Uploading_Video
    };

    enum DownloadState currentDownloadOperation;
    NSMutableData *currentDownload;
    NSString *currentDownloadFilename;
}

typedef void (^ASCompletionBlock)(NSMutableData *data, NSString *filename);

-(void)getVideosList:(ASCompletionBlock)callback;

-(void)downloadVideoFromServer:(NSString*)filename withCallback:(ASCompletionBlock)callback;

-(void)uploadVideo:(NSString*)filename fileData:(NSData*)fileData withCallback:(ASCompletionBlock)callback;

@end
