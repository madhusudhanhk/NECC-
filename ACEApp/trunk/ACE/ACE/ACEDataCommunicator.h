
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

@interface ACEDataCommunicator : ASIHTTPRequest{
    NSString * _serviceName;
}

+ (id)requestWithURL:(NSURL *)newURL serviceName: (NSString *)inServiceName;
+(id)requestWithURL:(NSURL *)newURL;

//- (void) setArguments:(NSString *)BodyMessage ConnectionType:(NSString *)Type;
- (void) setArguments:(NSString *)BodyMessage withSessionHeader:(NSString *)header ConnectionType:(NSString *)Type;


- (NSDictionary *) responseDictionary;

@end
