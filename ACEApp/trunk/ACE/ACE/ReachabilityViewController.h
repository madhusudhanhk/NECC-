//
//  ViewController.h
//  AlertViewTest
//
//  Created by Paul Peelen on 2011-11-30.
//  Copyright (c) 2011 9697271014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface ReachabilityViewController : UIViewController <UIAlertViewDelegate>

- (bool)checkForWIFIConnection;
- (bool)checkForNetworkConnection;

@end
