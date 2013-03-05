//
//  AECPullManager.h
//  ACE
//
//  Created by Santosh Kumar on 8/26/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AECPullManager : NSObject

+ (AECPullManager *)getPullSyncManager;

//Add Remove Observer.
- (void)addSyncObserver:(id)syncObserver;
- (void)removeSyncObserver:(id)syncObserver;

- (void)initiatePull;

@end

@interface AECPullManager ( AECPullManager )

//Past Data
- (void)ACEPullManager:(AECPullManager*)manager shouldChangeTitleTo:(NSString*)title;
- (void)ACEPullManagerDidFinishLoading:(AECPullManager *)manager;
- (void)ACEPullManagerDidFinishLoading:(AECPullManager *)manager 
          didReceiveErrorWithErrorText:(NSString*)errorText andError:(NSError*)error;

@end