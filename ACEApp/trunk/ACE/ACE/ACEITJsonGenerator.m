//
//  ACESyncManagerIT.m
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEITJsonGenerator.h"
#import "StudentDatabase.h"
#import "ACEUTILMethods.h"
#import "Logger.h"

@implementation ACEITJsonGenerator

- (NSArray*)getCurriculumListWithStuCurriculumId:(int)stuCurriculumId
{
    NSMutableArray *curriculumlist = [[NSMutableArray alloc] init];
    NSArray *sessionList = [StudentDatabase getActiveStudentSessionDetailWithStuCurriculumId:stuCurriculumId];
    
    for (NSDictionary *session in sessionList) {
        NSArray *activeSessionList = [StudentDatabase getITActiveSessionWithActiveStudentSessionId:
                                      [[session valueForKey:@"ActiveStudentSessionId"] intValue]];
        
        for (NSDictionary *sessionInfo in activeSessionList) {
            
            NSMutableDictionary *curriculumDictionary = [[NSMutableDictionary alloc] init];
            int sessionId = [[sessionInfo valueForKey:@"ITActiveSessionId"] intValue];
            
            //Read Student Info
            //Get Student Info
            NSDictionary *studDict = [StudentDatabase getActiveStudentSessionDetailWithActiveStudentSessionId:[[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
            
            //Stu Curriculum Details.
            NSDictionary *getStuCurriculum = [StudentDatabase getStuCurriculumDetailsForCurriculumWithStuCurriculumId:[[studDict valueForKey:@"StuCurriculumId"] intValue]];
            
            //Read Student Info
            //Get Student ActiveSession Details.
            NSDictionary *studentInfo = [StudentDatabase getDetailsOfStudentWithACEStudentId:self.studentId];
            
            //JSON Structure
            //     {"DataEntryStatus":null,"EnableEmailNotification":true,"EntryDate":"\/Date(1343327400000+0530)\/","Id":null,"Order":1,"Quarter":1,"SessionKey":"edf4da74-535a-4099-8f9f-7c45860db41a","SettingId":1007,"SettingName":"Home 1","Staff":"xyz","StatusId":4,"StatusName":"Discontinued","TrialTypeId":2,"TrialTypeName":"TR","UserId":1,"VersionId":5,"ContextId":13,"ContextName":"A1","StepCode":"FM","StepId":576,"Trials":[{"Id":0,"Minus":true,"NoResponse":false,"Plus":false,"PlusP":false,"TrialNumber":1}],"WeekendingDate":"\/Date(1338661800000+0530)\/"}
            
            //JSON Keys: DataEntryStatus,EnableEmailNotification,EntryDate,Id,Order,Quarter,SessionKey,SettingId,SettingName,
            //Staff,StatusId,StatusName,TrialTypeId,TrialTypeName,UserId,VersionId,ContextId,ContextName,StepCode,StepId,
            //WeekendingDate
            
            //DataEntryStatus
            [curriculumDictionary setValue:[NSNull null] forKey:@"DataEntryStatus"]; //Leave null.
            
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
            
            //ID
            [curriculumDictionary setValue:[NSNull null] forKey:@"Id"]; //Ignore: null.
            
            //Order
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"Order"] intValue]] forKey:@"Order"];
            
            //Quarter
            [curriculumDictionary setValue:
             [NSNumber numberWithInt:[[studentInfo valueForKey:@"Quarter"] intValue]] forKey:@"Quarter"]; 
            
            
            //SessionKey
            [curriculumDictionary setValue:self.guid forKey:@"SessionKey"];
            
            //Setting Id and Name (No Setting for ID and Name)
            //        int settingId = 0;
            //        NSString *settingName = @""; //Empty string.
            //        if ([sessionInfo valueForKey:@"MstSettingId"]) {
            //           
            //            settingId = [[sessionInfo valueForKey:@"MstSettingId"] intValue];
            //            NSDictionary *settingsDict = [StudentDatabase getMstSettingForMstSettingsId:[[sessionInfo valueForKey:@"MstSettingId"] intValue]];
            //            settingName = [settingsDict valueForKey:@"Name"];
            //        }
            
            //        [curriculumDictionary setValue:[NSNumber numberWithInt:settingId] forKey:@"SettingId"];
            //        [curriculumDictionary setValue:settingName forKey:@"SettingName"];
            
            //Staff
            [curriculumDictionary setValue:[sessionInfo valueForKey:@"Staff"] forKey:@"Staff"];
            
            //StatusId and StatusName
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"MstStatusId"] intValue]] forKey:@"StatusId"];
            NSDictionary *statusDict = [StudentDatabase getMstStatusForMstStatusId:[[sessionInfo valueForKey:@"MstStatusId"] intValue]];
            [curriculumDictionary setValue:[statusDict valueForKey:@"Name"] forKey:@"StatusName"];
            [curriculumDictionary setValue:[statusDict valueForKey:@"Name"] forKey:@"StatusName"];
            
            //TrialTypeId and TrialTypeName
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]] forKey:@"TrialTypeId"];
            NSDictionary *trialDict = [StudentDatabase getMstTrialTypeForMstTrialTypeId:[[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]];
            [curriculumDictionary setValue:[trialDict valueForKey:@"Name"] forKey:@"TrialTypeName"];
            
            //UserId
            [curriculumDictionary setValue:[NSNumber numberWithInt:self.userId] forKey:@"UserId"]; //Loggend in user.
            
            //StuCurriculum Id
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[getStuCurriculum valueForKey:@"CurrentVersionId"] intValue]] forKey:@"VersionId"];
            
            //ContextId and Name
            NSDictionary *contextInfo = [StudentDatabase getITContenxtInfoWithITContextId:[[sessionInfo valueForKey:@"ITContextId"] intValue]];
            [curriculumDictionary setValue:[NSNumber numberWithInt:
                                            [[contextInfo valueForKey:@"ACEITContextId"] intValue]] forKey:@"ContextId"];
            
            [curriculumDictionary setValue:[contextInfo valueForKey:@"Name"] forKey:@"ContextName"];
            
            
            //ITMIPId - Map to ITMIP.
            NSDictionary *ITMIPID = [StudentDatabase 
                                     getITMIPDetailsWithITMIPID:[[sessionInfo valueForKey:@"ITMIPId"] intValue]];
            [curriculumDictionary setValue:
            [NSNumber numberWithInt:[[ITMIPID valueForKey:@"ACEITMIPId"] intValue]] forKey:@"StepId"];
            [curriculumDictionary setValue:[ITMIPID valueForKey:@"Name"] forKey:@"StepCode"];
            
            //WeekendingDate
           date = [ACEUTILMethods getDateFromString:[sessionInfo valueForKey:@"WeekEndingDate"]];
            jsonDateFrom = [NSString stringWithFormat:@"/Date(%.0f000)/", [date timeIntervalSince1970]];
            [curriculumDictionary setValue:jsonDateFrom forKey:@"WeekendingDate"];
            
            NSArray *trialList = [StudentDatabase getITActiveTrialWithActiveITActiveSessionId:sessionId];
            NSMutableArray *trialItems = [[NSMutableArray alloc] init];
            
            for (NSDictionary *trial in trialList) {
                
                //JSON: {"Id":0,"Minus":true,"NoResponse":false,"Plus":false,"PlusP":false,"TrialNumber":1}
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
                
                if ([[trial valueForKey:@"NR"] intValue]) {
                    [trialInfoDict setValue:trueVal forKey:@"NoResponse"];
                }else{
                    [trialInfoDict setValue:falseVal forKey:@"NoResponse"];
                }
                
                if ([[trial valueForKey:@"Plus"] intValue]) {
                    [trialInfoDict setValue:trueVal forKey:@"Plus"];
                }else{
                    [trialInfoDict setValue:falseVal forKey:@"Plus"];
                }
                
                if ([[trial valueForKey:@"PlusP"] intValue]) {
                    [trialInfoDict setValue:trueVal forKey:@"PlusP"];
                }else{
                    [trialInfoDict setValue:falseVal forKey:@"PlusP"];
                }
                
                [trialInfoDict setValue:[NSNumber numberWithInt:[[trial valueForKey:@"TrialNumber"] intValue]] 
                                 forKey:@"TrialNumber"];
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
    
    NSArray *activeSessionList = [StudentDatabase getITActiveSessionWithActiveStudentSessionId:studentSessionId];
    
    for (NSDictionary *sessionInfo in activeSessionList) {
        
        NSMutableDictionary *curriculumDictionary = [[NSMutableDictionary alloc] init];
        int sessionId = [[sessionInfo valueForKey:@"ITActiveSessionId"] intValue];
        
        //Read Student Info
        //Get Student Info
        NSDictionary *studDict = [StudentDatabase getActiveStudentSessionDetailWithActiveStudentSessionId:[[sessionInfo valueForKey:@"ActiveStudentSessionId"] intValue]];
        
        //Stu Curriculum Details.
        NSDictionary *getStuCurriculum = [StudentDatabase getStuCurriculumDetailsForCurriculumWithStuCurriculumId:[[studDict valueForKey:@"StuCurriculumId"] intValue]];
        
        //Read Student Info
        //Get Student ActiveSession Details.
        NSDictionary *studentInfo = [StudentDatabase getDetailsOfStudentWithACEStudentId:self.studentId];
        
        //JSON Structure
        //     {"DataEntryStatus":null,"EnableEmailNotification":true,"EntryDate":"\/Date(1343327400000+0530)\/","Id":null,"Order":1,"Quarter":1,"SessionKey":"edf4da74-535a-4099-8f9f-7c45860db41a","SettingId":1007,"SettingName":"Home 1","Staff":"xyz","StatusId":4,"StatusName":"Discontinued","TrialTypeId":2,"TrialTypeName":"TR","UserId":1,"VersionId":5,"ContextId":13,"ContextName":"A1","StepCode":"FM","StepId":576,"Trials":[{"Id":0,"Minus":true,"NoResponse":false,"Plus":false,"PlusP":false,"TrialNumber":1}],"WeekendingDate":"\/Date(1338661800000+0530)\/"}
        
        //JSON Keys: DataEntryStatus,EnableEmailNotification,EntryDate,Id,Order,Quarter,SessionKey,SettingId,SettingName,
        //Staff,StatusId,StatusName,TrialTypeId,TrialTypeName,UserId,VersionId,ContextId,ContextName,StepCode,StepId,
        //WeekendingDate
        
        //DataEntryStatus
        [curriculumDictionary setValue:[NSNull null] forKey:@"DataEntryStatus"]; //Leave null.
        
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
        
        
        //ID
        [curriculumDictionary setValue:[NSNull null] forKey:@"Id"]; //Ignore: null.
        
        //Order
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"Order"] intValue]] forKey:@"Order"];
        
        //Quarter
        [curriculumDictionary setValue:
         [NSNumber numberWithInt:[[studentInfo valueForKey:@"Quarter"] intValue]] forKey:@"Quarter"]; 
        
        
        //SessionKey
        [curriculumDictionary setValue:self.guid forKey:@"SessionKey"];
        
        //Setting Id and Name (No Setting for ID and Name)
        //        int settingId = 0;
        //        NSString *settingName = @""; //Empty string.
        //        if ([sessionInfo valueForKey:@"MstSettingId"]) {
        //           
        //            settingId = [[sessionInfo valueForKey:@"MstSettingId"] intValue];
        //            NSDictionary *settingsDict = [StudentDatabase getMstSettingForMstSettingsId:[[sessionInfo valueForKey:@"MstSettingId"] intValue]];
        //            settingName = [settingsDict valueForKey:@"Name"];
        //        }
        
        //        [curriculumDictionary setValue:[NSNumber numberWithInt:settingId] forKey:@"SettingId"];
        //        [curriculumDictionary setValue:settingName forKey:@"SettingName"];
        
        //Staff
        [curriculumDictionary setValue:[sessionInfo valueForKey:@"Staff"] forKey:@"Staff"];

        //StatusId and StatusName
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstStatusId"] intValue]] forKey:@"StatusId"];
        NSDictionary *statusDict = [StudentDatabase getMstStatusForMstStatusId:[[sessionInfo valueForKey:@"MstStatusId"] intValue]];
        [curriculumDictionary setValue:[statusDict valueForKey:@"Name"] forKey:@"StatusName"];
        [curriculumDictionary setValue:[statusDict valueForKey:@"Name"] forKey:@"StatusName"];
        
        //TrialTypeId and TrialTypeName
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]] forKey:@"TrialTypeId"];
        NSDictionary *trialDict = [StudentDatabase getMstTrialTypeForMstTrialTypeId:[[sessionInfo valueForKey:@"MstTrialTypeId"] intValue]];
        [curriculumDictionary setValue:[trialDict valueForKey:@"Name"] forKey:@"TrialTypeName"];
        
        //UserId
        [curriculumDictionary setValue:[NSNumber numberWithInt:self.userId] forKey:@"UserId"]; //Loggend in user.
        
        //StuCurriculum Id
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[getStuCurriculum valueForKey:@"CurrentVersionId"] intValue]] forKey:@"VersionId"];
        
        //ContextId and Name
         NSDictionary *contextInfo = [StudentDatabase getITContenxtInfoWithITContextId:[[sessionInfo valueForKey:@"ITContextId"] intValue]];
        [curriculumDictionary setValue:[NSNumber numberWithInt:
                                        [[contextInfo valueForKey:@"ACEITContextId"] intValue]] forKey:@"ContextId"];
       
        [curriculumDictionary setValue:[contextInfo valueForKey:@"Name"] forKey:@"ContextName"];
        
        
        //ITMIPId - Map to ITMIP.
        NSDictionary *ITMIPID = [StudentDatabase 
                                 getITMIPDetailsWithITMIPID:[[sessionInfo valueForKey:@"ITMIPId"] intValue]];
        [curriculumDictionary setValue:
         [NSNumber numberWithInt:[[ITMIPID valueForKey:@"ACEITMIPId"] intValue]] forKey:@"StepId"];
        [curriculumDictionary setValue:[ITMIPID valueForKey:@"Name"] forKey:@"StepCode"];
        
        //WeekendingDate
        date = [ACEUTILMethods getDateFromString:[sessionInfo valueForKey:@"WeekEndingDate"]];
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"Z"]; //for getting the timezone part of the date only.
        jsonDateFrom = [NSString stringWithFormat:@"/Date(%.0f000%@)/", [date timeIntervalSince1970],[formatter stringFromDate:date]];
        [curriculumDictionary setValue:jsonDateFrom forKey:@"WeekendingDate"];
        
        NSArray *trialList = [StudentDatabase getITActiveTrialWithActiveITActiveSessionId:sessionId];
        NSMutableArray *trialItems = [[NSMutableArray alloc] init];
        
        for (NSDictionary *trial in trialList) {
            
            //JSON: {"Id":0,"Minus":true,"NoResponse":false,"Plus":false,"PlusP":false,"TrialNumber":1}
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
            
            if ([[trial valueForKey:@"NR"] intValue]) {
                [trialInfoDict setValue:trueVal forKey:@"NoResponse"];
            }else{
                [trialInfoDict setValue:falseVal forKey:@"NoResponse"];
            }
            
            if ([[trial valueForKey:@"Plus"] intValue]) {
                [trialInfoDict setValue:trueVal forKey:@"Plus"];
            }else{
                [trialInfoDict setValue:falseVal forKey:@"Plus"];
            }
            
            if ([[trial valueForKey:@"PlusP"] intValue]) {
                [trialInfoDict setValue:trueVal forKey:@"PlusP"];
            }else{
                [trialInfoDict setValue:falseVal forKey:@"PlusP"];
            }
            
            [trialInfoDict setValue:[NSNumber numberWithInt:[[trial valueForKey:@"TrialNumber"] intValue]] 
                             forKey:@"TrialNumber"];
            [trialItems addObject:trialInfoDict];
        }
        
        [curriculumDictionary setValue:trialItems forKey:@"Trials"];
        [curriculumlist addObject:curriculumDictionary];
        curriculumDictionary = nil;
    }
    
    return curriculumlist;
}

@end
