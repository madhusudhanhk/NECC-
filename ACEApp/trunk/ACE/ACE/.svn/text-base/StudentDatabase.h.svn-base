//
//  StudentDatabase.h
//  NECC
//
//  Created by Aditi technologies on 6/25/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h> 


@interface StudentDatabase : NSObject{
    NSString *databaseName;
    NSString *databasePath;
}



//Login Methods
+(BOOL)insertACEUserDetail:(NSString *)userID :(NSString *)sessionID :(NSString *)loginTime :(NSString *)lastSyncTime:(NSString *)isLogedOut:(NSString *)staffName:(NSString *)UserName;

+(BOOL)userIDCountForLogin:(NSString *)userId;
+(void)deleteUserFromACEUserTable;
+(int)ACEUserIdFromACEUserTable:( int)userId;
+(void)updateACEUserTable:(NSString *)sessionId:(NSString *)loginTime:(NSString *)lastSyncTime:(NSString *)userId;
+(void)updateACEUserTableWithIsLoggedOut:(int)userId;
+(int)getUserCount;
+(NSString*)getLoginTime:(int)userId;
+(NSString *)isLoggedOfFromACEUserTable;
+(NSString *)ACEUserIdFromACEUserTableForAddUserPage;
+(BOOL)userIDCountForLogin:(NSString *)userId;
//+(void)deleteUserFromACEUserTable:(NSString *)userId;

//Discard the Session.....
+(BOOL)discardSession:(NSString *)activeSessionID;
+ (NSString *)getStaffName:(NSString *)userID;

//SA Methods
+(NSString *)databasePath;
+ (StudentDatabase *)sharedSingleton;
+ (NSMutableArray *)mystudentList;
+ (NSMutableArray *)studentCurriculamList:(NSString *)stduId;
+ (NSMutableDictionary *)teacherDetails;
//+ (NSMutableArray *)mySchoolList;
+ (NSMutableArray *)myACEStudentList;
+ (NSMutableArray *)getSASublevels:(int)curriculamID;
+ (NSMutableArray *)getSAPastDataForSubLevel:(NSString *)sublevelID;
+ (NSMutableArray *)getSASteps:(NSString *)sublevelID;
+ (NSMutableArray *)TrialType;
+(NSMutableArray *)getActiveStudentInfo:(NSString *)ACEStudentID;
+(NSString *)insertActiveStudentSession:(NSString *)StudentCurriculamId isDirty:(NSString *)DirtyVal lastSyncDate:(NSString *)syncDate;
+(BOOL)insertSAActiveSession:(NSString *)ActiveStudentSessionID SASublevelID:(NSString *)sublevelID MSTtrialTypeID:(NSString *)TTypeID SetUPID:(NSString *)SetupID totalPuls:(NSString *)tPuls totalPulsP:(NSString *)tPulsP totalMinus:(NSString *)tMinus totalMinusP:(NSString *)tMinusP totalNR:(NSString *)tNR Date:(NSString *)date Staff:(NSString *)staff order:(NSString *)order isSummarized:(NSString *)isSummarizedVal isFinished:(NSString *)isFinishedVal;
+(NSString *)insertSAActiveSession:(NSMutableDictionary *)myDic;
+(NSString *)insertSAActiveTrial:(NSMutableDictionary *)myDic;
+(NSString *)updateSAActiveTrial:(NSMutableDictionary *)myDic;
+(NSMutableArray *)getMStStatus;
+(NSMutableArray *)getMstSetting;
+(BOOL)updateSAIsSummarizedData:(NSMutableDictionary *)SAActiveSessionDict;
+(BOOL)updateSAIsFinilizedData:(NSMutableDictionary *)SAActiveSessionDict;
+(BOOL)updateSAPastSession:(NSMutableDictionary *)SAActiveSessionDict;
+(NSString *)getSublevelName:(NSString *)sublevelid;
+(NSString *)getSkillName:(NSString *)sublevelid;
+(NSString *)getStepName:(NSString *)sublevelid;
+(NSString *)getTrialTypeNme:(NSString *)trialTypeID;
+(NSString *)getSAOldSessionTrialCount:(NSString *)SessionId;
+(BOOL)SAResumeSession:(NSString *)SessionId;
+(NSString *)getSASessionDate:(NSString *)SAActiveSessionID;
+(NSString *)getMaxSASessionOrder:(int)curriculamID;;


