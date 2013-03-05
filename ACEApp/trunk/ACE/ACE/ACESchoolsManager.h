//
//  ACESchoolsManager.h
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACEDataManager.h"

@interface ACESchoolsManager : ACEDataManager

- (id)initWithUserId:(int)UID
          token:(NSString*)token
          delegate:(id)_delegate;

- (void)loadSchoolList;

@end
