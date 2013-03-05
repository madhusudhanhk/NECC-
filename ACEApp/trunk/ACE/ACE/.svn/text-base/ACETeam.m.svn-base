//
//  AESTeam.m
//  WebServices
//
//  Created by Santosh Kumar on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACETeam.h"
#import "Logger.h"

@implementation ACETeam

@synthesize  ID;
@synthesize name;

- (void)dealloc 
{
    self.name = nil;
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

- (void)print
{
    [Logger log:@"Team Info : Name: %@ Id: %d",self.name,self.ID];
}

@end
