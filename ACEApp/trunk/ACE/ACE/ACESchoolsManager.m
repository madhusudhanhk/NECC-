//
//  ACESchoolsManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACESchoolsManager.h"
#import "JSON.h"
#import "ACESchool.h"
#import "Logger.h"
#import "ACEUTILMethods.h"

@interface ACESchoolsManager( )

@property (nonatomic, assign) int userId;

@end

@implementation ACESchoolsManager

@synthesize  userId;

- (void)dealloc 
{
#if !__has_feature(objc_arc)
    [self.sessionToken release];
#endif
    self.sessionToken = nil;
}

- (id)initWithUserId:(int)UID
               token:(NSString*)token
            delegate:(id)_delegate
{
    if (self = [super initWithDelegate:_delegate]) {
        self.sessionToken = token;
        self.userId = UID;
        apiReqType = eSchoolListReq;
    }
    
    return self;
}

- (NSString*)getAPIType
{
    return @"GET"; 
}

- (NSString*)getAPIURL
{
    NSString *apiURL;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:kURLLocation];
    apiURL = myString;
    apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"/Schools/%d?date=%@",self.userId,
                                              [ACEUTILMethods getCurrentDateByRemovingSpace]]];    

    [Logger log:@"API URL Schools :%@",apiURL];
    
    return apiURL;
}

- (void)loadSchoolList
{
    [self generateRequest];
    [apiRequest startAsynchronous];
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *userAsDict  = [responseString JSONValue]; 
    NSArray *schoolList = [userAsDict valueForKey:kData_Key];
 
    if ([schoolList isKindOfClass:[NSArray class]]) {
        self.responseData = [[NSMutableArray alloc] init];
        
        for (NSDictionary *school in schoolList) {
            int studId = [[school valueForKey:key_ID] intValue];
            NSString *name = [school valueForKey:key_Name];
            ACESchool *school = [[ACESchool alloc] init];
            school.ID = studId;
            school.name = name;
            [self.responseData addObject:school];
            school = nil;
        }
    }
    
    [super requestFinished:request]; //Super class will pass parsed data to Delegate.
}

@end