//TA Methods
+ (NSMutableArray *)getTATrainignSteps:(int)TAcurriculamID;
+ (NSMutableArray *)getTAPastData:(int)TAcurriculamID;
+ (NSMutableArray *)getTAPromptOption:(int)TAcurriculamID;
+(BOOL)addNewSeesionToTAActiveSessionTable:(NSMutableDictionary *)myDiction;
+(NSString *)insertInToTAActiveTrial:(NSMutableDictionary *)myDiction;
+(BOOL)updateInToTAActiveTrial:(NSMutableDictionary *)myDiction;
+(BOOL)updateTAActiveSessionOnSummasize:(NSString *)MstPromptStepId TAActiveSessionId:(NSString *)sessionID;
+(BOOL)updateTAActiveSessionOnFinish:(NSMutableDictionary *)myDiction;;
+(BOOL)insertInToTAPastSession:(NSMutableDictionary *)myDiction;
+(NSString *)getMstChainingSequence:(int)TAcurriculamID;
+(NSString *)getMstChainingSequenceID:(int)TAcurriculamID;
+(NSString *)getTACurricilumID:(int)stuCurriculumID;
+(BOOL)TAResumeSession:(NSString *)SessionId;
+ (NSString *)checkTASessionPromptIsSelected:(int)SessionID;
+ (NSString *)checkTASessionPromptIsSelected:(int)SessionID forTrainingStepId:(int )stepid;
+ (NSString *)checkTASessionPromptIsSelected:(int)SessionID forTrainingStepId:(int )stepid;
+ (NSString *)getTAOldSessionStepsPromptForActiveSessionId:(NSString *)activeSessionId forStep:(NSString *)stepid;
+ (NSString *)getTAOldSessionTrialID:(NSString *)activeSessionId forStep:(NSString *)stepid;
+(NSString *)checkPromptStatus:(int)TAcurriculamID;
+(NSString *)getMaxTASessionOrder:(int)curriculamID;


//IT Methods
//+ (NSMutableArray *)ITTrialType:(NSString *)ITContextID;
+ (NSMutableArray *)getITContext:(int)curriculamID;
+(NSString *)getITOldSessionTrialCount:(NSString *)SessionId;
+ (NSMutableArray *)getITPastData:(NSString *)ITContextID;
+(NSString *)insertInToITActiveTrial:(NSMutableDictionary *)myDic;
+(NSString *)updateInToITActiveTrial:(NSMutableDictionary *)myDic;
+(NSString *)addNewSeesionToITActiveSessionTable:(NSMutableDictionary *)myDiction;
+(BOOL)updateITIsSummarizedData:(NSMutableDictionary *)ITActiveSessionDict;
+(BOOL)updateITIsFinishedData:(NSMutableDictionary *)ITActiveSessionDict;
+ (NSMutableArray *)getITMIP:(int)curriculamID;
+ (NSMutableArray *)getFirstITMIP:(int)curriculamID;
+(NSString *)insertInToITPastData:(NSMutableDictionary *)myDic;
+(NSString *)updateInToITPastData:(NSMutableDictionary *)myDic;
+ (NSString *)checkFileExistForWeekEnd:(NSString *)weekEndDate forContextId:(NSString *)contextID;
+ (NSMutableArray *)getpastDATAFileExistForWeekEnd:(NSString *)weekEndDate forContextId:(NSString *)contextID;
+(BOOL)ITResumeSession:(NSString *)SessionId;
+(NSString *)getContextNameForContextId:(NSString *)contxtID;
//Class Methods for Curriculam page

