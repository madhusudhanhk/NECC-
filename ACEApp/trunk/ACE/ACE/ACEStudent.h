//
//  AESStudent.h
//  WebServices
//
//  Created by Santosh Kumar on 8/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACEStudent : NSObject

@property (nonatomic, assign) int ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *IEPQuarter;
@property (assign) BOOL isSelected;

- (void)print;

@end
