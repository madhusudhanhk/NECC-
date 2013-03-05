//
//  ViewController.m
//  AlertViewTest
//
//  Created by Paul Peelen on 2011-11-30.
//  Copyright (c) 2011 9697271014. All rights reserved.
//

#import "ReachabilityViewController.h"

@implementation ReachabilityViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self checkForWIFIConnection];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (bool)checkForNetworkConnection{
    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];  
    
   if(netStatus !=NotReachable){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Network Error!", @"AlertView") 
                                                            message:NSLocalizedString(@"Internet is down, Please try again later.", @"AlertView") 
                                                           delegate:self 
                                                  cancelButtonTitle:NSLocalizedString(@"Ok", @"AlertView") 
                                                  otherButtonTitles:nil];
        [alertView show];
       
        
    }
  
   return YES;  
}
- (bool)checkForWIFIConnection {
    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
    if (netStatus!=ReachableViaWiFi)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No WIFI available!", @"AlertView") 
                                                            message:NSLocalizedString(@"You have no wifi connection available. Please connect to a WIFI network.", @"AlertView") 
                                                           delegate:self 
                                                  cancelButtonTitle:NSLocalizedString(@"Ok", @"AlertView") 
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }
     return YES;
    }
/*
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    }
}
*/

@end