+ (NSMutableArray *)getStudentDetailsForUser:(int)UserID;
+ (NSMutableArray *)getCarriculamDetailsForStudent:(NSString *)studentID;
+ (void)delateDetailsForStudent:(NSString *)studentID;
+ (void)delateCurriculumDetailsForStudent:(NSString *)studentID;
+ (NSMutableArray *)getTopTenRecords;
+ (NSMutableArray *)getCurriculamName:(int)StudentCurriculumId;
+(BOOL)insertStudentDetailInCarrousal:(int)userID :(int)studentId :(NSString *)studentName :(NSString *)studentSchool :(NSString *)studentTeam :(NSString *)lastSyncTme andQuarter:(int)qrter;
+(BOOL)verifyStudentEntryOnInsertion :(NSString *)studentName :(NSString *)studentTeam :(NSString *)studentSchool;
+(BOOL)TAActiveSessionCount:(int)stuCurriculumId;
+(BOOL)SAActiveSessionCount:(int)stuCurriculumId;
+ (int)activeSessionIdForSATAIT:(int)stuCurriculumId;
+(NSString *)getSessionId;
+(NSString *)isVersionMatchedCheck:(int)stuCurriculumId;
+ (int)GetActiveSessionIdForSATAIT:(int)stuCurriculumId;
+(NSString *)getMaxITSessionOrder:(int)curriculamID;


//All Active Sessions 

+ (NSMutableArray *)getAllActiveSessions;
+ (NSMutableArray *)getSAOldSessionDetailsForActiveSessionId:(NSString *)activeSessionId;
+ (NSString *)getSAOldSessionTrialOptionForActiveSessionId:(NSString *)activeSessionId forTrialNumber:(NSString *)trialNumber;
+ (NSString *)getSAOldSessionTrialActiveSessionId:(NSString *)activeSessionId forTrialNumber:(NSString *)trialNumber;

+ (NSMutableArray *)getITOldSessionDetailsForActiveSessionId:(NSString *)activeSessionId;
+ (NSString *)getITOldSessionTrialOptionForActiveSessionId:(NSString *)activeSessionId forTrialNumber:(NSString *)trialNumber;
+ (NSString *)getITOldSessionTrialActiveSessionId:(NSString *)activeSessionId forTrialNumber:(NSString *)trialNumber;

+ (NSString *)getITContextName:(NSString *)contextID;
+ (NSMutableArray *)getTAOldSessionDetailsForActiveSessionId:(NSString *)activeSessionId;
+ (NSString *)getTATrainingStepName:(NSString *)contextID;

//********** Added by Santosh ******** //Inserting Curriculum Data.
+ (int)ACEStudentIdForStudentId:(int)_id;
+ (void)insertIntoStuCurriculumTable:(NSDictionary*)dictionary;
+ (int)getTopStuCurriculumId;

//IT Curriculum
+ (void)InsertITContext:(NSDictionary*)dictionary;
+ (void)InsertITPastSession:(NSDictionary*)dictionary;
+ (void)InsertITMIP:(NSDictionary*)dictionary;
+ (int)getTopITCurriculumContextId;


//TA Curriculum
+ (void)insertTACurriculum:(NSMutableDictionary*)dictionary;
+ (void)insertTAPastSession:(NSMutableDictionary*)dictionary;
+ (void)insertTAPromptStep:(NSMutableDictionary*)dictionary;
+ (void)insertTAStep:(NSMutableDictionary*)dictionary;
+ (int)getTopTACurriculumId;


