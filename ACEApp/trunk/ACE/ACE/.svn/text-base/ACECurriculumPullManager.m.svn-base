//
//  ACECurriculumPullManager.m
//  ACE
//
//  Created by Santosh Kumar on 9/3/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "ACECurriculumPullManager.h"
#import "JSON.h"
#import "Logger.h"
#import "ACEUTILMethods.h"
#import "Define.h"

@interface ACECurriculumPullManager( )

@property (retain) NSMutableArray *unFinishedActivationIDS;

- (NSArray*)generateListOfUnFinishedSessions;
- (BOOL)hasSessionInProgessWithActivationId:(int)actvId andInProgressActivationList:(NSMutableArray*)list;
- (void)showAlertForVersionMismatchForActiveSessions;
- (void)DeleteStuCurriculum;

@end

@implementation ACECurriculumPullManager

@synthesize unFinishedActivationIDS;

- (id)initWithStudentId:(ACEStudent *)student
                  token:(NSString*)token
               delegate:(id)_delegate
{
    if (self = [super initWithStudentId:student 
                                  token:token 
                               delegate:_delegate]) {
        apiReqType = eCurriculumManualPull;
    }
    
    return self;
}


- (id)initWithStudentIds:(NSArray*)idList
                   token:(NSString*)token
                delegate:(id)_delegate
{
    if (self = [super initWithStudentIds:idList 
                                   token:token 
                                delegate:_delegate]) {
        apiReqType = eCurriculumManualPull;
    }
    return self;
}

- (void)dealloc 
{
    self.delegate = nil;
    self.unFinishedActivationIDS = nil;
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

- (void)loadRequest
{
    [self generateRequest];
    [apiRequest startAsynchronous];

}

- (void)loadCurriculamDetails
{
    if ([ACEUTILMethods getUnsyncedDataCount] > 0) {
        [self showAlertForVersionMismatchForActiveSessions];   
    }else{
        [self loadRequest];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //Base classes override this to modify error. By default it passes error to delegate.
    NSError *error = [request error];
    [Logger log:@"Curriculum Detail Failed %@",error.description];
    if ([self.delegate respondsToSelector:@selector(ACECurriculumPullManagerDidFail:error:)]) {
        [self.delegate ACECurriculumPullManagerDidFail:self error:error];
    }
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *curriculumDict  = [responseString JSONValue]; 
    NSDictionary *dataDict = [curriculumDict valueForKey:@"Data"];
 
    [self DeleteStuCurriculum]; //Delete all curriculums for this student.
    
    //1.IT
    NSArray *ITCurriculums = [dataDict valueForKey:@"ITCurriculums"];
    [self insertITCurriculums:ITCurriculums andActualDictionary:dataDict];
    
    //2. TA
    NSArray *TACurriculums = [dataDict valueForKey:@"TACurriculums"];
    [self insertTACurriculums:TACurriculums andActualDictionary:dataDict];
    
    //3. SA
    NSArray *SACurriculums = [dataDict valueForKey:@"SACurriculums"];
    [self insertSACurriculums:SACurriculums andActualDictionary:dataDict];
    
    [self.queue removeLastObject]; //Once downloaded remove the last object.
    
    if ([self.queue count] == 0) {
       // [self updateComplete];
        [self loadCurriculamMasterData];
    } else{
        [self loadRequest];
    }
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
        
        //Mark All curriculums with progress session as version Mismatch
        [StudentDatabase markVersionMismatchForCurriculumWithActivationID:activationID];
    }
    
    return activationIDList;
}

- (BOOL)hasSessionInProgessWithActivationId:(int)actvId andInProgressActivationList:(NSMutableArray*)list
{
    BOOL inProgress = NO;
    
    for (NSNumber *activationId in list) {
        if ([activationId intValue] == actvId) {
            inProgress = YES;
            [list removeObject:activationId];
            break;
        }
    }
    return inProgress;
}

- (void)showAlertForVersionMismatchForActiveSessions
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                    message:@"One or more lessons with active sessions has been updated on the ACE.  If you wish to receive the update unsummarized data will be lost.  Select YES - If you wish to receive the update and delete unsummarized data. Select NO - If you wish to cancel update and summarize data."
                                                   delegate:self 
                                          cancelButtonTitle:@"No" 
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //Update curriculum based on user Choice.
    
    //If YES then delete active sessions also. Need to delete only from ActiveStudent Session Table
    //And TA, IT and SA Active session also.
    
    if (buttonIndex ==1) {
        [StudentDatabase DeleteAllActiveStudentSession];
        [self loadRequest];
        //Added by Madhusudhan , This is enable currentSessionType to noCurrentSession
        currentSessionType=noCurrentSeeion;
    }else{
        [self updateComplete];
    }
}

- (void)updateComplete
{
    if ([self.delegate respondsToSelector:@selector(ACECurriculumPullManagerDidFinishCurriculumLoading:)]) {
        [self.delegate ACECurriculumPullManagerDidFinishCurriculumLoading:self];
    }
}

//Student Curriculum Deletion

- (void)DeleteStuCurriculum
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    ACEStudent *student = [self.queue lastObject];
    int studId = [StudentDatabase ACEStudentIdForStudentId:student.ID];
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From StuCurriculum WHERE ACEStudentId = %d",studId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from StuCurriculum Table Using Studend ID");
        }else{
            NSLog(@"Error occured while deleting from StuCurriculum table using student ID: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
    
}

@end
