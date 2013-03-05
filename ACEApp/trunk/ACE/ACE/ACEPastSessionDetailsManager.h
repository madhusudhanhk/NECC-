//
//  ACEPastSessionDetailsManager.h
//  ACE
//
//  Created by Santosh Kumar on 8/23/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACEActivationCurriculumDetails.h"

@interface ACEPastSessionDetailsManager : ACEActivationCurriculumDetails

- (void)loadPastDataDetails;

@end

@interface ACEPastSessionDetailsManager ( ACEPastSessionDetailsManager )

- (void)ACEPastSessionDetailsManagerDidFinishLoading:(ACEPastSessionDetailsManager*)manager WithFailCount:(int)failCount;

@end