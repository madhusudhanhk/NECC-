//
//  AESDataManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEDataManager.h"

@interface ACEDataManager( )

@property (retain) ASIHTTPRequest *apiRequest;

@end

@implementation ACEDataManager

@synthesize delegate;
@synthesize apiRequest;
@synthesize responseData;
@synthesize sessionToken;
@synthesize baseURL;

- (id)initWithDelegate:(id)_delegate
{
    self = [super init];
    if (self) { 
        self.delegate = _delegate;
        apiReqType = eNone;
       NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        self.baseURL = [userDefault valueForKey:key_URL];
    }
    return self; 
}

- (void)dealloc 
{
    self.delegate = nil;
    self.apiRequest = nil;
    self.responseData = nil;
    self.sessionToken = nil;
    self.baseURL = nil;
    
    #if !__has_feature(objc_arc)
    [super dealloc];
    #endif
}

- (NSString*)getAPIURL
{
    return self.baseURL; //Overriden by subclasses.
}

- (NSString*)getAPIType
{
    return @"POST"; //By default API type is POST.
}

- (NSString*)getMessageBody
{
    return nil; //By default no message body.
}

- (API_TYPE)requestType
{
    return apiReqType;
}

- (void)cancelRequest
{
    [apiRequest setDelegate:nil];
    [apiRequest cancel];
}

- (void)generateRequest
{
    NSURL *apiURL = [[NSURL alloc] initWithString:[self getAPIURL]];
    apiRequest = [ASIHTTPRequest requestWithURL:apiURL];
    [apiRequest setDelegate:self];
    NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] init];
    [requestHeaders setValue:@"application/json; char-set=utf-8" forKey:key_Content_Type];
    [requestHeaders setValue:self.sessionToken forKey:key_SessionID];
    [requestHeaders setValue:@"172.16.150.31:8012" forKey:key_Host]; //Need to check this host.
    [apiRequest setRequestHeaders:requestHeaders];
    [apiRequest setValidatesSecureCertificate:NO];
    [apiRequest setRequestMethod:[self getAPIType]];
#if !__has_feature(objc_arc)
    [apiURL release];
#endif
    apiURL = nil;
    requestHeaders = nil;
}

#pragma mark - ASIHTTPRequest Delegate

- (void) requestFinished: (ASIHTTPRequest *)request
{
    //Base classes override this to parse data. 
    //This class only returns the response data to Delegate.
    if ([self.delegate respondsToSelector:@selector(ACEConnectionManager:didFinishLoadingData:)]) {
        [self.delegate ACEConnectionManager:self didFinishLoadingData:self.responseData];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //Base classes override this to modify error. By default it passes error to delegate.
    NSError *error = [request error];
    
    if ([self.delegate respondsToSelector:@selector(ACEConnectionManager:didRecieveError:)]) {
        [self.delegate ACEConnectionManager:self didRecieveError:error];
    }
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    if ([self.delegate respondsToSelector:@selector(ACEConnectionManager:didRecieveResponse:)]) {
        [self.delegate ACEConnectionManager:self didRecieveResponse:responseHeaders];
    }
}

@end
