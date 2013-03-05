//
//  StudentDatabase.m
//  NECC
//
//  Created by Aditi technologies on 6/25/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "StudentDatabase.h"
#import "MyActiveSessions.h"
#import "ACEUTILMethods.h"

//Quries List

#pragma mark SA Quries 

#define kACEStudentList "Select Name,TeamName, ACEUserId from ACEStudent";
#define kTeamList "Select Id, Name from Team where SchoolId = %@";
#define kSASublevelQry @"select SASubLevel.* from SASubLevel join SALevel on SALevel.SALevelId=SASubLevel.SALevelId where SALevel.StuCurriculumId="
#define kSAPastDataQry @"select SAPastSession.* from SAPastSession where SAPastSession.SASubLevelId="
#define kTrailTypeQry @"Select * from MstTrialType"
#define kSASetpQry @"SELECT SAStep.* FROM SASubLevel JOIN SAStep ON SAStep.SALevelId =  SASubLevel.SALevelId WHERE SASubLevel.SASubLevelId ="
#define kStudentInfoQry @"Select Studentid, Name from ACEStudent where ACEStudentid ="
#define kinsertActiveStudentSession @"insert into ActiveStudentSession(StuCurriculumId,IsDirty,LastSyncTime) values"
#define kinsertSAActiveSession @"insert into SAActiveSession(ActiveStudentSessionId,MstSettingId,MstStatusId,SASubLevelId,MstTrialTypeId,StepId,TotalPlus,TotalPlusP,TotalMinus,TotalMinusP,TotalNR,Date,Staff,[Order],IsSummarized,IsFinished,IsEmailEnabled) values"
#define kinsertSAActiveTrialQry @"INSERT INTO SAActiveTrial(SAActiveSessionId,TrialNumber,Plus,PlusP,Minus,MinusP,NR) values"
#define kupdateSAActiveTrialQry @"UPDATE SAActiveTrial SET SAActiveSessionId= 4,TrialNumber=0, Plus=1, PlusP=1, Minus=1, MinusP=1, NR=1 WHERE SAActiveTrial.SAActiveTrialId = 1"
// Summarized -- update SAActiveSession set TotalPlus=1, TotalPlusP=1, TotalMinus=6, TotalMinusP=4, TotalNR=1, IsSummarized=1 where SAActiveSessionId=64
// Finished -- Update SAActiveSession set MstSettingId=2, MstStatusId=2, Date='12/12/2012', Staff='staffName', IsFinished=1 where SAActiveSessionId=64
// PastSession  -- insert into SAPastSession(SASubLevelId, Date ,Step,Type,Score,Status,[Order]) values (1, '12/12/2013', 'NA', 'NA', '5/6', 'In Progress', 1)

#pragma mark TA Quries 

#define kGetTAPastData @"SELECT TAPastSession.[Date],TAPastSession.TrialType,TAPastSession.TrainingStep,TAPastSession.StepIndependent,TAPastSession.PromptStep,MstChainingSequence.Name FROM TACurriculum JOIN TAPastSession ON TACurriculum.TACurriculumId = TAPastSession.TACurriculumId JOIN MstChainingSequence ON MstChainingSequence.MstChainingSequenceId =  TACurriculum.MstChainingSequenceId WHERE TACurriculum.TACurriculumId ="

#define kGetTATrainigSteps @"SELECT TAStep.TAStepId,TAStep.Name ,TAStep.Description,TAStep.[Order] FROM TAStep JOIN TACurriculum ON TACurriculum.TACurriculumId = TAStep.TACurriculumId WHERE TACurriculum.TACurriculumId ="

#define kGetStudentCurriculamName @"SELECT Name from StuCurriculum WHERE StuCurriculumId="
#define kGetTAPromptOption @"select  TAPromptStepId,Name from TAPromptStep where TACurriculumid="

#define kAddNewSessionToTAActiveSession @"INSERT INTO TAActiveSession ([ActiveStudentSessionId], [TACurriculumId], [MstTrialTypeId], [TATrainingStepId], [MstPromptStepId], [Staff], [TAStepIndependentId], [MstSetttingId], [MstStatusId], [NoOfTrials], [Date], [Order], [IsSummarized], [IsFinished],[IsEmailEnabled]) VALUES"


#define kinsertTAActiveTrial @"INSERT INTO TAActiveTrial (TAActiveSessionId,TAStepId,TAPromptStepId) VALUES"
#define kinsertInToTAPastSession @"INSERT INTO TAPastsession(TACurriculumid,Date,TrialType,StepIndependent,TrainingStep,PromptStep,[Order]) values"


//IT Queries

#define kGETITContext @"SELECT ITContext.Name, ITContext.ITContextId FROM ITContext WHERE ITContext.ITContextId NOT IN( SELECT ITActiveSession.ITContextId FROM StuCurriculum JOIN ActiveStudentSession ON ActiveStudentSession.StuCurriculumId = StuCurriculum.StuCurriculumId JOIN ITActiveSession ON ITActiveSession.ActiveStudentSessionId = ActiveStudentSession.ActiveStudentSessionId WHERE StuCurriculum.CurriculumTypeId = 2 AND ITActiveSession.IsFinished <> 'true' AND StuCurriculum.StuCurriculumId = 999)"
//#define kGETITContext @"SELECT ITContext.Name, ITContext.ITContextId FROM ITContext WHERE ITContext.StuCurriculumId ="
#define kGetITMIP @"select ITMIP.ITMIPId,ITMIP.Name from ITMIP where ITMIP.StuCurriculumId="
#define kGetITPastData @"SELECT ITPastSession.ITPastSessionId,WeekEnding,TrialType,MIP,TotalPlus,TotalPlusP,TotalMinus,TotalNR FROM ITPastSession where ITContextId="
//Quries for fatching data for caricullam page
#pragma mark caricullam Quries 

#define kStudentInfoQryForCarrousal @"SELECT ACEStudent.Name,ACEStudent.TeamName,ACEStudent.SchoolName,ACEStudentId FROM ACEStudent WHERE ACEUserId ="
#define kStudentCurriculamListInfoQry @"SELECT StuCurriculum.Name,StuCurriculum.StuCurriculumId,StuCurriculum.ActivationId,StuCurriculum.ObjectiveNo,MstCurriculumType.Name AS [Type] FROM StuCurriculum JOIN MstCurriculumType ON StuCurriculum.CurriculumTypeId = MstCurriculumType.MstCurriculumTypeId WHERE StuCurriculum.ACEStudentId ="
#define kDeleteCurriculum @"DELETE FROM StuCurriculum WHERE StuCurriculum.ACEStudentId="
#define kDeleteACEStudent @"DELETE FROM ACEStudent WHERE ACEStudent.ACEStudentId="
#define kGetTopTenRecords @"SELECT * FROM ACEStudent LIMIT 10"
#define kACEUserCount @"SELECT COUNT(*) from aceuser where userid ="
#define kdeleteUserDetailsFromACEUser @"delete from ACEUser"
#define kACEUserIdSelection @"select ACEUserId from ACEUser where UserId ="
#define kLoginTimeSelection @"select LoginTime from ACEUser where ACEUserId ="


#define kSessionId @"select SessionId from ACEUser"
#define kTotalACEuser @"select count(*) from ACEUser"
#define kACEUserCount @"SELECT COUNT(*) from aceuser where userid ="
#define kSortStuCurriculumOrderByObjectiveNo @"SELECT * FROM 'StuCurriculum' ORDER BY ObjectiveNo"





#define kAddNewSessionToITActiveSession @"INSERT INTO [ITActiveSession](ActiveStudentSessionId,[MstTrialTypeId],[ITContextId],[ITMIPId],[MstStatusId],[StepId],[TotalPlus],[TotalPlusP],[TotalMinus],[TotalNR],[Staff],[WeekEndingDate],[Date],[Order],[IsSummarized],[IsFinished],[IsEmailEnabled])VALUES"





#define kInsertIntoITActiveTrial @"INSERT INTO [ITActiveTrial]([ITActiveSessionId],[TrialNumber],[Plus],[PlusP],[Minus],[NR])VALUES"
#define kInsertIntoITpastDatatable @"INSERT INTO [ITPastSession]([ITContextId],[WeekEnding],[TrialType],[Opportunities],[MIP],[TotalPlusP],[TotalPlus],[TotalMinus],[TotalNR],[Order])VALUES"
#define kUpdateITPastData @"UPDATE ITPastSession SET [WeekEnding]='1/1/2012',[TrialType]='BL',[Opportunities]='2',[MIP]='G',[TotalPlusP]=1,[TotalPlus]=1,[TotalMinus]=2,[TotalNR]=1,[Order]=2 WHERE WeekEnding = '1/1/2012'"



//Active Sessions
#define kgetAllActiveSessions @"SELECT ACEStudent.ACEStudentId,StuCurriculum.StuCurriculumId,ActiveStudentSessionId,TAActiveSession.TAActiveSessionId AS ActiveSessionId,StuCurriculum.NAME AS CurriculumName,3 AS CurriculumType,ACEStudent.NAME AS StudentName,'' AS [Description]FROM TAActiveSession JOIN TACurriculum ON TACurriculum.TACurriculumId = TAActiveSession.TACurriculumId JOIN StuCurriculum ON StuCurriculum.StuCurriculumId = TACurriculum.StuCurriculumId JOIN ACEStudent ON StuCurriculum.ACEStudentId = ACEStudent.ACEStudentId WHERE TAActiveSession.IsFinished != 'true' UNION SELECT ACEStudent.ACEStudentId,StuCurriculum.StuCurriculumId,SAActiveSession.ActiveStudentSessionId,SAActiveSession.SAActiveSessionId AS ActiveSessionId,StuCurriculum.NAME AS CurriculumName,1 AS CurriculumType,ACEStudent.NAME AS StudentName,SASubLevel.Skill AS [Description]FROM SAActiveSession JOIN ActiveStudentSession ON ActiveStudentSession.ActiveStudentSessionId = SAActiveSession.ActiveStudentSessionId JOIN StuCurriculum ON StuCurriculum.StuCurriculumId = ActiveStudentSession.StuCurriculumId JOIN SASubLevel ON SASubLevel.SASubLevelId = SAActiveSession.SASubLevelId JOIN ACEStudent ON StuCurriculum.ACEStudentId = ACEStudent.ACEStudentId WHERE SAActiveSession.IsFinished != 'true' UNION SELECT ACEStudent.ACEStudentId,StuCurriculum.StuCurriculumId,ITActiveSession.ActiveStudentSessionId,ITActiveSession.ITActiveSessionId AS ActiveSessionId,StuCurriculum.NAME AS CurriculumName,2 AS CurriculumType,ACEStudent.NAME AS StudentName,ITContext.NAME AS [Description]FROM ITActiveSession JOIN ActiveStudentSession ON ActiveStudentSession.ActiveStudentSessionId = ITActiveSession.ActiveStudentSessionId JOIN StuCurriculum ON StuCurriculum.StuCurriculumId = ActiveStudentSession.StuCurriculumId JOIN ITContext ON ITContext.ITContextId = ITActiveSession.ITContextId AND ITContext.StuCurriculumId = ActiveStudentSession.StuCurriculumId JOIN ACEStudent ON StuCurriculum.ACEStudentId = ACEStudent.ACEStudentId WHERE ITActiveSession.IsFinished != 'true'"



@implementation StudentDatabase


+ (StudentDatabase *)sharedSingleton
{
    static StudentDatabase *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[StudentDatabase alloc] init];
        
        return sharedSingleton;
    }
}



-(NSString *)databasePath{
    // Setup some globals
	databaseName = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    return databasePath;
       
}
/*
+ (NSMutableArray *)mySchoolList{
    
    
    // Setup some globals
	  NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    //NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
	
	// Init the animals Array
	
	
	// Open the database from the users filessytem
	if(sqlite3_open([[self databasePath] UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
        
		//const char *sqlStatement =" Select Id, Name from Team where SchoolId = 1";
        const char *sqlStatement =kACEStudentList;
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *sID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				
                
                
                NSLog(@"ID.  %@",sID);
                NSLog(@"name  %@",aName);
                
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    return nil;

}
*/

+ (NSMutableArray *)myACEStudentList{
    int articlesCount = 0;
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        const char* sqlStatement = kACEStudentList;
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            if( sqlite3_step(statement) == SQLITE_ROW )
                articlesCount  = sqlite3_column_int(statement, 0); 
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return nil;    
}

+ (NSMutableArray *)mystudentList{
    
    return nil;
    
    
}


+ (NSMutableArray *)studentCurriculamList:(NSString *)stduId{
    return nil;
}


+ (NSMutableDictionary *)teacherDetails{
    return nil;
}

+(BOOL)discardSession:(NSString *)activeSessionID{
    
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"delete from ActiveStudentSession where ActiveStudentSessionId=%@",activeSessionID];
        
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+ (NSString *)getStaffName:(NSString *)userID{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"NR" ;
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select  [Order] from TAStep where TAStepId=%@",userID];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultArry=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;
}
#pragma mark SA methods

