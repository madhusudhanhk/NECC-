//
//  ACEActivationCurriculumDetails.m
//  ACE
//
//  Created by Santosh Kumar on 8/23/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "ACEActivationCurriculumDetails.h"
#import "ACEUTILMethods.h"
#import "Logger.h"
#import "JSON.h"
#import "StudentDatabase.h"

@interface ACEActivationCurriculumDetails( )

- (void)insertTACurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict forStudent:(int)studentId;
- (void)insertITCurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict forStudent:(int)studentId;
- (void)insertSACurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict forStudent:(int)studentId;

@end

@implementation ACEActivationCurriculumDetails

- (id)initWithVersionIds:(NSArray *)versionList
                   token:(NSString*)token
                delegate:(id)_delegate
{
    if (self = [super initWithDelegate:_delegate]) {
        apiReqType = eActivationIdBasedCurriculumDetail;
        self.sessionToken = token;
        self.queue = [NSMutableArray arrayWithArray:versionList];
    }
    
    return self;
}

- (NSString*)getAPIURL
{
    NSString *apiURL = nil;
    NSString *IdList = @"";
    
    NSDictionary *versionInfo = [self.queue lastObject];
    NSMutableArray *versionList = [[NSMutableArray alloc] 
                                   initWithArray:[versionInfo valueForKey:@"ActivationId"]];
    
    if ([versionList count] > 0) {
        NSDictionary *actvId = [versionList lastObject];
        IdList = [IdList stringByAppendingString:[NSString stringWithFormat:@",%@",[actvId valueForKey:@"ActivationId"]]];
        [versionList removeLastObject];
    }
    
    for (NSDictionary *actv in versionList) {
        IdList = [IdList stringByAppendingString:[NSString stringWithFormat:@",%@",[actv valueForKey:@"ActivationId"]]];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:kURLLocation];
    apiURL = myString;
    
    apiURL = [apiURL stringByAppendingString:[NSString stringWithFormat:@"/ActiveCurriculumDetails/%@?date=%@",IdList,
                                              [ACEUTILMethods getCurrentDateByRemovingSpace]]];
    
    [Logger log:@"API URL Curruculum Details : %@",apiURL];
    
    return apiURL;
}

- (void)loadCurriculamDetails
{
    [self generateRequest];
    [apiRequest startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self.queue removeLastObject];
    
    if ([self.queue count] > 0) {
        [self loadCurriculamDetails];
    }else{
        //Notify Delegate
        if ([self.delegate respondsToSelector:
             @selector(ACEActivationCurriculumDetailsDidFinishCurriculumLoading:)]) {
            [self.delegate ACEActivationCurriculumDetailsDidFinishCurriculumLoading:self];
        }
    }
}

- (void) requestFinished: (ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    [Logger log:@"Json Response = %@ for Student = %d",responseString,[self.queue count]];
    
    NSDictionary *studDictionary = [self.queue lastObject];
    
    int studentId = [[studDictionary valueForKey:@"ACEStudentId"] intValue];
    [self.queue removeLastObject];
    
    NSDictionary *curriculumDict  = [responseString JSONValue]; 
    NSDictionary *dataDict = [curriculumDict valueForKey:@"Data"];
    
    //1.IT
    NSArray *ITCurriculums = [dataDict valueForKey:@"ITCurriculums"];
    [self insertITCurriculums:ITCurriculums andActualDictionary:curriculumDict forStudent:studentId];
    
    //2. TA
    NSArray *TACurriculums = [dataDict valueForKey:@"TACurriculums"];
    [self insertTACurriculums:TACurriculums andActualDictionary:curriculumDict forStudent:studentId];
    
    //3. SA
    NSArray *SACurriculums = [dataDict valueForKey:@"SACurriculums"];
    [self insertSACurriculums:SACurriculums andActualDictionary:curriculumDict forStudent:studentId];
    
    if ([self.queue count] > 0) {
        [self loadCurriculamDetails];
    }else{
        //Notify Delegate
        if ([self.delegate respondsToSelector:
             @selector(ACEActivationCurriculumDetailsDidFinishCurriculumLoading:)]) {
            [self.delegate ACEActivationCurriculumDetailsDidFinishCurriculumLoading:self];
        }
    }
}

