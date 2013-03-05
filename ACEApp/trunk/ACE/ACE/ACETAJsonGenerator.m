//
//  ACESyncManagerTA.m
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACETAJsonGenerator.h"
#import "StudentDatabase.h"
#import "ACEUTILMethods.h"
#import "Logger.h"

@implementation ACETAJsonGenerator

- (NSArray*)getCurriculumListWithStuCurriculumId:(int)stuCurriculumId
{
    NSMutableArray *curriculumlist = [[NSMutableArray alloc] init];
    NSArray *sessionList = [StudentDatabase getActiveStudentSessionDetailWithStuCurriculumId:stuCurriculumId];
    
    for (NSDictionary *session in sessionList) {
        NSArray *activeSessionList = [StudentDatabase getTAActiveSessionForActiveStudentSessionId:
                                      [[session valueForKey:@"ActiveStudentSessionId"] intValue]];
        
        for (NSDictionary *sessionInfo in activeSessionList) {
            
            NSMutableDictionary *curriculumDictionary = [[NSMutableDictionary alloc] init];
            int sessionId = [[sessionInfo valueForKey:@"TAActiveSessionId"] intValue];
            
            //Read Student Info
            //Get Student Info
            NSDictionary *studDict = [StudentDatabase getActiveStudentSessionDetailWithActiveStudentSessionId:[[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
            
            //Stu Curriculum Details.
            NSDictionary *getStuCurriculum = [StudentDatabase getStuCurriculumDetailsForCurriculumWithStuCurriculumId:[[studDict valueForKey:@"StuCurriculumId"] intValue]];
            
            
            //JSON Structure
            // {"DataEntryStatus":null,"EnableEmailNotification":true,"EntryDate":"\/Date(1343327400000+0530)\/","Id":null,"Order":1,"Quarter":1,"SessionKey":"c6e960cf-1cdb-43e1-8093-a53b41480393","SettingId":1007,"SettingName":"Home 1","Staff":"xyz","StatusId":2,"StatusName":"Retrain","TrialTypeId":1,"TrialTypeName":"BL","UserId":1,"VersionId":3,"ChainingType":0,"IndependentStepCode":"2","IndependentStepId":22,"NumberOfTrails":1,"PromptLevelId":496,"PromptLevelName":"DU","TrainStepCode":"4","TrainStepId":24,"Trials":[{"Id":0,"PromptName":"DU","PromptStepId":496,"StepCode":"3","StepId":24,"TrialNumber":0}]}
            
            //JSON Keys
            //DataEntryStatus,EnableEmailNotification,EntryDate,Id,Order,Quarter,SessionKey,SettingId,SettingName,
            //Staff,StatusId,StatusName,TrialTypeId,TrialTypeName,UserId,VersionId,ChainingType
            //IndependentStepCode,IndependentStepId,NumberOfTrails,PromptLevelId,PromptLevelName,TrainStepCode,
            //TrainStepId,Trials[]
            
            
            //DataEntryStatus
            [curriculumDictionary setValue:[NSNull null] forKey:@"DataEntryStatus"]; //Leave blank.
            
            //EnableEmailNotification
            if ([[sessionInfo valueForKey:@"IsEmailEnabled"] isEqualToString:@"true"] == true) {
                [curriculumDictionary setValue:[NSNumber numberWithBool:TRUE] forKey:@"EnableEmailNotification"];
            }else{
                [curriculumDictionary setValue:[NSNumber numberWithBool:FALSE] forKey:@"EnableEmailNotification"];
            }
            
            //EntryDate
            NSDate *date = [ACEUTILMethods getDateFromString:[sessionInfo valueForKey:@"Date"]];
            NSString *jsonDateFrom = [NSString stringWithFormat:@"/Date(%.0f000)/", [date timeIntervalSince1970]];
            [Logger log:@"JSON Date String = %@",jsonDateFrom];
            [curriculumDictionary setValue:jsonDateFrom forKey:@"EntryDate"];
        
            //Id
            [curriculumDictionary setValue:[NSNull null] forKey:@"Id"]; //Ignore: Blank or null.
            
            //Order
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"Order"] intValue]] forKey:@"Order"];
            
            //Get User Info
            NSDictionary *studentInfo = [StudentDatabase getDetailsOfStudentWithACEStudentId:self.studentId];
            
            //Quarter
            [curriculumDictionary setValue:
             [NSNumber numberWithInt:[[studentInfo valueForKey:@"Quarter"] intValue]] forKey:@"Quarter"]; 
            
            //SessionKey
            [curriculumDictionary setValue:self.guid forKey:@"SessionKey"];
            
            //SettingId And SettingName
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"MstSetttingId"] intValue]] forKey:@"SettingId"];
            NSDictionary *settingsDict = [StudentDatabase getMstSettingForMstSettingsId:[[sessionInfo valueForKey:@"MstSetttingId"] intValue]];
            [curriculumDictionary setValue:[settingsDict valueForKey:@"Name"] forKey:@"SettingName"];
            
            // Staff
            [curriculumDictionary setValue:[sessionInfo valueForKey:@"Staff"] forKey:@"Staff"];
            
            //StatusId And StatusName
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"MstStatusId"] intValue]] forKey:@"StatusId"];
            NSDictionary *statusDict = [StudentDatabase getMstStatusForMstStatusId:[[sessionInfo valueForKey:@"MstStatusId"] intValue]];
            [curriculumDictionary setValue:[statusDict valueForKey:@"Name"] forKey:@"StatusName"];
            
            //TrialTypeId And TrialTypeName
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]] forKey:@"TrialTypeId"];
            NSDictionary *trialDict = [StudentDatabase getMstTrialTypeForMstTrialTypeId:[[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]];
            [curriculumDictionary setValue:[trialDict valueForKey:@"Name"] forKey:@"TrialTypeName"];
            
            //UserId
            [curriculumDictionary setValue:[NSNumber numberWithInt:self.userId] forKey:@"UserId"]; //Loggend in user.
            
            //VersionId
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[getStuCurriculum valueForKey:@"CurrentVersionId"] intValue]] forKey:@"VersionId"];
            
            
            // ChainingType :
            NSDictionary *TACurriculum = [StudentDatabase 
                                          getTACurriculumWithStuCurriculumId:[[studDict valueForKey:@"StuCurriculumId"] intValue]];
            [curriculumDictionary setValue:
             [NSNumber numberWithInt:[[TACurriculum valueForKey:@"MstChainingSequenceId"] intValue]] 
                                    forKey:@"ChainingType"];
            
            
            // IndependentStepCode - Name
            // IndependentStepId - TAStepIndependentId
            NSDictionary *stepDictionary = [StudentDatabase getTAStepForStepId:[[sessionInfo valueForKey:@"TAStepIndependentId"] intValue]];
            [curriculumDictionary setValue:[NSNumber numberWithInt:[[stepDictionary valueForKey:@"ACETAStepId"] intValue]] forKey:@"IndependentStepId"];
            [curriculumDictionary setValue:[stepDictionary valueForKey:@"Name"] forKey:@"IndependentStepCode"];
            
            //NumberOfTrails
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"NoOfTrials"] intValue]] forKey:@"NumberOfTrails"];
            
            NSDictionary *promptDict = [StudentDatabase getTAPromptStepForTAPromptStepId:[[sessionInfo valueForKey:@"MstPromptStepId"] intValue]];
            
            //Prompt Level And PromptLevelName
            [curriculumDictionary setValue:[promptDict valueForKey:@"ACETAPromptStepId"] forKey:@"PromptLevelId"];
            [curriculumDictionary setValue:[promptDict valueForKey:@"Name"] forKey:@"PromptLevelName"];
            
            
            //TrainStepCode and TrainStepId
            NSDictionary *stepDict = [StudentDatabase getTAStepForStepId:[[sessionInfo valueForKey:@"TATrainingStepId"] intValue]];
            [curriculumDictionary setValue:[stepDict valueForKey:@"Name"] forKey:@"TrainStepCode"];
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[stepDict valueForKey:@"ACETAStepId"] intValue]] forKey:@"TrainStepId"];
            
            
            NSArray *trialList = [StudentDatabase getTAActiveTrialForTAActiveSessionId:sessionId];
            NSMutableArray *trialItems = [[NSMutableArray alloc] init];
            
            int trialNo = 0;
            
            for (NSDictionary *trial in trialList) {
                
                //TATrial
                //{"Id":0,"PromptName":"I","PromptStepId":495,"StepCode":"1","StepId":22,"TrialNumber":0}
                
                //Generate trial dictionary.
                NSMutableDictionary *trialInfoDict = [[NSMutableDictionary alloc] init];
                [trialInfoDict setValue:[NSNumber numberWithInt:0] forKey:@"Id"];
                
                //Step ID
                NSDictionary *stepDict = [StudentDatabase getTAStepForStepId:[[trial valueForKey:@"TAStepId"] intValue]];
                [trialInfoDict setValue:[NSNumber numberWithInt:
                                         [[stepDict valueForKey:@"ACETAStepId"] intValue]] forKey:@"StepId"];
                [trialInfoDict setValue:[stepDict valueForKey:@"Name"] forKey:@"StepCode"];
                
                //Prompt
                NSDictionary *promptDict = [StudentDatabase getTAPromptStepForTAPromptStepId:[[trial valueForKey:@"TAPromptStepId"] intValue]];
                
                [trialInfoDict setValue:[NSNumber numberWithInt:
                                         [[promptDict valueForKey:@"ACETAPromptStepId"] intValue]] forKey:@"PromptStepId"];
                [trialInfoDict setValue:[promptDict valueForKey:@"Name"] forKey:@"PromptName"];
                
                [trialInfoDict setValue:[NSNumber numberWithInt:trialNo] forKey:@"TrialNumber"];
                trialNo++;
                
                [trialItems addObject:trialInfoDict];
            }
            
            [curriculumDictionary setValue:trialItems forKey:@"Trials"];
            [curriculumlist addObject:curriculumDictionary];
            curriculumDictionary = nil;
        }
        
    }
    
    return curriculumlist;
}