+ (NSMutableArray *)getSASublevels:(int)curriculamID{
    
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@%d",kSASublevelQry,curriculamID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *SAsublevelid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *SAsublevelName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                NSString *SAsublevelSkill = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                
                
                SAsublevelName=[SAsublevelName stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                SAsublevelSkill=[SAsublevelSkill stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:SAsublevelid forKey:@"sasublevelid"];
                [myDic setValue:SAsublevelName forKey:@"sasublevelname"];
                [myDic setValue:SAsublevelSkill forKey:@"sasublevelskill"];
                [resultArry addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;    
    
}

+ (NSMutableArray *)getSAPastDataForSubLevel:(NSString *)sublevelID{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry1 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@%@",kSAPastDataQry,sublevelID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *step = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                NSString *type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString *score = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                NSString *status = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                NSString *pastDataId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                  NSString *plus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                  NSString *plusP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                  NSString *minus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                  NSString *minusP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,11)];
                  NSString *NR = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                 [myDic setValue:date forKey:@"date"];
                 [myDic setValue:step forKey:@"step"];
                 [myDic setValue:type forKey:@"type"];
                 [myDic setValue:score forKey:@"score"];
                 [myDic setValue:status forKey:@"status"];
                [myDic setValue:pastDataId forKey:@"pastDataId"];
                [myDic setValue:plus forKey:@"plus"];
                [myDic setValue:plusP forKey:@"plusP"];
                [myDic setValue:minus forKey:@"minus"];
                [myDic setValue:minusP forKey:@"minusP"];
                [myDic setValue:NR forKey:@"NR"];
                [resultArry1 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry1;    
}


+ (NSMutableArray *)getSASteps:(NSString *)sublevelID{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@%@",kSASetpQry,sublevelID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *stepName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                 
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:stepID forKey:@"stepID"];
                [myDic setValue:stepName forKey:@"stepName"];
               
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;    
}


+ (NSMutableArray *)TrialType{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@",kTrailTypeQry]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *trialid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
               
                
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:trialid forKey:@"trialid"];
                [myDic setValue:name forKey:@"trialtype"];
               
                
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;    
}
+(NSMutableArray *)getActiveStudentInfo:(NSString *)ACEStudentID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@%@",kStudentInfoQry,ACEStudentID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *stepName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:stepID forKey:@"studentid"];
                [myDic setValue:stepName forKey:@"studentname"];
                
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;
}
+(NSString *)insertActiveStudentSession:(NSString *)StudentCurriculamId isDirty:(NSString *)DirtyVal lastSyncDate:(NSString *)syncDate{
    
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@(%@,'%@','%@')",kinsertActiveStudentSession,StudentCurriculamId,DirtyVal,syncDate]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                int prikey =sqlite3_last_insert_rowid(database);

                resultStatus=[NSString stringWithFormat:@"%d",prikey];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(NSString *)insertSAActiveSession:(NSMutableDictionary *)myDic{
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,'%@','%@','%@','%@','%@','%@')",kinsertSAActiveSession,
                               [myDic valueForKey:@"ActiveStudentSessionId"],
                               [myDic valueForKey:@"MstSettingId"],
                               [myDic valueForKey:@"MstStatusId"],
                               [myDic valueForKey:@"SASubLevelId"],
                               [myDic valueForKey:@"MstTrialTypeId"],
                               [myDic valueForKey:@"StepId"],
                               [myDic valueForKey:@"TotalPlus"],
                               [myDic valueForKey:@"TotalPlusP"],
                               [myDic valueForKey:@"TotalMinus"],
                               [myDic valueForKey:@"TotalMinusP"],
                               [myDic valueForKey:@"TotalNR"],
                               [myDic valueForKey:@"Date"],
                               [myDic valueForKey:@"Staff"],
                               [myDic valueForKey:@"Order"],
                               [myDic valueForKey:@"IsSummarized"],
                               [myDic valueForKey:@"IsFinished"],[myDic valueForKey:@"IsEmailEnabled"]]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                
                int prikey =sqlite3_last_insert_rowid(database);
                resultStatus=[NSString stringWithFormat:@"%d",prikey];
                
                
                [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",prikey] forKey:@"SAActiveSessionID"];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}

+(NSString *)insertSAActiveTrial:(NSMutableDictionary *)myDic{
    
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@(%@,%@,%@,%@,%@,%@,%@)",kinsertSAActiveTrialQry,
                               [myDic valueForKey:@"SAActiveSessionId"],
                               [myDic valueForKey:@"TrialNumber"],
                               [myDic valueForKey:@"+"],
                               [myDic valueForKey:@"+P"],
                               [myDic valueForKey:@"-"],
                               [myDic valueForKey:@"-P"],
                               [myDic valueForKey:@"NR"]];
                               
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
               // NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                int prikey =sqlite3_last_insert_rowid(database);
                resultStatus=[NSString stringWithFormat:@"%d",prikey];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(NSString *)updateSAActiveTrial:(NSMutableDictionary *)myDic{
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"UPDATE SAActiveTrial SET  Plus=%@, PlusP=%@, Minus=%@, MinusP=%@, NR=%@ WHERE SAActiveTrial.SAActiveTrialId = %@",
                               
                               [myDic valueForKey:@"+"],
                               [myDic valueForKey:@"+P"],
                               [myDic valueForKey:@"-"],
                               [myDic valueForKey:@"-P"],
                               [myDic valueForKey:@"NR"],
                               [myDic valueForKey:@"SAActiveTrialId"]];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                // NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                int prikey =sqlite3_last_insert_rowid(database);
                resultStatus=[NSString stringWithFormat:@"%d",prikey];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(NSMutableArray *)getMStStatus{
    
    
    
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = @"SELECT * FROM MstStatus";
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                NSString *mstStatusId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *mstStatusName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
               
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:mstStatusId forKey:@"mstStatusId"];
                [myDic setValue:mstStatusName forKey:@"mstStatusName"];
               
                [resultArry addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
    
}
+(NSMutableArray *)getMstSetting{
    
    
    
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = @"SELECT * FROM MstSetting";
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *mstSettingid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *mstSettingname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *DisplayOrder = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                
                if([DisplayOrder length]==1){
                    DisplayOrder=[@"0" stringByAppendingString:DisplayOrder];
                    
                }
                
             //   int myDisplayOrderIntVal=[DisplayOrder intValue];
                
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:mstSettingid forKey:@"mstSettingid"];
                [myDic setValue:mstSettingname forKey:@"mstSettingname"];
                [myDic setValue:DisplayOrder forKey:@"DisplayOrder"];
                
                [resultArry addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"DisplayOrder" ascending:YES];
    [resultArry sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];
    
    return resultArry;  
}
+(BOOL)updateSAIsSummarizedData:(NSMutableDictionary *)SAActiveSessionDict{
    
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"update SAActiveSession set TotalPlus=%@, TotalPlusP=%@, TotalMinus=%@, TotalMinusP=%@, TotalNR=%@, IsSummarized='true' where SAActiveSessionId=%@",[SAActiveSessionDict valueForKey:@"plusCount"]
                               ,[SAActiveSessionDict valueForKey:@"plusPCount"]
                               ,[SAActiveSessionDict valueForKey:@"minusCount"]
                               ,[SAActiveSessionDict valueForKey:@"minusPCount"]
                               ,[SAActiveSessionDict valueForKey:@"NRCount"]
                               ,[SAActiveSessionDict valueForKey:@"SAActiveSessionID"]];
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}
+(BOOL)updateSAIsFinilizedData:(NSMutableDictionary *)SAActiveSessionDict{
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"Update SAActiveSession set MstSettingId=%@, MstStatusId=%@, Date='%@', Staff='%@', IsFinished='true',IsEmailEnabled='%@' where SAActiveSessionId=%@"
                               ,[SAActiveSessionDict valueForKey:@"MstSettingId"],
                               [SAActiveSessionDict valueForKey:@"MstStatusId"],
                               [SAActiveSessionDict  valueForKey:@"Date"],
                               [SAActiveSessionDict valueForKey:@"Staff"],kSAEmailSessionDASA,
                               [SAActiveSessionDict valueForKey:@"SAActiveSessionID"]];
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(BOOL)updateSAPastSession:(NSMutableDictionary *)SAActiveSessionDict{
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString =[NSString stringWithFormat:@"insert into SAPastSession(SASubLevelId, Date ,Step,Type,Score,Status,[Order],Plus,PlusP,Minus,MinusP,NR) values (%@, '%@', '%@', '%@', '%@', '%@', %@,%@,%@,%@,%@,%@)"
                              ,[SAActiveSessionDict  valueForKey:@"sasublevelid"]
                              ,[SAActiveSessionDict  valueForKey:@"Date"]
                              ,[SAActiveSessionDict  valueForKey:@"stepName"]
                              ,[SAActiveSessionDict  valueForKey:@"trialtype"]
                              ,[SAActiveSessionDict  valueForKey:@"score"]
                              ,[SAActiveSessionDict  valueForKey:@"mstStatusName"]
                              ,@"1"
                              ,[SAActiveSessionDict  valueForKey:@"plusCount"]
                              ,[SAActiveSessionDict  valueForKey:@"plusPCount"]
                              ,[SAActiveSessionDict  valueForKey:@"minusCount"]
                              ,[SAActiveSessionDict  valueForKey:@"minusPCount"]
                              ,[SAActiveSessionDict  valueForKey:@"NRCount"]
                              ];
        
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}

+(NSString *)getSublevelName:(NSString *)sublevelid{
 
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select Skill from SASubLevel where SASubLevelId=%@",sublevelid];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                resultStatus= [resultStatus
                              stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
               
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(NSString *)getSkillName:(NSString *)sublevelid{
    
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select Name from SASubLevel where SASubLevelId=%@",sublevelid];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                resultStatus= [resultStatus
                               stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(NSString *)getStepName:(NSString *)sublevelid{
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select name from SAStep where SAStepId=%@",sublevelid];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;

}

+(NSString *)getTrialTypeNme:(NSString *)trialTypeID{
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select Name from MstTrialType where MstTrialType.MstTrialTypeId =%@",trialTypeID];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}
+(NSString *)getSAOldSessionTrialCount:(NSString *)SessionId{
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"SELECT count(SAActiveTrialID) from SAActiveTrial where SAActiveSessionid=%@",SessionId];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(BOOL )SAResumeSession:(NSString *)SessionId{
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"UPDATE SAActiveSession set  IsSummarized='false' where SAActiveSession.SAActiveSessionId=%@",SessionId];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
               
                
                resultStatus=YES;
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}
+(NSString *)getSASessionDate:(NSString *)SAActiveSessionID{
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select SAActiveSession.Date from SAActiveSession where SAActiveSessionId=%@",SAActiveSessionID];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}
+(NSString *)getMaxSASessionOrder:(int)curriculamID{
    
    
    NSString *resultStatus=@"1";
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select MAX(SAActiveSession.[Order]) from SAActiveSession join SASubLevel on SAActiveSession.SASubLevelId=SASubLevel.SASubLevelId join SALevel on SASubLevel.SALevelId=SALevel.SALevelId where SALevel.StuCurriculumId=%d",curriculamID];
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            
           
            
            
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                if(sqlite3_column_text(statement, 0)!=NULL){
                    
                    resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    
                    resultStatus=[NSString stringWithFormat:@"%d",[resultStatus intValue]+1];
                    
                }else{
                    
                }
                
                
                
                
            }
          //  NSLog(@"%@",[NSThread callStackSymbols]);
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}
#pragma mark TA Methods

+ (NSMutableArray *)getTATrainignSteps:(int)TAcurriculamID{

    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@%d",kGetTATrainigSteps,TAcurriculamID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
               NSString *StepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *discription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                discription= [discription
                              stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
                
                
                 name=[name stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                NSString *order = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                 
                
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                 [myDic setValue:StepID forKey:@"StepID"];
                [myDic setValue:name forKey:@"stepname"];
                [myDic setValue:discription forKey:@"stepdiscription"];
                 [myDic setValue:order forKey:@"order"];
                [resultArry addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;
    
}

+ (NSMutableArray *)getTAPastData:(int)TAcurriculamID{
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@%d",kGetTAPastData,TAcurriculamID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *trialtype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *trainingStep = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *stepIndipendent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                NSString *promptstep = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:date forKey:@"date"];
                [myDic setValue:trialtype forKey:@"trialtype"];
                [myDic setValue:trainingStep forKey:@"trainingStep"];
                [myDic setValue:stepIndipendent forKey:@"stepIndipendent"];
                [myDic setValue:promptstep forKey:@"promptstep"];
                [myDic setValue:name forKey:@"name"];
                [resultArry addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;
}
+ (NSMutableArray *)getTAPromptOption:(int)TAcurriculamID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@%d",kGetTAPromptOption,TAcurriculamID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *PromptID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *Promptname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
               
                Promptname=[Promptname stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
               [myDic setValue:PromptID forKey:@"PromptID"];
                [myDic setValue:Promptname forKey:@"Promptname"];
                
                [resultArry addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;
}



+ (NSMutableArray *)getCurriculamName:(int)StudentCurriculumId{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@%d",kGetStudentCurriculamName,StudentCurriculumId]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                name= [name stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:name forKey:@"studentcurriculamname"];
                [resultArry addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;
}

+(BOOL)addNewSeesionToTAActiveSessionTable:(NSMutableDictionary *)myDiction{
 
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@ (%@,%@,%@,%@,%@,'%@',%@,%@,%@,%@,'%@',%@,'%@','%@','%@')",kAddNewSessionToTAActiveSession,
        
        [myDiction valueForKey:@"ActiveStudentSessionId"],
        [myDiction valueForKey:@"TACurriculumId"],
        [myDiction valueForKey:@"MstTrialTypeId"],
        [myDiction valueForKey:@"TATrainingStepId"],
        [myDiction valueForKey:@"MstPromptStepId"],
        [myDiction valueForKey:@"Staff"],
        [myDiction valueForKey:@"TAStepIndependentId"],
        [myDiction valueForKey:@"MstSetttingId"],
        [myDiction valueForKey:@"MstStatusId"],
        [myDiction valueForKey:@"NoOfTrials"],
        [myDiction valueForKey:@"Date"],
        [myDiction valueForKey:@"Order"],
        [myDiction valueForKey:@"IsSummarized"],
        [myDiction valueForKey:@"IsFinished"],[myDiction valueForKey:@"IsEmailEnabled"]];
        
        
        
              
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                int TACurrentActiveSessionID =sqlite3_last_insert_rowid(database);
                kTAActiveSessionID=TACurrentActiveSessionID;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}

+(NSString *)insertInToTAActiveTrial:(NSMutableDictionary *)myDiction{

   
    NSString *resultStatus;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@(%@,%@,%@)",kinsertTAActiveTrial,
                               [myDiction valueForKey:@"TAActiveSessionId"],
                               [myDiction valueForKey:@"TAStepId"],
                               [myDiction valueForKey:@"TAPromptStepId"]];
        
                                       
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                // NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                int prikey =sqlite3_last_insert_rowid(database);
              resultStatus=[NSString stringWithFormat:@"%d",prikey];
                    
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}

+(BOOL)updateInToTAActiveTrial:(NSMutableDictionary *)myDiction{
    BOOL resultStatus;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"UPDATE TAActiveTrial SET TAPromptStepId=%@ WHERE TAActiveTrialId=%@",[myDiction valueForKey:@"TAPromptStepID"],[myDiction valueForKey:@"TAActivetrialId"]];
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                // NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                //int prikey =sqlite3_last_insert_rowid(database);
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}

+(BOOL)updateTAActiveSessionOnSummasize:(NSString *)MstPromptStepId TAActiveSessionId:(NSString *)sessionID{
    
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString =[NSString stringWithFormat:@"UPDATE TAActiveSession SET [MstPromptStepId] = %@,[IsSummarized] = 'true' WHERE TAActiveSessionId =%@",MstPromptStepId,sessionID];
        
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}


+(BOOL)updateTAActiveSessionOnFinish:(NSMutableDictionary *)myDiction;{
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
    NSString *sqlString =[NSString stringWithFormat:@"UPDATE TAActiveSession SET [MstPromptStepId] =%@,[Staff] = '%@',[TAStepIndependentId] =%@,[MstSetttingId] =%@,[MstStatusId] =%@,[NoOfTrials] =%@,[Date] = '%@',[IsFinished] = 'true',[IsEmailEnabled] ='%@' WHERE TAActiveSessionId =%@",[myDiction valueForKey:@"MstPromptStepId"],[myDiction valueForKey:@"Staff"],[myDiction valueForKey:@"TAStepIndependentId"],[myDiction valueForKey:@"MstSetttingId"],[myDiction valueForKey:@"MstStatusId"],[myDiction valueForKey:@"NoOfTrials"],[myDiction valueForKey:@"Date"],[myDiction valueForKey:@"IsEmailEnabled"],[myDiction valueForKey:@"sessionID"]];
                                                        
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}




+(BOOL)insertInToTAPastSession:(NSMutableDictionary *)myDiction{
    
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
       
        NSString *sqlString ;
        
        
        
        if(kTATraingStepID==0){
            
             sqlString=[NSString stringWithFormat:@"%@(%d,'%@','%@','%@','%@','%@',%@)",kinsertInToTAPastSession,kTACurrentCurriculamId,[myDiction valueForKey:@"Date"],kTATrialTypeName,[myDiction valueForKey:@"TAStepIndependentName"],@"NA",kMstPromptStepName,[myDiction valueForKey:@"order"]];
        }else{
           
             sqlString =[NSString stringWithFormat:@"%@(%d,'%@','%@','%@',%d,'%@',%@)",kinsertInToTAPastSession,kTACurrentCurriculamId,[myDiction valueForKey:@"Date"],kTATrialTypeName,[myDiction valueForKey:@"TAStepIndependentName"],kTATraingStepID,kMstPromptStepName,[myDiction valueForKey:@"order"]];
        }
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}
+(NSString *)getMstChainingSequence:(int)TAcurriculamID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultString;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"SELECT MstChainingSequence.MstChainingSequenceId,MstChainingSequence .Name FROM TACurriculum join MstChainingSequence ON MstChainingSequence.MstChainingSequenceId = TACurriculum.MstChainingSequenceId WHERE TACurriculum.TACurriculumId =%d",TAcurriculamID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultString;
}

+(NSString *)getMstChainingSequenceID:(int)TAcurriculamID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultString;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"SELECT MstChainingSequence.MstChainingSequenceId,MstChainingSequence .Name FROM TACurriculum join MstChainingSequence ON MstChainingSequence.MstChainingSequenceId = TACurriculum.MstChainingSequenceId WHERE TACurriculum.TACurriculumId =%d",TAcurriculamID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultString;
}
+(NSString *)getTACurricilumID:(int)stuCurriculumID{
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultString;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select TACurriculumId from TACurriculum where TACurriculum.StuCurriculumId=%d",stuCurriculumID];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultString;
}
+(BOOL)TAResumeSession:(NSString *)SessionId{
 
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"UPDATE TAActiveSession set  IsSummarized='false' where TAActiveSession.TAActiveSessionId=%@",SessionId];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultStatus=YES;
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}

+ (NSString *)checkTASessionPromptIsSelected:(int)SessionID{
    // Setup some globals
    
    NSString *resultString;
    
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"SELECT COUNT(*) FROM TAActiveTrial where TAActiveSessionId= %d",SessionID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                resultString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultString;
    
    
    
}

+ (NSString *)checkTASessionPromptIsSelected:(int)SessionID forTrainingStepId:(int )stepid{
    // Setup some globals
    
    NSString *resultString;
    
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"SELECT COUNT(*) FROM TAActiveTrial where TAActiveSessionId= %d and TAStepId=%d",SessionID,stepid]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                resultString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultString;
    
    
    
}

+ (NSString *)getTAOldSessionStepsPromptForActiveSessionId:(NSString *)activeSessionId forStep:(NSString *)stepid{
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"Not yet Done";
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from TAActiveTrial where TAActiveSessionId=%@ and TAStepId=%@",activeSessionId,stepid];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                
                resultArry = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                               
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
    
    
}


+ (NSString *)getTAOldSessionTrialID:(NSString *)activeSessionId forStep:(NSString *)stepid{
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"";
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from TAActiveTrial where TAActiveSessionId=%@ and TAStepId=%@",activeSessionId,stepid];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                
                resultArry = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
    
    
}
+(NSString *)checkPromptStatus:(int)TAcurriculamID{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultString;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select  Count(*) from TAPromptStep where TACurriculumid= %d and TAPromptStepId>0",TAcurriculamID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultString;
}


+(NSString *)getMaxTASessionOrder:(int)curriculamID{
    
    
    NSString *resultStatus=@"1";
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select Max(TAActiveSession.[Order]) from TAActiveSession join TACurriculum on TAActiveSession.TACurriculumId=TACurriculum.TACurriculumId where TACurriculum.StuCurriculumId=%d",curriculamID];
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            
            
            
            
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                if(sqlite3_column_text(statement, 0)!=NULL){
                    
                    resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    
                    resultStatus=[NSString stringWithFormat:@"%d",[resultStatus intValue]+1];
                    
                }else{
                    
                }
                
                
                
                
            }
            //  NSLog(@"%@",[NSThread callStackSymbols]);
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}
#pragma mark IT page methods

