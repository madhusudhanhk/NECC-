//
//  Constants.h
//  NECC
//
//  Created by Aditi technologies on 6/25/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDatabaseName @"ACEMobile1.sqlite"
#define kActiveStudentSessionPlistPath @"~/Library/Caches/ActiveStudentSession.plist"


 CurrentSessionType currentSessionType;
IsNewSessionStartType isNewSessionStartType;

extern NSString * kApplicationName;
extern NSString * kAuthenticateURL;
extern NSString * kGetSchollsURL;
extern NSString * kGetTeamsURL;
extern NSString * kGetStudent;
extern NSString * kGetValueForSchool;
extern NSString * kGetValueForTeam;
extern NSString * kGetValueForStudent;
extern int  kGetCurrentValueForSchoolId; 
extern int  kGetCurrentValueForTeamId;
extern NSString  *kLoginUserId;
extern NSString  *kLoginSessionId;
extern NSString  *kLoginTime;
extern NSString  *kLastSyncTime;
extern NSString  *kACEUserId;
extern int kACEUserIDFromTable;
extern NSString  *kLastUser;
extern NSString  *kStaffName;
extern NSString  *kUserName;
extern NSString  *kTimeDifference;
extern NSString *kInternetConnectionMsg;
extern int  loginCountCheck;

extern NSString  *kLocation;
//extern NSString  *kRecommandations;
//extern NSString  *kTimer;
#pragma Mark Mast Value

extern int kMstTrialType;

extern int kStudentCurriculamID;
extern NSString *kActiveStudentSessionId;
extern NSString *kStuCuriculumId;
extern NSString *kActiveStudentImageName;
extern NSString *kCurrentActiveStudentName;
extern NSString *kCurrentActiveCurriculumName;
extern NSString *kisCurrentSessionSummarized;



#pragma Database Queries
char *kreadSchool;


#pragma Current session 

extern NSString *kCurrentSessionDetailPath;
extern NSString *kACEStudentID;


#pragma mark SA variables
extern int kSATrialNumberForOldsession;
extern int kSAStuCurriCulumID;
extern int kSAPastDataScore;
extern int kSATotalnumberOftrilaForSession;
extern int kSASubLevelID;
extern NSString *kSATrialTypeName;
extern NSString *kSATrialTypeID;
extern NSString *kSAStepID;
extern NSString *kSAActiveSessionID;
extern NSString *kSAEmailSessionDASA;




#pragma mark TA variables

extern int kTACurrentCurriculamId;
extern int kTACurrentCurriculamId;
extern int kTATotalNUmberOfStepsForSession;
extern int kTATotalNUmberofOptionsInStep;
extern int kTATraingStepID;
extern int kTAActiveSessionID;
extern int kTAMstPromptStepId;

extern int kTAMstSettingID;
extern int kTAMstStatusID;
extern int kTAFsiBsiTsi;
extern NSString *kTAFsiBsiTsiName;
extern int kTANoOfTrial;
extern int kTAStepID;
extern NSString *kTAStaffName;


extern NSString *kTATrialTypeName;
extern NSString *kMstPromptStepName;


extern NSString *kTACurrentStudentName;
extern NSString *kTACurrentCurilulumName;


extern NSString *kTAEmailSessionDATA;
extern int kTSIcount;

#pragma mark IT variables

extern int kITTrialNumberForOldsession;
extern int kITStuCurriCulumID;
extern NSString *kITContextId;
extern NSString *kITMIPId;
extern NSString *kITContextName;
extern int kITTrialNumbers;
extern NSString *kITActiveSessionId;
extern NSString *kIT_ACEITMIPId;
extern NSString *kIT_ACEITMIPName;
extern NSString *kIT_StatusId;
extern NSString *kITEmailSessionDATA;
extern NSString *kIT_MstTrialTypeId;
extern NSString *kIT_MstTrialTypeName;

#pragma mark curriculum session

extern  NSString *currentSessionCurriculumName;
extern  NSString *currentSessionStudentName;
extern  NSString *currentSessionSelectionType;
extern  NSString *currentSessionStuCurriculumId;
extern  NSString *currentSessionStudentCurriculumId;
extern  NSMutableArray *schoolList;

//static NSString *currentSessionCurriculumName;

