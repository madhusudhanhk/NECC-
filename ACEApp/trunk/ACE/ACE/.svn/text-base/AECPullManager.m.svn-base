//
//  AECPullManager.m
//  ACE
//
//  Created by Santosh Kumar on 8/26/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "AECPullManager.h"
#import "ACECurriculumVersionsManager.h"
#import "ACEPastSessionDetailsManager.h"
#import "ACEActivationCurriculumDetails.h"
#import "StudentDatabase.h"

static AECPullManager *sharedInstance = nil;

@interface AECPullManager( )

- (void)initiateVersionCheckPull;
- (void)pullAllPastDataForAllCurriculums;
- (void)updateObserversWithText:(NSString*)text;
- (void)updateComplete;
- (void)showAlertForVersionMismatchForActiveSessions;
- (NSArray*)generateListOfUnFinishedSessions;
- (BOOL)containsInArray:(NSArray*)array item:(int)actvId;

@property (nonatomic, retain) ACECurriculumVersionsManager *versionManager;
@property (nonatomic, retain) ACEActivationCurriculumDetails *curriculumDetailsManager;
@property (nonatomic, retain) ACEPastSessionDetailsManager *pastDataManager;

@property (assign) BOOL isPullInProgress;

@property (retain) NSMutableArray *activeDirtyVersions;
@property (retain) NSMutableArray *dirtyVersions;
@property (retain)NSMutableArray *observers;

@end

@implementation AECPullManager

@synthesize versionManager,curriculumDetailsManager,pastDataManager;
@synthesize isPullInProgress;
@synthesize observers;
@synthesize activeDirtyVersions;
@synthesize dirtyVersions;

+ (AECPullManager *)getPullSyncManager
{
	if(sharedInstance == nil) {
		sharedInstance = [[AECPullManager alloc] init];
	}
	return sharedInstance;
}

- (id) init
{
	self = [super init];
	
	if (self != nil) { 
        self.observers = [[NSMutableArray alloc] init];
        self.dirtyVersions = [[NSMutableArray alloc] init];
        self.activeDirtyVersions = [[NSMutableArray alloc] init];
        self.isPullInProgress = NO;
    }
	
	return self;
}

