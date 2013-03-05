//
//  AECCurriculamDetailsManager.h
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACEDataManager.h"
#import "ACEStudent.h"
#import "ACEMasterDataManager.h"

//Curriculum parsing keys.

//IT Curriculums
static NSString *key_ITCurriculums = @"ITCurriculums";

//SA Curriculums
static NSString *key_SACurriculums = @"SACurriculums";

//TA Curriculum keys (DB Keys)

//TAPrmomp Table PRompt Keys
static NSString *key_TACurriculums = @"TACurriculums";
static NSString *key_TAPromptStepId = @"TAPromptStepId";
static NSString *key_TACurriculumId = @"TACurriculumId";
static NSString *key_ACETAPromptStepId =  @"ACETAPromptStepId";

//Step Table
static NSString *key_ACETAStepId = @"ACETAStepId";
static NSString *key_Description = @"Description";
static NSString *key_Order  = @"Order";

//Name already defined.

static NSString *key_CurriculumTypeId = @"CurriculumTypeId";
static NSString *key_CurriculumId = @"CurriculumId";
static NSString *key_CurriculumName = @"CurriculumName";
static NSString *key_ObjectiveNumber = @"ObjectiveNumber";
static NSString *key_UpdatedOn = @"UpdatedOn";
static NSString *key_ActivationId = @"ActivationId";
static NSString *key_CmType = @"CmType";
static NSString *key_MappingId = @"CmType";
static NSString *key_PublishedId = @"PublishedId";
static NSString *key_VersionId = @"VersionId";
static NSString *key_MstChainingSequenceId = @"MstChainingSequenceId";
static NSString *key_Code = @"Code";
static NSString *key_Date = @"Date";
static NSString *key_IndependentStep = @"IndependentStep";
static NSString *key_StepIndependent = @"StepIndependent";
static NSString *key_PromptStep = @"PromptStep";

static NSString *key_TrailType = @"TrailType";
static NSString *key_TrainingStep = @"TrainingStep";
static NSString *key_Steps = @"Steps";
static NSString *key_PromptSteps = @"PromptSteps";
static NSString *key_PastSession = @"PastSession";

//SACurriculum Fill Keys (For Generation)
static NSString *key_DeviceKey = @"DeviceKey";
static NSString *key_ITSessions = @"ITSessions";
static NSString *key_StudentName = @"StudentName";
static NSString *key_UserId = @"UserId";
static NSString *key_UserName = @"UserName";
static NSString *key_Version = @"Version";

static NSString *key_ACEStudentId = @"key_ACEStudentId";
static NSString *key_CurrentVersionId = @"CurrentVersionId";

@interface ACECurriculumDetailsManager : ACEDataManager

@property (nonatomic, retain) NSMutableArray *queue;

- (id)initWithStudentId:(ACEStudent *)student
             token:(NSString*)token
          delegate:(id)_delegate;

- (id)initWithStudentIds:(NSArray*)idList
                  token:(NSString*)token
                delegate:(id)_delegate;

- (void)loadCurriculamDetails;
- (void)loadCurriculamMasterData;
- (void)updateComplete;

@end

@interface ACECurriculumDetailsManager ( ACEDataManager )

- (void)ACECurriculamDetailsManagerDidRecieveEmptyIdList:(ACEDataManager*)manager;
- (void)ACECurriculamDetailsManagerDidREcieveAllCurriculum:(ACEDataManager*)manager withFailureDictionary:(NSDictionary*)dct;

@end

@interface ACECurriculumDetailsManager( )

//TA Curriculum
- (void)insertTACurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict;

//SA Curriculum
- (void)insertSACurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict;


//IT Curriculum
- (void)insertITCurriculums:(NSArray*)curriculumArray andActualDictionary:(NSDictionary*)rootDict;

@end
