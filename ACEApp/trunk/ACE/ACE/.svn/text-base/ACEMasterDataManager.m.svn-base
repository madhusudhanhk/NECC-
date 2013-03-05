//
//  ACECurriculamMasterDataManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEMasterDataManager.h"
#import "JSON.h"
#import "ACEUTILMethods.h"
#import "StudentDatabase.h"
#import "Logger.h"

@interface ACEMasterDataManager( )

- (void)enterMstChainingSequence:(NSArray*)array;
- (void)enterMstCurriculumType:(NSArray*)array;
- (void)enterMstStatus:(NSArray*)array;
- (void)enterMstSetting:(NSArray*)array;
- (void)enterMstTrialType:(NSArray*)array;

@end

@implementation ACEMasterDataManager

- (void)dealloc 
{
#if !__has_feature(objc_arc)
    [self.sessionToken release];
    self.sessioToken = nil;
#endif
    self.sessionToken = nil;
}

- (id)initWithToken:(NSString*)token
           delegate:(id)_delegate
{
    if (self = [super initWithDelegate:_delegate]) {
        apiReqType = eMasterData;
        self.sessionToken = token;
    }
    
    return self;
}

- (NSString*)getAPIType
{
    return @"GET"; 
}

- (NSString*)getAPIURL
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:kURLLocation];
    NSString *apiURL = myString;
    apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"/Curriculum/MasterData?date=%@",
                                              [ACEUTILMethods getCurrentDateByRemovingSpace]]];
    
    [Logger log:@"API URL Curruculum Details : %@",apiURL];
    
    return apiURL;
}

- (void)loadCurriculamMasterData
{
    [self generateRequest];
    [apiRequest startAsynchronous];
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *masterDataDict  = [responseString JSONValue]; 
    NSDictionary *content = [masterDataDict valueForKey:@"Data"];
    
    NSArray *chainingSequence = [content valueForKey:@"ChainingSequence"];
    NSArray *CurrTypes = [content valueForKey:@"CurrTypes"];
    NSArray *DataEntryStatuses = [content valueForKey:@"DataEntryStatuses"];
    NSArray *MstSettings = [content valueForKey:@"MstSettings"];
    NSArray *MstTrialTypes = [content valueForKey:@"MstTrialTypes"];
    
    //[self enterMstChainingSequence:chainingSequence];
    //[self enterMstCurriculumType:CurrTypes];
    //[self enterMstStatus:DataEntryStatuses];
    
    [self enterMstSetting:MstSettings];
 //   [self enterMstTrialType:MstTrialTypes];
    
    
    [super requestFinished:request]; //Super class will pass parsed data to Delegate.
}

- (void)enterMstChainingSequence:(NSArray*)array
{
    for (NSDictionary *dict in array) {
        NSMutableDictionary *setting = [[NSMutableDictionary alloc] init];
        [setting setValue:[dict valueForKey:@"Id"] forKey:@"MstChainingSequenceId"];
        [setting setValue:[dict valueForKey:@"Name"] forKey:@"Name"];
        [StudentDatabase enterMstChainingSequence:setting];
        setting = nil;
    }
}

- (void)enterMstCurriculumType:(NSArray*)array
{
    for (NSDictionary *dict in array) {
        NSMutableDictionary *setting = [[NSMutableDictionary alloc] init];
        [setting setValue:[dict valueForKey:@"Id"] forKey:@"MstCurriculumTypeId"];
        [setting setValue:[dict valueForKey:@"Name"] forKey:@"Name"];
        [StudentDatabase enterMstCurriculumType:setting];
        setting = nil;
    }
}

- (void)enterMstStatus:(NSArray*)array
{
    for (NSDictionary *dict in array) {
        NSMutableDictionary *setting = [[NSMutableDictionary alloc] init];
        [setting setValue:[dict valueForKey:@"Id"] forKey:@"MstStatusId"];
        [setting setValue:[dict valueForKey:@"Name"] forKey:@"Name"];
        [StudentDatabase enterMstStatus:setting];
        setting = nil;
    }
}

- (void)enterMstSetting:(NSArray*)array
{
    for (NSDictionary *dict in array) {
        NSMutableDictionary *setting = [[NSMutableDictionary alloc] init];
        [setting setValue:[dict valueForKey:@"Id"] forKey:@"MstSettingId"];
        [setting setValue:[dict valueForKey:@"Name"] forKey:@"Name"];
        [setting setValue:[dict valueForKey:@"DisplayOrder"] forKey:@"DisplayOrder"];
        [StudentDatabase enterMstSetting:setting];
        setting = nil;
    }
}

- (void)enterMstTrialType:(NSArray*)array
{
    for (NSDictionary *dict in array) {
        NSMutableDictionary *setting = [[NSMutableDictionary alloc] init];
        [setting setValue:[dict valueForKey:@"Id"] forKey:@"MstTrialTypeId"];
        [setting setValue:[dict valueForKey:@"Name"] forKey:@"Name"];
        [StudentDatabase enterMstTrialType:setting];
        setting = nil;
    }
}

@end