+ (NSMutableArray *)getITContext:(int)curriculamID{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        //NSString *sqlString = @"SELECT ITContext.Name FROM ITContext WHERE ITContext.StuCurriculumId = 10";
        // NSString *sqlString = [NSString stringWithFormat:@"SELECT ITContext.Name FROM ITContext WHERE ITContext.StuCurriculumId = %@",curriculamID]; 
         // NSString *sqlString = [NSString stringWithFormat:@"%@ %d",kGETITContext,curriculamID]; 
        NSString *sqlString = [NSString stringWithFormat:@"SELECT ITContext.Name, ITContext.ITContextId FROM ITContext WHERE ITContext.ITContextId NOT IN( SELECT ITActiveSession.ITContextId FROM StuCurriculum JOIN ActiveStudentSession ON ActiveStudentSession.StuCurriculumId = StuCurriculum.StuCurriculumId JOIN ITActiveSession ON ITActiveSession.ActiveStudentSessionId = ActiveStudentSession.ActiveStudentSessionId WHERE StuCurriculum.CurriculumTypeId = 2 AND ITActiveSession.IsFinished <> 'true' AND StuCurriculum.StuCurriculumId = %d) and StuCurriculumId =%d",curriculamID,curriculamID];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *ContextName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                  NSString *ContextID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                
                ContextName=[ContextName stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];

                
                
                //SELECT ITContext.Name FROM ITContext WHERE ITContext.StuCurriculumId =       
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:ContextName forKey:@"Name"];
                [myDic setValue:ContextID forKey:@"ContextID"];
                
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;    
    
    
    
    
}

+(NSString *)getITOldSessionTrialCount:(NSString *)SessionId{
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"SELECT count(ITActiveTrialID) from ITActiveTrial where ITActiveSessionid=%@",SessionId];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
               
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+ (NSMutableArray *)getFirstITMIP:(int)curriculamID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString =[NSString stringWithFormat: @"select ITMIPId from ITMIP where StuCurriculumId=%d",curriculamID];
        
        
       
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
               
                NSString *ContextID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                //SELECT ITContext.Name FROM ITContext WHERE ITContext.StuCurriculumId =       
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                
                [myDic setValue:ContextID forKey:@"ACEITMIPId"];
                
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;
}

+ (NSMutableArray *)getITMIP:(int)curriculamID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@ %d",kGetITMIP,curriculamID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *ContextName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                
                ContextName=[ContextName
                 stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                NSString *ContextID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                //SELECT ITContext.Name FROM ITContext WHERE ITContext.StuCurriculumId =       
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:ContextName forKey:@"Name"];
                
                [myDic setValue:ContextID forKey:@"ACEITMIPId"];
                
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;
}
+(NSString *)insertInToITPastData:(NSMutableDictionary *)myDic{
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@(%@,'%@','%@','%@','%@',%@,%@,%@,%@,%@)",kInsertIntoITpastDatatable,
                               [myDic valueForKey:@"ITContextId"],
                               [myDic valueForKey:@"WeekEnding"],
                               [myDic valueForKey:@"TrialType"],
                               [myDic valueForKey:@"Opportunities"],
                               [myDic valueForKey:@"MIP"],
                               [myDic valueForKey:@"TotalPlusP"],
                               [myDic valueForKey:@"TotalPlus"],
                               [myDic valueForKey:@"TotalMinus"],
                               [myDic valueForKey:@"TotalNR"],
                               [myDic valueForKey:@"Order"]];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                // NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                int prikey =sqlite3_last_insert_rowid(database);
                resultStatus=[NSString stringWithFormat:@"%d",prikey];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus; 
}
+(NSString *)updateInToITPastData:(NSMutableDictionary *)myDic{
    
    
       
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"UPDATE ITPastSession SET [ITContextId]=%@,[WeekEnding]='%@',[TrialType]='%@',[Opportunities]='%@',[MIP]='%@',[TotalPlusP]=%@,[TotalPlus]=%@,[TotalMinus]=%@,[TotalNR]=%@,[Order]=%@ WHERE ITContextId= %@ AND WeekEnding = '%@'",
                               [myDic valueForKey:@"ITContextId"],
                               [myDic valueForKey:@"WeekEnding"],
                               [myDic valueForKey:@"TrialType"],
                               [myDic valueForKey:@"Opportunities"],
                               [myDic valueForKey:@"MIP"],
                               [myDic valueForKey:@"TotalPlusP"],
                               [myDic valueForKey:@"TotalPlus"],
                               [myDic valueForKey:@"TotalMinus"],
                               [myDic valueForKey:@"TotalNR"],
                               [myDic valueForKey:@"Order"], [myDic valueForKey:@"ITContextId"],[myDic valueForKey:@"WeekEnding"]];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                // NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                int prikey =sqlite3_last_insert_rowid(database);
                resultStatus=[NSString stringWithFormat:@"%d",prikey];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+ (NSString *)checkFileExistForWeekEnd:(NSString *)weekEndDate forContextId:(NSString *)contextID{
    // Setup some globals
    
    NSString *resultString;
    
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"SELECT COUNT(*) FROM ITPastSession where ITContextId= %@ AND WeekEnding = '%@'",contextID,weekEndDate]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
              
               resultString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultString;
    
    
    
}
+ (NSMutableArray *)getpastDATAFileExistForWeekEnd:(NSString *)weekEndDate forContextId:(NSString *)contextID{
    
    
   
    
    
    
   
    
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *resultDictn;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM ITPastSession where ITContextId= %@ AND WeekEnding = '%@'",contextID,weekEndDate]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                 resultDictn=[[NSMutableDictionary alloc]init];
                  NSString *ITContextId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                  NSString *WeekEnding = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                  NSString *TrialType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                  NSString *Opportunities = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                  NSString *MIP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                  NSString *TotalPlus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                  NSString *TotalPlusP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                  NSString *TotalMinus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                  NSString *TotalNR = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                  NSString *Order = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                
                [resultDictn setValue:ITContextId forKey:@"ITContextId"];
                [resultDictn setValue:WeekEnding forKey:@"WeekEnding"];
                [resultDictn setValue:TrialType forKey:@"TrialType"];
                [resultDictn setValue:TrialType forKey:@"TrialType"];
                [resultDictn setValue:Opportunities forKey:@"Opportunities"];
                [resultDictn setValue:MIP forKey:@"MIP"];
                [resultDictn setValue:TotalPlus forKey:@"TotalPlus"];
                [resultDictn setValue:TotalPlusP forKey:@"TotalPlusP"];
                [resultDictn setValue:TotalMinus forKey:@"TotalMinus"];
                [resultDictn setValue:TotalNR forKey:@"TotalNR"];
                [resultDictn setValue:ITContextId forKey:@"ITContextId"];
                [resultDictn setValue:Order forKey:@"Order"];
                
              
                [resultArry addObject:resultDictn];
                
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;
}
+(BOOL)ITResumeSession:(NSString *)SessionId{
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"UPDATE ITActiveSession set  IsSummarized='false' where ITActiveSession.ITActiveSessionId=%@",SessionId];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultStatus=YES;
                
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus; 
}
+(NSString *)getContextNameForContextId:(NSString *)contxtID{
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select Title from ITContext where ITContext.ITContextId=%@",contxtID];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                resultStatus= [resultStatus
                               stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+ (NSMutableArray *)getITPastData:(NSString *)ITContextID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
      
        NSString *sqlString = [NSString stringWithFormat:@"%@ %@",kGetITPastData,ITContextID]; 
       
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                NSString *weekending = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *trialtype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                 NSString *mip = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                 NSString *totalplus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                 NSString *totalplusP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                 NSString *totalMinus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                 NSString *totalNR = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
               
                    
                
                mip=[mip stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                                
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:weekending forKey:@"weekending"];
                [myDic setValue:trialtype forKey:@"trialtype"];  
                [myDic setValue:totalplus forKey:@"totalplus"];
                [myDic setValue:totalplusP forKey:@"totalplusP"];
                [myDic setValue:totalMinus forKey:@"totalMinus"];
                [myDic setValue:totalNR forKey:@"totalNR"];
                [myDic setValue:mip forKey:@"mip"];
                
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;  
}

+(NSString *)addNewSeesionToITActiveSessionTable:(NSMutableDictionary *)myDiction{
    
    NSString * resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@ (%@,%@,%@,%@,%@,'%@',%@,%@,%@,%@,'%@','%@','%@','%@','%@','%@','%@')",kAddNewSessionToITActiveSession,
                               
                               [myDiction valueForKey:@"ActiveStudentSessionId"],
                               [myDiction valueForKey:@"MstTrialTypeId"],
                               [myDiction valueForKey:@"ITContextId"],
                               [myDiction valueForKey:@"ITMIPId"],
                               [myDiction valueForKey:@"MstStatusId"],
                               [myDiction valueForKey:@"StepId"],
                               [myDiction valueForKey:@"TotalPlus"],
                               [myDiction valueForKey:@"TotalPlusP"],
                               [myDiction valueForKey:@"TotalMinus"],
                               [myDiction valueForKey:@"TotalNR"],
                               [myDiction valueForKey:@"Staff"],
                               [myDiction valueForKey:@"WeekendDate"],
                               [myDiction valueForKey:@"Date"],
                               [myDiction valueForKey:@"Order"],
                               [myDiction valueForKey:@"IsSummarized"],[myDiction valueForKey:@"IsFinished"],[myDiction valueForKey:@"IsEmailEnabled"]];
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                              
                int TACurrentActiveSessionID =sqlite3_last_insert_rowid(database);
                resultStatus=[NSString stringWithFormat:@"%d",TACurrentActiveSessionID];
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}

+(NSString *)insertInToITActiveTrial:(NSMutableDictionary *)myDic{
    
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@(%@,%@,'%@','%@','%@','%@')",kInsertIntoITActiveTrial,
                               [myDic valueForKey:@"ITActiveSessionId"],
                               [myDic valueForKey:@"TrialNumber"],
                               [myDic valueForKey:@"+"],
                               [myDic valueForKey:@"+P"],
                               [myDic valueForKey:@"-"],[myDic valueForKey:@"NR"]];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                // NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                int prikey =sqlite3_last_insert_rowid(database);
                resultStatus=[NSString stringWithFormat:@"%d",prikey];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(NSString *)updateInToITActiveTrial:(NSMutableDictionary *)myDic{
    
    
    NSString *resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"UPDATE [ITActiveTrial]SET [Plus]='%@',[PlusP]='%@',[Minus]='%@',[NR]='%@' WHERE [ITActiveTrial].ITActiveTrialId =%@",[myDic valueForKey:@"+"],
                               [myDic valueForKey:@"+P"],
                               [myDic valueForKey:@"-"],
                               [myDic valueForKey:@"NR"],
                               [myDic valueForKey:@"ITActiveSessionId"]];
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                // NSString *stepID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                int prikey =sqlite3_last_insert_rowid(database);
                resultStatus=[NSString stringWithFormat:@"%d",prikey];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(BOOL)updateITIsSummarizedData:(NSMutableDictionary *)ITActiveSessionDict{
 
    
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"update ITActiveSession set TotalPlus=%@, TotalPlusP=%@, TotalMinus=%@, TotalNR=%@, IsSummarized='true' where ITActiveSessionId=%@",[ITActiveSessionDict valueForKey:@"plusCount"]
                               ,[ITActiveSessionDict valueForKey:@"plusPCount"]
                               ,[ITActiveSessionDict valueForKey:@"minusCount"]
                               ,[ITActiveSessionDict valueForKey:@"NRCount"]
                               ,[ITActiveSessionDict valueForKey:@"ITActiveSessionId"]];
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}
+(BOOL)updateITIsFinishedData:(NSMutableDictionary *)ITActiveSessionDict{
    
    
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"update ITActiveSession set ITMipId=%@,Staff='%@',MstStatusId=%@,IsEmailEnabled='%@',IsFinished='true',Date='%@' where ITActiveSessionId=%@",[ITActiveSessionDict valueForKey:@"MIPid"]
                               ,[ITActiveSessionDict valueForKey:@"staff"]
                               ,[ITActiveSessionDict valueForKey:@"statusid"]
                               ,[ITActiveSessionDict valueForKey:@"isEmailed"]
                               ,[ITActiveSessionDict valueForKey:@"date"]
                               ,[ITActiveSessionDict valueForKey:@"ITActiveSessionId"]
                               ];
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
}

+(NSString *)getMaxITSessionOrder:(int)curriculamID{
    
    
    NSString *resultStatus=@"1";
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString=[NSString stringWithFormat:@"select Max(ITActiveSession.[Order]) from ITActiveSession join ITContext on ITActiveSession.ITContextId=ITContext.ITContextId where ITContext.StuCurriculumId=%d and ITActiveSession.IsFinished='true'",curriculamID];
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            
            
            
            
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                if(sqlite3_column_text(statement, 0)!=NULL){
                    
                    resultStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                    
                    resultStatus=[NSString stringWithFormat:@"%d",[resultStatus intValue]+1];
                    
                }else{
                    
                }
                
                
                
                
            }
            //  NSLog(@"%@",[NSThread callStackSymbols]);
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultStatus;
    
}
#pragma mark Curricula page methods

//Method for curriculam page's carousel information for particular teacher(User)

+ (NSMutableArray *)getStudentDetailsForUser:(int )UserID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@ %d",kStudentInfoQryForCarrousal,UserID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *StudentName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *StudentSchool = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *StudentTeam = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *StudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:StudentID forKey:@"studentID"];
                [myDic setValue:StudentName forKey:@"studentName"];
                
                [myDic setValue:StudentSchool forKey:@"studentSchool"];
                
                [myDic setValue:StudentTeam forKey:@"studentTeam"];
                
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;    
    
    
}

+ (NSMutableArray *)getCarriculamDetailsForStudent:(NSString *)studentID{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@ %@",kStudentCurriculamListInfoQry,studentID]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *StudentCurriculamName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                StudentCurriculamName= [StudentCurriculamName
                              stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
                NSString *StuCurriculamId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *StudentCurriculamId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *StudentCurriculamType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString *StudentCurriculamObjective = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
               
             
                if(myDic) myDic=nil;
               
                //SELECT StuCurriculum.Name,StuCurriculum.StuCurriculumId,StuCurriculum.StudentCurriculumId,StuCurriculum.ObjectiveNo,MstCurriculumType.Name AS [Type] FROM StuCurriculum JOIN MstCurriculumType ON StuCurriculum.CurriculumTypeId = MstCurriculumType.MstCurriculumTypeId WHERE StuCurriculum.ACEStudentId =
                
                myDic=[[NSMutableDictionary alloc]init];
                //[myDic setValue:ACEStudentID forKey:@"studentID"];
                [myDic setValue:StudentCurriculamName forKey:@"curriculamName"];
                
                [myDic setValue:StudentCurriculamType forKey:@"curriculamType"];
                
                [myDic setValue:StudentCurriculamObjective forKey:@"curriculamObjective"];
                [myDic setValue:StudentCurriculamId forKey:@"studentCurriculamID"];
                [myDic setValue:StuCurriculamId forKey:@"stuCurriculamID"];
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;    
    
    
}



