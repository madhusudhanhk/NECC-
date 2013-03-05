//
//  ACEPastSessionDetailsManager.m
//  ACE
//
//  Created by Santosh Kumar on 8/23/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "ACEPastSessionDetailsManager.h"
#import "ACEUTILMethods.h"
#import "Logger.h"
#import "JSON.h"
#import "StudentDatabase.h"

@interface ACEPastSessionDetailsManager( )

- (void)processPastsessionData:(NSArray*)pastData;
- (void)processSAPastSessionData:(NSArray*)SAPastData;
- (void)processITPastSessionData:(NSArray*)ITPastData;
- (void)processTAPastSessionData:(NSArray*)TAPastData andActivationId:(int)activationId;
- (void)updateQueueStatusOnResponse;

@property (retain) NSMutableArray *requestQueue;
@property (assign) int failCount;

@end

@implementation ACEPastSessionDetailsManager
@synthesize requestQueue;
@synthesize failCount;

- (id)initWithVersionIds:(NSArray *)versionList
                   token:(NSString*)token
                delegate:(id)_delegate
{
    if (self = [super initWithVersionIds:versionList 
                                   token:token 
                                delegate:_delegate]) {
        apiReqType = eCurriculumBasedPastData;
        self.requestQueue = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSString*)getAPIURL
{
    NSString *apiURL = nil;
    NSString *IdList = @"";
    
    NSMutableArray *activationList = [self.queue objectAtIndex:0];
    
    if ([activationList count] > 0) {
        NSNumber *actvId = [activationList objectAtIndex:0];
        IdList = [IdList stringByAppendingString:
                  [NSString stringWithFormat:@"%d",[actvId intValue]]];
        [activationList removeObjectAtIndex:0];
    }
    
    for (NSNumber *actv in activationList) {
        IdList = [IdList stringByAppendingString:
                  [NSString stringWithFormat:@",%d",[actv intValue]]];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:kURLLocation];
    apiURL = myString;
    
    apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"/PastSessionDetails/%@?date=%@",IdList,
                                              [ACEUTILMethods getCurrentDateByRemovingSpace]]];
    
    [Logger log:@"API URL Curruculum Details : %@",apiURL];
    
    return apiURL;
}

- (void)loadPastDataDetails
{
    NSMutableArray *iterationArray = [[NSMutableArray alloc] initWithArray:self.queue];
    self.failCount = 0;
    
    for (NSMutableArray *studentActivation in iterationArray) {
        [self generateRequest];
        [self.requestQueue addObject:apiRequest];
        apiRequest = nil;
        [self.queue removeObject:studentActivation];
    }
    
    [self.requestQueue makeObjectsPerformSelector:@selector(startAsynchronous)];
    
    //No Reuest. So Inform delegate 
    if ([self.requestQueue count] <= 0) {
        if ([self.delegate respondsToSelector:@selector(ACEPastSessionDetailsManagerDidFinishLoading:WithFailCount:)]) {
            [self.delegate ACEPastSessionDetailsManagerDidFinishLoading:self WithFailCount:self.failCount];
        }
    }
}

- (void)updateQueueStatusOnResponse
{
    if ([self.requestQueue count] <= 0) {
        if ([self.delegate respondsToSelector:@selector(ACEPastSessionDetailsManagerDidFinishLoading:WithFailCount:)]) {
            [self.delegate ACEPastSessionDetailsManagerDidFinishLoading:self WithFailCount:self.failCount];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    self.failCount ++;
    [self.requestQueue removeObject:request];
    [self updateQueueStatusOnResponse];
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    NSLog(@"JSON String in Version Manager = %@",responseString);
    
    NSDictionary *curriculumDict  = [responseString JSONValue]; 
    NSArray *pastDataList = [curriculumDict valueForKey:@"Data"];
    int resultCode = [[curriculumDict valueForKey:@"ResultCode"] intValue];
    if (nil != pastDataList && resultCode != 401) { //If Valid data then only delete old and put new data.
        [self processPastsessionData:pastDataList];
    }else{
        self.failCount ++;
    }
    
    [self.requestQueue removeObject:request];
    [self updateQueueStatusOnResponse];
}

- (void)processPastsessionData:(NSArray*)pastData
{
   for (NSDictionary *pastCurriculumData in pastData) {
        int curriculumType = [[pastCurriculumData valueForKey:@"CurriculumType"] intValue];
        
        if (1 == curriculumType) { //SA Session
            
            NSArray *SALevels = [pastCurriculumData valueForKey:@"SALevels"];
            [self processSAPastSessionData:SALevels];
            
        }else if(2 == curriculumType){//IT Session
            
            NSArray *ITContext = [pastCurriculumData valueForKey:@"ITContext"];
            [self processITPastSessionData:ITContext];
            
        }else if(3 == curriculumType){ //TA Session
            
            int activationId = [[pastCurriculumData valueForKey:@"ActivationId"] intValue];
            NSArray *TASessionDataCollection = [pastCurriculumData valueForKey:@"TASessionDataCollection"];         
            [self processTAPastSessionData:TASessionDataCollection andActivationId:activationId];
        }
    }
}

- (void)processSAPastSessionData:(NSArray*)SAPastData
{
    if ([SAPastData isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary *level in SAPastData) {
            
            //SALevel: No Required.
            NSArray *subLevel = [level valueForKey:@"SubLevels"];
            
            if ([subLevel isKindOfClass:[NSArray class]]) {
               
                for (NSDictionary *subLvl in subLevel) {
                    
                    //SASublevel: No required.
                    int aceSubLevelID = [[subLvl valueForKey:@"Id"] intValue];
                    int subLevelID = [StudentDatabase getSASublevelIdWithACESublevelId:aceSubLevelID];
                    NSArray *pastSessions = [subLvl valueForKey:@"PastSessionData"];
                    [StudentDatabase deleteSAPastSessionDataWithSASubLevelId:subLevelID];
                    
                    //SASubLevelId, Date, Step,Type,Score,Status,Order,Plus,PlusP,Minus,MinusP
                    
                    if ([pastSessions isKindOfClass:[NSArray class]]) {
                        
                        for (NSDictionary *pastSession in pastSessions) {
                            
                            NSMutableDictionary *pastSessionDict = [[NSMutableDictionary alloc] init];
                            [pastSessionDict setValue:[NSNumber numberWithInt:subLevelID] forKey:@"SASubLevelId"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"Date"] forKey:@"Date"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"Order"] forKey:@"Order"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"Score"] forKey:@"Score"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"Status"] forKey:@"Status"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"Step"] forKey:@"Step"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"Type"] forKey:@"Type"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"Plus"] forKey:@"Plus"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"PlusP"] forKey:@"PlusP"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"Minus"] forKey:@"Minus"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"MinusP"] forKey:@"MinusP"];
                            [pastSessionDict setValue:[pastSession valueForKey:@"NR"] forKey:@"NR"];
                            [StudentDatabase insertSAPastSession:pastSessionDict];
                            pastSessionDict = nil;
                            
                        }
                    }
                }
            }
            //Steps: No required.
        }
    }
    
}

