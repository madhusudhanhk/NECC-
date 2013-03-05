//
//  ACECurriculumVersionsManager.m
//  ACE
//
//  Created by Santosh Kumar on 8/23/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "ACECurriculumVersionsManager.h"
#import "JSON.h"
#import "StudentDatabase.h"
#import "Logger.h"
#import "ACEUTILMethods.h"
#import "Define.h"
#import "ACEStudent.h"

@interface ACECurriculumVersionsManager( )

- (NSArray*)parseAndGetVersionList:(NSArray*)recievedList;
- (void)cleanUPArchivedCurriculumsWithNewList:(NSArray*)newList andOldList:(NSArray*)oldList;
- (BOOL)containsActivationId:(NSArray*)activationList withActivationID:(int)actvID;
- (NSArray*)generateNewlyAddedCurriculumWithNewList:(NSArray*)newList andOldList:(NSArray*)oldList;
- (NSArray*)generateListOfUnFinishedSessions;

@end

@implementation ACECurriculumVersionsManager

- (id)initWithStudentId:(ACEStudent *)student
                  token:(NSString*)token
               delegate:(id)_delegate
{
    if (self = [super initWithStudentId:student 
                                  token:token 
                               delegate:_delegate]) {
        apiReqType = eCurriculumVersionId;
    }
    return self;
}


- (NSString*)getAPIURL
{
    NSString *apiURL = nil;
    NSString *IdList = @"";
    
    if ([self.queue count] > 0) {
        ACEStudent *student = [self.queue objectAtIndex:0];
        IdList = [IdList stringByAppendingString:[NSString stringWithFormat:@"%d",student.ID]];
        [self.queue removeObjectAtIndex:0];
    }
    
    for (ACEStudent *student in self.queue) {
        IdList = [IdList stringByAppendingString:[NSString stringWithFormat:@",%d",student.ID]];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:kURLLocation];
    apiURL = myString;
    
    apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"/CurriculumVersions/%@?date=%@",IdList,
                                              [ACEUTILMethods getCurrentDateByRemovingSpace]]];
    
    [self.queue removeAllObjects];    
    
    [Logger log:@"API URL Curruculum Details : %@",apiURL];
    
    return apiURL;
}

- (void)loadVersionDetails
{
    [self generateRequest];
    [apiRequest startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [super requestFailed:request];
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    [Logger log:@"Version JSON String : %@",responseString];
    
    NSDictionary *curriculumDict  = [responseString JSONValue]; 
    NSArray *data = [curriculumDict valueForKey:@"Data"];
    NSArray *versionList = [self parseAndGetVersionList:data];
    
    if ([self.delegate respondsToSelector:@selector(ACECurriculumVersionsManager:didRecieveVersionList:)]) {
        [self.delegate ACECurriculumVersionsManager:self didRecieveVersionList:versionList];
    }
}

- (NSArray*)parseAndGetVersionList:(NSArray*)recievedList
{
    NSMutableArray *finalUdateList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *versionDetails in recievedList) {
        
        NSMutableArray *versionAray = [[NSMutableArray alloc] init];
        NSArray *recievedVersionArray = [versionDetails objectForKey:@"ActiveCurriculumDetails"];
        NSString *studId = [versionDetails objectForKey:@"StudentId"];
        
        for (NSDictionary *versionDct in recievedVersionArray) {
            NSMutableDictionary *newVersionDct = [[NSMutableDictionary alloc] init];
            
            [newVersionDct setValue:
             [versionDct valueForKey:@"ActivationId"] forKey:@"ActivationId"];
            
            [newVersionDct setValue:
             [versionDct valueForKey:@"VersionId"] forKey:@"VersionId"];
            [versionAray addObject:newVersionDct];
            newVersionDct = nil;
        }
        
        NSMutableArray *versionIDS = [[NSMutableArray alloc] init];
        [StudentDatabase compareAndUpdateVersionsForCurriculums:versionAray];
        
        NSDictionary *studInfo = [StudentDatabase getDetailsOfStudentWithStudentId:[studId intValue]];
        int studentId = [[studInfo valueForKey:@"ACEStudentId"] intValue];
        [versionIDS addObjectsFromArray:
         [StudentDatabase listOfCurriculumWithVersionUpdateForStudent:studentId]];
        NSArray *allVersion = [StudentDatabase listOfAllCurriculumsWithStudentId:studentId];
        
        [self cleanUPArchivedCurriculumsWithNewList:versionAray andOldList:allVersion];
        
        [versionIDS addObjectsFromArray:[self generateNewlyAddedCurriculumWithNewList:versionAray 
                                                                           andOldList:allVersion]];
        [versionAray removeAllObjects];
        
        if ([versionIDS count] > 0 ) {
            NSMutableDictionary *updateList = [[NSMutableDictionary alloc] init];
            [updateList setValue:versionIDS forKey:@"ActivationId"];
            [updateList setValue:[NSNumber numberWithInt:studentId] forKey:@"ACEStudentId"];
            [finalUdateList addObject:updateList];
        }
    }
    
    return finalUdateList;
}