- (void)dealloc 
{
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

- (void)initiatePull
{
    if (!self.isPullInProgress) {
        //Initiate Pull.
        
        [self.activeDirtyVersions removeAllObjects];
        [self.dirtyVersions removeAllObjects];
        
        self.isPullInProgress = YES;
        [self initiateVersionCheckPull];
    }
}

#pragma - Version Check 

//Version Check Start.

- (void)initiateVersionCheckPull
{
    //Notify observer to change text.
    [self updateObserversWithText:NSLocalizedString(@"version_check_title", nil)];
    
    NSArray *students = [StudentDatabase getAddedStudents];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSString *sessionToken = [StudentDatabase getLoggedInUserSessionId];
    
    for (NSDictionary *stud in students) {
        ACEStudent *student = [[ACEStudent alloc] init];
        student.ID = [[stud valueForKey:@"StudentId"] intValue];
        student.name = [stud valueForKey:@"Name"];
        [tempArray addObject:student];
        student = nil;
    }

    self.versionManager = [[ACECurriculumVersionsManager alloc] initWithStudentIds:tempArray 
                                                                             token:sessionToken 
                                                                          delegate:self];
 
    [self.versionManager loadVersionDetails];
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

- (void)ACECurriculumVersionsManager:(ACECurriculumVersionsManager*)manager didRecieveVersionList:(NSArray*)list
{
    if ([list count] > 0) { //Version Updated
        
        NSMutableArray *unFinishedSessionActivationIDS = [[NSMutableArray alloc] initWithArray:[self generateListOfUnFinishedSessions]];
        
        if ([unFinishedSessionActivationIDS count] > 0 ) { //Some sessions are in progress.
            //See if there is version update for those sessions. And for array accordingly.
            
            NSMutableArray *activeList = [[NSMutableArray alloc] init];
            NSMutableArray *nonActiveList = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dirtyCurriculum in list) {
                
                NSArray *activationIDList = [dirtyCurriculum valueForKey:@"ActivationId"];
                
                NSMutableArray *actvSessionlist = [[NSMutableArray alloc] init];
                NSMutableArray *inActiveSessionlist = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dct in activationIDList) { //This for each entry for each student.
                    int activationId = [[dct valueForKey:@"ActivationId"] intValue];
                    NSMutableDictionary *idDictionary = [[NSMutableDictionary alloc] init];
                    [idDictionary setValue:[dct valueForKey:@"ActivationId"] forKey:@"ActivationId"];
                    
                    if ([self containsInArray:unFinishedSessionActivationIDS item:activationId]) {
                        NSLog(@"Version Match");
                        [actvSessionlist addObject:idDictionary];
                    }else{
                        [inActiveSessionlist addObject:idDictionary];
                        NSLog(@"Version Miss Match");
                    }
                    
                    idDictionary = nil;
                }
                
                //Here fill arrays.
                if ([actvSessionlist count] > 0) {
                    NSLog(@"Adding active session");
                    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
                    [dictionary setValue:[dirtyCurriculum valueForKey:@"ACEStudentId"] forKey:@"ACEStudentId"];
                    [dictionary setValue:actvSessionlist forKey:@"ActivationId"];
                    [activeList addObject:dictionary];
                }
                
                if ([inActiveSessionlist count] > 0) {
                    NSLog(@"Adding In active session");
                    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
                    [dictionary setValue:[dirtyCurriculum valueForKey:@"ACEStudentId"] forKey:@"ACEStudentId"];
                    [dictionary setValue:inActiveSessionlist forKey:@"ActivationId"];
                    [nonActiveList addObject:dictionary];
                }
                
                //Outer Loop.
            }
                 
            //Iteration over.
            [self.dirtyVersions addObjectsFromArray:nonActiveList];
            [self.activeDirtyVersions addObjectsFromArray:activeList];
            
        }else{
            
            //No Active Session. So Add everthing to dirtyVersions.
            [self.dirtyVersions addObjectsFromArray:list];
        }
        
        [self pullAllPastDataForAllCurriculums];
                 
    }else { //No version update. Load only past Data
        [self pullAllPastDataForAllCurriculums];
    }
    
    self.versionManager = nil;
}

- (BOOL)containsInArray:(NSArray*)array item:(int)actvId
{
    BOOL contains = NO;
    
    for (NSNumber *activationID in array) {
        int progressAcitvationId = [activationID intValue];
        if (progressAcitvationId == actvId) {
            contains = YES;
            break;
        }
    }
    
    return contains;
}

//Version Check End.

#pragma - Pash Data Pulling.

- (void)pullAllPastDataForAllCurriculums
{
    //Notify observer to change text.
    [self updateObserversWithText:NSLocalizedString(@"updating_past_data_title", nil)];
 
    NSArray *studentList = [StudentDatabase getAddedStudents];
    NSMutableArray *studentActivationList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *stud in studentList) {
        NSArray *activationIdList = [StudentDatabase 
                                     allCurrculumsActivationIDForStudent:[[stud valueForKey:@"ACEStudentId"] intValue]];
        if ([activationIdList count] > 0 ) {
            NSMutableArray *activationList = [[NSMutableArray alloc] initWithArray:activationIdList];
            [studentActivationList addObject:activationList];
        }
    }
    
    NSString *sessionToken = [StudentDatabase getLoggedInUserSessionId];
    
    self.pastDataManager = [[ACEPastSessionDetailsManager alloc] 
                            initWithVersionIds:studentActivationList
                            token:sessionToken
                            delegate:self];
    
    [self.pastDataManager loadPastDataDetails];
}