//SA Curriculum
+ (int)getSALevelTopId;
+ (int)getSASublevelTopId;
+ (void)insertSALevel:(NSMutableDictionary*)dictionary;
+ (void)insertSAPastSession:(NSMutableDictionary*)dictionary;
+ (void)insertSASubLevel:(NSMutableDictionary*)dictionary;
+ (void)insertSASteps:(NSMutableDictionary*)dictionary;

//Master Data Entry
+ (void)enterMstChainingSequence:(NSDictionary*)dictionary;
+ (void)enterMstCurriculumType:(NSDictionary*)dictionary;
+ (void)enterMstStatus:(NSDictionary*)dictionary;
+ (void)enterMstSetting:(NSDictionary*)dictionary;
+ (void)enterMstTrialType:(NSDictionary*)dictionary;

//JSON Related Queries.

//Active Students
+ (NSArray*)getListOfAllActiveStudentSession;
+ (NSDictionary*)getDetailsOfStudentWithACEStudentId:(int)aceStudId;
+ (NSDictionary*)getDetailsOfStudentWithStudentId:(int)studId;
+ (NSDictionary*)getActiveStudentSessionDetailWithActiveStudentSessionId:(int)actID;

//SA Curriculum Queries
+ (NSMutableArray*)getSAActiveTrialsForActiveSessionID:(int)activeSessionId;
+ (NSMutableArray*)getSAActiveSessionForActiveStudentID:(int)activeSessionId;
+ (NSDictionary*)getSASubLevelForSubLevelId:(int)subLevelId;
+ (NSDictionary*)getSAStepForStepId:(int)stepId;
+ (NSDictionary*)getSALevelForLevelID:(int)levelId;

//TA Curriculum Queries.
+ (NSMutableArray*)getTAActiveSessionForActiveStudentSessionId:(int)sessionId;
+ (NSMutableArray*)getTAActiveTrialForTAActiveSessionId:(int)sessionId;

//IT Curriculum Queries
+ (NSMutableArray*)getITActiveSessionWithActiveStudentSessionId:(int)activeStudentId;
+ (NSMutableArray*)getITActiveTrialWithActiveITActiveSessionId:(int)activeSessionId;
+ (NSMutableDictionary*)getTACurriculumWithStuCurriculumId:(int)stuCurriculumId;
+ (NSMutableDictionary*)getMstChainingSequenceWithMstChainingSequenceId:(int)seqId;
+ (NSMutableDictionary*)getITMIPDetailsWithITMIPID:(int)imipID;

//StuCurriculum retirevel methods
+ (NSDictionary*)getStuCurriculumDetailsForCurriculumWithStuCurriculumId:(int)StuCurriculumId;

//Sync Table Insertion/Deletion/Query
+ (void)insertIntoSyncTable:(NSMutableDictionary*)dictionary;
+ (NSMutableArray*)getAllUnsyncedSessionDetails;
+ (void)deleteSyncInfoWithSyncKey:(NSString*)syncKey;

//Settings Retireval
+ (NSDictionary*)getMstSettingForMstSettingsId:(int)settingsId;
+ (NSDictionary*)getMstStatusForMstStatusId:(int)statusId;
+ (NSDictionary*)getMstTrialTypeForMstTrialTypeId:(int)trialId;
+ (NSDictionary*)getMstCurriculumTypeForCurriculumId:(int)crclmId;

//TA Prompt Steps
+ (NSMutableDictionary*)getTAPromptStepForTAPromptStepId:(int)stepId;
+ (NSMutableDictionary*)getTAStepForStepId:(int)stepId;
+ (NSMutableDictionary*)getTaStepForACEStepId:(int)stepId;
+ (NSMutableDictionary*)getTAPromptStepForACETAPromptStepId:(int)stepId;

//IT
+ (NSMutableDictionary*)getITContenxtInfoWithITContextId:(int)contextId;

//User Details
+ (NSDictionary*)getUserDetailsForUserWithId:(int)uid;

