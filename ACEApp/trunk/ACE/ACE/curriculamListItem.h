//
//  curriculamListItem.h
//  NECC
//
//  Created by Aditi on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface curriculamListItem : NSObject{
    
    NSString *curriculamName;
    NSString *curriculamType;
    NSString *curriculamObjective;
}

@property(nonatomic,retain)NSString *curriculamName;
@property(nonatomic,retain)NSString *curriculamType;
@property(nonatomic,retain)NSString *curriculamObjective;

@end
