//
//  ACESyncManager.m
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACESyncManager.h"
#import "StudentDatabase.h"
#import "SBJSON.h"
#import "Logger.h"
#import "ACEUTILMethods.h"
#import "ACETAJsonGenerator.h"
#import "ACESAJsonGenerator.h"
#import "ACEITJsonGenerator.h"
#import "ASIHTTPRequest.h"
#import "NSString+SBJSON.h"

typedef enum 
{
    eNoStatus,
    eSuscessful,
    eFailed
}SYNC_STATUS;

static ACESyncManager *sharedInstance = nil;

@interface ACESyncManager( )

- (void)generateSessionJSONForAllActiveSessions;
- (NSString*)getAPIURL;
- (NSString*)getMessageBody;
- (void)generateRequest;
- (void)generateSyncQueue;
- (void)initiateCurriculumSync;
- (void)syncCompleted;
- (void)syncCompletedForSingleItemWithStatu:(SYNC_STATUS)status;
- (NSString*)getAPIType;
- (int)readUserId;

@property (nonatomic, retain) NSMutableArray *syncQueue;
@property (retain)NSMutableArray *observers;
@property (nonatomic, assign) int userId;
@property (nonatomic, assign) int failCount;
@property (retain) ASIHTTPRequest *apiRequest;
@property (assign) API_TYPE apiReqType;
@property (assign) BOOL isSyncingInProgress;
@property (assign) BOOL isSynchronousMode;

@end

@implementation ACESyncManager

@synthesize isSyncingInProgress;
@synthesize syncQueue;
@synthesize userId;
@synthesize failCount;
@synthesize observers;
@synthesize apiRequest, apiReqType;
@synthesize isSynchronousMode;

#pragma mark - Initialization And Deallocation

+ (ACESyncManager *)getSyncManager
{
	if(sharedInstance == nil) {
		sharedInstance = [[ACESyncManager alloc] init];
	}
	return sharedInstance;
}

- (id) init
{
	self = [super init];
	
	if (self != nil) { 
        self.syncQueue = [[NSMutableArray alloc] init];
        self.observers = [[NSMutableArray alloc] init];
        self.isSyncingInProgress = NO;
        self.isSynchronousMode = NO;
        apiReqType = eSyncData;
    }
	
	return self;
}

- (void)dealloc 
{
    self.syncQueue = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

- (NSString*)readActiveSessionToken
{
    return [StudentDatabase getLoggedInUserSessionId];
}

- (int)readUserId
{
    return [StudentDatabase GetLoggedInUserID];
}

- (NSString*)readUSerName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:@"uname"];
}

#pragma mark - Private Methods

- (NSString*)getAPIURL
{
    NSString *apiURL;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:kURLLocation];
    apiURL = myString;
    
    //Based on the mode decide the URL.
    apiURL = (self.isSynchronousMode) ? [apiURL stringByAppendingString:@"/Curriculum/SessionData/Sync"] :
                      [apiURL stringByAppendingString:@"/Curriculum/SessionData/Async"];  
    
    [Logger log:@"API URL Curruculum Details : %@",apiURL];
    
    return apiURL;
}

- (NSString*)getMessageBody
{
    NSDictionary *syncDict = [self.syncQueue lastObject];
    return [syncDict valueForKey:@"SyncData"];
}

- (NSString*)getAPIType
{
    return @"POST"; 
}

- (void)generateRequest
{
    self.apiRequest = nil;
    
    NSURL *apiURL = [[NSURL alloc] initWithString:[self getAPIURL]];
    self.apiRequest = [ASIHTTPRequest requestWithURL:apiURL];
    [apiRequest setDelegate:self];
    [apiRequest addRequestHeader: @"Content-Type" value: @"application/json; char-set=utf-8" ];
    [apiRequest addRequestHeader: @"User-Agent" value: @"ACE iOS App" ];
    [apiRequest addRequestHeader: @"Content-Length" value:@"1739" ];
    [apiRequest addRequestHeader:@"Session-Id" value:[self readActiveSessionToken]];
    [apiRequest setValidatesSecureCertificate:NO];
    [apiRequest setRequestMethod:[self getAPIType]];
    [apiRequest setPostBody: [NSMutableData dataWithData: [[self getMessageBody] 
                                                           dataUsingEncoding:NSUTF8StringEncoding]]];
    
#if !__has_feature(objc_arc)
    [apiURL release];
#endif
    apiURL = nil;
}

- (void)generateSyncQueue
{
    [self.syncQueue removeAllObjects];
    NSMutableArray *syncArray = [[NSMutableArray alloc] initWithArray:[StudentDatabase getAllUnsyncedSessionDetails]];
    self.syncQueue = syncArray;
    
    if ([self.syncQueue count] > 0) {
        [self initiateCurriculumSync];
    }
}

