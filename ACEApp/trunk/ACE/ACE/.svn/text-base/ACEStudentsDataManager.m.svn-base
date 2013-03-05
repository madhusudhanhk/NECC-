//
//  ACEStudentsDataManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEStudentsDataManager.h"
#import "JSON.h"
#import "Logger.h"
#import "ACEStudent.h"
#import "ACETeam.h"
#import "ACEUTILMethods.h"
#import "Logger.h"

@interface ACEStudentsDataManager( )

@property (nonatomic, strong) ACETeam *team;

@end

@implementation ACEStudentsDataManager

@synthesize team;

- (void)dealloc 
{
    self.sessionToken = nil;
    self.team = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

- (id)initWithTeam:(ACETeam *)_team
             token:(NSString*)token
          delegate:(id)_delegate
{
 
    if (self = [super initWithDelegate:_delegate]) {
        self.sessionToken = token;
        apiReqType = eStudentList;
        self.team = _team;
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

    apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"/Students/%d?date=%@",self.team.ID,[ACEUTILMethods getCurrentDateByRemovingSpace]]];

    [Logger log:@"API URL Student : %@",apiURL];
    
    return apiURL;
}

- (void)loadStudentsList
{
    [self generateRequest];
     [apiRequest startAsynchronous];
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *responseDict  = [responseString JSONValue]; 
    NSArray *studentList = [responseDict valueForKey:kData_Key];
    
   if ([studentList isKindOfClass:[NSArray class]]) {
        self.responseData = [[NSMutableArray alloc] init];
       
        for (NSDictionary *school in studentList) {
            int teamId = [[school valueForKey:key_ID] intValue];
            NSString *name = [school valueForKey:key_Name];
            NSString *iepQuarter = [school valueForKey:key_IEPQuarter];
            ACEStudent *student = [[ACEStudent alloc] init];
            student.ID = teamId;
            student.name = name;
            student.isSelected = NO;
            student.IEPQuarter = iepQuarter;
            [self.responseData addObject:student];
            student = nil;
        }
    }
   
    [super requestFinished:request]; //Super class will pass parsed data to Delegate.
}

@end
