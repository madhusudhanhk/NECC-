//
//  AESAuthenticationManager.h
//  WebServices
//
//  Created by Santosh Kumar on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACEDataManager.h"

static NSString *key_DeviceId = @"deviceId";
static NSString *key_username = @"username";
static NSString *key_password = @"password";

@interface ACEAuthenticationManager : ACEDataManager

- (id)initWithUser:(NSString*)userName 
          password:(NSString*)pwd
       andDeviceId:(NSString*)devId
          delegate:(id)_delegate;

- (void)validateUser;

@end

@interface ACEAuthenticationManager ( ACEDataManager )

- (void)ACEConnectionManager:(ACEDataManager*)manager didLoginSuscessfull:(NSMutableArray*)responseData;
- (void)ACEConnectionManagerDidLoginFailed:(ACEDataManager*)manager isAccountLocked:(BOOL)isLocked loginAttemptCount:(int)count;

@end
