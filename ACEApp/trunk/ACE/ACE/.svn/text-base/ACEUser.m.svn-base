//
//  ACEUser.m
//  WebServices
//
//  Created by Santosh Kumar on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEUser.h"
#import "Logger.h"

@implementation ACEUser

@synthesize ACEUserId;
@synthesize UserId;
@synthesize SessionId;
@synthesize LoginTime;
@synthesize LastSyncTime;

- (void)dealloc 
{
    self.SessionId = nil;
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

- (void)print
{
    [Logger log:@"User Info : USer ID: %d Id: %d",self.ACEUserId];
}

@end
