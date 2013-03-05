//
//  Logger.h
//  WebServices
//
//  Created by Santosh Kumar on 8/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Logger : NSObject 
{
}
+ (void) log:(NSString*) msg, ...;
+ (void) logP:(NSString*) msg, ...;
@end