- (void)ACEPastSessionDetailsManagerDidFinishLoading:(ACEPastSessionDetailsManager*)manager WithFailCount:(int)failCount
{
    //TODO: Decide on flow for fail count.
    
    if ([self.dirtyVersions count] > 0) {
        
        //Notify observer to change text.
        [self updateObserversWithText:NSLocalizedString(@"updating_curriculum_data_title", nil)];
        
        NSString *sessionToken = [StudentDatabase getLoggedInUserSessionId];
        self.curriculumDetailsManager = [[ACEActivationCurriculumDetails alloc] 
                                         initWithVersionIds:self.dirtyVersions
                                         token:sessionToken
                                         delegate:self];
 
        [self.dirtyVersions removeAllObjects];
        [self.curriculumDetailsManager loadCurriculamDetails];
        
    }else if([self.activeDirtyVersions count] > 0) {
       //Show Alert.
        [self showAlertForVersionMismatchForActiveSessions];
    }else{
         [self updateComplete];
    }
    
    self.pastDataManager =  nil;
}

- (void)ACEActivationCurriculumDetailsDidFinishCurriculumLoading:(ACEActivationCurriculumDetails*)manager
{
    if ([self.activeDirtyVersions count] > 0 ) {
        //Show Alert
        [self showAlertForVersionMismatchForActiveSessions];
    }else{
        [self  updateComplete];
    }
    
    self.curriculumDetailsManager = nil;
}

//eCurriculumBasedPastData,
//eActivationIdBasedCurriculumDetail,
//eCurriculumVersionId
- (void)ACEConnectionManager:(ACEDataManager*)manager didRecieveError:(NSError*)error
{
    NSString *text = @"";
    
    if (manager.requestType == eCurriculumVersionId) {
        
        text = @"Failed to load versions.";
        
    }else if(manager.requestType == eCurriculumBasedPastData){
        
        text = @"Failed to load past data.";
        
    }else if(manager.requestType == eActivationIdBasedCurriculumDetail){
        
        text = @"Failed to load curriculum details.";
    }
    
    for (id observer in self.observers) {
        if ([observer respondsToSelector:
             @selector(ACEPullManagerDidFinishLoading:didReceiveErrorWithErrorText:andError:)]) {
            [observer ACEPullManagerDidFinishLoading:self 
                        didReceiveErrorWithErrorText:text 
                                            andError:error];
        }
    }
    
    self.isPullInProgress = NO;
}

- (void)updateComplete
{
    self.isPullInProgress = NO;
    
    for (id observer in self.observers) {
        if ([observer respondsToSelector:
             @selector(ACEPullManagerDidFinishLoading:)]) {
            [observer ACEPullManagerDidFinishLoading:self];
        }
    }
}

- (void)updateObserversWithText:(NSString*)text
{
    for (id observer in self.observers) {
        if ([observer respondsToSelector:@selector(ACEPullManager:shouldChangeTitleTo:)]) {
            [observer ACEPullManager:self shouldChangeTitleTo:text];
        }
    }
}

//Add Remove Observer.
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

- (void)showAlertForVersionMismatchForActiveSessions
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                    message:@"One or more lessons with active sessions has been updated on the ACE.  If you wish to receive the update, unsummarized data will be lost.  Select YES - If you wish to receive the update and delete unsummarized data. Select NO - If you wish to cancel update and summarize data."
                                                   delegate:self 
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"YES", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //Update curriculum based on user Choice.
    
    //If YES then delete active sessions also. Need to delete only from ActiveStudent Session Table
    //And TA, IT and SA Active session also.

    if (buttonIndex ==1) {
        [StudentDatabase DeleteAllActiveStudentSession];
        
        [self updateObserversWithText:NSLocalizedString(@"updating_curriculum_data_title", nil)];
        
        NSString *sessionToken = [StudentDatabase getLoggedInUserSessionId];
        self.curriculumDetailsManager = [[ACEActivationCurriculumDetails alloc] 
                                         initWithVersionIds:self.activeDirtyVersions
                                         token:sessionToken
                                         delegate:self];
        
        [self.activeDirtyVersions removeAllObjects];
        [self.curriculumDetailsManager loadCurriculamDetails];
        
        //Added by Madhusudhan , This is enable currentSessionType to noCurrentSession
        currentSessionType=noCurrentSeeion;
        
    }else{
        [self updateComplete];
    }
}

@end
