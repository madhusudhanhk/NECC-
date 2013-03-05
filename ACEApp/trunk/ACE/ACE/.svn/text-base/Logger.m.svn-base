//
//  Logger.m
//  WebServices
//
//  Created by Santosh Kumar on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Logger.h"

@implementation Logger

+ (void) log:(NSString*) msg, ...
{
#if TARGET_IPHONE_SIMULATOR
	if(msg && [msg length]>0)
	{
		va_list argumentList;
		va_start(argumentList, msg);
		va_end(argumentList);
		NSLogv(msg, argumentList);
	}
#endif
}

+ (void) logP:(NSString*) msg, ...
{
	if(msg && [msg length]>0)
	{
		va_list argumentList;
		va_start(argumentList, msg);
		va_end(argumentList);
		NSLogv(msg, argumentList);
	}
}

@end
