//
//  ACEUTILMethods.m
//  WebServices
//
//  Created by Santosh Kumar on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEUTILMethods.h"
#import "Constants.h"
#import "StudentDatabase.h"
#import "Logger.h"

@implementation ACEUTILMethods

+(NSString *)getUUID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    
    return uuidString;
}

+ (NSString *)getCurrentDate
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init]; 
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];  
    return ([DateFormatter stringFromDate:[NSDate date]]);
}

+ (NSString*)getCurrentDateByRemovingSpace
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init]; 
    [DateFormatter setDateFormat:@"yyyy-MM-ddhh:mm:ss"];  
    NSString *date = [DateFormatter stringFromDate:[NSDate date]];
    
    return date;
}

+ (NSString*)getDBPath
{
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    return databasePath1;
}

+ (NSDate*)getDateFromString:(NSString*)dateString
{
    //Asumption: Date is in format MM/dd/YYYY
    NSArray *itemsArray = [dateString componentsSeparatedByString:@"/"];
    
    int month = 0;
    int day = 0;
    int year = 0;
    
    if ([itemsArray count] > 0) {
        month = [[itemsArray objectAtIndex:0] intValue];
    }

    if ([itemsArray count] >= 1) {
        day = [[itemsArray objectAtIndex:1] intValue];
    }

    if ([itemsArray count] > 1) {
        year = [[itemsArray objectAtIndex:2] intValue];
    }
    
    NSDateComponents *dateComponent = [[NSDateComponents alloc] init];
    [dateComponent setDay:day];
    [dateComponent setMonth:month];
    [dateComponent setYear:year];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    NSDate *dateFromComp = [calendar dateFromComponents:dateComponent];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init]; 
    [DateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"]; 
    
    NSString *string = [DateFormatter stringFromDate:dateFromComp];
    NSDate *newDate = [DateFormatter dateFromString:string];
    
    return newDate;
}

+ (NSDate*) dateFromJSONString:(NSString *)dateString
{
    NSCharacterSet *charactersToRemove = [[ NSCharacterSet decimalDigitCharacterSet ] invertedSet ];
    NSString* milliseconds = [dateString stringByTrimmingCharactersInSet:charactersToRemove];   
    
    if (milliseconds != nil && ![milliseconds isEqualToString:@"62135596800000"]) {
        NSTimeInterval  seconds = [milliseconds doubleValue] / 1000;
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

//Returns unsynced data.
+ (int)getUnsyncedDataCount
{
    int unsyncedDataCount = 0;
    int unsyncedSessionsCount = [StudentDatabase countOfUnsyncedSessions];
    NSArray *saActiveSessions = [StudentDatabase getListOFSAActiveSessionIDs];
    NSArray *taActiveSessions = [StudentDatabase getListOFTAActiveSessionIDs];
    NSArray *itActiveSessions = [StudentDatabase getListOFITActiveSessionIDs];
    unsyncedDataCount = unsyncedSessionsCount 
                                            +  [saActiveSessions count] + 
                                                [taActiveSessions count] + 
                                                [itActiveSessions count]; 
    
    return unsyncedDataCount;
}

+ (int)getFinishedSessionsCount
{
    int unsyncedDataCount = 0;
    int unsyncedSessionsCount = [StudentDatabase countOfUnsyncedSessions];
    NSArray *saActiveSessions = [StudentDatabase getListOFSAFinishedSessionIDs];
    NSArray *taActiveSessions = [StudentDatabase getListOFTAFinishedSessionIDs];
    NSArray *itActiveSessions = [StudentDatabase getListOFITFinishedSessionIDs];
    unsyncedDataCount = unsyncedSessionsCount 
    +  [saActiveSessions count] + 
    [taActiveSessions count] + 
    [itActiveSessions count]; 
    
    return unsyncedDataCount;

}

+ (BOOL)shouldShowRecomendations
{
    BOOL show = NO;
}

@end
