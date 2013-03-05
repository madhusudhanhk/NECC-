//
//  AESDataManager.h
//  WebServices
//
//  Created by Santosh Kumar on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

#define generateDict_(...) [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]

#define  isInternalServer 0
#define isExternalServer 0
#define isProduction 1

#define kServer isProduction

static NSString *kConfigurationProductionURL = @"https://autismcurriculum.org/resources/xmls/ApiConfig.xml"; 
static NSString *kConfigurationInternalDevURL = @"https://172.16.150.31/Resources/xmls/ApiConfig.xml";
static NSString *kConfigurationExternalDevURL = @"https://121.244.158.94/Resources/xmls/ApiConfig.xml";

//Keys
static NSString *ITCurriculam_Key = @"ITCurriculums";
static NSString *SACurriculam_Key = @"SACurriculums";
static NSString *TACurriculam_Key =  @"TACurriculums";
static NSString *kData_Key = @"Data";
static NSString *key_SessionID = @"Session-Id";
static NSString *key_Host = @"Host";
static NSString *key_Content_Type = @"Content-Type";


//Json Keys
static NSString *key_ID = @"Id"; 
static NSString *key_Name = @"Name"; 
static NSString *key_IEPQuarter = @"IEPQuarter"; 

//TODO:Remove base string later.
static NSString *kBaseString = @"https://121.244.158.94/AceService/AceService.svc";

typedef enum 
{
    eConfigurationReq,
    eLoginReq,
    eSchoolListReq,
    eTeamList,
    eStudentList,
    eCurriculamDetails,
    eMasterData,
    eSyncTASession,
    eSyncITSession,
    eSyncSASession,
    eRequestPassword,
    eSyncData,
    eCurriculumBasedPastData,
    eActivationIdBasedCurriculumDetail,
    eCurriculumVersionId,
    eCurriculumManualPull,
    eNone
}API_TYPE;

@protocol ACEConnectionManagerDelegate;

@interface ACEDataManager : NSObject <ASIHTTPRequestDelegate>
{
    id __unsafe_unretained delegate;
    ASIHTTPRequest *apiRequest;
    NSMutableArray *responseData;
    API_TYPE apiReqType;
    NSString *baseURL;
}

@property (unsafe_unretained)  id  delegate;
@property (nonatomic, retain) NSString *sessionToken;
@property (strong) NSMutableArray *responseData;
@property (retain) NSString *baseURL;

- (id)initWithDelegate:(id)_delegate;

- (NSString*)getAPIURL;
- (NSString*)getAPIType;
- (NSString*)getMessageBody;
- (void)generateRequest;

- (void)cancelRequest;
- (API_TYPE)requestType;

@end

@interface ACEDataManager ( ACEDataManager )

- (void)ACEConnectionManager:(ACEDataManager*)manager didRecieveResponse:(NSDictionary*)response;
- (void)ACEConnectionManager:(ACEDataManager*)manager didFinishLoadingData:(NSMutableArray*)responseData;
- (void)ACEConnectionManager:(ACEDataManager*)manager didRecieveError:(NSError*)error;
- (NSURLCredential*)userCredentialsForConnectionOnRecievingAuthenticationChallenge;

@end