- (void)initiateCurriculumSync
{
    self. isSyncingInProgress = YES;
    [self generateRequest];
    [apiRequest startAsynchronous];
}

#pragma mark - Add  Delete Observer

- (void)addSyncObserver:(id)syncObserver
{
    [self.observers addObject:syncObserver];
}

- (void)removeSyncObserver:(id)syncObserver
{
    if ([self.observers containsObject:syncObserver]) {
        [self.observers removeObject:syncObserver];
    }
}

//JSON Generation Start
#pragma mark - JSON generation methods

- (void)generateSessionJSONForAllActiveSessions
{
    //Get List of Distinct Stu Curriculums from Active Sessions Table with isDirty Flag 'true'
    NSArray *curriculumId = [StudentDatabase getListOfDistinctStuCurriculumIdFromActiveSession];
    int summarizedSessionCount = 0;
    
    for (NSDictionary *curriculum in curriculumId) {
        
        int stuCurriculumId = [[curriculum valueForKey:@"StuCurriculumId"] intValue];
        //Stu Curriculum Details.
        NSDictionary *getStuCurriculum = [StudentDatabase getStuCurriculumDetailsForCurriculumWithStuCurriculumId:stuCurriculumId];
        
        int curriculumId = [[getStuCurriculum valueForKey:@"CurriculumTypeId"] intValue];
        NSMutableArray *activeSessionInfo = [StudentDatabase getActiveSessionDetailsForStuCurriculumId:stuCurriculumId];
        BOOL isSummarized = NO;
        int activeSessionCount = 0;
        
         //1 - SA, 2 - IT, 3 - TA
        if (1 == curriculumId) {
 
            for (NSDictionary *dictionary in activeSessionInfo) {
                activeSessionCount += [StudentDatabase countForActiveSASessionWithActiveStudentSessionId:[[dictionary valueForKey:@"ActiveStudentSessionId"] intValue]];
            }
            
        }else if(2 == curriculumId){
            
            for (NSDictionary *dictionary in activeSessionInfo) {
                activeSessionCount += [StudentDatabase countForActiveITSessionWithActiveStudentSessionId:[[dictionary valueForKey:@"ActiveStudentSessionId"] intValue]];
            }
            
        }else if(3 == curriculumId){
            
            for (NSDictionary *dictionary in activeSessionInfo) {
                activeSessionCount += [StudentDatabase countForActiveTASessionWithActiveStudentSessionId:[[dictionary valueForKey:@"ActiveStudentSessionId"] intValue]];
            }
        }
        
        if (activeSessionCount) {
            isSummarized = YES;
        }
        
        if (isSummarized) {
            
            summarizedSessionCount++;
            
            //JSON Structure
            //"sessionInfo": {"ActivationId":5,"CmType":2,"CurriculumName":"IT - 1","DeviceKey":"edf4da74-535a-4099-8f9f-7c45860db41a","IEPQuarter":1,"ITSessions":[],"SASessions":[],"StudentName":"Test, Student","TASessions":[],"UserId":1,"UserName":"ashin@aditi.com","Version":5
            
            //Get Student Info
            NSDictionary *studDict = [StudentDatabase getDetailsOfStudentWithACEStudentId:[[getStuCurriculum valueForKey:@"ACEStudentId"] intValue]];
            
            //Curriculum Type
            NSDictionary *curriculumInfo = [StudentDatabase getMstCurriculumTypeForCurriculumId:[[getStuCurriculum valueForKey:@"CurriculumTypeId"] intValue]];

            //Generate the top dictionary. (It contains items at root level. Internal hierarchy should be formed within the
            //spescific curriculum types method.
            
            //ActivationId
            NSMutableDictionary *activeSessionInfoDictionary = [[NSMutableDictionary alloc] init];
            [activeSessionInfoDictionary setValue:[NSNumber numberWithInt:
                                                   [[getStuCurriculum valueForKey:@"ActivationId"] intValue]] forKey:@"ActivationId"];
            
            //CmType
            [activeSessionInfoDictionary setValue:[NSNumber numberWithInt:
                                                   [[curriculumInfo valueForKey:@"MstCurriculumTypeId"] intValue]] forKey:@"CmType"];
            
            //CurriculumName
            [activeSessionInfoDictionary setValue:[getStuCurriculum valueForKey:@"Name"] forKey:@"CurriculumName"];
            
            //DeviceKey
            NSString *GUID = [ACEUTILMethods getUUID];
            [activeSessionInfoDictionary setValue:GUID forKey:@"DeviceKey"];  
            
            //IEPQuarter
            [activeSessionInfoDictionary setValue:[NSNumber numberWithInt:[[studDict valueForKey:@"Quarter"] intValue]] forKey:@"IEPQuarter"]; 
            
            //StudentName
            [activeSessionInfoDictionary setValue:[studDict valueForKey:@"Name"] forKey:@"StudentName"];
            
            int userID = [self readUserId];
            //UserId
            [activeSessionInfoDictionary setValue:
             [NSNumber numberWithInt:userID] forKey:@"UserId"]; //logged in user
            
            //UserName 
            [activeSessionInfoDictionary setValue:[self readUSerName] forKey:@"UserName"]; 
            
            //Version
            [activeSessionInfoDictionary setValue:[NSNumber numberWithInt:
                                                   [[getStuCurriculum valueForKey:@"CurrentVersionId"] intValue]] forKey:@"Version"]; 
            
            //PublishId
            [activeSessionInfoDictionary setValue:[NSNumber numberWithInt:
                                                   [[getStuCurriculum valueForKey:@"PublishedId"] intValue]] forKey:@"PublishedId"];
            
            //Fill Curriculum details based on curriculum type.
            NSMutableArray *TASessions = [[NSMutableArray alloc] init];
            NSMutableArray *SASessions = [[NSMutableArray alloc] init];
            NSMutableArray *ITSession = [[NSMutableArray alloc] init];
            int ACEStudentId = [[studDict valueForKey:@"ACEStudentId"] intValue];
            
            if (1 == curriculumId) {
                
                ACESAJsonGenerator *SAJsonGenerator = [[ACESAJsonGenerator alloc] initWithGUID: GUID
                                                                                     andUserId:userID
                                                                                  andStudentId:ACEStudentId];
                
                NSArray *curriculumArray = [SAJsonGenerator getCurriculumListWithStuCurriculumId:stuCurriculumId];
                [SASessions addObjectsFromArray:curriculumArray];
                SAJsonGenerator = nil;
                
            }else if(2 == curriculumId){
                
                ACEITJsonGenerator *ITJsonGenerator = [[ACEITJsonGenerator alloc] initWithGUID:GUID 
                                                                                     andUserId:userID
                                                                                  andStudentId:ACEStudentId];
                
                NSArray *curriculumArray = [ITJsonGenerator getCurriculumListWithStuCurriculumId:stuCurriculumId];
                [ITSession addObjectsFromArray:curriculumArray];
                ITJsonGenerator = nil;
                
                
            }else if(3 == curriculumId){
                
                ACETAJsonGenerator *TAJsonGenerator = [[ACETAJsonGenerator alloc] initWithGUID:GUID 
                                                                                     andUserId:userID
                                                                                  andStudentId:ACEStudentId];
                
                NSArray *curriculumArray = [TAJsonGenerator getCurriculumListWithStuCurriculumId:stuCurriculumId];
                [TASessions addObjectsFromArray:curriculumArray];
                TAJsonGenerator = nil;
            }
            
            [activeSessionInfoDictionary setValue:ITSession forKey:@"ITSessions"];
            [activeSessionInfoDictionary setValue:SASessions forKey:@"SASessions"];
            [activeSessionInfoDictionary setValue:TASessions forKey:@"TASessions"];
            
            //Generate the final Sync Dictionary
            NSDictionary *finalSyncDictionary = [[NSMutableDictionary alloc] init];
            [finalSyncDictionary setValue:activeSessionInfoDictionary forKey:@"sessionInfo"];
            
            NSString *jsonString = nil;
            NSError *error = nil;
            SBJSON * json = [[SBJSON alloc] init];
            jsonString = [json stringWithObject:finalSyncDictionary error:&error];
            
            [Logger log:@"JSON STRING  = %@",jsonString];
            
            if (error) {
                [Logger log:@"Error: while framing Sync JSON String: %@",error];
            }else{
                
                //Make entry in Sync table.
                NSMutableDictionary *syncTableInfo = [[NSMutableDictionary alloc] init];
                [syncTableInfo setValue:GUID forKey:@"SyncKey"];
                [syncTableInfo setValue:jsonString forKey:@"SyncData"];
                [syncTableInfo setValue:jsonString forKey:@"Retries"];
                [StudentDatabase insertIntoSyncTable:syncTableInfo];
                syncTableInfo = nil;
                
                
                //Take the session List.
                NSArray *sessionList = [StudentDatabase getActiveStudentSessionDetailWithStuCurriculumId:stuCurriculumId];
                
                if (1 == curriculumId) {
                    
                    for (NSDictionary *session in sessionList) {
                        NSArray *activeSessionList = [StudentDatabase getSAActiveSessionForActiveStudentID:
                                                      [[session valueForKey:@"ActiveStudentSessionId"] intValue]];
                        for (NSDictionary *sessionInfo in activeSessionList) {
                            //Delete from ActiveStudentSession Sync table it will delete from every where. (Cascaded Delete).
                            [StudentDatabase DeleteActiveStudentSessionWithActiveSessionId:
                             [[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
                        }
                    }
                    
                }else if(2 == curriculumId){
                    
                    for (NSDictionary *session in sessionList) {
                        NSArray *activeSessionList = [StudentDatabase getITActiveSessionWithActiveStudentSessionId:
                                                      [[session valueForKey:@"ActiveStudentSessionId"] intValue]];
                        for (NSDictionary *sessionInfo in activeSessionList) {
                            //Delete from ActiveStudentSession Sync table it will delete from every where. (Cascaded Delete).
                            [StudentDatabase DeleteActiveStudentSessionWithActiveSessionId:
                             [[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
                        }
                    }                    
                    
                }else if(3 == curriculumId){
                    
                    for (NSDictionary *session in sessionList) {
                        NSArray *activeSessionList = [StudentDatabase getTAActiveSessionForActiveStudentSessionId:
                                                      [[session valueForKey:@"ActiveStudentSessionId"] intValue]];
                        for (NSDictionary *sessionInfo in activeSessionList) {
                            //Delete from ActiveStudentSession Sync table it will delete from every where. (Cascaded Delete).
                            [StudentDatabase DeleteActiveStudentSessionWithActiveSessionId:
                             [[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
                        }
                    }
                }
            }
        }
    }
    
    if (summarizedSessionCount > 0) {
        [self generateSyncQueue];
    }else{
        [self syncCompleted]; 
    }
}

//JSON Generation End

#pragma mark - Public Methods

- (void)syncCuroculumWithServerInSynchronosMode
{
    self.isSynchronousMode = YES;
    [self syncCurriculumWithServer];
}

- (void)syncCurriculumWithServer
{
    if (!self.isSyncingInProgress) {
        [self generateSyncQueue];
        if ([self.syncQueue count] <= 0) { 
            [self generateSessionJSONForAllActiveSessions];
        }
    }
}

#pragma mark - ASHIHTTPRequest Delegate

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [Logger log:@"Uploadin Failed"];
    [self syncCompletedForSingleItemWithStatu:eFailed];
}

//{"ResultCode":3,"ResultText":"Completed","ActivationId":5,"LatestVersion":5,"SyncedVersion":5}
- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *respDictionary = [responseString JSONValue];
    [Logger log:@"Response String for Sync = %@",responseString];
    int ResultCode = [[respDictionary valueForKey:@"ResultCode"] intValue];
    //SYNC_STATUS status = (ResultCode == 3 || ResultCode == 1) ? eSuscessful : eFailed;
    SYNC_STATUS status =  eSuscessful; //Since response is recieved. So delete the data irrespective of fail/success.
    [self syncCompletedForSingleItemWithStatu:status];
}

- (void)syncCompleted
{
    if (self.failCount > 0) {
        for (id observer in self.observers) {
            if ([observer respondsToSelector:@selector(ACESyncManageDidSyncFailed:WithFailCount:)]) {
                [observer ACESyncManageDidSyncFailed:self WithFailCount:self.failCount];
            }
        }
    }else{
        for (id observer in self.observers) {
            if ([observer respondsToSelector:@selector(ACESyncManageDidFinishSync:)]) {
                [observer ACESyncManageDidFinishSync:self];
            }
        }
    }
    
    self.isSyncingInProgress = NO;
    self.failCount = 0;
    self.isSynchronousMode = NO;
}

- (void)syncCompletedForSingleItemWithStatu:(SYNC_STATUS)status
{
    self.failCount = (status == eFailed) ? (self.failCount + 1) : self.failCount;
    
    NSDictionary *syncInfo = [self.syncQueue lastObject];
    NSString *key = [syncInfo valueForKey:@"SyncKey"];
    
    //Once downloaded remove the last object. Remove irrespective of reponse.
    [self.syncQueue removeLastObject]; 
    
    //If Success then delete it from local DB.
    if (status == eSuscessful) {
        [StudentDatabase deleteSyncInfoWithSyncKey:key];
    }
    
    if ([self.syncQueue count] == 0) {
        
        //Once sync is complete, check is there are any more active sessions added.
        self.syncQueue = nil;
        [self generateSessionJSONForAllActiveSessions];
        
    } else{
        [self initiateCurriculumSync]; //More items queued. So initiate sync again.
    }
}

@end