- (void)cleanUPArchivedCurriculumsWithNewList:(NSArray*)newList andOldList:(NSArray*)oldList
{
    for (NSDictionary *newDict in oldList) {
        int actvnID = [[newDict valueForKey:@"ActivationId"] intValue];
        NSMutableArray *activeSessionList = [[NSMutableArray alloc] 
                                             initWithArray:[self generateListOfUnFinishedSessions]];
        
        if (![self containsActivationId:newList withActivationID:actvnID]) {
            
            //Mark version mismatch.
            [StudentDatabase markVersionMismatchForCurriculumWithActivationID:actvnID];
            BOOL isInProgress = NO;
 
            for (NSNumber *actvnNo in activeSessionList) {
                int Val = [actvnNo intValue];
                if (Val == actvnID) {
                    isInProgress = YES;
                    [activeSessionList removeObject:actvnNo];
                    break;
                }
            }
            
            if (!isInProgress) {
                [StudentDatabase DeleteStuCurriculumWithActivationId:actvnID];
            }
        }
    }
}

- (NSArray*)generateNewlyAddedCurriculumWithNewList:(NSArray*)newList andOldList:(NSArray*)oldList
{
    NSMutableArray *newlyAdded = [[NSMutableArray alloc] init];
    
    for (NSDictionary *newDict in newList) {
        int actvnID = [[newDict valueForKey:@"ActivationId"] intValue];
        if (![self containsActivationId:oldList withActivationID:actvnID]) {
            [newlyAdded addObject:newDict];
        }
    }
    
    return newlyAdded;
}

- (BOOL)containsActivationId:(NSArray*)activationList withActivationID:(int)actvID
{
    BOOL isContained = NO;
    
    for (NSDictionary *dcitionary in activationList) {
        int actvnID = [[dcitionary valueForKey:@"ActivationId"] intValue];
        if (actvnID == actvID) {
            isContained = YES;
        }
    }
    return isContained;
}

- (NSArray*)generateListOfUnFinishedSessions
{
    NSMutableArray *activationIDList = [[NSMutableArray alloc] init];
    
    //Get List OF Unfinished sessions.
    NSArray *saActiveSessions = [StudentDatabase getListOFSAActiveSessionIDs];
    NSArray *taActiveSessions = [StudentDatabase getListOFTAActiveSessionIDs];
    NSArray *itActiveSessions = [StudentDatabase getListOFITActiveSessionIDs];
    
    NSMutableArray *listOfActiveSessions = [[NSMutableArray alloc] init];
    [listOfActiveSessions addObjectsFromArray:saActiveSessions];
    [listOfActiveSessions addObjectsFromArray:taActiveSessions];
    [listOfActiveSessions addObjectsFromArray:itActiveSessions];
    
    for (NSDictionary *session in listOfActiveSessions) {
        
        int ActiveStudentSessionId = [[session valueForKey:@"ActiveStudentSessionId"] intValue];
        
        //Get Stu Curriculum 
        NSDictionary *actvSessionDetails = [StudentDatabase getActiveStudentSessionDetailWithActiveStudentSessionId:ActiveStudentSessionId];
        int stuCurriculum = [[actvSessionDetails valueForKey:@"StuCurriculumId"] intValue];
        NSDictionary *stuDetails = [StudentDatabase getStuCurriculumDetailsForCurriculumWithStuCurriculumId:stuCurriculum];
        int activationID = [[stuDetails valueForKey:@"ActivationId"] intValue];
        [activationIDList addObject:[NSNumber numberWithInt:activationID]];
        
    }
    
    return activationIDList;
}

@end
