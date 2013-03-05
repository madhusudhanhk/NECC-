//
//  ACEActivationCurriculumDetails.h
//  ACE
//
//  Created by Santosh Kumar on 8/23/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACECurriculumDetailsManager.h"

@interface ACEActivationCurriculumDetails : ACECurriculumDetailsManager

- (id)initWithVersionIds:(NSArray *)versionList
                   token:(NSString*)token
                delegate:(id)_delegate;

@end

@interface ACEActivationCurriculumDetails ( ACEActivationCurriculumDetails )

- (void)ACEActivationCurriculumDetailsDidFinishCurriculumLoading:(ACEActivationCurriculumDetails*)manager;

@end