+ (void)delateDetailsForStudent:(NSString *)studentID{
    NSString  *databaseName1 = kDatabaseName;
    sqlite3 *database;
    //BOOL retValue = YES;
    //   BOOL retValue1 = YES;
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    NSString *sqlString = [NSString stringWithFormat:@"%@ %@",kDeleteACEStudent,studentID];
    //NSString *sqlString1 = [NSString stringWithFormat:@"%@ %@",kDeleteCurriculum,studentID];
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        
        const char* sqlStatement =[sqlString UTF8String];
        //    const char* sqlStatement1 = [sqlString1 UTF8String];
        sqlite3_stmt *compiledStatement;
        //    sqlite3_stmt *compiledStatement1;
        //  retValue1 = sqlite3_prepare_v2(database, sqlStatement1, -1, &compiledStatement1, NULL);
        //retValue=  sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
        sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
        
        if(SQLITE_DONE != sqlite3_step(compiledStatement))//add this line
        {
            NSLog(@"Error while deleting data. '%s'", sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
        /*
         if(SQLITE_DONE != sqlite3_step(compiledStatement1))//add this line
         {
         NSLog(@"Error while deleting data. '%s'", sqlite3_errmsg(database));
         }
         sqlite3_finalize(compiledStatement1);
         */
    }
    sqlite3_close(database);
    
    
}
+ (void)delateCurriculumDetailsForStudent:(NSString *)studentID{
    NSString  *databaseName1 = kDatabaseName;
    sqlite3 *database;
    //  BOOL retValue = YES;
    //  BOOL retValue1 = YES;
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    //NSString *sqlString = [NSString stringWithFormat:@"%@ %@",kDeleteACEStudent,studentID];
    NSString *sqlString1 = [NSString stringWithFormat:@"%@ %@",kDeleteCurriculum,studentID];
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK)  {
        
        
        // const char* sqlStatement =[sqlString UTF8String];
        const char* sqlStatement1 = [sqlString1 UTF8String];
        sqlite3_stmt *compiledStatement;
        // sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
        sqlite3_prepare_v2(database, sqlStatement1, -1, &compiledStatement, NULL);
        if(SQLITE_DONE != sqlite3_step(compiledStatement))//add this line
        {
            NSLog(@"Error while deleting data. '%s'", sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
    
}

//kGetTopTenRecords
// NSString *sqlString = [NSString stringWithFormat:@"%@",kGetTopTenRecords];
//+ (NSMutableArray *)getStudentDetailsForUser:(NSString *)UserID
+ (NSMutableArray *)getTopTenRecords{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *myDic;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"%@",kGetTopTenRecords]; 
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                // NSString *ACEStudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *StudentName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                NSString *StudentSchool = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *StudentTeam = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                NSString *StudentID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                
                if(myDic) myDic=nil;
                
                myDic=[[NSMutableDictionary alloc]init];
                [myDic setValue:StudentID forKey:@"studentID"];
                [myDic setValue:StudentName forKey:@"studentName"];
                
                [myDic setValue:StudentSchool forKey:@"studentSchool"];
                
                [myDic setValue:StudentTeam forKey:@"studentTeam"];
                
                [resultArry2 addObject:myDic];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry2;   
}


+(BOOL)insertStudentDetailInCarrousal:(int)userID :(int)studentId :(NSString *)studentName :(NSString *)studentSchool :(NSString *)studentTeam :(NSString *)lastSyncTme andQuarter:(int)qrter
{
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString =[NSString stringWithFormat:@"INSERT INTO ACEStudent(ACEUserId,StudentId,Name,SchoolName,TeamName,LastSyncTime,Quarter) values ('%d', '%d', '%@', '%@', '%@', '%@',%d)",userID,studentId,studentName,studentSchool,studentTeam,lastSyncTme,qrter];
        
                          
        //INSERT INTO ACEStudent(ACEStudentId,ACEUserId,StudentId,Name,SchoolName,TeamName,LastSyncTime) values(101,3,14,'rigg','AbhuDhabi','hufff','1/1/2012')
        
        //INSERT INTO ACEStudent(ACEUserId,StudentId,Name,SchoolName,TeamName,LastSyncTime) values(3,16,'iopg','india','gvjf','1/1/2012')
    
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return resultStatus;
  
}

+(BOOL)verifyStudentEntryOnInsertion :(NSString *)studentName :(NSString *)studentTeam :(NSString *)studentSchool
{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	int count = -1;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"SELECT COUNT(*) from ACEStudent where ACEStudent.Name ='%@' and ACEStudent.TeamName = '%@' and ACEStudent.SchoolName = '%@'",studentName,studentTeam,studentSchool];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                count = sqlite3_column_int(statement, 0);
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    if (count == 0 ) {
        return FALSE;
    }
    else{
        return TRUE;
    }
    
    
    
    
    
}

//Get count for TA Active student in DB
+(BOOL)TAActiveSessionCount:(int)stuCurriculumId{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	int count = -1;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"select COUNT(*) from TAActiveSession join TACurriculum on TAActiveSession.TACurriculumId=TACurriculum.TACurriculumId where TACurriculum.StuCurriculumId=%d and TAActiveSession.IsFinished='false'",stuCurriculumId];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                count = sqlite3_column_int(statement, 0);
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    if (count == 0 ) {
        return FALSE;
    }
    else{
        return TRUE;
    }
 
    
}

//Get count for SA Active Student
+(BOOL)SAActiveSessionCount:(int)stuCurriculumId{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	int count = -1;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"select Count(*) from SAActiveSession join SASubLevel on SAActiveSession.SASubLevelId=SASubLevel.SASubLevelId join SALevel on SASubLevel.SALevelId=SALevel.SALevelId where SALevel.StuCurriculumId=%d and SAActiveSession.IsFinished=='false'",stuCurriculumId];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                count = sqlite3_column_int(statement, 0);
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    if (count == 0 ) {
        return FALSE;
    }
    else{
        return TRUE;
    }

    
}

+ (int)activeSessionIdForSATAIT:(int)stuCurriculumId{
    int currentActiveSessionId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT SAActiveSession.SAActiveSessionId FROM StuCurriculum JOIN ActiveStudentSession ON ActiveStudentSession.StuCurriculumId = StuCurriculum.StuCurriculumId JOIN SAActiveSession ON SAActiveSession.ActiveStudentSessionId = ActiveStudentSession.ActiveStudentSessionId WHERE StuCurriculum.CurriculumTypeId = 1 AND StuCurriculum.StuCurriculumId = %d UNION SELECT ITActiveSession.ITActiveSessionId FROM StuCurriculum JOIN ActiveStudentSession ON ActiveStudentSession.StuCurriculumId = StuCurriculum.StuCurriculumId JOIN ITActiveSession ON ITActiveSession.ActiveStudentSessionId = ActiveStudentSession.ActiveStudentSessionId WHERE StuCurriculum.CurriculumTypeId = 2 AND StuCurriculum.StuCurriculumId = %d UNION SELECT TAActiveSession.TAActiveSessionId FROM StuCurriculum JOIN ActiveStudentSession ON ActiveStudentSession.StuCurriculumId = StuCurriculum.StuCurriculumId JOIN TAActiveSession ON TAActiveSession.ActiveStudentSessionId = ActiveStudentSession.ActiveStudentSessionId WHERE StuCurriculum.CurriculumTypeId = 3 AND StuCurriculum.StuCurriculumId = %d",stuCurriculumId,stuCurriculumId,stuCurriculumId];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                currentActiveSessionId = sqlite3_column_int(statement, 0);
            }
            
            // Finalize and close database.
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
    }
    
    return currentActiveSessionId;
    
}

+ (int)GetActiveSessionIdForSATAIT:(int)stuCurriculumId{
    int currentActiveSessionId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT SAActiveSession.ActiveStudentSessionId FROM StuCurriculum JOIN ActiveStudentSession ON ActiveStudentSession.StuCurriculumId = StuCurriculum.StuCurriculumId JOIN SAActiveSession ON SAActiveSession.ActiveStudentSessionId = ActiveStudentSession.ActiveStudentSessionId WHERE StuCurriculum.CurriculumTypeId = 1 AND StuCurriculum.StuCurriculumId = %d UNION SELECT ITActiveSession.ActiveStudentSessionId FROM StuCurriculum JOIN ActiveStudentSession ON ActiveStudentSession.StuCurriculumId = StuCurriculum.StuCurriculumId JOIN ITActiveSession ON ITActiveSession.ActiveStudentSessionId = ActiveStudentSession.ActiveStudentSessionId WHERE StuCurriculum.CurriculumTypeId = 2 AND StuCurriculum.StuCurriculumId = %d UNION SELECT TAActiveSession.ActiveStudentSessionId FROM StuCurriculum JOIN ActiveStudentSession ON ActiveStudentSession.StuCurriculumId = StuCurriculum.StuCurriculumId JOIN TAActiveSession ON TAActiveSession.ActiveStudentSessionId = ActiveStudentSession.ActiveStudentSessionId WHERE StuCurriculum.CurriculumTypeId = 3 AND StuCurriculum.StuCurriculumId = %d",stuCurriculumId,stuCurriculumId,stuCurriculumId];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                currentActiveSessionId = sqlite3_column_int(statement, 0);
            }
            
            // Finalize and close database.
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
    }
    
    return currentActiveSessionId;
    
}


//Get sessionId 

+(NSString *)getSessionId{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    // NSString *ACEUserId = [[NSString alloc]init];
    NSString *sessionId;
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"%@",kSessionId];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                //ACEUserId   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                // ACEUserId = sqlite3_column_int(statement, 0);
                sessionId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];            
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return sessionId;
    
    
}

//method to check version match
+(NSString *)isVersionMatchedCheck:(int)stuCurriculumId{
    
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    // NSString *ACEUserId = [[NSString alloc]init];
    NSString *isVersionMatch;
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
 
        NSString *sqlString = [NSString stringWithFormat:@"select isversionmatch from stucurriculum where stucurriculumid =%d",stuCurriculumId];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        
         if(SQLITE_OK == sqlite3_prepare_v2(database, sqlStatement, -1,&statement, nil) )

        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                @try
                {
                isVersionMatch = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                }
                @catch (NSException * e) {
                 isVersionMatch = @"true"; 
                    NSLog(@"Exception: %@", e); 
                    

                    
                }

            
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return isVersionMatch;

 }
//Login Page Method
+(BOOL)insertACEUserDetail:(NSString *)userID :(NSString *)sessionID :(NSString *)loginTime :(NSString *)lastSyncTime:(NSString *)isLogedOut:(NSString *)staffName:(NSString *)UserName;{
    
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString =[NSString stringWithFormat:@"insert into ACEUser (UserId, SessionId, LoginTime, LastSyncTime, IsLoggedOut, StaffName, UserName) values ('%@', '%@', '%@', '%@', '%@', '%@', '%@')",userID,sessionID,loginTime,lastSyncTime,isLogedOut,staffName,UserName];
        
               const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return resultStatus; 
}
+(void)deleteUserFromACEUserTable{
    
    NSString  *databaseName1 = kDatabaseName;
    sqlite3 *database;
   // BOOL retValue = YES;
    //   BOOL retValue1 = YES;
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    NSString *sqlString = [NSString stringWithFormat:@"%@",kdeleteUserDetailsFromACEUser];
    //NSString *sqlString1 = [NSString stringWithFormat:@"%@ %@",kDeleteCurriculum,studentID];
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        
        const char* sqlStatement =[sqlString UTF8String];
        //    const char* sqlStatement1 = [sqlString1 UTF8String];
        sqlite3_stmt *compiledStatement;
        //    sqlite3_stmt *compiledStatement1;
        //  retValue1 = sqlite3_prepare_v2(database, sqlStatement1, -1, &compiledStatement1, NULL);
        sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
        
        
        if(SQLITE_DONE != sqlite3_step(compiledStatement))//add this line
        {
            NSLog(@"Error while deleting data. '%s'", sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
        /*
         if(SQLITE_DONE != sqlite3_step(compiledStatement1))//add this line
         {
         NSLog(@"Error while deleting data. '%s'", sqlite3_errmsg(database));
         }
         sqlite3_finalize(compiledStatement1);
         */
    }
    sqlite3_close(database);
    
}
+(int)ACEUserIdFromACEUserTable:(int)userId{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
   // NSString *ACEUserId = [[NSString alloc]init];
    int ACEUserId;
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"%@%d",kACEUserIdSelection,userId];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                //ACEUserId   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                ACEUserId = sqlite3_column_int(statement, 0);
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return ACEUserId;
    
    
}
+(NSString *)ACEUserIdFromACEUserTableForAddUserPage{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    // NSString *ACEUserId = [[NSString alloc]init];
    int ACEUserId;
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"select userId from ACEUser"];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                //ACEUserId   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                ACEUserId = sqlite3_column_int(statement, 0);
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    NSString *str = [NSString stringWithFormat:@"%d",ACEUserId];
    
    
    return str;
    
    
}
+(NSString *)isLoggedOfFromACEUserTable{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    // NSString *ACEUserId = [[NSString alloc]init];
    NSString *isLoggedOf;
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"select isloggedout from aceuser"];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                
             // int prikey =sqlite3_last_insert_rowid(database);
                
               // isLoggedOf=[NSString stringWithFormat:@"%d",prikey];
                
                //ACEUserId   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                // ACEUserId = sqlite3_column_int(statement, 0);
             //isLoggedOf = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];      
               // isLoggedOf = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];  
                isLoggedOf =[ NSString stringWithFormat:@"%@",sqlite3_column_int(statement, 0)];
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return isLoggedOf;
    
    
}

+(void)updateACEUserTable:(NSString *)sessionId:(NSString *)loginTime:(NSString *)lastSyncTime:(NSString *)userId{
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString =[NSString stringWithFormat:@"update ACEUser Set sessionId ='%@', loginTime = '%@',lastSyncTime = '%@'  where userId =%@",sessionId,loginTime,lastSyncTime,userId];        
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
  //  return resultStatus;
}
+(void)updateACEUserTableWithIsLoggedOut:(int)userId{
    BOOL resultStatus ;
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString =[NSString stringWithFormat:@"update ACEUser Set IsLoggedOut ='true' where ACEUserId =%d",userId];        
        
        
        
        
        
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_DONE ){
                resultStatus=YES;
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
   // return resultStatus;
}

+(NSString *)getLoginTime:(int)userId{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    // NSString *ACEUserId = [[NSString alloc]init];
    NSString *ACEUserIdLoginTime;
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"%@%d",kLoginTimeSelection,userId];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                //ACEUserId   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
               // ACEUserId = sqlite3_column_int(statement, 0);
                ACEUserIdLoginTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];            
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return ACEUserIdLoginTime;
    
    
}

+(int)getUserCount{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	int count = -1;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"%@",kTotalACEuser];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                count = sqlite3_column_int(statement, 0);
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    if (count == 0 ) {
        return FALSE;
    }
    else{
        return TRUE;
    }
    
    
    
    
    
}






+(BOOL)userIDCountForLogin:(NSString *)userId{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	int count = -1;
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        //   NSString *sqlString = [NSString stringWithFormat:@"%@,%@,%@,%@",kGetSelectedStudentInfoCount,studentName,studentTeam,studentSchool]; 
        NSString *sqlString = [NSString stringWithFormat:@"%@%@",kACEUserCount,userId];
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                count = sqlite3_column_int(statement, 0);
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    if (count == 0 ) {
        return FALSE;
    }
    else{
        return TRUE;
    }
    
    
}
//Active Session 

+ (NSMutableArray *)getAllActiveSessions{

    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    MyActiveSessions *activeSessions;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = kgetAllActiveSessions;
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                 if(activeSessions) activeSessions=nil;
                activeSessions=[[MyActiveSessions alloc]init];
                
                
                activeSessions.studentName   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                activeSessions.curiculumName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                activeSessions.curiculumName= [activeSessions.curiculumName
                                        stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
                activeSessions.curiculumType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                activeSessions.discription   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                activeSessions.discription= [activeSessions.discription
                                               stringByReplacingOccurrencesOfString:@"&apos;" withString:@"\'"];
                
                activeSessions.activeSessionId= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                activeSessions.activeStudentsessionId= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                 activeSessions.aceStudentId= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                 activeSessions.stucurrilumId= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                
               
                
               
                [resultArry addObject:activeSessions];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;    

}
+ (NSMutableArray *)getSAOldSessionDetailsForActiveSessionId:(NSString *)activeSessionId{
 
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *oldDataDiction;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from SAActiveSession where SAActiveSessionId=%@",activeSessionId];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                if(oldDataDiction) oldDataDiction=nil;
                oldDataDiction=[[NSMutableDictionary alloc]init];
                
                
                
                 NSString *mstSettingId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                 NSString *mstStatusId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                 NSString *sublevelId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                 NSString *mstTrialtypeId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                 NSString *stepid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
           
                
                
                NSString *totalp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
              
                 NSString *totalpP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                 NSString *totalm = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                 NSString *totalmP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                 NSString *totalNR = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
                 NSString *isSummarized = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 15)];


                
                
                [oldDataDiction setValue:mstSettingId forKey:@"mstSettingId"];
                [oldDataDiction setValue:mstStatusId forKey:@"mstStatusId"];
                [oldDataDiction setValue:sublevelId forKey:@"sublevelId"];
                [oldDataDiction setValue:mstTrialtypeId forKey:@"mstTrialtypeId"];
                [oldDataDiction setValue:stepid forKey:@"stepid"];
                
                [oldDataDiction setValue:totalp forKey:@"totalp"];
                [oldDataDiction setValue:totalpP forKey:@"totalpP"];
                [oldDataDiction setValue:totalm forKey:@"totalm"];
                [oldDataDiction setValue:totalmP forKey:@"totalmP"];
                [oldDataDiction setValue:totalNR forKey:@"totalNR"];
                 [oldDataDiction setValue:isSummarized forKey:@"isSummarized"];
                
                
                
                [resultArry addObject:oldDataDiction];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
}
+ (NSString *)getSAOldSessionTrialOptionForActiveSessionId:(NSString *)activeSessionId forTrialNumber:(NSString *)trialNumber{
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"";
   
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from SAActiveTrial where SAActiveSessionId=%@ and TrialNumber=%@",activeSessionId,trialNumber];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                               
                
                NSString *p = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                NSString *pP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString *m = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                NSString *mP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                NSString *NR = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                                
                
                if([p isEqualToString:@"1"]){
                    
                    resultArry= @"+";
                }else if([pP isEqualToString:@"1"]){
                    
                    resultArry = @"+P";
                    
                }else if([m isEqualToString:@"1"]){
                    
                    resultArry = @"-";
                }else if([mP isEqualToString:@"1"]){
                    
                    resultArry = @"-P";
                }else if([NR isEqualToString:@"1"]){
                    
                    resultArry = @"NR";
                }
               
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  

    
}