//Delete Commands
+ (void)DeleteStuCurriculumWithIsVersionMatchedSet;
+ (void)DeleteStuCurriculumWithStudentId:(int)_studentID;
+ (void)DeleteActiveStudentSessionWithActiveSessionId:(int)actStudentSessionId;

+ (void)DeleteITActiveSessionWithActiveStudentSessionId:(int)studSessionId;
+ (void)DeleteITActiveTrialWithITActiveSessionId:(int)actvSessionId;

+ (void)DeleteSAActiveSessionWithActiveStudentSessionId:(int)sctStdnSessionId;
+ (void)DeleteSAActiveTrialWithSAActiveSessionId:(int)saActiveSessionId;

+ (void)DeleteTAActiveSessionWithActiveStudentSessionId:(int)sessionId;
+ (void)DeleteTAActiveTrialWithTAActiveSessionId:(int)taActiveSessionId;

//User Details
+ (int)GetLoggedInUserID;
+ (NSString*)getLoggedInUserSessionId;

//Student Details
+ (NSArray*)getAddedStudents;

+ (void)compareAndUpdateVersionsForCurriculums:(NSArray*)curriculumArray;
+ (NSArray*)listOfCurriculumWithVersionUpdateForStudent:(int)studentID;
+ (NSArray*)listOfAllCurriculumsWithStudentId:(int)studID;

//Stu curriculum Deletion.
+ (void)DeleteStuCurriculumWithActivationId:(int)activationId;
+ (void)markVersionMismatchForCurriculumWithActivationID:(int)actvId;

//All Active Sessions
+ (NSArray*)allCurrculumsActivationIDForStudent:(int)aceStudId;

//Delete Past session
+ (void)deleteSAPastSessionDataWithSASubLevelId:(int)subLevelId;
+ (void)deleteTAPastSessionDataWithTACurriculumId:(int)taId;
+ (void)deleteITPastSessionDataWithITContextId:(int)contextId;

//Related to Past Data Entry
+ (int)getSASublevelIdWithACESublevelId:(int)aceSubLevelId;
+ (int)getITCurriculumContextIdWithACEContextID:(int)ACEContextID;

//TA Past data related methods
+ (int)getStuCurriculumIdWithActivationId:(int)actvId;
+ (int)getTACurriculumIdWithStuCurriculumId:(int)stuCurriculumId;

+ (int)getStuCurriculumActivationIdWithStuCurriculumId:(int)stuCurriculumId;

+ (NSArray*)getListOFSAActiveSessionIDs;
+ (NSArray*)getListOFTAActiveSessionIDs;
+ (NSArray*)getListOFITActiveSessionIDs;

//Finished Sessions
+ (NSArray*)getListOFSAFinishedSessionIDs;
+ (NSArray*)getListOFTAFinishedSessionIDs;
+ (NSArray*)getListOFITFinishedSessionIDs;

+ (void)DeleteAllActiveStudentSession;

//Sumarrized Sessions
+ (NSArray*)getListOFSASummarizedSessionIDS;
+ (NSArray*)getListOFTASummarizedSessionIDS;
+ (NSArray*)getListOFITASummarizedSessionIDS;

+ (int)countOfAddedStudents;
+ (int)countOfUnsyncedSessions;

//Support for new push
+ (NSArray*)getListOfDistinctStuCurriculumIdFromActiveSession;
+ (NSMutableArray*)getActiveSessionDetailsForStuCurriculumId:(int)stuCurriculumId;
+ (int)countForActiveSASessionWithActiveStudentSessionId:(int)sessionId;
+ (int)countForActiveTASessionWithActiveStudentSessionId:(int)sessionId;
+ (int)countForActiveITSessionWithActiveStudentSessionId:(int)sessionId;
+ (NSArray*)getActiveStudentSessionDetailWithStuCurriculumId:(int)stuId;

+ (int)getTAStepsCountForCurriculumWithCurriculumId:(int)curriculumId;

//Santosh Methods End.

@end