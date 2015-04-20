//
//  NSObject+InternetController.m
//  CricketApp
//
//  Created by Aqeel Rafiq on 21/01/2015.
//  Copyright (c) 2015 Aqeel Rafiq. All rights reserved.
// Internet controller CLASS MAIN CLASS

#import "InternetController.h"

NSString *SERVER_URL = @"http://161.23.54.162"; //IP ADDRESS NEEDS TO BE THE SAME ON MACHINE AND PHONE THIS IS IMPORTANT OTHERWISE XAMMP WONT NOTICE THIS

@implementation InternetController

void(^getServerResponseForUrlCallback)(NSMutableData *data, NSString *filename);

-(id)init
{
    self = [super init];
    
    currentDownloadOperation = Nothing;
    currentDownload = nil;
    currentDownloadFilename = nil;
    
    return self;
}


//four methods used here for debugging purposes if an error is hit output message is displayed in the log
-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog( @"I have hit the server" ); //outputs message when connection has been made
    currentDownload = [NSMutableData alloc];
    
    [currentDownload setLength :0]; //incase of a redirect resets the data
}



// Downloading gives an update
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [currentDownload appendData:data];
}

// Finished
-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    if( getServerResponseForUrlCallback != nil )
    {
        getServerResponseForUrlCallback( currentDownload, currentDownloadFilename );
    }
    
    if( currentDownload != NULL )
    {
        currentDownload = NULL;
    }
}


// this method is used to display an error if an error is hit. it tells me the exact error and why it happened.
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    if( getServerResponseForUrlCallback != nil )
    {
        getServerResponseForUrlCallback( nil, currentDownloadFilename );
    }
    
    NSLog( @"Connection downloading error!- %@ %@,",[error localizedDescription],
          [[error userInfo]objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    
    if( currentDownload != NULL )
    {
        currentDownload = NULL;
    }
    
    
}


//callback fucntions used so saves me having to copy the WHOLE METHOD just refrence getVideosList in class requrired
-(void)getVideosList:(ASCompletionBlock)callback;
{
    getServerResponseForUrlCallback = callback;
    currentDownloadFilename = @"_videoslist";
    
    NSString *url = [NSString stringWithFormat:@"%@/get.php",SERVER_URL];
    
    //creating the request
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:30.0]; //if no response after 30 seconds timeout
    
    currentDownloadOperation = Getting_VideosList; //this is what outputs the data in the table
    
    [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self]; //create a request on itself
}


//again a CALLBACK FUNCTION USED saves me having to copy the whole method
-(void)downloadVideoFromServer:(NSString*)filename withCallback:(ASCompletionBlock)callback;
{
    getServerResponseForUrlCallback = callback;
    currentDownloadFilename = filename;
    
    NSString *url = [NSString stringWithFormat:@"%@/get.php?video=%@",SERVER_URL, filename];
    NSLog( @"%@", url ); //make sure getscript is saved in HTDOCS folder and file server is turned on
    
    // TESTING
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:30.0]; //if no response after 30 seconds timeout
    currentDownloadOperation = Getting_Video; //stores the data in a mutable object
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self]; //create a request on itself
    connection = connection;
}

//this is to upload a video (PSOT METHOD USED).

-(void)uploadVideo:(NSString*)filename fileData:(NSData*)fileData withCallback:(ASCompletionBlock)callback
{
    getServerResponseForUrlCallback = callback;
    currentDownloadFilename = filename;
    
    //creating the request
    NSString *url = [NSString stringWithFormat:@"%@/upload.php",SERVER_URL]; //make sure file is saved in HTDOCS folder and server is turned on.
    
    NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [postRequest setHTTPMethod:@"POST"];
    
    // Set content type (the type of uploader we use)
    NSString *boundary = @"--gc0p4Jq0M2Yt08jU534c0p--";//boundary is for the chunks
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@", boundary]; //split the data through tunnel less stress
    [postRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // Setup the body
    NSMutableData *body = [NSMutableData data]; //all the data for the post
    
    // Send parameter 1: THE FILENAME
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"filename\"\r\n\r\n%@\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]]; //enter enter filenmae
    }
    
    // Send paramater 2: THE BINARY DATA
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"blob\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:fileData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // Ending boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [postRequest setHTTPBody:body];
    
    currentDownloadOperation = Uploading_Video; //stores the data in a mutable object
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self]; //create a request on itself
}

@end