+ (NSString *)getSAOldSessionTrialActiveSessionId:(NSString *)activeSessionId forTrialNumber:(NSString *)trialNumber{
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"";
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from SAActiveTrial where SAActiveSessionId=%@ and TrialNumber=%@",activeSessionId,trialNumber];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                
               resultArry = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                               
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
    
    
}


+ (NSMutableArray *)getITOldSessionDetailsForActiveSessionId:(NSString *)activeSessionId{
    
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry = [[NSMutableArray alloc]init];
    NSMutableDictionary *oldDataDiction;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from ITActiveSession where ITActiveSessionId=%@",activeSessionId];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                if(oldDataDiction) oldDataDiction=nil;
                oldDataDiction=[[NSMutableDictionary alloc]init];
                
                
                
                NSString *IIMPid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString *mstStatusId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                NSString *contectid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                NSString *mstTrialtypeId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *stepid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                
                
                
                NSString *totalp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                
                NSString *totalpP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                NSString *totalm = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];

                NSString *totalNR = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                 NSString *isSummarized = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
                
                
                
                [oldDataDiction setValue:IIMPid forKey:@"IIMPid"];
                [oldDataDiction setValue:mstStatusId forKey:@"mstStatusId"];
                [oldDataDiction setValue:contectid forKey:@"contextid"];
                [oldDataDiction setValue:mstTrialtypeId forKey:@"mstTrialtypeId"];
                [oldDataDiction setValue:stepid forKey:@"stepid"];
                
                [oldDataDiction setValue:totalp forKey:@"totalp"];
                [oldDataDiction setValue:totalpP forKey:@"totalpP"];
                [oldDataDiction setValue:totalm forKey:@"totalm"];
               
                [oldDataDiction setValue:totalNR forKey:@"totalNR"];
                [oldDataDiction setValue:isSummarized forKey:@"isSummarized"];
                
                
                
                [resultArry addObject:oldDataDiction];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
}
+ (NSString *)getITOldSessionTrialOptionForActiveSessionId:(NSString *)activeSessionId forTrialNumber:(NSString *)trialNumber{
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"" ;
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from ITActiveTrial where ITActiveSessionId=%@ and TrialNumber=%@",activeSessionId,trialNumber];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                
                NSString *p = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                
                NSString *pP = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString *m = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
              
                NSString *NR = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                
                
                if([p isEqualToString:@"1"]){
                    
                    resultArry= @"+";
                }else if([pP isEqualToString:@"1"]){
                    
                    resultArry = @"+P";
                    
                }else if([m isEqualToString:@"1"]){
                    
                    resultArry = @"-";
                }else if([NR isEqualToString:@"1"]){
                    
                    resultArry = @"NR";
                }
                
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
    
    
}

+ (NSString *)getITOldSessionTrialActiveSessionId:(NSString *)activeSessionId forTrialNumber:(NSString *)trialNumber{
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"" ;
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from ITActiveTrial where ITActiveSessionId=%@ and TrialNumber=%@",activeSessionId,trialNumber];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                
              resultArry = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                               
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
    
    
}

+ (NSString *)getITContextName:(NSString *)contextID{
    
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"NR" ;
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select NAME from ITContext where ITContextId=%@",contextID];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultArry=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
}
+ (NSMutableArray *)getTAOldSessionDetailsForActiveSessionId:(NSString *)activeSessionId{
    
    
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSMutableArray *resultArry=[[NSMutableArray alloc]init];
    NSMutableDictionary *mydiction;
    
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select * from TAActiveSession where TAActiveSessionId=%@",activeSessionId];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                if(mydiction)mydiction=nil;
                mydiction=[[NSMutableDictionary alloc]init];
                
                NSString *tacuriculumid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                NSString *stepid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                NSString *isSummarized = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
                 NSString *mstPromptID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                
                [mydiction setValue:tacuriculumid forKey:@"tacuriculumid"];
                [mydiction setValue:stepid forKey:@"stepid"];
                [mydiction setValue:isSummarized forKey:@"isSummarized"];
                [mydiction setValue:mstPromptID forKey:@"mstPromptID"];
                
                [resultArry addObject:mydiction];
                
                
                
                                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry; 
}

+ (NSString *)getTATrainingStepName:(NSString *)stepid{
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    NSString *resultArry=@"NR" ;
    
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        
        NSString *sqlString = [NSString stringWithFormat:@"select  [Name] from TAStep where TAStepId=%@",stepid];
        
        
        const char* sqlStatement =[sqlString UTF8String];
        
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                
                
                resultArry=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return resultArry;  
}
//********** Added by Santosh ******** //Inserting Curriculum Data.

+ (int)ACEStudentIdForStudentId:(int)_id
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    int studId = -1;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *sqlString = [NSString stringWithFormat:@"SELECT ACEStudentId from ACEStudent Where StudentId = %d",_id];
        const char* sqlStatement =[sqlString UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                studId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return studId;    
    
}

+ (void)insertIntoStuCurriculumTable:(NSDictionary*)dictionary
{
    //Insert into StuCurriculum
    //ACEStudentId,ActivationId,CurriculumTypeId,CurrentVersionId,LastSyncTime,Name,ObjectiveNo,IsVersionMatch
    
    //UNMAPPED : IsVersionMatch [[dictionary valueForKey:@"IsVersionMatch"] intValue]
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *curriculumName = [[dictionary valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into StuCurriculum (ACEStudentId,ActivationId,CurriculumTypeId,PublishedId,CurrentVersionId,LastSyncTime,Name,ObjectiveNo) values (%d,%d,%d,%d,%d,'%@','%@','%@')",[[dictionary valueForKey:@"ACEStudentId"] intValue],
                               [[dictionary valueForKey:@"ActivationId"] intValue],[[dictionary valueForKey:@"CurriculumTypeId"] intValue],
                               [[dictionary valueForKey:@"PublishedId"] intValue],
                               [[dictionary valueForKey:@"CurrentVersionId"] intValue],[dictionary valueForKey:@"LastSyncTime"],
                               curriculumName,[dictionary valueForKey:@"ObjectiveNo"]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting StuCurriculum  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting StuCurriculum  into table");
        }
        
        insertSql = nil;       
        sqlite3_close(database);
    }
}

+ (int)getTopStuCurriculumId
{
    int stuCurriculumId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT MAX( StuCurriculumId) FROM StuCurriculum"];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                stuCurriculumId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return stuCurriculumId;
}

//IT Curriculum
+ (void)InsertITContext:(NSDictionary*)dictionary
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *name = [[dictionary valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        NSString *title = [[dictionary valueForKey:@"Title"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into ITContext (ACEITContextId,StuCurriculumId,Name,Status,Title) values (%d,%d,'%@',%d,'%@')",[[dictionary valueForKey:@"ACEITContextId"] intValue],
                               [[dictionary valueForKey:@"StuCurriculumId"] intValue],name,
                               [[dictionary valueForKey:@"Status"] intValue],title];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting ITContext  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting ITContext  into table");
        }
        
        insertSql = nil;        
        sqlite3_close(database);
    }
}

+ (void)InsertITPastSession:(NSDictionary*)dictionary
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *MIP = [[dictionary valueForKey:@"MIP"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        
        // ITContextId, WeekEnding, TrialType, Opportunities, MIP, TotalPlus, TotalPlusP, TotalMinus, TotalNR, Order
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into ITPastSession (ITContextId,WeekEnding,TrialType,Opportunities,MIP,TotalPlus,TotalPlusP,TotalMinus,TotalNR,[Order]) values (%d,'%@','%@','%@','%@',%d,%d,%d,%d,%d)",[[dictionary valueForKey:@"ITContextId"] intValue],
                               [dictionary valueForKey:@"WeekEnding"],[dictionary valueForKey:@"TrialType"],
                               [dictionary valueForKey:@"Opportunities"],MIP,
                               [[dictionary valueForKey:@"TotalPlus"] intValue],[[dictionary valueForKey:@"TotalPlusP"] intValue],
                               [[dictionary valueForKey:@"TotalMinus"] intValue],[[dictionary valueForKey:@"TotalNR"] intValue],
                               [[dictionary valueForKey:@"Order"] intValue]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting ITPastSession  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting ITPastSession  into table");
        }
        
        insertSql = nil;  
        sqlite3_close(database);
    }
    
}

+ (void)InsertITMIP:(NSDictionary*)dictionary
{
    //ACEITMIPId,StuCurriculumId,Name
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        // ITContextId, WeekEnding, TrialType, Opportunities, MIP, TotalPlus, TotalPlusP, TotalMinus, TotalNR, Order
        NSString *name = [[dictionary valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into ITMIP (ACEITMIPId,StuCurriculumId,Name) values (%d,%d,'%@')",[[dictionary valueForKey:@"ACEITMIPId"] intValue],
                               [[dictionary valueForKey:@"StuCurriculumId"] intValue],
                               name];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting ITMIP  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting ITMIP  into table");
        }
        
        insertSql = nil;        
        sqlite3_close(database);
    }
    
}

+ (int)getTopITCurriculumContextId
{
    int contextId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT MAX( ITContextId) FROM ITContext"];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                contextId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return contextId;
}

//TA Curriculum

+ (int)getTopTACurriculumId
{
    int curriculumId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT MAX( TACurriculumId) FROM TACurriculum"];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                curriculumId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return curriculumId;
}

//TA Curriculum
+ (void)insertTACurriculum:(NSMutableDictionary*)dictionary
{
    // StuCurriculumId,MstChainingSequenceId
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into TACurriculum (StuCurriculumId,MstChainingSequenceId) values (%d,%d)",[[dictionary valueForKey:@"StuCurriculumId"] intValue],
                               [[dictionary valueForKey:@"MstChainingSequenceId"] intValue]];
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting TACurriculum  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting TACurriculum  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
}

+ (void)insertTAPastSession:(NSMutableDictionary*)dictionary
{
    // TACurriculumid,Date,TrialType,StepIndependent,TrainingStep,PromptStep,Order
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into TAPastSession (TACurriculumid,Date,TrialType,StepIndependent,TrainingStep,PromptStep,[Order]) values (%d,'%@','%@','%@','%@','%@',%d)",[[dictionary valueForKey:@"TACurriculumid"] intValue],
                               [dictionary valueForKey:@"Date"],[dictionary valueForKey:@"TrialType"],
                               [dictionary valueForKey:@"StepIndependent"],
                               [dictionary valueForKey:@"TrainingStep"],
                               [dictionary valueForKey:@"PromptStep"],
                               [[dictionary valueForKey:@"Order"] intValue]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting TAPastSession  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting TAPastSession  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
    
}

+ (void)insertTAPromptStep:(NSMutableDictionary*)dictionary
{
    // TACurriculumId,ACETAPromptStepId,Name
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
         NSString *name = [[dictionary valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into TAPromptStep (TACurriculumId,ACETAPromptStepId,Name) values (%d,%d,'%@')",[[dictionary valueForKey:@"TACurriculumid"] intValue],
                               [[dictionary valueForKey:@"ACETAPromptStepId"] intValue],name];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting TAPromptStep  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting TAPromptStep  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
}

+ (void)insertTAStep:(NSMutableDictionary*)dictionary
{
    //TACurriculumId,ACETAStepId,Name,Description,Order
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *description = [[dictionary valueForKey:@"Description"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
          NSString *name = [[dictionary valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into TAStep (TACurriculumId,ACETAStepId,Name,Description,[Order]) values (%d,%d,'%@','%@',%d)",[[dictionary valueForKey:@"TACurriculumid"] intValue],
                               [[dictionary valueForKey:@"ACETAStepId"] intValue],name,
                               description,[[dictionary valueForKey:@"Order"] intValue]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting TAStep  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting TAStep  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
    
}

//SA Curriculum
+ (int)getSALevelTopId
{
    int topId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT MAX( SALevelId) FROM SALevel"];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                topId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return topId;
}

+ (int)getSASublevelTopId
{
    int topId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT MAX( SASubLevelId) FROM SASubLevel"];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                topId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return topId;
}

+ (void)insertSALevel:(NSMutableDictionary*)dictionary
{
    //ACESALevelId, StuCurriculumId,Name,CurrentVersionId
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *name = [[dictionary valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into SALevel (ACESALevelId, StuCurriculumId,Name,CurrentVersionId,ProcedureId) values (%d,%d,'%@',%d,%d)",[[dictionary valueForKey:@"ACESALevelId"] intValue],
                               [[dictionary valueForKey:@"StuCurriculumId"] intValue],name,
                               [[dictionary valueForKey:@"CurrentVersionId"] intValue],[[dictionary valueForKey:@"ProcedureId"] intValue]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting SALevel  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting SALevel  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
    
}

+ (void)insertSAPastSession:(NSMutableDictionary*)dictionary
{
    //    SAPastSession
    //SASubLevelId,Date,Step,Type,Score,Status,Order
    //Plus,PlusP,Minus,MinusP,NR : New Fields
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into SAPastSession (SASubLevelId,Date,Step,Type,Score,Status,[Order],Plus,PlusP,Minus,MinusP,NR) values (%d,'%@','%@','%@','%@','%@',%d,%d,%d,%d,%d,%d)",[[dictionary valueForKey:@"SASubLevelId"] intValue],[dictionary valueForKey:@"Date"],[dictionary valueForKey:@"Step"],[dictionary valueForKey:@"Type"],[dictionary valueForKey:@"Score"],[dictionary valueForKey:@"Status"],
                               [[dictionary valueForKey:@"Order"] intValue],[[dictionary valueForKey:@"Plus"] intValue],[[dictionary valueForKey:@"PlusP"] intValue],[[dictionary valueForKey:@"Minus"] intValue],[[dictionary valueForKey:@"MinusP"] intValue],[[dictionary valueForKey:@"NR"] intValue]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting SAPastSession  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting SAPastSession  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
    
}

+ (void)insertSASubLevel:(NSMutableDictionary*)dictionary
{
    //SASubLevel
    //SALevelId,ACESASubLevelid,Name,Skill
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
          NSString *name = [[dictionary valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        NSString *skill = [[dictionary valueForKey:@"Skill"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into SASubLevel (SALevelId,ACESASubLevelid,Name,Skill) values (%d,%d,'%@','%@')",[[dictionary valueForKey:@"SALevelId"] intValue],
                               [[dictionary valueForKey:@"ACESASubLevelid"] intValue],name,
                               skill];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting SASubLevel  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting SASubLevel  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
    
}

+ (void)insertSASteps:(NSMutableDictionary*)dictionary
{
    //SAStep
    //ACESAStepId,SALevelId,Name
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *name = [[dictionary valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into SAStep (ACESAStepId,SALevelId,Name) values (%d,%d,'%@')",[[dictionary valueForKey:@"ACESAStepId"] intValue],
                               [[dictionary valueForKey:@"SALevelId"] intValue],name];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting ACESAStepId  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting ACESAStepId  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
}


//Master Data Entry
+ (void)enterMstChainingSequence:(NSDictionary*)dictionary
{
    //MstChainingSequence
    //MstChainingSequenceId,Name
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into MstChainingSequence (MstChainingSequenceId,Name) values (%d,'%@')",[[dictionary valueForKey:@"MstChainingSequenceId"] intValue],
                               [dictionary valueForKey:@"Name"]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting MstChainingSequence  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting MstChainingSequence  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
}

+ (void)enterMstCurriculumType:(NSDictionary*)dictionary
{
    //MstCurriculumType
    //MstCurriculumTypeId,Name
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into MstCurriculumType (MstCurriculumTypeId,Name) values (%d,'%@')",[[dictionary valueForKey:@"MstCurriculumTypeId"] intValue],
                               [dictionary valueForKey:@"Name"]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting MstCurriculumType  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting MstCurriculumType  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
}

+ (void)enterMstStatus:(NSDictionary*)dictionary
{
    //MstStatus
    //MstStatusId,Name
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into MstStatus (MstStatusId,Name) values (%d,'%@')",[[dictionary valueForKey:@"MstStatusId"] intValue],
                               [dictionary valueForKey:@"Name"]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting MstStatusId  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting MstStatusId  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
}

+ (void)enterMstSetting:(NSDictionary*)dictionary
{
    //MstSetting
    //MstSettingId,Name,DisplayOrder
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert Or Replace into MstSetting (MstSettingId,Name,DisplayOrder) values (%d,'%@',%d)",[[dictionary valueForKey:@"MstSettingId"] intValue],
                               [dictionary valueForKey:@"Name"],[[dictionary valueForKey:@"DisplayOrder"] intValue]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting MstSetting  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting MstSetting  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
    
}

+ (void)enterMstTrialType:(NSDictionary*)dictionary
{
    //MstTrialType
    //MstTrialTypeId,Name
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into MstTrialType (MstTrialTypeId,Name) values (%d,'%@')",[[dictionary valueForKey:@"MstTrialTypeId"] intValue],
                               [dictionary valueForKey:@"Name"]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting MstTrialTypeId  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting MstTrialTypeId  into table");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
}

+ (NSArray*)getActiveStudentSessionDetailWithStuCurriculumId:(int)stuId
{
    //ActiveStudentSession
    //ActiveStudentSessionId,StuCurriculumId,IsDirty,LastSyncTime
    
    NSMutableArray *sessions = [[NSMutableArray alloc] init];
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId,StuCurriculumId,IsDirty,LastSyncTime FROM ActiveStudentSession WHERE StuCurriculumId = %d",stuId];
        
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                
                NSMutableDictionary *activeStudentSession = [[NSMutableDictionary alloc] init];
                //Read all values and store in the sessionDict.
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                                        forKey:@"ActiveStudentSessionId"];
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                                        forKey:@"StuCurriculumId"];
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                                        forKey:@"IsDirty"];
                
                char *activeTrials = (char *)sqlite3_column_text(getActiveTrials, 3);
                if (NULL != activeTrials) {
                    [activeStudentSession setValue:[NSString stringWithUTF8String:activeTrials]
                                            forKey:@"LastSyncTime"];
                }else{
                    [activeStudentSession setValue:@""
                                            forKey:@"LastSyncTime"];
                }
                
                [sessions addObject:activeStudentSession];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return sessions;
}

+ (NSDictionary*)getActiveStudentSessionDetailWithActiveStudentSessionId:(int)actID
{
    //ActiveStudentSession
    //ActiveStudentSessionId,StuCurriculumId,IsDirty,LastSyncTime
    
    NSMutableDictionary *activeStudentSession = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId,StuCurriculumId,IsDirty,LastSyncTime FROM ActiveStudentSession WHERE ActiveStudentSessionId = %d",actID];
        
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                //Read all values and store in the sessionDict.
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                                        forKey:@"ActiveStudentSessionId"];
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                                        forKey:@"StuCurriculumId"];
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                                        forKey:@"IsDirty"];
                
                char *activeTrials = (char *)sqlite3_column_text(getActiveTrials, 3);
                if (NULL != activeTrials) {
                    [activeStudentSession setValue:[NSString stringWithUTF8String:activeTrials]
                                            forKey:@"LastSyncTime"];
                }else{
                    [activeStudentSession setValue:@""
                                            forKey:@"LastSyncTime"];
                }
                
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return activeStudentSession;
}

//Active Students
+ (NSArray*)getListOfAllActiveStudentSession
{
    //ActiveStudentSession
    //ActiveStudentSessionId,StuCurriculumId,IsDirty,LastSyncTime
    
    NSMutableArray *activeStudentSessions = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId,StuCurriculumId,IsDirty,LastSyncTime FROM ActiveStudentSession WHERE IsDirty = 'true'"];
        
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *StudentsessionDict = [[NSMutableDictionary alloc] init];
                //Read all values and store in the sessionDict.
                [StudentsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                                      forKey:@"ActiveStudentSessionId"];
                [StudentsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                                      forKey:@"StuCurriculumId"];
                [StudentsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                                      forKey:@"IsDirty"];
                
                char *activeTrials = (char *)sqlite3_column_text(getActiveTrials, 3);
                if (NULL != activeTrials) {
                    [StudentsessionDict setValue:[NSString stringWithUTF8String:activeTrials]
                                          forKey:@"LastSyncTime"];
                }else{
                    [StudentsessionDict setValue:@""
                                          forKey:@"LastSyncTime"];
                }
                
                [activeStudentSessions addObject:StudentsessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return activeStudentSessions;
}

+ (NSDictionary*)getDetailsOfStudentWithStudentId:(int)studId
{   
    //ACEStudent
    //ACEStudentId,ACEUserId,StudentId,Name,SchoolName,TeamName,LastSyncTime
    
    NSMutableDictionary *student = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ACEStudentId,ACEUserId,StudentId,Name,SchoolName,TeamName,LastSyncTime,Quarter FROM ACEStudent WHERE StudentId = %d",studId];
        
        sqlite3_stmt *getStud;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getStud, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getStud)) {
                
                //Read all values and store in the sessionDict.
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 0)]
                           forKey:@"ACEStudentId"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 1)]
                           forKey:@"ACEUserId"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 2)]
                           forKey:@"StudentId"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 3)]
                           forKey:@"Name"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 4)]
                           forKey:@"SchoolName"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 5)]
                           forKey:@"TeamName"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 6)]
                           forKey:@"LastSyncTime"];
                
                char *quarter = (char *)sqlite3_column_text(getStud, 7);
                if (NULL != quarter) {
                    [student setValue:[NSString stringWithUTF8String:quarter]
                               forKey:@"Quarter"];
                }else{
                    [student setValue:@""
                               forKey:@"Quarter"];
                }
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getStud);
        sqlite3_close(database);
    }
    
    return student;
    
}

