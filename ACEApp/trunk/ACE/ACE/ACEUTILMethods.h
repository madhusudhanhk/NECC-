//
//  ACEUTILMethods.h
//  WebServices
//
//  Created by Santosh Kumar on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACEUTILMethods : NSObject

+(NSString *)getUUID;
+ (NSString *)getCurrentDate;
+ (NSString*)getCurrentDateByRemovingSpace;
+ (NSString*)getDBPath;
+ (NSDate*)getDateFromString:(NSString*)dateString;
+ (NSDate*) dateFromJSONString:(NSString *)dateString;
+ (int)getUnsyncedDataCount;
+ (int)getFinishedSessionsCount;
+ (BOOL)shouldShowRecomendations;

@end

