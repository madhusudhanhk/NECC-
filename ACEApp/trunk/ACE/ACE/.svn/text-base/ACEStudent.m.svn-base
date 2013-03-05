//
//  AESStudent.m
//  WebServices
//
//  Created by Santosh Kumar on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEStudent.h"
#import "Logger.h"

@implementation ACEStudent

@synthesize  ID;
@synthesize name;
@synthesize IEPQuarter;
@synthesize isSelected;

- (void)dealloc 
{
    self.name = nil;
    self.IEPQuarter = nil;
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

- (void)print
{
    [Logger log:@"Student Info : Name: %@ IEPQuarter: %@ Id: %d",self.name,self.IEPQuarter,self.ID];
}

@end