+ (NSDictionary*)getDetailsOfStudentWithACEStudentId:(int)aceStudId
{
    //ACEStudent
    //ACEStudentId,ACEUserId,StudentId,Name,SchoolName,TeamName,LastSyncTime
    
    NSMutableDictionary *student = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ACEStudentId,ACEUserId,StudentId,Name,SchoolName,TeamName,LastSyncTime,Quarter FROM ACEStudent WHERE ACEStudentId = %d",aceStudId];
        
        sqlite3_stmt *getStud;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getStud, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getStud)) {
                
                //Read all values and store in the sessionDict.
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 0)]
                           forKey:@"ACEStudentId"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 1)]
                           forKey:@"ACEUserId"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 2)]
                           forKey:@"StudentId"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 3)]
                           forKey:@"Name"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 4)]
                           forKey:@"SchoolName"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 5)]
                           forKey:@"TeamName"];
                [student setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStud, 6)]
                           forKey:@"LastSyncTime"];
                
                char *quarter = (char *)sqlite3_column_text(getStud, 7);
                if (NULL != quarter) {
                    [student setValue:[NSString stringWithUTF8String:quarter]
                               forKey:@"Quarter"];
                }else{
                    [student setValue:@""
                               forKey:@"Quarter"];
                }
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getStud);
        sqlite3_close(database);
    }
    
    return student;
    
}

//SA Queries
//SA Curriculum Retireval

+ (NSMutableArray*)getSAActiveSessionForActiveStudentID:(int)activeSessionId
{
    //SAActiveSession
    //SAActiveSessionId,ActiveStudentSessionId,MstSettingId,MstStatusId,SASubLevelId,MstTrialTypeId,StepId,TotalPlus,TotalPlusP,TotalMinus,TotalMinusP,TotalNR,Date,Staff,Order,IsSummarized,IsFinished,IsEmailEnabled
    NSMutableArray *activeSASessions = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT SAActiveSessionId,ActiveStudentSessionId,MstSettingId,MstStatusId,SASubLevelId,MstTrialTypeId,StepId,TotalPlus,TotalPlusP,TotalMinus,TotalMinusP,TotalNR,Date,Staff,[Order],IsSummarized,IsFinished,IsEmailEnabled FROM SAActiveSession WHERE ActiveStudentSessionId = %d and IsFinished = 'true' ",activeSessionId];
        
        sqlite3_stmt *getActiveSASession;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveSASession, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveSASession)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                //Read all values and form the trial Dict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 0)]
                               forKey:@"SAActiveSessionId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 1)]
                               forKey:@"ActiveStudentSessionId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 2)]
                               forKey:@"MstSettingId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 3)]
                               forKey:@"MstStatusId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 4)]
                               forKey:@"SASubLevelId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 5)]
                               forKey:@"MstTrialTypeId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 6)]
                               forKey:@"StepId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 7)]
                               forKey:@"TotalPlus"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 8)]
                               forKey:@"TotalPlusP"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 9)]
                               forKey:@"TotalMinus"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 10)]
                               forKey:@"TotalMinusP"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 11)]
                               forKey:@"TotalNR"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 12)]
                               forKey:@"Date"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 13)]
                               forKey:@"Staff"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 14)]
                               forKey:@"Order"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 15)]
                               forKey:@"IsSummarized"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 16)]
                               forKey:@"IsFinished"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveSASession, 17)]
                               forKey:@"IsEmailEnabled"];
                
                [activeSASessions addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveSASession);
        sqlite3_close(database);
    }
    
    return activeSASessions;
}


+ (NSMutableArray*)getSAActiveTrialsForActiveSessionID:(int)activeSessionId
{
    //SAActiveTrial
    // SAActiveTrialId,SAActiveSessionId,TrialNumber,Plus,PlusP,Minus,MinusP,NR
    
    NSMutableArray *activeSATrials = [[NSMutableArray alloc] init];
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT SAActiveTrialId,SAActiveSessionId,TrialNumber,Plus,PlusP,Minus,MinusP,NR FROM SAActiveTrial WHERE SAActiveSessionId = %d",activeSessionId];
        
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *SAsessionDict = [[NSMutableDictionary alloc] init];
                //Read all values and store in the sessionDict.
                [SAsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                                 forKey:@"SAActiveTrialId"];
                [SAsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                                 forKey:@"SAActiveSessionId"];
                [SAsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                                 forKey:@"TrialNumber"];
                [SAsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 3)]
                                 forKey:@"Plus"];
                [SAsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 4)]
                                 forKey:@"PlusP"];
                [SAsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 5)]
                                 forKey:@"Minus"];
                [SAsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 6)]
                                 forKey:@"MinusP"];
                [SAsessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 7)]
                                 forKey:@"NR"];
                [activeSATrials addObject:SAsessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return activeSATrials;
}

//SA Queries End

//TA Queries Start 

+ (NSMutableArray*)getTAActiveSessionForActiveStudentSessionId:(int)sessionId
{
    // TAActiveSession
    //TAActiveSessionId,ActiveStudentSessionId,TACurriculumId,MstTrialTypeId,TATrainingStepId,MstPromptStepId,Staff,TAStepIndependentId,
    //MstSetttingId,MstStatusId,NoOfTrials,Date,Order,IsSummarized,IsFinished,IsEmailEnabled
    
    NSMutableArray *activeTASessions = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT TAActiveSessionId,ActiveStudentSessionId,TACurriculumId,MstTrialTypeId,TATrainingStepId,MstPromptStepId,Staff,TAStepIndependentId,MstSetttingId,MstStatusId,NoOfTrials,Date,[Order],IsSummarized,IsFinished,IsEmailEnabled FROM TAActiveSession WHERE ActiveStudentSessionId = %d and IsFinished = 'true' ",sessionId];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"TAActiveSessionId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                               forKey:@"ActiveStudentSessionId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                               forKey:@"TACurriculumId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 3)]
                               forKey:@"MstTrialTypeId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 4)]
                               forKey:@"TATrainingStepId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 5)]
                               forKey:@"MstPromptStepId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 6)]
                               forKey:@"Staff"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 7)]
                               forKey:@"TAStepIndependentId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 8)]
                               forKey:@"MstSetttingId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 9)]
                               forKey:@"MstStatusId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 10)]
                               forKey:@"NoOfTrials"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 11)]
                               forKey:@"Date"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 12)]
                               forKey:@"Order"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 13)]
                               forKey:@"IsSummarized"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 14)]
                               forKey:@"IsFinished"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 15)]
                               forKey:@"IsEmailEnabled"];
                
                [activeTASessions addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return activeTASessions;
}

+ (NSMutableArray*)getTAActiveTrialForTAActiveSessionId:(int)sessionId
{
    // TAActiveTrial
    //TAActiveTrialId,TAActiveSessionId,TAStepId,TAPromptStepId
    
    NSMutableArray *TAActiveTrial = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT TAActiveTrialId,TAActiveSessionId,TAStepId,TAPromptStepId FROM TAActiveTrial WHERE TAActiveSessionId = %d",sessionId];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"TAActiveTrialId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                               forKey:@"TAActiveSessionId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                               forKey:@"TAStepId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 3)]
                               forKey:@"TAPromptStepId"];
                
                [TAActiveTrial addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return TAActiveTrial;
    
}

+ (NSMutableDictionary*)getTACurriculumWithStuCurriculumId:(int)stuCurriculumId
{
    //TACurriculum
    //TACurriculumId,StuCurriculumId,MstChainingSequenceId
    
    NSMutableDictionary *TACurriculum = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT TACurriculumId,StuCurriculumId,MstChainingSequenceId FROM TACurriculum WHERE stuCurriculumId = %d",stuCurriculumId];
        
        sqlite3_stmt *getTACurriculum;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getTACurriculum, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getTACurriculum)) {
                
                //Read all values.
                [TACurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getTACurriculum, 0)]
                                forKey:@"TACurriculumId"];
                [TACurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getTACurriculum, 1)]
                                forKey:@"StuCurriculumId"];
                [TACurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getTACurriculum, 2)]
                                forKey:@"MstChainingSequenceId"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getTACurriculum);
        sqlite3_close(database);
        
    }
    
    return TACurriculum;
}

+ (NSMutableDictionary*)getMstChainingSequenceWithMstChainingSequenceId:(int)seqId
{
    //MstChainingSequence
    //MstChainingSequenceId,Name
    
    NSMutableDictionary *ChaningSeq = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT MstChainingSequenceId,Name FROM MstChainingSequence WHERE MstChainingSequenceId = %d",seqId];
        
        sqlite3_stmt *getChainingSeq;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getChainingSeq, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getChainingSeq)) {
                
                //Read all values.
                [ChaningSeq setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getChainingSeq, 0)]
                              forKey:@"TACurriculumId"];
                [ChaningSeq setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getChainingSeq, 1)]
                              forKey:@"StuCurriculumId"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getChainingSeq);
        sqlite3_close(database);
        
    }
    
    return ChaningSeq;
    
}

//TA Queries End

//IT Queries Start

+ (NSMutableDictionary*)getITMIPDetailsWithITMIPID:(int)imipID
{
    //ITMIP
    //ITMIPId,ACEITMIPId,StuCurriculumId,Name
    
    NSMutableDictionary *itmip = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ITMIPId,ACEITMIPId,StuCurriculumId,Name FROM ITMIP WHERE ITMIPId = %d",imipID];
        
        sqlite3_stmt *getITMIPID;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getITMIPID, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getITMIPID)) {
                
                //Read all values and store in the sessionDict.
                [itmip setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getITMIPID, 0)]
                         forKey:@"ITMIPId"];
                [itmip setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getITMIPID, 1)]
                         forKey:@"ACEITMIPId"];
                [itmip setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getITMIPID, 2)]
                         forKey:@"StuCurriculumId"];
                [itmip setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getITMIPID, 3)]
                         forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getITMIPID);
        sqlite3_close(database);
    }
    
    return itmip;
    
}

+ (NSMutableArray*)getITActiveSessionWithActiveStudentSessionId:(int)activeStudentId
{
    //   ITActiveSession
    //ITActiveSessionId,ActiveStudentSessionId,MstTrialTypeId,ITContextId,ITMIPId,MstStatusId,StepId,TotalPlus,TotalPlusP,
    //TotalMinus,TotalNR,Staff,WeekEndingDate,Date,Order,IsSummarized,IsFinished,IsEmailEnabled
    NSMutableArray *ITActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ITActiveSessionId,ActiveStudentSessionId,MstTrialTypeId,ITContextId,ITMIPId,MstStatusId,StepId,TotalPlus,TotalPlusP,TotalMinus,TotalNR,Staff,WeekEndingDate,Date,[Order],IsSummarized,IsFinished,IsEmailEnabled FROM ITActiveSession WHERE ActiveStudentSessionId = %d and IsFinished = 'true' ",activeStudentId];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ITActiveSessionId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                               forKey:@"ActiveStudentSessionId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                               forKey:@"MstTrialTypeId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 3)]
                               forKey:@"ITContextId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 4)]
                               forKey:@"ITMIPId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 5)]
                               forKey:@"MstStatusId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 6)]
                               forKey:@"StepId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 7)]
                               forKey:@"TotalPlus"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 8)]
                               forKey:@"TotalPlusP"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 9)]
                               forKey:@"TotalMinus"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 10)]
                               forKey:@"TotalNR"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 11)]
                               forKey:@"Staff"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 12)]
                               forKey:@"WeekEndingDate"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 13)]
                               forKey:@"Date"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 14)]
                               forKey:@"Order"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 15)]
                               forKey:@"IsSummarized"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 16)]
                               forKey:@"IsFinished"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 17)]
                               forKey:@"IsEmailEnabled"];
                
                
                [ITActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return ITActiveSession;
    
}

+ (NSMutableArray*)getITActiveTrialWithActiveITActiveSessionId:(int)activeSessionId
{
    //ITActiveTrial
    //ITActiveTrialId,ITActiveSessionId,TrialNumber,Plus,PlusP,Minus,NR
    
    NSMutableArray *ITActiveTrial = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ITActiveTrialId,ITActiveSessionId,TrialNumber,Plus,PlusP,Minus,NR FROM ITActiveTrial WHERE ITActiveSessionId = %d",activeSessionId];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ITActiveTrialId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                               forKey:@"ITActiveSessionId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                               forKey:@"TrialNumber"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 3)]
                               forKey:@"Plus"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 4)]
                               forKey:@"PlusP"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 5)]
                               forKey:@"Minus"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 6)]
                               forKey:@"NR"];
                
                [ITActiveTrial addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return ITActiveTrial;
}
//IT Queries End
//Retrievel Queries end.

