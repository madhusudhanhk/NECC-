//
//  ACEResetPasswordManager.h
//  WebServices
//
//  Created by Santosh Kumar on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACEDataManager.h"

@interface ACEResetPasswordManager : ACEDataManager

- (id)initWithEmailID:(NSString*)eId 
          delegate:(id)_delegate;

- (void)resetPassword;

@end

@interface ACEResetPasswordManager ( ACEResetPasswordManager )

- (void)ACEDataManagerDidResetPassword:(ACEResetPasswordManager*)manager;
- (void)ACEDataManagerDidResetPasswordFailed:(NSError*)error;

@end