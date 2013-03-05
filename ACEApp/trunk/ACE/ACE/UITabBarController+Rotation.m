//
//  UITabBarController+Rotation.h
//  ACE
//
//  Created by Santosh Kumar on 9/11/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "UITabBarController+Rotation.h"

@implementation UITabBarController (Rotation)


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
