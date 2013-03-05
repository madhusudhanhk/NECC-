
#import "ACEDataCommunicator.h"
#import "PBUtilities.h"
#import "SBJSON.h"
#import "JSON.h"

#define dict_(...) [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]

@implementation ACEDataCommunicator

- (id) initWithURL: (NSURL *) newURL serviceName: (NSString *)inServiceName{

    self = [super initWithURL: newURL];
    if (self) {
       // _serviceName = [inServiceName copy];
    }
    return self;
}

+ (id)requestWithURL:(NSURL *)newURL serviceName: (NSString *)inServiceName; {    
    return [[[self alloc] initWithURL: newURL serviceName: inServiceName] autorelease];
}

+ (id) requestWithURL: (NSURL *)newURL 
          serviceName: (NSString *)inServiceName 
           usingCache: (id <ASICacheDelegate>)cache; {

    return [self requestWithURL:newURL serviceName: inServiceName usingCache: cache];
}

+(id)requestWithURL:(NSURL *)newURL{
     return [[[self alloc] initWithURL: newURL serviceName: nil] autorelease];
}
- (void)dealloc {
    [_serviceName release];
    _serviceName = nil;
    [super dealloc];
}

#pragma mark - 

- (void) setArguments:(NSString *)BodyMessage withSessionHeader:(NSString *)header ConnectionType:(NSString *)Type
{
    NSError *theError = nil;
    SBJSON * json = [[SBJSON alloc] init];
    //NSString *post = [json stringWithObject: methodCall error:&theError];
    NSString *post =BodyMessage;
    
    
    if (theError) {
       // PBLog(@"<Error: %@> while framing JSON-RPC", theError);
        [json release];
        return ;
    }
    
   // PBLog(@"%@", post);    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [post length]];
    [self addRequestHeader: @"Content-Type" value: @"application/json; char-set=utf-8" ];
    [self addRequestHeader: @"User-Agent" value: @"ACE iOS App" ];
    [self addRequestHeader: @"Content-Length" value:@"200" ];
    [self addRequestHeader:@"SessionId" value:@"68C989A6-6128-45CB-99B1-20DDA2D29E6E"];
    [self setRequestMethod: Type];
   [self setPostBody: [NSMutableData dataWithData: [post dataUsingEncoding:NSUTF8StringEncoding]]];// ASIHttp API setPostBody requires mutable data
    
    [json release];
}


- (NSDictionary *) responseDictionary; {
    
    NSData *data = [self responseData];
    
	if (!data) {
		return nil;
	}
	
    NSString * responseString = [[NSString alloc] initWithBytes: [data bytes] 
                                                         length: [data length] 
                                                       encoding: [self responseEncoding]];
    
    NSDictionary * responseDictionary = [responseString JSONValue];
    [responseString release]; 
    
	return responseDictionary;
}




@end
