//
//  ACETeamsManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACETeamsManager.h"
#import "JSON.h"
#import "ACETeam.h"
#import "Logger.h"
#import "ACEUTILMethods.h"

@interface ACETeamsManager( )

@property (nonatomic, assign) int userId;
@property (nonatomic, assign) int schoolId;

@end

@implementation ACETeamsManager

@synthesize userId, schoolId;

- (void)dealloc 
{
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    self.sessionToken = nil;
}

- (id)initWithUserId:(int)UID
            schoolID:(int)_schoolId
               token:(NSString*)token
            delegate:(id)_delegate
{
    if (self = [super initWithDelegate:_delegate]) {
        apiReqType = eTeamList;
        self.sessionToken = token;
        self.userId = UID;
        self.schoolId = _schoolId;
        apiReqType = eTeamList;
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
    apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"/Teams/%d/%d?date=%@",self.userId,self.schoolId,[ACEUTILMethods getCurrentDateByRemovingSpace]]];
    
    [Logger log:@"API URL Teams :%@",apiURL];
    
    return apiURL;
}

- (void)loadTeamsList
{
    [self generateRequest];
    [apiRequest startAsynchronous];
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *userAsDict  = [responseString JSONValue]; 
    NSArray *teamList = [userAsDict valueForKey:kData_Key];
    
    if ([teamList isKindOfClass:[NSArray class]]) {
        self.responseData = [[NSMutableArray alloc] init];
        
        for (NSDictionary *school in teamList) {
            int teamId = [[school valueForKey:key_ID] intValue];
            NSString *name = [school valueForKey:key_Name];
            ACETeam *team = [[ACETeam alloc] init];
            team.ID = teamId;
            team.name = name;
            [self.responseData addObject:team];
            team = nil;
        }
    }
    
    [super requestFinished:request]; //Super class will pass parsed data to Delegate.
}

@end
