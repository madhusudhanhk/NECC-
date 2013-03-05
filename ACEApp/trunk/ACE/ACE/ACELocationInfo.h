//
//  LocationInfo.h
//  WebServices
//
//  Created by Santosh Kumar on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACELocationInfo : NSObject
{
    NSString *name;
    NSString *URL;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *URL;

- (void)print;

@end
