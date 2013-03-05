//
//  ACESyncManagerSA.m
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACESAJsonGenerator.h"
#import "ACECurriculumDetailsManager.h"
#import "StudentDatabase.h"
#import "ACEUTILMethods.h"
#import "Logger.h"

@interface ACESAJsonGenerator( )

@end

@implementation ACESAJsonGenerator

- (NSArray*)getCurriculumListWithStuCurriculumId:(int)stuCurriculumId
{
    NSMutableArray *curriculumlist = [[NSMutableArray alloc] init];
    NSArray *sessionList = [StudentDatabase getActiveStudentSessionDetailWithStuCurriculumId:stuCurriculumId];
    
    for (NSDictionary *session in sessionList) {
            NSArray *activeSessionList = [StudentDatabase getSAActiveSessionForActiveStudentID:
                                          [[session valueForKey:@"ActiveStudentSessionId"] intValue]];
        
        for (NSDictionary *sessionInfo in activeSessionList) {
            
            NSMutableDictionary *curriculumDictionary = [[NSMutableDictionary alloc] init];
            int sessionId = [[sessionInfo valueForKey:@"SAActiveSessionId"] intValue];
            
            //Read Student Info
            //Get Student ActiveSession Details.
            NSDictionary *studDict = [StudentDatabase getActiveStudentSessionDetailWithActiveStudentSessionId:[[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
            
            //Get User Info
            NSDictionary *studentInfo = [StudentDatabase getDetailsOfStudentWithACEStudentId:self.studentId];
            
            //Stu Curriculum Details.
            NSDictionary *getStuCurriculum = [StudentDatabase getStuCurriculumDetailsForCurriculumWithStuCurriculumId:[[studDict valueForKey:@"StuCurriculumId"] intValue]];
            
            NSDictionary *subLevelDict = [StudentDatabase getSASubLevelForSubLevelId:[[sessionInfo valueForKey:@"SASubLevelId"] intValue]];
            
            //Json Keys: DataEntryStatus,EnableEmailNotification,EntryDate,Id,Order,Quarter,SessionKey,SettingId
            //SettingName,Staff,StatusId,StatusName,TrialTypeId,TrialTypeName,UserId,VersionId,ProcedureId,StepCode
            // StepId, SubLevelId,SubLevelName
            
            //JSON Structure
            //     {"DataEntryStatus":null,"EnableEmailNotification":true,"EntryDate":"\/Date(1343327400000+0530)\/","Id":null,"Order":1,"Quarter":1,"SessionKey":"9db8b4f9-6555-49b8-9a81-c41dcd70d848","SettingId":1007,"SettingName":"Home 1","Staff":"abc","StatusId":3,"StatusName":"Retrain","TrialTypeId":2,"TrialTypeName":"TR","UserId":1,"VersionId":6,"ProcedureId":7,"StepCode":"1","StepId":270,"SubLevelId":4,"SubLevelName":"2.01","Trials":[{"Id":0,"Minus":true,"MinusP":false,"NoResponse":false,"Plus":false,"PlusP":false,"TrialNumber":1}]}
            
            //DataEntryStatus
            [curriculumDictionary setValue:[NSNull null] forKey:@"DataEntryStatus"]; //Leave blank.
            // int  isEmailEnabled =  [[sessionInfo valueForKey:@"IsEmailEnabled"] intValue];
            
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
            [curriculumDictionary setValue:[NSNull null]  forKey:@"Id"]; //Ignore: 0.
            
            //Order
            [curriculumDictionary setValue:
             [NSNumber numberWithInt:[[sessionInfo valueForKey:@"Order"] intValue]] forKey:@"Order"];
            
            //Quarter 
            [curriculumDictionary setValue:
             [NSNumber numberWithInt:[[studentInfo valueForKey:@"Quarter"] intValue]] forKey:@"Quarter"]; 
            
            //SessionKey
            [curriculumDictionary setValue:self.guid forKey:@"SessionKey"];
            
            //SettingId
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"MstSettingId"] intValue]] forKey:@"SettingId"];
            
            //SettingName
            NSDictionary *settingsDict = [StudentDatabase getMstSettingForMstSettingsId:[[sessionInfo valueForKey:@"MstSettingId"] intValue]];
            [curriculumDictionary setValue:[settingsDict valueForKey:@"Name"] forKey:@"SettingName"];
            
            //Staff
            [curriculumDictionary setValue:[sessionInfo valueForKey:@"Staff"] forKey:@"Staff"];
            
            //Status ID
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"MstStatusId"] intValue]] forKey:@"StatusId"];
            NSDictionary *statusDict = [StudentDatabase getMstStatusForMstStatusId:[[sessionInfo valueForKey:@"MstStatusId"] intValue]];
            
            //StatusName
            [curriculumDictionary setValue:[statusDict valueForKey:@"Name"] forKey:@"StatusName"];
            
            //TrialTypeId
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]] forKey:@"TrialTypeId"];
            NSDictionary *trialDict = [StudentDatabase getMstTrialTypeForMstTrialTypeId:[[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]];
            
            //TrialTypeName
            [curriculumDictionary setValue:[trialDict valueForKey:@"Name"] forKey:@"TrialTypeName"];
            
            //USER ID
            [curriculumDictionary setValue:[NSNumber numberWithInt:self.userId] forKey:@"UserId"]; //Loggend in user.
            
            //Version ID
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[getStuCurriculum valueForKey:@"CurrentVersionId"] intValue]] forKey:@"VersionId"];
            
            //ProcedureId
            NSDictionary *levelDICT = [StudentDatabase getSALevelForLevelID:
                                       [[subLevelDict valueForKey:@"SALevelId"] intValue]];
            
            [curriculumDictionary 
             setValue:[NSNumber numberWithInt:[[levelDICT valueForKey:@"ProcedureId"] intValue]] 
             forKey:@"ProcedureId"]; 
            
            //StepCode And StepId
            NSDictionary *stepDict = [StudentDatabase getSAStepForStepId:[[sessionInfo valueForKey:@"StepId"] intValue]];
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[stepDict valueForKey:@"ACESAStepId"] intValue]] forKey:@"StepId"];
            [curriculumDictionary setValue:[stepDict valueForKey:@"Name"] forKey:@"StepCode"];  //Map with name
            
            
            //SubLevelId And SubLevelName
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[subLevelDict valueForKey:@"ACESASubLevelid"] intValue]] forKey:@"SubLevelId"];
            [curriculumDictionary setValue:[subLevelDict valueForKey:@"Name"] forKey:@"SubLevelName"];
            
            //Trials
            NSArray *trialList = [StudentDatabase getSAActiveTrialsForActiveSessionID:sessionId];
            NSMutableArray *trialItems = [[NSMutableArray alloc] init];
            
            for (NSDictionary *trial in trialList) {
                
                //Generate trial dictionary.
                NSMutableDictionary *trialInfoDict = [[NSMutableDictionary alloc] init];
                [trialInfoDict setValue:[NSNumber numberWithInt:0] forKey:@"Id"];
                
                NSNumber *trueVal = [NSNumber numberWithBool:TRUE];
                NSNumber *falseVal = [NSNumber numberWithBool:NO]; 
                
                if ([[trial valueForKey:@"Minus"] intValue]) {
                    [trialInfoDict setValue:trueVal forKey:@"Minus"];
                }else{
                    [trialInfoDict setValue:falseVal forKey:@"Minus"];
                }
                
                if ([[trial valueForKey:@"MinusP"] intValue]) {
                    [trialInfoDict setValue:trueVal forKey:@"MinusP"];
                }else{
                    [trialInfoDict setValue:falseVal forKey:@"MinusP"];
                }
                
                if ([[trial valueForKey:@"NR"] intValue] ) {
                    [trialInfoDict setValue:trueVal forKey:@"NoResponse"];
                }else{
                    [trialInfoDict setValue:falseVal forKey:@"NoResponse"];
                }
                
                if ([[trial valueForKey:@"Plus"] intValue] ) {
                    [trialInfoDict setValue:trueVal forKey:@"Plus"];
                }else{
                    [trialInfoDict setValue:falseVal forKey:@"Plus"];
                }
                
                if ([[trial valueForKey:@"PlusP"] intValue]) {
                    [trialInfoDict setValue:trueVal forKey:@"PlusP"];
                }else{
                    [trialInfoDict setValue:falseVal forKey:@"PlusP"];
                }
                
                [trialInfoDict setValue:[NSNumber numberWithInt:
                                         [[trial valueForKey:@"TrialNumber"] intValue]] forKey:@"TrialNumber"];
                
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
    
    NSArray *activeSessionList = [StudentDatabase getSAActiveSessionForActiveStudentID:studentSessionId];
    
    for (NSDictionary *sessionInfo in activeSessionList) {
        
        NSMutableDictionary *curriculumDictionary = [[NSMutableDictionary alloc] init];
        int sessionId = [[sessionInfo valueForKey:@"SAActiveSessionId"] intValue];
        
        //Read Student Info
        //Get Student ActiveSession Details.
        NSDictionary *studDict = [StudentDatabase getActiveStudentSessionDetailWithActiveStudentSessionId:[[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
        
        //Get User Info
        NSDictionary *studentInfo = [StudentDatabase getDetailsOfStudentWithACEStudentId:self.studentId];
        
        //Stu Curriculum Details.
        NSDictionary *getStuCurriculum = [StudentDatabase getStuCurriculumDetailsForCurriculumWithStuCurriculumId:[[studDict valueForKey:@"StuCurriculumId"] intValue]];
        
        NSDictionary *subLevelDict = [StudentDatabase getSASubLevelForSubLevelId:[[sessionInfo valueForKey:@"SASubLevelId"] intValue]];
        
        //Json Keys: DataEntryStatus,EnableEmailNotification,EntryDate,Id,Order,Quarter,SessionKey,SettingId
        //SettingName,Staff,StatusId,StatusName,TrialTypeId,TrialTypeName,UserId,VersionId,ProcedureId,StepCode
        // StepId, SubLevelId,SubLevelName
        
        //JSON Structure
        //     {"DataEntryStatus":null,"EnableEmailNotification":true,"EntryDate":"\/Date(1343327400000+0530)\/","Id":null,"Order":1,"Quarter":1,"SessionKey":"9db8b4f9-6555-49b8-9a81-c41dcd70d848","SettingId":1007,"SettingName":"Home 1","Staff":"abc","StatusId":3,"StatusName":"Retrain","TrialTypeId":2,"TrialTypeName":"TR","UserId":1,"VersionId":6,"ProcedureId":7,"StepCode":"1","StepId":270,"SubLevelId":4,"SubLevelName":"2.01","Trials":[{"Id":0,"Minus":true,"MinusP":false,"NoResponse":false,"Plus":false,"PlusP":false,"TrialNumber":1}]}
        
        //DataEntryStatus
        [curriculumDictionary setValue:[NSNull null] forKey:@"DataEntryStatus"]; //Leave blank.
       // int  isEmailEnabled =  [[sessionInfo valueForKey:@"IsEmailEnabled"] intValue];
        
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
        [Logger log:@"JSON Date String = %@",jsonDateFrom];
        formatter = nil;
        [curriculumDictionary setValue:jsonDateFrom forKey:@"EntryDate"];
        
        //Id
        [curriculumDictionary setValue:[NSNull null]  forKey:@"Id"]; //Ignore: 0.
        
        //Order
        [curriculumDictionary setValue:
         [NSNumber numberWithInt:[[sessionInfo valueForKey:@"Order"] intValue]] forKey:@"Order"];
        
        //Quarter 
        [curriculumDictionary setValue:
         [NSNumber numberWithInt:[[studentInfo valueForKey:@"Quarter"] intValue]] forKey:@"Quarter"]; 
        
        //SessionKey
        [curriculumDictionary setValue:self.guid forKey:@"SessionKey"];
        
        //SettingId
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstSettingId"] intValue]] forKey:@"SettingId"];
        
        //SettingName
        NSDictionary *settingsDict = [StudentDatabase getMstSettingForMstSettingsId:[[sessionInfo valueForKey:@"MstSettingId"] intValue]];
        [curriculumDictionary setValue:[settingsDict valueForKey:@"Name"] forKey:@"SettingName"];
        
        //Staff
        [curriculumDictionary setValue:[sessionInfo valueForKey:@"Staff"] forKey:@"Staff"];
        
        //Status ID
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstStatusId"] intValue]] forKey:@"StatusId"];
        NSDictionary *statusDict = [StudentDatabase getMstStatusForMstStatusId:[[sessionInfo valueForKey:@"MstStatusId"] intValue]];
        
        //StatusName
        [curriculumDictionary setValue:[statusDict valueForKey:@"Name"] forKey:@"StatusName"];
        
        //TrialTypeId
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]] forKey:@"TrialTypeId"];
        NSDictionary *trialDict = [StudentDatabase getMstTrialTypeForMstTrialTypeId:[[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]];
        
        //TrialTypeName
        [curriculumDictionary setValue:[trialDict valueForKey:@"Name"] forKey:@"TrialTypeName"];
        
        //USER ID
        [curriculumDictionary setValue:[NSNumber numberWithInt:self.userId] forKey:@"UserId"]; //Loggend in user.
        
        //Version ID
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[getStuCurriculum valueForKey:@"CurrentVersionId"] intValue]] forKey:@"VersionId"];
        
        //ProcedureId
        NSDictionary *levelDICT = [StudentDatabase getSALevelForLevelID:
                                   [[subLevelDict valueForKey:@"SALevelId"] intValue]];
        
        [curriculumDictionary 
         setValue:[NSNumber numberWithInt:[[levelDICT valueForKey:@"ProcedureId"] intValue]] 
         forKey:@"ProcedureId"]; 
        
        //StepCode And StepId
        NSDictionary *stepDict = [StudentDatabase getSAStepForStepId:[[sessionInfo valueForKey:@"StepId"] intValue]];
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[stepDict valueForKey:@"ACESAStepId"] intValue]] forKey:@"StepId"];
        [curriculumDictionary setValue:[stepDict valueForKey:@"Name"] forKey:@"StepCode"];  //Map with name
        
        
        //SubLevelId And SubLevelName
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[subLevelDict valueForKey:@"ACESASubLevelid"] intValue]] forKey:@"SubLevelId"];
        [curriculumDictionary setValue:[subLevelDict valueForKey:@"Name"] forKey:@"SubLevelName"];
        
        //Trials
        NSArray *trialList = [StudentDatabase getSAActiveTrialsForActiveSessionID:sessionId];
        NSMutableArray *trialItems = [[NSMutableArray alloc] init];
        
        for (NSDictionary *trial in trialList) {
            
            //Generate trial dictionary.
            NSMutableDictionary *trialInfoDict = [[NSMutableDictionary alloc] init];
            [trialInfoDict setValue:[NSNumber numberWithInt:0] forKey:@"Id"];
            
            NSNumber *trueVal = [NSNumber numberWithBool:TRUE];
            NSNumber *falseVal = [NSNumber numberWithBool:NO]; 
            
            if ([[trial valueForKey:@"Minus"] intValue]) {
                [trialInfoDict setValue:trueVal forKey:@"Minus"];
            }else{
                [trialInfoDict setValue:falseVal forKey:@"Minus"];
            }
            
            if ([[trial valueForKey:@"MinusP"] intValue]) {
                [trialInfoDict setValue:trueVal forKey:@"MinusP"];
            }else{
                [trialInfoDict setValue:falseVal forKey:@"MinusP"];
            }
            
            if ([[trial valueForKey:@"NR"] intValue] ) {
                [trialInfoDict setValue:trueVal forKey:@"NoResponse"];
            }else{
                [trialInfoDict setValue:falseVal forKey:@"NoResponse"];
            }
            
            if ([[trial valueForKey:@"Plus"] intValue] ) {
                [trialInfoDict setValue:trueVal forKey:@"Plus"];
            }else{
                [trialInfoDict setValue:falseVal forKey:@"Plus"];
            }
            
            if ([[trial valueForKey:@"PlusP"] intValue]) {
                [trialInfoDict setValue:trueVal forKey:@"PlusP"];
            }else{
                [trialInfoDict setValue:falseVal forKey:@"PlusP"];
            }
            
            [trialInfoDict setValue:[NSNumber numberWithInt:
                                     [[trial valueForKey:@"TrialNumber"] intValue]] forKey:@"TrialNumber"];
            
            [trialItems addObject:trialInfoDict];
        }
        
        [curriculumDictionary setValue:trialItems forKey:@"Trials"];
        [curriculumlist addObject:curriculumDictionary];
        curriculumDictionary = nil;
    }
    
    return curriculumlist;
}

@end
