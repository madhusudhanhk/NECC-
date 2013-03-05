//
//  ACEJsonGenerator.h
//  WebServices
//
//  Created by Santosh Kumar on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACEJsonGenerator : NSObject

@property (assign) int userId;
@property (retain) NSString *guid;
@property (assign) int studentId;

- (id)initWithGUID:(NSString*)_guid andUserId:(int)_userId andStudentId:(int)studId;

- (NSArray*)getCurriculumListWithActiveStudentSessionId:(int)studentSessionId;
- (NSArray*)getCurriculumListWithStuCurriculumId:(int)stuCurriculumId;

@end