- (void)processITPastSessionData:(NSArray*)ITPastData
{
    if ([ITPastData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dictionary in ITPastData) {
            
            //ITContext: Not required
            int contextId = [StudentDatabase 
                             getITCurriculumContextIdWithACEContextID:[[dictionary valueForKey:@"Id"] intValue]];
            
            NSArray *sessionList = [dictionary valueForKey:@"SessionCollection"];
            [StudentDatabase deleteITPastSessionDataWithITContextId:contextId];
            
            if ([sessionList isKindOfClass:[NSArray class]]) {
                for (NSDictionary *sessionInfo in sessionList) {
                    
                    NSMutableDictionary *session = [[NSMutableDictionary alloc] init];
                    [session setValue:[NSNumber numberWithInt:contextId] forKey:@"ITContextId"];
                    [session setValue:[sessionInfo valueForKey:@"WeekEnding"] forKey:@"WeekEnding"];
                    [session setValue:[sessionInfo valueForKey:@"TrialType"] forKey:@"TrialType"];
                    [session setValue:[sessionInfo valueForKey:@"TrialType"] forKey:@"TrialType"];
                    [session setValue:[sessionInfo valueForKey:@"Opportunities"] forKey:@"Opportunities"];
                    [session setValue:[sessionInfo valueForKey:@"Mip"] forKey:@"MIP"];
                    [session setValue:[sessionInfo valueForKey:@"TotalPlus"] forKey:@"TotalPlus"];
                    [session setValue:[sessionInfo valueForKey:@"TotalPlusP"] forKey:@"TotalPlusP"];
                    [session setValue:[sessionInfo valueForKey:@"TotalMinus"] forKey:@"TotalMinus"];
                    [session setValue:[sessionInfo valueForKey:@"TotalMinus"] forKey:@"TotalMinus"];
                    [session setValue:[sessionInfo valueForKey:@"TotalNR"] forKey:@"TotalNR"];
                    [session setValue:[sessionInfo valueForKey:@"Order"] forKey:@"Order"];
                    [StudentDatabase InsertITPastSession:session];
                    session = nil;
                }
            }
        }
    }
}

- (void)processTAPastSessionData:(NSArray*)TAPastData andActivationId:(int)activationId
{
    int stuCurriculumID = [StudentDatabase getStuCurriculumIdWithActivationId:activationId];
    int TACurriculumID = [StudentDatabase getTACurriculumIdWithStuCurriculumId:stuCurriculumID];
    [StudentDatabase deleteTAPastSessionDataWithTACurriculumId:TACurriculumID];
    
    if ([TAPastData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *pastSession in TAPastData) {
            
            //Create Past Session Dictionary.
            NSMutableDictionary *pastDict = [[NSMutableDictionary alloc] init];
            [pastDict setValue:[NSNumber numberWithInt:TACurriculumID] forKey:@"TACurriculumid"];
            [pastDict setValue:[pastSession valueForKey:@"Date"] forKey:@"Date"];
            [pastDict setValue:[pastSession  valueForKey:@"TrailType"] forKey:@"TrialType"];
            [pastDict setValue:[pastSession valueForKey:@"PromptStep"] forKey:@"PromptStep"];
            [pastDict setValue:[pastSession valueForKey:@"TrainingStep"] forKey:@"TrainingStep"];
            [pastDict setValue:[pastSession valueForKey:@"IndependentStep"] forKey:@"StepIndependent"];
            [pastDict setValue:[NSNumber numberWithInt:[[pastSession valueForKey:@"Order"] intValue]] 
                        forKey:@"Order"];
            //Pass this dictionary to SQL for inserting into DB.
            [StudentDatabase insertTAPastSession:pastDict];
            pastDict  = nil;
        }
    
    }
    
}


@end
