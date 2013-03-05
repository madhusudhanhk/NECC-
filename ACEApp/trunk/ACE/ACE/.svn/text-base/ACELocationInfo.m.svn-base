//
//  LocationInfo.m
//  WebServices
//
//  Created by Santosh Kumar on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACELocationInfo.h"
#import "Logger.h"

@implementation ACELocationInfo

@synthesize name;
@synthesize URL;

- (void)dealloc 
{
    self.name = nil;
    self.URL = nil;
    
#if !__has_feature(objc_arc)
   [super dealloc];
#endif
}

- (void)print
{
    [Logger log:@"Location Info : Name: %@ URL: %@",self.name,self.URL];
}

@end
