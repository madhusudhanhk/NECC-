//
//  ACEJsonGenerator.m
//  WebServices
//
//  Created by Santosh Kumar on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ACEJsonGenerator.h"

@implementation ACEJsonGenerator

@synthesize userId,studentId,guid;

- (id)initWithGUID:(NSString*)_guid andUserId:(int)_userId andStudentId:(int)studId
{
    self = [super init];
    if (self) {
        self.userId = _userId;
        self.studentId = _userId;
        self.guid = _guid;
    }
    
    return self;
}

- (NSArray*)getCurriculumListWithActiveStudentSessionId:(int)studentSessionId
{
    //Overriden by sub classes.
    return nil;
}

- (NSArray*)getCurriculumListWithStuCurriculumId:(int)stuCurriculumId
{
    return nil; //Overriden by sub classes.
}

@end
