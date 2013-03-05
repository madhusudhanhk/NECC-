//
//  AESAuthenticationManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEAuthenticationManager.h"
#import "JSON.h"
#import "Logger.h"
#import "ACEUser.h"

@interface ACEAuthenticationManager( )

@property (nonatomic, strong) NSString *uName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *deviceID;

@end
@implementation ACEAuthenticationManager

@synthesize uName, password, deviceID;

- (void)dealloc 
{
    self.deviceID = nil;
    self.uName = nil;
    self.password = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (id)initWithUser:(NSString*)userName 
          password:(NSString*)pwd
       andDeviceId:(NSString*)devId
          delegate:(id)_delegate
{
    if (self = [super initWithDelegate:_delegate]) {
        self.uName = userName;
        self.password = pwd;
        self.deviceID = devId;
        apiReqType = eLoginReq;
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
    [apiRequest addRequestHeader: @"Content-Length" value:@"200" ];
    [apiRequest setValidatesSecureCertificate:NO];
    [apiRequest setRequestMethod:[self getAPIType]];
    [apiRequest setPostBody: [NSMutableData dataWithData: [[self getMessageBody] 
                                                           dataUsingEncoding:NSUTF8StringEncoding]]];
    
#if !__has_feature(objc_arc)
    [apiURL release];
#endif
    apiURL = nil;
    
    //Subclasses can modify this method based on requirement.
}

- (NSString*)getAPIURL
{
    NSString *apiURL;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:kURLLocation];
    apiURL = myString;
    apiURL = [apiURL stringByAppendingString:@"/Authenticate"];
 
    return apiURL;
}

- (NSString*)getMessageBody
{
    NSDictionary *inputParam = generateDict_(deviceID,key_DeviceId,uName,
                                             key_username,password,key_password);

    NSError *error = nil;
    SBJSON * json = [[SBJSON alloc] init];
    NSString *message = [json stringWithObject: inputParam error:&error];
    
    if (error) {
        [Logger log:@"Error: while framing JSON String: %@",error];
        return nil;
    }
    
    return message;
}

- (void)validateUser
{
    [self generateRequest];
    [apiRequest startAsynchronous];
}

#pragma mark - ASIHTTPRequest Delegate

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *userAsDict  = [responseString JSONValue]; 
    int resultCode = [[userAsDict objectForKey:@"ResultCode"] intValue];
    int count = [[[userAsDict objectForKey:@"Data"] objectForKey:@"LogOnAttempts"] intValue];
    kStaffName = [[userAsDict objectForKey:@"Data"] objectForKey:@"StaffName"];
    [[NSUserDefaults standardUserDefaults]setValue: [[userAsDict objectForKey:@"Data"] objectForKey:@"StaffName"] forKey:@"kStaffName"];
    
    kUserName = [[userAsDict objectForKey:@"Data"] objectForKey:@"UserName"];
  //  NSString *userName = [[userAsDict objectForKey:@"Data"] objectForKey:@"LogOnAttempts"];
    if ( 1 == resultCode ) { //Valid Login
        
        NSDictionary *ticket = [[userAsDict objectForKey:@"Data"] objectForKey:@"Ticket"];
       

        ACEUser *aceUser = [[ACEUser alloc] init];
        aceUser.ACEUserId = [[ticket valueForKey:@"AceUserId"] intValue];
       aceUser.SessionId = [ticket valueForKey:@"SessionId"];
        
        responseData = [NSMutableArray arrayWithObject:aceUser];
        
        if ([self.delegate respondsToSelector:@selector(ACEConnectionManager:didLoginSuscessfull:)]) {
            [self.delegate ACEConnectionManager:self didLoginSuscessfull:responseData];
        }
        aceUser = nil;
        
    } else if( 0 == resultCode ) { //Invalid login, wrong User name or password
        
        if ([self.delegate respondsToSelector:@selector(ACEConnectionManagerDidLoginFailed:isAccountLocked:loginAttemptCount:)]) {
            [self.delegate ACEConnectionManagerDidLoginFailed:self isAccountLocked:NO loginAttemptCount:count];
        }
        
    } else if( 2 == resultCode ) { //Invalid login, user locked
       
        if ([self.delegate respondsToSelector:@selector(ACEConnectionManagerDidLoginFailed:isAccountLocked:loginAttemptCount:)]) {
            [self.delegate ACEConnectionManagerDidLoginFailed:self isAccountLocked:YES loginAttemptCount:count];
        }
    }
   
}

@end