- (void)insertTACurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict forStudent:(int)studentId
{
    for (NSArray *crlm in curriculumArray) {
        
        for (NSDictionary *dictionary in crlm) {
            
            //First Delete from Stu Curriculum
            int activationId = [[dictionary valueForKey:@"ActivationId"] intValue];
            [StudentDatabase DeleteStuCurriculumWithActivationId:activationId];
            
            //Make first Entry in StuCurriculum Table.
            NSMutableDictionary *StuCurriculumEntry = [[NSMutableDictionary alloc] init];
            [StuCurriculumEntry setValue:[NSNumber numberWithInt:studentId] forKey:@"ACEStudentId"];
            [StuCurriculumEntry setValue:[dictionary valueForKey:key_ActivationId] forKey:@"ActivationId"];
            [StuCurriculumEntry setValue:
             [NSNumber numberWithInt:[[dictionary
                                       valueForKey:@"CmType"] intValue] ]
                                  forKey:@"CurriculumTypeId"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:key_VersionId] forKey:@"CurrentVersionId"];
            [StuCurriculumEntry setValue:[ACEUTILMethods getCurrentDate] forKey:@"LastSyncTime"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"CurriculumName"] forKey:@"Name"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"ObjectiveNumber"] forKey:@"ObjectiveNo"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"PublishedId"] forKey:@"PublishedId"];
            //Insert this dictionary into StuCurriculum.
            [StudentDatabase insertIntoStuCurriculumTable:StuCurriculumEntry];
            int stuCurriculumId = [StudentDatabase getTopStuCurriculumId];
            
            //Take StuCurriculumId from StuCurriculum Table. After inserting the dictionary.
            //Insert into  TACurriculum
            //TACurriculum:StuCurriculumId, MstChainingSequenceId
            //MstChainingSequenceId not available in Json
            NSMutableDictionary *TACurriculum = [[NSMutableDictionary alloc] init];
            [TACurriculum setValue:[NSNumber numberWithInt:stuCurriculumId] forKey:@"StuCurriculumId"];
            
            int mst = [[dictionary valueForKey:@"ChainingSequenceId"] intValue];
            [TACurriculum setValue:[NSNumber numberWithInt:mst] forKey:@"MstChainingSequenceId"];
            
            [StudentDatabase insertTACurriculum:TACurriculum];
            
            //Insert TAPastSession: TACurriculumid, Date, TrialType, StepIndependent, TrainingStep, PromptStep,Order       
            //JSON : {"Date":"\\/Date(1266085800000+0530)\\/","Id":1505,"IndependentStep":12,"Order":0,"PromptStep":" Independent","TACurriculumId":1505,"TrailType":"MT","TrainingStep":6\}
            //Table Field: TAPastSession
            //TACurriculumid, Date, TrialType, StepIndependent, TrainingStep, PromptStep, Order
            
            int curriculamId = [StudentDatabase getTopTACurriculumId];
            
            NSArray *pastSessions = [dictionary valueForKey:@"PastSession"];
            
            for (NSDictionary *pastSession in pastSessions) {
                
                //Create Past Session Dictionary.
                NSMutableDictionary *pastDict = [[NSMutableDictionary alloc] init];
                [pastDict setValue:[NSNumber numberWithInt:curriculamId] forKey:@"TACurriculumid"];
                [pastDict setValue:[pastSession valueForKey:@"Date"] forKey:@"Date"];
                [pastDict setValue:[pastSession  valueForKey:@"TrailType"] forKey:@"TrialType"];
                [pastDict setValue:[pastSession valueForKey:@"PromptStep"] forKey:@"PromptStep"];
                [pastDict setValue:[pastSession valueForKey:@"TrainingStep"] forKey:@"TrainingStep"];
                [pastDict setValue:[pastSession valueForKey:@"IndependentStep"] forKey:@"StepIndependent"];
                
                //Pass this dictionary to SQL for inserting into DB.
                [StudentDatabase insertTAPastSession:pastDict];
                pastDict  = nil;
            }
            
            //Insert Prompt Step.
            NSArray *promptSteps = [dictionary valueForKey:@"PromptSteps"];
            for (NSDictionary *promptStep in promptSteps) {
                //JSON : {"Id":-1,"Name":null,"Code":"NA"\}
                //Table Field: TAPromptStep
                //TAPromptStepId, TACurriculumId, ACETAPromptStepId, Name
                //TAPromptStepId is auto generated, ACETAPromptStepId is mapped to Id in Json.
                
                //Create prompt Dictionary.
                NSMutableDictionary *prompt = [[NSMutableDictionary alloc] init];
                [prompt setValue:[promptStep valueForKey:@"Id"] forKey:@"ACETAPromptStepId"];
                [prompt setValue:[promptStep valueForKey:@"Name"] forKey:@"Name"];
                [prompt setValue:[NSNumber numberWithInt:curriculamId] forKey:@"TACurriculumid"];
                
                //Pass this dict to SQlite to insert.
                [StudentDatabase insertTAPromptStep:prompt];
                
            }
            
            //Insert Steps
            NSArray *steps = [dictionary valueForKey:@"Steps"];
            for (NSDictionary *step in steps) {
                
                // JSON:  {"Id":4827,"Name":"2","Description":"Wet both hands","Order":2\}
                //Table Fields: TAStep
                //TAStepId , TACurriculumId , ACETAStepId, Name, Description, Order   
                //TAStepId - Auto generate : ACETAStepId mapped to Id in Json.
                
                //Create Steps Dictionary.
                NSMutableDictionary *stepDict = [[NSMutableDictionary alloc] init];
                [stepDict setValue:[step valueForKey:@"Id"] forKey:@"ACETAStepId"];
                [stepDict setValue:[NSNumber numberWithInt:curriculamId] forKey:@"TACurriculumid"];
                [stepDict setValue:[step valueForKey:@"Description"] forKey:@"Description"];
                [stepDict setValue:[step valueForKey:@"Order"] forKey:@"Order"];
                [stepDict setValue:[step valueForKey:@"Name"] forKey:@"Name"];
                
                [StudentDatabase insertTAStep:stepDict];
                stepDict = nil;
            }
        }
    }
}

