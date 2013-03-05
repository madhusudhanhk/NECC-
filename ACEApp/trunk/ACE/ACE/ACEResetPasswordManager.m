//
//  ACEResetPasswordManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEResetPasswordManager.h"
#import "JSON.h"
#import "Logger.h"

@interface ACEResetPasswordManager( )

@property (nonatomic, strong) NSString *emailID;

@end

@implementation ACEResetPasswordManager
@synthesize emailID;

- (void)dealloc 
{
    self.emailID = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (id)initWithEmailID:(NSString*)eId 
             delegate:(id)_delegate
{
    if (self = [super initWithDelegate:_delegate]) {
        self.emailID = eId;
        apiReqType = eRequestPassword;
    }
    
    return self;
}

- (void)generateRequest
{
    NSURL *apiURL = [[NSURL alloc] initWithString:[self getAPIURL]];
    apiRequest = [ASIHTTPRequest requestWithURL:apiURL];
    [apiRequest setDelegate:self];
    [apiRequest addRequestHeader: @"Content-Type" value: @"application/json; char-set=utf-8" ];
    [apiRequest addRequestHeader: @"User-Agent" value: @"ACE iOS App" ];
    [apiRequest addRequestHeader: @"Content-Length" value:@"56" ];
    [apiRequest setValidatesSecureCertificate:NO];
    [apiRequest setRequestMethod:[self getAPIType]];
    [apiRequest setPostBody: [NSMutableData dataWithData: [[self getMessageBody] 
                                                           dataUsingEncoding:NSUTF8StringEncoding]]];
    
#if !__has_feature(objc_arc)
    [apiURL release];
#endif
    apiURL = nil;
}


- (NSString*)getMessageBody
{
    NSDictionary *inputParam = generateDict_(emailID,@"emailId");
    
    NSError *error = nil;
    SBJSON * json = [[SBJSON alloc] init];
    NSString *message = [json stringWithObject: inputParam error:&error];
    
    if (error) {
        [Logger log:@"Error: while framing JSON String: %@",error];
        return nil;
    }
    
    return message;
}

- (NSString*)getAPIURL
{
    NSString *apiURL;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:kURLLocation];
    apiURL = myString;
    apiURL = [apiURL stringByAppendingString:@"/RequestPassword"];
    
    return apiURL;
}


- (void)resetPassword
{
    [self generateRequest];
    [apiRequest startAsynchronous];
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *userAsDict  = [responseString JSONValue]; 
    int resultCode = [[userAsDict valueForKey:@"ResultCode"] intValue];
    
    if (resultCode == 200) {
        if ([self.delegate respondsToSelector:@selector(ACEDataManagerDidResetPassword:)]) {
            [self.delegate ACEDataManagerDidResetPassword:self];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(ACEDataManagerDidResetPasswordFailed:)]) {
            [self.delegate ACEDataManagerDidResetPasswordFailed:nil];
        }
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
   
    NSError *error = [request error];
    
    if ([self.delegate respondsToSelector:@selector(ACEDataManagerDidResetPasswordFailed:)]) {
        [self.delegate ACEDataManagerDidResetPasswordFailed:error];
    }
}

@end