//StuCurriculum retirevel methods
+ (NSDictionary*)getStuCurriculumDetailsForCurriculumWithStuCurriculumId:(int)StuCurriculumId
{
    // StuCurriculum
    //StuCurriculumId,ACEStudentId,ActivationId,CurriculumTypeId,CurrentVersionId,LastSyncTime,
    //Name,ObjectiveNo,IsVersionMatch
    
    NSMutableDictionary *stuCurriculum = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT StuCurriculumId,ACEStudentId,ActivationId,PublishedId,CurriculumTypeId,CurrentVersionId,LastSyncTime,Name,ObjectiveNo,IsVersionMatch,Quarter FROM StuCurriculum WHERE StuCurriculumId = %d",StuCurriculumId];
        sqlite3_stmt *getStuCurriculum;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getStuCurriculum, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getStuCurriculum)) {
                //Read all values.
                [stuCurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 0)]
                                 forKey:@"StuCurriculumId"];
                [stuCurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 1)]
                                 forKey:@"ACEStudentId"];
                [stuCurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 2)]
                                 forKey:@"ActivationId"];
                
                char *publishId = (char *)sqlite3_column_text(getStuCurriculum, 3);
                if (NULL != publishId) {
                    [stuCurriculum setValue:[NSString stringWithUTF8String:publishId]
                                     forKey:@"PublishedId"];
                }else{
                    [stuCurriculum setValue:@""
                                     forKey:@"PublishedId"];
                }
                
                [stuCurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 4)]
                                 forKey:@"CurriculumTypeId"];
                
                char *versionId = (char *)sqlite3_column_text(getStuCurriculum, 5);
                if (NULL != versionId) {
                    [stuCurriculum setValue:[NSString stringWithUTF8String:versionId]
                                     forKey:@"CurrentVersionId"];
                }else{
                    [stuCurriculum setValue:@""
                                     forKey:@"CurrentVersionId"];
                }
                
                [stuCurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 6)]
                                 forKey:@"LastSyncTime"];
                [stuCurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 7)]
                                 forKey:@"Name"];
                [stuCurriculum setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 8)]
                                 forKey:@"ObjectiveNo"];
                
                char *versionMatch = (char *)sqlite3_column_text(getStuCurriculum, 9);
                if (NULL != versionMatch) {
                    [stuCurriculum setValue:[NSString stringWithUTF8String:versionMatch]
                                     forKey:@"IsVersionMatch"];
                }else{
                    [stuCurriculum setValue:@""
                                     forKey:@"IsVersionMatch"];
                }
                
                char *quarter = (char *)sqlite3_column_text(getStuCurriculum, 10);
                if (NULL != quarter) {
                    [stuCurriculum setValue:[NSString stringWithUTF8String:quarter]
                                     forKey:@"Quarter"];
                }else{
                    [stuCurriculum setValue:@""
                                     forKey:@"Quarter"];
                }
                
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getStuCurriculum);
        sqlite3_close(database);
    }
    
    return stuCurriculum;
}

//Sync Table Insertion/Deletion/Query
+ (void)insertIntoSyncTable:(NSMutableDictionary*)dictionary
{
    // SyncTable
    //SyncTableId,SyncKey,SyncData,Retries
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *insertSql = [[NSString alloc] initWithFormat:@"Insert into SyncTable (SyncKey,SyncData,Retries) values ('%@','%@',%d)",[dictionary valueForKey:@"SyncKey"],[dictionary valueForKey:@"SyncData"],[[dictionary valueForKey:@"SyncData"] intValue]];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [insertSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){
            NSLog(@"Error Occured while inserting SyncTableId  into table Reason: %s",error_msg);
        }else{
            NSLog(@"inserting Syn info  into SyncTableId");
        }
        
        insertSql = nil;
        sqlite3_close(database);
    }
}

+ (NSMutableArray*)getAllUnsyncedSessionDetails
{
    // SyncTable
    //SyncTableId,SyncKey,SyncData,Retries
    
    NSMutableArray *unSyncedSessions = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT SyncTableId,SyncKey,SyncData,Retries FROM SyncTable"];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"SyncTableId"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                               forKey:@"SyncKey"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                               forKey:@"SyncData"];
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 3)]
                               forKey:@"Retries"];
                
                [unSyncedSessions addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return unSyncedSessions;
}

+ (void)deleteSyncInfoWithSyncKey:(NSString*)syncKey
{
    // SyncTable
    //SyncTableId,SyncKey,SyncData,Retries
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From SyncTable where SyncKey = '%@'",syncKey];
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Delete from Table SyncTable");
        }else{
            NSLog(@"Error occured while deleting from Sync table: %s and nErrorCode = %d",error_msg,nErrorCode);;
        }
        
        sqlite3_close(database);
    }
}

//Settings Retireval
+ (NSDictionary*)getMstSettingForMstSettingsId:(int)settingsId
{
    //MstSetting
    //MstSettingId,Name
    NSMutableDictionary *MstSettings = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT MstSettingId,Name FROM MstSetting WHERE MstSettingId = %d",settingsId];
        sqlite3_stmt *mstSettings;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&mstSettings, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(mstSettings)) {
                //Read all values.
                [MstSettings setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(mstSettings, 0)]
                               forKey:@"MstSettingId"];
                [MstSettings setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(mstSettings, 1)]
                               forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(mstSettings);
        sqlite3_close(database);
    }
    
    return MstSettings;
}

+ (NSDictionary*)getMstCurriculumTypeForCurriculumId:(int)crclmId
{
    //MstCurriculumType
    //MstCurriculumTypeId,Name
    NSMutableDictionary *MstSettings = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT MstCurriculumTypeId,Name FROM MstCurriculumType WHERE MstCurriculumTypeId = %d",crclmId];
        sqlite3_stmt *mstSettings;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&mstSettings, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(mstSettings)) {
                //Read all values.
                [MstSettings setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(mstSettings, 0)]
                               forKey:@"MstCurriculumTypeId"];
                [MstSettings setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(mstSettings, 1)]
                               forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(mstSettings);
        sqlite3_close(database);
    }
    
    return MstSettings;
    
}

+ (NSDictionary*)getMstStatusForMstStatusId:(int)statusId
{
    //MstStatus
    //MstStatusId,Name
    NSMutableDictionary *MstStatus = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT MstStatusId,Name FROM MstStatus WHERE MstStatusId = %d",statusId];
        sqlite3_stmt *mstStatus;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&mstStatus, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(mstStatus)) {
                //Read all values.
                [MstStatus setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(mstStatus, 0)]
                             forKey:@"MstStatusId"];
                [MstStatus setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(mstStatus, 1)]
                             forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(mstStatus);
        sqlite3_close(database);
    }
    
    return MstStatus;
}

+ (NSDictionary*)getMstTrialTypeForMstTrialTypeId:(int)trialId
{
    //MstTrialType
    //MstTrialTypeId,Name
    NSMutableDictionary *MstTrial = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT MstTrialTypeId,Name FROM MstTrialType WHERE MstTrialTypeId = %d",trialId];
        sqlite3_stmt *mstTrial;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&mstTrial, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(mstTrial)) {
                //Read all values.
                [MstTrial setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(mstTrial, 0)]
                            forKey:@"MstTrialTypeId"];
                [MstTrial setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(mstTrial, 1)]
                            forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(mstTrial);
        sqlite3_close(database);
    }
    
    return MstTrial;
}

+ (NSDictionary*)getSASubLevelForSubLevelId:(int)subLevelId
{
    //SASubLevel
    //SASubLevelId,SALevelId,ACESASubLevelid,Name,Skill
    
    NSMutableDictionary *subLevelDict = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT SASubLevelId,SALevelId,ACESASubLevelid,Name,Skill FROM SASubLevel WHERE SASubLevelId = %d",subLevelId];
        sqlite3_stmt *subLevel;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&subLevel, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(subLevel)) {
                //Read all values.
                [subLevelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(subLevel, 0)]
                                forKey:@"SASubLevelId"];
                [subLevelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(subLevel, 1)]
                                forKey:@"SALevelId"];
                [subLevelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(subLevel, 2)]
                                forKey:@"ACESASubLevelid"];
                [subLevelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(subLevel, 3)]
                                forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(subLevel);
        sqlite3_close(database);
    }
    
    return subLevelDict;
}

+ (NSDictionary*)getSALevelForLevelID:(int)levelId
{
    //SALevel
    //SALevelId,ACESALevelId,StuCurriculumId,Name,CurrentVersionId,ProcedureId
    
    NSMutableDictionary *levelDict = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT SALevelId,ACESALevelId,StuCurriculumId,Name,CurrentVersionId,ProcedureId FROM SALevel WHERE SALevelId = %d",levelId];
        sqlite3_stmt *level;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&level, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(level)) {
                //Read all values.
                [levelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(level, 0)]
                             forKey:@"SALevelId"];
                [levelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(level, 1)]
                             forKey:@"ACESALevelId"];
                [levelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(level, 2)]
                             forKey:@"StuCurriculumId"];
                [levelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(level, 3)]
                             forKey:@"Name"];
                [levelDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(level, 4)]
                             forKey:@"CurrentVersionId"];
                
                char *ProcedureId = (char *)sqlite3_column_text(level, 5);
                
                if (NULL != ProcedureId) {
                    [levelDict setValue:[NSString stringWithUTF8String:ProcedureId]
                                 forKey:@"ProcedureId"];
                }else{
                    [levelDict setValue:@""
                                 forKey:@"ProcedureId"];
                }
                
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(level);
        sqlite3_close(database);
    }
    
    return levelDict;
    
}

+ (NSDictionary*)getSAStepForStepId:(int)stepId
{
    //SAStep
    //SAStepId,ACESAStepId,SALevelId,Name
    
    NSMutableDictionary *stepDict = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT SAStepId,ACESAStepId,SALevelId,Name FROM SAStep WHERE SAStepId = %d",stepId];
        sqlite3_stmt *step;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&step, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(step)) {
                //Read all values.
                [stepDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(step, 0)]
                            forKey:@"SAStepId"];
                [stepDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(step, 1)]
                            forKey:@"ACESAStepId"];
                [stepDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(step, 2)]
                            forKey:@"SALevelId"];
                [stepDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(step, 3)]
                            forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(step);
        sqlite3_close(database);
    }
    
    return stepDict;
}

//TA Prompt Steps

+ (NSMutableDictionary*)getTAPromptStepForACETAPromptStepId:(int)stepId
{
    //TAPromptStep
    // TAPromptStepId,TACurriculumId,ACETAPromptStepId,Name
    
    NSMutableDictionary *promptDict = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT TAPromptStepId,TACurriculumId,ACETAPromptStepId,Name FROM TAPromptStep WHERE ACETAPromptStepId = %d",stepId];
        sqlite3_stmt *prmptStep;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&prmptStep, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(prmptStep)) {
                //Read all values.
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 0)]
                              forKey:@"TAPromptStepId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 1)]
                              forKey:@"TACurriculumId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 2)]
                              forKey:@"ACETAPromptStepId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 3)]
                              forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(prmptStep);
        sqlite3_close(database);
    }
    
    return promptDict;
    
}

+ (NSMutableDictionary*)getTAPromptStepForTAPromptStepId:(int)stepId
{
    //TAPromptStep
    // TAPromptStepId,TACurriculumId,ACETAPromptStepId,Name
    
    NSMutableDictionary *promptDict = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT TAPromptStepId,TACurriculumId,ACETAPromptStepId,Name FROM TAPromptStep WHERE TAPromptStepId = %d",stepId];
        sqlite3_stmt *prmptStep;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&prmptStep, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(prmptStep)) {
                //Read all values.
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 0)]
                              forKey:@"TAPromptStepId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 1)]
                              forKey:@"TACurriculumId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 2)]
                              forKey:@"ACETAPromptStepId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 3)]
                              forKey:@"Name"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(prmptStep);
        sqlite3_close(database);
    }
    
    return promptDict;
}

+ (NSMutableDictionary*)getTaStepForACEStepId:(int)stepId
{
    //TAStep
    //TAStepId,TACurriculumId,ACETAStepId,Name,Description,Order
    
    NSMutableDictionary *promptDict = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT TAStepId,TACurriculumId,ACETAStepId,Name,Description,[Order] FROM TAStep WHERE ACETAStepId = %d",stepId];
        sqlite3_stmt *prmptStep;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&prmptStep, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(prmptStep)) {
                //Read all values.
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 0)]
                              forKey:@"TAStepId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 1)]
                              forKey:@"TACurriculumId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 2)]
                              forKey:@"ACETAStepId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 3)]
                              forKey:@"Name"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 4)]
                              forKey:@"Description"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 5)]
                              forKey:@"Order"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(prmptStep);
        sqlite3_close(database);
    }
    
    return promptDict;
}

+ (NSMutableDictionary*)getTAStepForStepId:(int)stepId
{
    //TAStep
    //TAStepId,TACurriculumId,ACETAStepId,Name,Description,Order
    
    NSMutableDictionary *promptDict = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT TAStepId,TACurriculumId,ACETAStepId,Name,Description,[Order] FROM TAStep WHERE TAStepId = %d",stepId];
        sqlite3_stmt *prmptStep;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&prmptStep, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(prmptStep)) {
                //Read all values.
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 0)]
                              forKey:@"TAStepId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 1)]
                              forKey:@"TACurriculumId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 2)]
                              forKey:@"ACETAStepId"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 3)]
                              forKey:@"Name"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 4)]
                              forKey:@"Description"];
                [promptDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 5)]
                              forKey:@"Order"];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(prmptStep);
        sqlite3_close(database);
    }
    
    return promptDict;
}

+ (NSMutableDictionary*)getITContenxtInfoWithITContextId:(int)contextId
{
    //ITContext
    //ITContextId,ACEITContextId,StuCurriculumId,Name,Status
    
    NSMutableDictionary *contextDict = [[NSMutableDictionary alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ITContextId,ACEITContextId,StuCurriculumId,Name,Status FROM ITContext WHERE ITContextId = %d",contextId];
        sqlite3_stmt *prmptStep;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&prmptStep, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(prmptStep)) {
                //Read all values.
                [contextDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 0)]
                               forKey:@"ITContextId"];
                [contextDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 1)]
                               forKey:@"ACEITContextId"];
                [contextDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 2)]
                               forKey:@"StuCurriculumId"];
                [contextDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 3)]
                               forKey:@"Name"];
                [contextDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(prmptStep, 4)]
                               forKey:@"Status"];
                
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(prmptStep);
        sqlite3_close(database);
    }
    
    return contextDict;
}

//User Details
+ (NSDictionary*)getUserDetailsForUserWithId:(int)uid
{
    //ACEUser
    //ACEUserId,UserId,SessionId,LoginTime,LastSyncTime,IsLoggedOut
    
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ACEUserId,UserId,SessionId,LoginTime,LastSyncTime,IsLoggedOut  FROM ACEUser WHERE UserId = %d",uid];
        sqlite3_stmt *userQuery;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&userQuery, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(userQuery)) {
                
                //Read all values.
                [userDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(userQuery, 0)]
                            forKey:@"ACEUserId"];
                [userDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(userQuery, 1)]
                            forKey:@"UserId"];
                [userDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(userQuery, 2)]
                            forKey:@"SessionId"];
                [userDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(userQuery, 3)]
                            forKey:@"Name"];
                [userDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(userQuery, 4)]
                            forKey:@"LoginTime"];
                [userDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(userQuery, 5)]
                            forKey:@"LastSyncTime"];
                [userDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(userQuery, 6)]
                            forKey:@"IsLoggedOut"];
                
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(userQuery);
        sqlite3_close(database);
    }
    
    return userDict;
}