- (NSArray*)getCurriculumListWithActiveStudentSessionId:(int)studentSessionId
{
    NSMutableArray *curriculumlist = [[NSMutableArray alloc] init];
    
    NSArray *activeSessionList = [StudentDatabase getTAActiveSessionForActiveStudentSessionId:studentSessionId];
    
    for (NSDictionary *sessionInfo in activeSessionList) {
        
        NSMutableDictionary *curriculumDictionary = [[NSMutableDictionary alloc] init];
        int sessionId = [[sessionInfo valueForKey:@"TAActiveSessionId"] intValue];
        
        //Read Student Info
        //Get Student Info
        NSDictionary *studDict = [StudentDatabase getActiveStudentSessionDetailWithActiveStudentSessionId:[[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
        
        //Stu Curriculum Details.
        NSDictionary *getStuCurriculum = [StudentDatabase getStuCurriculumDetailsForCurriculumWithStuCurriculumId:[[studDict valueForKey:@"StuCurriculumId"] intValue]];
        
        
        //JSON Structure
        // {"DataEntryStatus":null,"EnableEmailNotification":true,"EntryDate":"\/Date(1343327400000+0530)\/","Id":null,"Order":1,"Quarter":1,"SessionKey":"c6e960cf-1cdb-43e1-8093-a53b41480393","SettingId":1007,"SettingName":"Home 1","Staff":"xyz","StatusId":2,"StatusName":"Retrain","TrialTypeId":1,"TrialTypeName":"BL","UserId":1,"VersionId":3,"ChainingType":0,"IndependentStepCode":"2","IndependentStepId":22,"NumberOfTrails":1,"PromptLevelId":496,"PromptLevelName":"DU","TrainStepCode":"4","TrainStepId":24,"Trials":[{"Id":0,"PromptName":"DU","PromptStepId":496,"StepCode":"3","StepId":24,"TrialNumber":0}]}
        
        //JSON Keys
        //DataEntryStatus,EnableEmailNotification,EntryDate,Id,Order,Quarter,SessionKey,SettingId,SettingName,
        //Staff,StatusId,StatusName,TrialTypeId,TrialTypeName,UserId,VersionId,ChainingType
        //IndependentStepCode,IndependentStepId,NumberOfTrails,PromptLevelId,PromptLevelName,TrainStepCode,
        //TrainStepId,Trials[]
        
        
        //DataEntryStatus
        [curriculumDictionary setValue:[NSNull null] forKey:@"DataEntryStatus"]; //Leave blank.
        
        //EnableEmailNotification
        if ([[sessionInfo valueForKey:@"IsEmailEnabled"] isEqualToString:@"true"] == true) {
            [curriculumDictionary setValue:[NSNumber numberWithBool:TRUE] forKey:@"EnableEmailNotification"];
        }else{
            [curriculumDictionary setValue:[NSNumber numberWithBool:FALSE] forKey:@"EnableEmailNotification"];
        }
        
        //EntryDate
        NSDate *date = [ACEUTILMethods getDateFromString:[sessionInfo valueForKey:@"Date"]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"Z"]; //for getting the timezone part of the date only.
        NSString *jsonDateFrom = [NSString stringWithFormat:@"/Date(%.0f000%@)/", [date timeIntervalSince1970],[formatter stringFromDate:date]];
        formatter = nil;
        [curriculumDictionary setValue:jsonDateFrom forKey:@"EntryDate"];
        
        //Id
        [curriculumDictionary setValue:[NSNull null] forKey:@"Id"]; //Ignore: Blank or null.
        
        //Order
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"Order"] intValue]] forKey:@"Order"];
        
        //Get User Info
        NSDictionary *studentInfo = [StudentDatabase getDetailsOfStudentWithACEStudentId:self.studentId];
        
        //Quarter
        [curriculumDictionary setValue:
         [NSNumber numberWithInt:[[studentInfo valueForKey:@"Quarter"] intValue]] forKey:@"Quarter"]; 
        
        //SessionKey
        [curriculumDictionary setValue:self.guid forKey:@"SessionKey"];
        
        //SettingId And SettingName
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstSetttingId"] intValue]] forKey:@"SettingId"];
        NSDictionary *settingsDict = [StudentDatabase getMstSettingForMstSettingsId:[[sessionInfo valueForKey:@"MstSetttingId"] intValue]];
        [curriculumDictionary setValue:[settingsDict valueForKey:@"Name"] forKey:@"SettingName"];
        
        // Staff
        [curriculumDictionary setValue:[sessionInfo valueForKey:@"Staff"] forKey:@"Staff"];
        
        //StatusId And StatusName
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstStatusId"] intValue]] forKey:@"StatusId"];
        NSDictionary *statusDict = [StudentDatabase getMstStatusForMstStatusId:[[sessionInfo valueForKey:@"MstStatusId"] intValue]];
        [curriculumDictionary setValue:[statusDict valueForKey:@"Name"] forKey:@"StatusName"];
        
        //TrialTypeId And TrialTypeName
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]] forKey:@"TrialTypeId"];
        NSDictionary *trialDict = [StudentDatabase getMstTrialTypeForMstTrialTypeId:[[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]];
        [curriculumDictionary setValue:[trialDict valueForKey:@"Name"] forKey:@"TrialTypeName"];
        
        //UserId
        [curriculumDictionary setValue:[NSNumber numberWithInt:self.userId] forKey:@"UserId"]; //Loggend in user.
        
        //VersionId
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[getStuCurriculum valueForKey:@"CurrentVersionId"] intValue]] forKey:@"VersionId"];
        
        
        // ChainingType :
        NSDictionary *TACurriculum = [StudentDatabase 
                                      getTACurriculumWithStuCurriculumId:[[studDict valueForKey:@"StuCurriculumId"] intValue]];
        [curriculumDictionary setValue:
         [NSNumber numberWithInt:[[TACurriculum valueForKey:@"MstChainingSequenceId"] intValue]] 
                                forKey:@"ChainingType"];
        
        
        // IndependentStepCode - Name
        // IndependentStepId - TAStepIndependentId
        NSDictionary *stepDictionary = [StudentDatabase getTAStepForStepId:[[sessionInfo valueForKey:@"TAStepIndependentId"] intValue]];
        [curriculumDictionary setValue:[NSNumber numberWithInt:[[stepDictionary valueForKey:@"ACETAStepId"] intValue]] forKey:@"IndependentStepId"];
        [curriculumDictionary setValue:[stepDictionary valueForKey:@"Name"] forKey:@"IndependentStepCode"];
        
        //NumberOfTrails
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"NoOfTrials"] intValue]] forKey:@"NumberOfTrails"];
        
        //Prompt Level And PromptLevelName
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstPromptStepId"] intValue]] forKey:@"PromptLevelId"];
        NSDictionary *promptDict = [StudentDatabase getTAPromptStepForTAPromptStepId:[[sessionInfo valueForKey:@"MstPromptStepId"] intValue]];
        [curriculumDictionary setValue:[promptDict valueForKey:@"Name"] forKey:@"PromptLevelName"];
        
        
        //TrainStepCode and TrainStepId
        NSDictionary *stepDict = [StudentDatabase getTAStepForStepId:[[sessionInfo valueForKey:@"TATrainingStepId"] intValue]];
        [curriculumDictionary setValue:[stepDict valueForKey:@"Name"] forKey:@"TrainStepCode"];
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[stepDict valueForKey:@"ACETAStepId"] intValue]] forKey:@"TrainStepId"];
        
        
        NSArray *trialList = [StudentDatabase getTAActiveTrialForTAActiveSessionId:sessionId];
        NSMutableArray *trialItems = [[NSMutableArray alloc] init];
        
        int trialNo = 0;
        
        for (NSDictionary *trial in trialList) {
            
            //TATrial
            //{"Id":0,"PromptName":"I","PromptStepId":495,"StepCode":"1","StepId":22,"TrialNumber":0}
            
            //Generate trial dictionary.
            NSMutableDictionary *trialInfoDict = [[NSMutableDictionary alloc] init];
            [trialInfoDict setValue:[NSNumber numberWithInt:0] forKey:@"Id"];
            
            //Step ID
            NSDictionary *stepDict = [StudentDatabase getTAStepForStepId:[[trial valueForKey:@"TAStepId"] intValue]];
            [trialInfoDict setValue:[NSNumber numberWithInt:
                                     [[stepDict valueForKey:@"ACETAStepId"] intValue]] forKey:@"StepId"];
            [trialInfoDict setValue:[stepDict valueForKey:@"Name"] forKey:@"StepCode"];
            
            //Prompt
            NSDictionary *promptDict = [StudentDatabase getTAPromptStepForTAPromptStepId:[[trial valueForKey:@"TAPromptStepId"] intValue]];
            
            [trialInfoDict setValue:[NSNumber numberWithInt:
                                     [[promptDict valueForKey:@"ACETAPromptStepId"] intValue]] forKey:@"PromptStepId"];
            [trialInfoDict setValue:[promptDict valueForKey:@"Name"] forKey:@"PromptName"];
            
            [trialInfoDict setValue:[NSNumber numberWithInt:trialNo] forKey:@"TrialNumber"];
            trialNo++;
            
            [trialItems addObject:trialInfoDict];
        }
        
        [curriculumDictionary setValue:trialItems forKey:@"Trials"];
        [curriculumlist addObject:curriculumDictionary];
        curriculumDictionary = nil;
    }
    
    return curriculumlist;
}

@end
