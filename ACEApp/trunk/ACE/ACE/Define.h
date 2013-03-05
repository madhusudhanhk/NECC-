


/*
 *  System Versioning Preprocessor Macros
 */ 

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/* Search Option parameters */
 
#define kLocationButtonTag @"34789"
#define kExperienceButtonTag @"7858"
#define kRoleButtonTag @"8967"
#define kSATrailNumber 0
#define kITTrailNumber 0

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//ACCEPTABLE_CHARECTERS for staff name 

#define ACCEPTABLE_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
//enum for Current SessionType

typedef enum {
    noCurrentSeeion,
	typeSA,
	typeTA,
	typeIT
    
} CurrentSessionType;


//enum for New SessionType

typedef enum {
    
	newSession,
    oldSession
    
} IsNewSessionStartType;


//enum for MstChainingSequence

typedef enum {
    
	Forward,
    Backward,
    TotalTask
    
} MstChainingSequence;

//User Defaults Constant
static NSString *key_URL = @"url_loc";
static NSString *key_Location_Name = @"loc_name";
static NSString *kTimerValue = @"time";
static NSString *kRecammondation = @"Recammondation";
static NSString *kURLLocation =@"url_loc";
static NSString *kfirstLaunch =@"First_Launch";
static NSString *kPosition =@"user_position";
static NSString *kIsLoggedOut =@"isLoggedOf";
static NSString *kClickCheckInLocation =@"click_check";
static NSString *kClickCheckInLogin =@"login_check";
static NSString *kClickLoginOnBackground =@"login_back";