//Delete Commands
+ (void)DeleteActiveStudentSessionWithActiveSessionId:(int)actStudentSessionId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From ActiveStudentSession WHERE ActiveStudentSessionId = %d",actStudentSessionId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from ActiveStudentSession Table");
        }else{
            NSLog(@"Error occured while deleting from ActiveStudentSession table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

+ (void)DeleteITActiveSessionWithActiveStudentSessionId:(int)studSessionId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From ITActiveSession WHERE ActiveStudentSessionId = %d",studSessionId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from ITActiveSession Table");
        }else{
            NSLog(@"Error occured while deleting from ITActiveSession table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

+ (void)DeleteITActiveTrialWithITActiveSessionId:(int)actvSessionId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From ITActiveTrial WHERE ITActiveSessionId = %d",actvSessionId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from ITActiveTrial Table");
        }else{
            NSLog(@"Error occured while deleting from ITActiveTrial table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

+ (void)DeleteSAActiveSessionWithActiveStudentSessionId:(int)sctStdnSessionId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From SAActiveSession WHERE ActiveStudentSessionId = %d",sctStdnSessionId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from SAActiveSession Table");
        }else{
            NSLog(@"Error occured while deleting from SAActiveSession table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

+ (void)DeleteSAActiveTrialWithSAActiveSessionId:(int)saActiveSessionId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From SAActiveTrial WHERE SAActiveSessionId = %d",saActiveSessionId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from SAActiveTrial Table");
        }else{
            NSLog(@"Error occured while deleting from SAActiveTrial table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

+ (void)DeleteTAActiveSessionWithActiveStudentSessionId:(int)sessionId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From TAActiveSession WHERE ActiveStudentSessionId = %d",sessionId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from TAActiveSession Table");
        }else{
            NSLog(@"Error occured while deleting from TAActiveSession table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

+ (void)DeleteTAActiveTrialWithTAActiveSessionId:(int)taActiveSessionId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From TAActiveTrial WHERE TAActiveSessionId = %d",taActiveSessionId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from TAActiveTrial Table");
        }else{
            NSLog(@"Error occured while deleting from TAActiveTrial table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

//User Details
+ (int)GetLoggedInUserID
{
    //ACEUser
    //ACEUserId,UserId,SessionId,LoginTime,LastSyncTime,IsLoggedOut
    int userID = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
       NSString *userQuery = [NSString stringWithFormat:@"SELECT UserId From ACEUser"];
        sqlite3_stmt *usrQuery;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [userQuery UTF8String], -1,&usrQuery, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(usrQuery)) {
                
                //Read all values.
                userID = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(usrQuery, 0)] intValue];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(usrQuery);
        sqlite3_close(database);
    }
    
    return userID;
}

+ (NSString*)getLoggedInUserSessionId
{
    //ACEUser
    //ACEUserId,UserId,SessionId,LoginTime,LastSyncTime,IsLoggedOut
    NSString *sessionToken = nil;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *userQuery = [NSString stringWithFormat:@"SELECT SessionId From ACEUser"];
        sqlite3_stmt *usrQuery;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [userQuery UTF8String], -1,&usrQuery, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(usrQuery)) {
                
                //Read all values.
                sessionToken = [NSString stringWithUTF8String:(char *)sqlite3_column_text(usrQuery, 0)];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(usrQuery);
        sqlite3_close(database);
    }
    
    return sessionToken;

}

//Student Details
+ (NSArray*)getAddedStudents
{
    // ACEStudent
    //ACEUserId,StudentId,Name
    
    NSMutableArray *students = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ACEStudentId,StudentId,Name FROM ACEStudent LIMIT 10"];
        sqlite3_stmt *getStudents;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getStudents, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getStudents)) {
                NSMutableDictionary *studDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [studDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStudents, 0)]
                            forKey:@"ACEStudentId"];
                [studDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStudents, 1)]
                               forKey:@"StudentId"];
                [studDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStudents, 2)]
                               forKey:@"Name"];
             
                [students addObject:studDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getStudents);
        sqlite3_close(database);
    }
    
    return students;
}

/////////////////////////////UPDATE RELATED COMMANDS ///////////////////

+ (void)compareAndUpdateVersionsForCurriculums:(NSArray*)curriculumArray
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        for (NSDictionary *dictionary  in curriculumArray) {
            
            //Recieved Values
            int activationId = [[dictionary valueForKey:@"ActivationId"] intValue];
            int versionId = [[dictionary valueForKey:@"VersionId"] intValue];
            
            NSString *updateSql = [NSString stringWithFormat:@"UPDATE StuCurriculum SET IsVersionMatch = 'false' WHERE ActivationId = %d and CurrentVersionId < %d",activationId,versionId];
            
            char* error_msg;
            int nErrorCode = sqlite3_exec(database, [updateSql UTF8String],NULL,NULL,&error_msg); 
            
            if(SQLITE_OK != nErrorCode){ //IF couldn't update then its newly added curriculum.
                NSLog(@"Error Occured while Updating StuCurriculum  into table Reason: %s",error_msg);
            }else{
                NSLog(@"updating StuCurriculum  into table");
            }
            
            updateSql = nil;     
           }
        
         sqlite3_close(database);
    }
}

+ (NSArray*)listOfAllCurriculumsWithStudentId:(int)studID
{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    // StuCurriculum
    //StuCurriculumId,ACEStudentId,ActivationId,CurriculumTypeId,CurrentVersionId,LastSyncTime,
    //Name,ObjectiveNo,IsVersionMatch
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActivationId FROM StuCurriculum WHERE ACEStudentId = %d",studID];
        sqlite3_stmt *getStuCurriculum;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getStuCurriculum, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getStuCurriculum)) {
                
                NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
                [result setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 0)]
                          forKey:@"ActivationId"];
                [resultList addObject:result];
                result = nil;
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getStuCurriculum);
        sqlite3_close(database);
    }
    
    return resultList;
    
}

+ (NSArray*)listOfCurriculumWithVersionUpdateForStudent:(int)studentID
{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    // StuCurriculum
    //StuCurriculumId,ACEStudentId,ActivationId,CurriculumTypeId,CurrentVersionId,LastSyncTime,
    //Name,ObjectiveNo,IsVersionMatch
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActivationId FROM StuCurriculum WHERE IsVersionMatch = 'false' and ACEStudentId = %d",studentID];
        sqlite3_stmt *getStuCurriculum;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getStuCurriculum, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getStuCurriculum)) {
                
                NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
                [result setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 0)]
                          forKey:@"ActivationId"];
                [resultList addObject:result];
                result = nil;
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getStuCurriculum);
        sqlite3_close(database);
    }
    
    return resultList;
}

/////////////////////////////UPDATE COMMANDS ///////////////////

//Stu curriculum Deletion.
+ (void)DeleteStuCurriculumWithIsVersionMatchedSet
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From StuCurriculum WHERE IsVersionMatch = 'false'"];
        
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

+ (void)DeleteStuCurriculumWithStudentId:(int)_studentID
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From StuCurriculum WHERE ACEStudentId = %d and IsVersionMatch != 'false' ",_studentID];
        
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

+ (void)DeleteStuCurriculumWithActivationId:(int)activationId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From StuCurriculum WHERE ActivationId = %d",activationId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from StuCurriculum Table");
        }else{
            NSLog(@"Error occured while deleting from StuCurriculum table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

+ (void)markVersionMismatchForCurriculumWithActivationID:(int)actvId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE StuCurriculum SET IsVersionMatch = 'false' WHERE ActivationId = %d",actvId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [updateSql UTF8String],NULL,NULL,&error_msg); 
        
        if(SQLITE_OK != nErrorCode){ //IF couldn't update then its newly added curriculum.
            NSLog(@"Error Occured while Archieving StuCurriculum  into table Reason: %s",error_msg);
        }else{
            NSLog(@"Archieving StuCurriculum  into table");
        }
        
        updateSql = nil;  
        sqlite3_close(database);
    }
}

+ (NSArray*)allCurrculumsActivationIDForStudent:(int)aceStudId
{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    // StuCurriculum
    //StuCurriculumId,ACEStudentId,ActivationId,CurriculumTypeId,CurrentVersionId,LastSyncTime,
    //Name,ObjectiveNo,IsVersionMatch
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActivationId FROM StuCurriculum WHERE ACEStudentId = %d",aceStudId];
        sqlite3_stmt *getStuCurriculum;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getStuCurriculum, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getStuCurriculum)) {
                    [resultList addObject:[NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 0)] intValue]]];
                 }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getStuCurriculum);
        sqlite3_close(database);
    }
    
    return resultList;
    
}

//Delete Past session
+ (void)deleteSAPastSessionDataWithSASubLevelId:(int)subLevelId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From SAPastSession WHERE SASubLevelId = %d",subLevelId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from SAPastSession Table");
        }else{
            NSLog(@"Error occured while deleting from SAPastSession table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

+ (void)deleteTAPastSessionDataWithTACurriculumId:(int)taId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From TAPastSession WHERE TACurriculumid = %d",taId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from TAPastSession Table");
        }else{
            NSLog(@"Error occured while deleting from TAPastSession table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    
    }
    
}

+ (void)deleteITPastSessionDataWithITContextId:(int)contextId
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From ITPastSession WHERE ITContextId = %d",contextId];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted from ITPastSession Table");
        }else{
            NSLog(@"Error occured while deleting from ITPastSession table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }
}

//Related to Past Data Entry
+ (int)getSASublevelIdWithACESublevelId:(int)aceSubLevelId
{
    int SASublevelID = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT SASubLevelId FROM SASubLevel WHERE ACESASubLevelid  = %d",aceSubLevelId];
        
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                SASublevelID = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving SASublevelID in SASubLevelId");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return SASublevelID;
    
}

+ (int)getITCurriculumContextIdWithACEContextID:(int)ACEContextID
{
    int contextId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT ITContextId FROM ITContext WHERE ACEITContextId  = %d",ACEContextID];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                contextId = sqlite3_column_int(statement, 0);
            }
            
            // Finalize and close database.
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }else{
            NSLog(@"Error While retrieving USer ID in ACEStudentIdForStudentId");
        }
    }
    
    return contextId;
}

//TA Past data related methods
+ (int)getStuCurriculumIdWithActivationId:(int)actvId
{
    int stuCurriculumId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT StuCurriculumId FROM StuCurriculum WHERE ActivationId  = %d",actvId];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                stuCurriculumId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving StuCurriculumID in StuCurriculum");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return stuCurriculumId;
}

+ (int)getTACurriculumIdWithStuCurriculumId:(int)stuCurriculumId
{
    
    int TACurriculumId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT TACurriculumId FROM TACurriculum WHERE StuCurriculumId  = %d",stuCurriculumId];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                TACurriculumId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving StuCurriculumID in StuCurriculum");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return TACurriculumId;
}

+ (int)getStuCurriculumActivationIdWithStuCurriculumId:(int)stuCurriculumId
{
    int activationId = -1;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT ActivationId FROM StuCurriculum WHERE StuCurriculumId  = %d",stuCurriculumId];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                activationId = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving StuCurriculumID in StuCurriculum");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return activationId;
}

//Get ActiveStudentSessionId for all Active Sessions
+ (NSArray*)getListOFSAFinishedSessionIDs
{
    NSMutableArray *SAActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM SAActiveSession WHERE IsFinished = 'true' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [SAActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return SAActiveSession;

}

+ (NSArray*)getListOFSAActiveSessionIDs
{
    NSMutableArray *SAActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM SAActiveSession WHERE IsFinished = 'false' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [SAActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return SAActiveSession;
}

+ (NSArray*)getListOFTAFinishedSessionIDs
{
    NSMutableArray *TAActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM TAActiveSession WHERE IsFinished = 'true' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [TAActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return TAActiveSession;
}

+ (NSArray*)getListOFTAActiveSessionIDs
{
    NSMutableArray *TAActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM TAActiveSession WHERE IsFinished = 'false' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [TAActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return TAActiveSession;
    
}

+ (NSArray*)getListOFITFinishedSessionIDs
{
    NSMutableArray *ITActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM ITActiveSession WHERE IsFinished = 'true' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [ITActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return ITActiveSession;
}

+ (NSArray*)getListOFITActiveSessionIDs
{
    NSMutableArray *ITActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM ITActiveSession WHERE IsFinished = 'false' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [ITActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return ITActiveSession;
}

+ (void)DeleteAllActiveStudentSession
{
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *dropQuery = [NSString stringWithFormat:@"Delete From ActiveStudentSession"];
        
        char* error_msg;
        int nErrorCode = sqlite3_exec(database, [dropQuery UTF8String],NULL,NULL,&error_msg); 
        
        if (SQLITE_OK == nErrorCode) {
            NSLog(@"Deleted All from ActiveStudentSession Table");
        }else{
            NSLog(@"Error occured while deleting All from ActiveStudentSession table: %s and nErrorCode = %d",error_msg,nErrorCode);
        }
        
        sqlite3_close(database);
    }

}


//Sumarrized Sessions List

+ (NSArray*)getListOFSASummarizedSessionIDS
{
    NSMutableArray *SAActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM SAActiveSession WHERE IsFinished = 'true' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [SAActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return SAActiveSession;
}

+ (NSArray*)getListOFTASummarizedSessionIDS
{
    NSMutableArray *TAActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM TAActiveSession WHERE IsFinished = 'true' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [TAActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return TAActiveSession;
    
}

+ (NSArray*)getListOFITASummarizedSessionIDS
{
    NSMutableArray *ITActiveSession = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM ITActiveSession WHERE IsFinished = 'true' "];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                NSMutableDictionary *sessionDict = [[NSMutableDictionary alloc] init];
                
                //Read all values and store in the sessionDict.
                [sessionDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                               forKey:@"ActiveStudentSessionId"];
                [ITActiveSession addObject:sessionDict];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return ITActiveSession;
}

+ (int)countOfAddedStudents
{
    int count = 0;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT COUNT(*)  FROM ACEStudent"];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                count = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving count of user in ACEStudent");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return count;
}

+ (int)countOfUnsyncedSessions
{
    int count = 0;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT COUNT(*)  FROM SyncTable"];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                count = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving count of user in SyncTable");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return count;
}

//Support for new push
+ (NSArray*)getListOfDistinctStuCurriculumIdFromActiveSession
{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    // StuCurriculum
    //StuCurriculumId,ACEStudentId,ActivationId,CurriculumTypeId,CurrentVersionId,LastSyncTime,
    //Name,ObjectiveNo,IsVersionMatch
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT DISTINCT StuCurriculumId from ActiveStudentSession Where IsDirty = 'true' "];
        sqlite3_stmt *getStuCurriculum;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getStuCurriculum, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getStuCurriculum)) {
                
                NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
                [result setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getStuCurriculum, 0)]
                          forKey:@"StuCurriculumId"];
                [resultList addObject:result];
                result = nil;
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getStuCurriculum);
        sqlite3_close(database);
    }
    
    return resultList;
}

+ (NSMutableArray*)getActiveSessionDetailsForStuCurriculumId:(int)stuCurriculumId
{
    //ActiveStudentSession
    //ActiveStudentSessionId,StuCurriculumId,IsDirty,LastSyncTime
    NSMutableArray *sessionList = [[NSMutableArray alloc] init];
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId,StuCurriculumId,IsDirty,LastSyncTime FROM ActiveStudentSession WHERE StuCurriculumId = %d",stuCurriculumId];
        
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                
                NSMutableDictionary *activeStudentSession = [[NSMutableDictionary alloc] init];
                //Read all values and store in the sessionDict.
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 0)]
                                        forKey:@"ActiveStudentSessionId"];
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 1)]
                                        forKey:@"StuCurriculumId"];
                [activeStudentSession setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(getActiveTrials, 2)]
                                        forKey:@"IsDirty"];
                
                char *activeTrials = (char *)sqlite3_column_text(getActiveTrials, 3);
                if (NULL != activeTrials) {
                    [activeStudentSession setValue:[NSString stringWithUTF8String:activeTrials]
                                            forKey:@"LastSyncTime"];
                }else{
                    [activeStudentSession setValue:@""
                                            forKey:@"LastSyncTime"];
                }
                
                [sessionList addObject:activeStudentSession];
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return sessionList;
}

+ (int)countForActiveSASessionWithActiveStudentSessionId:(int)sessionId
{
    int count = 0;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM SAActiveSession WHERE ActiveStudentSessionId = %d AND IsFinished = 'true' ",sessionId];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                count++;
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }

    return count;
}

+ (int)countForActiveTASessionWithActiveStudentSessionId:(int)sessionId
{
    int count = 0;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM TAActiveSession WHERE ActiveStudentSessionId = %d AND IsFinished = 'true' ",sessionId];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                count++;
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return count;
}

+ (int)countForActiveITSessionWithActiveStudentSessionId:(int)sessionId
{
    int count = 0;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        
        NSString* query = [NSString stringWithFormat:@"SELECT ActiveStudentSessionId FROM ITActiveSession WHERE ActiveStudentSessionId = %d AND IsFinished = 'true' ",sessionId];
        sqlite3_stmt *getActiveTrials;
        
        if(SQLITE_OK == sqlite3_prepare_v2(database, [query UTF8String], -1,&getActiveTrials, nil) ) {
            
            while(SQLITE_ROW == sqlite3_step(getActiveTrials)) {
                count++;
            }
        }
        
        // Finalize and close database.
        sqlite3_finalize(getActiveTrials);
        sqlite3_close(database);
    }
    
    return count;
}

+ (int)getTAStepsCountForCurriculumWithCurriculumId:(int)curriculumId
{
    int count = 0;
    
    NSString *databasePath1 = [ACEUTILMethods getDBPath];
    sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) {
        NSString *maxSQL = [[NSString alloc] initWithFormat:@"SELECT COUNT(*)  FROM TAStep where TACurriculumId = %d",curriculumId];
        const char* sqlStatement =[maxSQL UTF8String];
        sqlite3_stmt* statement;
        int code = sqlite3_prepare_v2(database, sqlStatement, -1, &statement, nil);
        
        if(code  == SQLITE_OK ) {
            while( sqlite3_step(statement) == SQLITE_ROW ){
                count = sqlite3_column_int(statement, 0);
            }
        }else{
            NSLog(@"Error While retrieving count from TAPromptStep");
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return count;
}

//Santosh Methods End.

@end
