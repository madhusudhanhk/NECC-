//
//  MyActiveSessions.h
//  ACE
//
//  Created by Aditi technologies on 8/8/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyActiveSessions : NSObject{
    
    NSString *studentName;
    NSString *curiculumName;
    NSString *curiculumType;
    NSString *discription;
    NSString *activeSessionId;
    NSString *activeStudentsessionId;
    NSString *aceStudentId;
    NSString *stucurrilumId;
    
    
}

@property(nonatomic,retain)NSString *studentName;
@property(nonatomic,retain)NSString *curiculumName;
@property(nonatomic,retain)NSString *curiculumType;
@property(nonatomic,retain)NSString *discription;
@property(nonatomic,retain)NSString *activeSessionId;
@property(nonatomic,retain)NSString *activeStudentsessionId;
@property(nonatomic,retain)NSString *aceStudentId;
@property(nonatomic,retain)NSString *stucurrilumId;

- (void)print;
@end
