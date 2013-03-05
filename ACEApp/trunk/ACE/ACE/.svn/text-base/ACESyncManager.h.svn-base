//
//  ACESyncManager.h
//  WebServices
//
//  Created by Santosh Kumar on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACEDataManager.h"
#import "Define.h"
#import "ASIHTTPRequest.h"

@interface ACESyncManager : NSObject <ASIHTTPRequestDelegate>

+ (ACESyncManager *)getSyncManager;

- (void)syncCurriculumWithServer;
- (void)syncCuroculumWithServerInSynchronosMode;

//Add Remove Observer.
- (void)addSyncObserver:(id)syncObserver;
- (void)removeSyncObserver:(id)syncObserver;

@end

@interface ACESyncManager ( ACESyncManager )

- (void)ACESyncManageDidFinishSync:(ACESyncManager*)syncManager;
- (void)ACESyncManageDidSyncFailed:(ACESyncManager*)syncManager WithFailCount:(int)count;

@end