- (void)insertITCurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict forStudent:(int)studentId
{
    for (NSArray *crlm in curriculumArray) {
        
        for (NSDictionary *dictionary in crlm) {
            
            //First Delete from Stu Curriculum
            int activationId = [[dictionary valueForKey:@"ActivationId"] intValue];
            [StudentDatabase DeleteStuCurriculumWithActivationId:activationId];
            
            
            //Make first Entry in StuCurriculum Table.
            NSMutableDictionary *StuCurriculumEntry = [[NSMutableDictionary alloc] init];
            [StuCurriculumEntry setValue:[NSNumber numberWithInt:studentId] forKey:@"ACEStudentId"];
            [StuCurriculumEntry setValue:[dictionary valueForKey:@"ActivationId"] forKey:@"ActivationId"];
            [StuCurriculumEntry setValue:
             [NSNumber numberWithInt:[[dictionary
                                       valueForKey:@"CmType"] intValue] ]
                                  forKey:@"CurriculumTypeId"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"VersionId"] forKey:@"CurrentVersionId"];
            [StuCurriculumEntry setValue:[ACEUTILMethods getCurrentDate] forKey:@"LastSyncTime"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"CurriculumName"] forKey:@"Name"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"ObjectiveNumber"] forKey:@"ObjectiveNo"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"PublishedId"] forKey:@"PublishedId"];
            
            //Insert this dictionary into StuCurriculum.
            [StudentDatabase insertIntoStuCurriculumTable:StuCurriculumEntry];
            
            //Take StuCurriculumId from StuCurriculum Table. After inserting the dictionary.
            int stuCurriculumId = [StudentDatabase getTopStuCurriculumId];
            NSArray *contextArray  = [dictionary valueForKey:@"Context"];
            
            for (NSDictionary *dictionary  in contextArray) {
                
                //Table ITContext: ACEITContextId, StuCurriculumId, Name, Status
                //Json: {"Id":13213,"Name":"A", - IT Context Info.
                //Status : Not available in Json.
                
                NSMutableDictionary *contextDict = [[NSMutableDictionary alloc] init];
                [contextDict setValue:[dictionary valueForKey:@"Id"] forKey:@"ACEITContextId"];
                [contextDict setValue:[dictionary valueForKey:@"Name"] forKey:@"Name"];
                [contextDict setValue:[NSNumber numberWithInt:stuCurriculumId] forKey:@"StuCurriculumId"];
                [contextDict setValue:[NSNumber numberWithInt:1] forKey:@"Status"];
                [contextDict setValue:[dictionary valueForKey:@"Title"] forKey:@"Title"];
                [StudentDatabase InsertITContext:contextDict];
                contextDict = nil;
                
                //Insert Session Colllection (Past Session)
                //            //Insert ITPastSession : ITPastSession
                //            // ITContextId, WeekEnding, TrialType, Opportunities, MIP, TotalPlus, TotalPlusP, TotalMinus, TotalNR, Order
                //             //Json: "SessionCollection":[\{"Mip":"I","Order":1,"TotalPlus":3,"TrialType":"BL","WeekEnding":"7\\/22\\/2012"\}]\} -  Past Session Info
                
                int contextId = [StudentDatabase getTopITCurriculumContextId];
                
                NSArray *sessionList = [dictionary valueForKey:@"SessionCollection"];
                
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
            
            NSArray *MIPArray = [dictionary valueForKey:@"MIP"];
            
            for (NSDictionary *dictionary in MIPArray) {
                
                //            //Table: ITMIP
                //            //ACEITMIPId, StuCurriculumId, Name
                //            //Json: {"Id":555,"Name":"I"\}
                
                NSMutableDictionary *newMIPEntry = [[NSMutableDictionary alloc] init];
                [newMIPEntry setValue:[dictionary valueForKey:@"Id"] forKey:@"ACEITMIPId"];
                [newMIPEntry setValue:[dictionary valueForKey:@"Name"] forKey:@"Name"];
                [newMIPEntry setValue:[NSNumber numberWithInt:stuCurriculumId] forKey:@"StuCurriculumId"];
                [StudentDatabase InsertITMIP:newMIPEntry];
                newMIPEntry = nil;
                
            }
        }
    }
}

- (void)insertSACurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict forStudent:(int)studentId
{
    for (NSArray *crlm in curriculumArray) {
        
        for (NSDictionary *dictionary in crlm) {
            
            //First Delete from Stu Curriculum
            int activationId = [[dictionary valueForKey:@"ActivationId"] intValue];
            [StudentDatabase DeleteStuCurriculumWithActivationId:activationId];
            
            
            //Make first Entry in StuCurriculum Table.
            NSMutableDictionary *StuCurriculumEntry = [[NSMutableDictionary alloc] init];
            [StuCurriculumEntry setValue:[NSNumber numberWithInt:studentId] forKey:@"ACEStudentId"];
            [StuCurriculumEntry setValue:[dictionary valueForKey:key_ActivationId] forKey:@"ActivationId"];
            [StuCurriculumEntry setValue:
             [NSNumber numberWithInt:[[dictionary
                                       valueForKey:@"CmType"] intValue] ]
                                  forKey:@"CurriculumTypeId"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:key_VersionId] forKey:@"CurrentVersionId"];
            [StuCurriculumEntry setValue:[ACEUTILMethods getCurrentDate] forKey:@"LastSyncTime"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"CurriculumName"] forKey:@"Name"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"ObjectiveNumber"] forKey:@"ObjectiveNo"];
            [StuCurriculumEntry setValue:[dictionary  valueForKey:@"PublishedId"] forKey:@"PublishedId"];
            
            //Insert this dictionary into StuCurriculum.
            [StudentDatabase insertIntoStuCurriculumTable:StuCurriculumEntry];
            int stuCurriculumId = [StudentDatabase getTopStuCurriculumId];
            
            NSArray *levels = [dictionary valueForKey:@"Levels"];
            
            for (NSDictionary *level in levels) {
                
                //Make entry for SA Level.
                NSMutableDictionary *levelDict = [[NSMutableDictionary alloc] init];
                [levelDict setValue:[level valueForKey:@"Id"] forKey:@"ACESALevelId"];
                [levelDict setValue:[NSNumber numberWithInt:stuCurriculumId] forKey:@"StuCurriculumId"];
                [levelDict setValue:[level valueForKey:@"Name"] forKey:@"Name"];
                [levelDict setValue:[level valueForKey:@"VersionId"] forKey:@"CurrentVersionId"];
                [levelDict setValue:[level valueForKey:@"ProcedureId"] forKey:@"ProcedureId"];
                [StudentDatabase insertSALevel:levelDict];
                
                int toplevelId = [StudentDatabase getSALevelTopId];
                
                NSArray *subLevel = [level valueForKey:@"SubLevels"];
                
                if ([subLevel isKindOfClass:[NSArray class]]) 
                for (NSDictionary *subLvl in subLevel) {
                    
                    NSMutableDictionary *subLevelDict = [[NSMutableDictionary alloc] init];
                    [subLevelDict setValue:[subLvl valueForKey:@"Id"] forKey:@"ACESASubLevelid"];
                    [subLevelDict setValue:[NSNumber numberWithInt:toplevelId] forKey:@"SALevelId"];
                    [subLevelDict setValue:[subLvl valueForKey:@"Name"] forKey:@"Name"];
                    [subLevelDict setValue:[subLvl valueForKey:@"Skill"] forKey:@"Skill"];
                    [StudentDatabase insertSASubLevel:subLevelDict];
                    
                    int subLevelTopId = [StudentDatabase getSASublevelTopId];
                    NSArray *pastSessions = [subLvl valueForKey:@"PastSessionData"];
                    
                    //SASubLevelId, Date, Step,Type,Score,Status,Order,Plus,PlusP,Minus,MinusP
                    
                    if ([pastSessions isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *pastSession in pastSessions) {
                            NSMutableDictionary *pastSessionDict = [[NSMutableDictionary alloc] init];
                            [pastSessionDict setValue:[NSNumber numberWithInt:subLevelTopId] forKey:@"SASubLevelId"];
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
                
                NSArray *stepsList = [level valueForKey:@"Steps"];
                //Make Entry for steps.
                
                for (NSDictionary *steps in stepsList) {
                    
                    NSMutableDictionary *stepDict = [[NSMutableDictionary alloc] init];
                    [stepDict setValue:[NSNumber numberWithInt:toplevelId] forKey:@"SALevelId"];
                    [stepDict setValue:[steps valueForKey:@"Id"] forKey:@"ACESAStepId"];
                    [stepDict setValue:[steps valueForKey:@"Name"] forKey:@"Name"];
                    [StudentDatabase insertSASteps:stepDict];
                    stepDict  = nil;
                }
            }
        }
    }
}

@end
