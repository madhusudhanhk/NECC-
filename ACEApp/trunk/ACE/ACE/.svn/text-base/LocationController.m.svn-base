//
//  LocationController.m
//  ACE
//
//  Created by Test on 06/08/2012.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "LocationController.h"
#import "LoginPage.h"
#import "ACELocationInfo.h"
#import "Reachability.h"

@interface LocationController( )

- (void)presentView:(UIView*)background show:(BOOL)show;

@end

@implementation LocationController
@synthesize locationText;
@synthesize configManager;

- (void)loadConfiguration
{
    self.configManager = [[ACEConfigurationManager alloc]  initWithDelegate:self];
    [self.configManager getConfugurationXML];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)selectLocation:(id)sender
{
    if ([location count] > 0) {
        [self presentView:locationPickerBack show:YES];
    }else{
        if ([[Reachability reachabilityForInternetConnection] isReachable]) {
            [self showProgressHudInView:self.view withTitle:@"Loading Location..." andMsg:nil]; 
            [self loadConfiguration];
        }else{
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:kInternetConnectionMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alt    show];
        }
    }
}

- (IBAction)continueButton:(id)sender
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) 
    {
    NSString *isLoggedOut = @"1";
    NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
    [loggedValue setValue:isLoggedOut forKey:kClickCheckInLocation];
    [loggedValue synchronize];
    LoginPage *reference = [[LoginPage alloc]initWithNibName:@"LoginPage" bundle:[NSBundle mainBundle]];
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:reference];
    [self.parentViewController presentModalViewController:navController4 animated:YES]; 
    } else{
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:kInternetConnectionMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alt    show];
        
    }

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    count = 0;
    NSString *navigationBarTitle = kApplicationName;
    self.view.backgroundColor =UIColorFromRGB(0xe7e6eb);
    self.navigationController.navigationBar.topItem.title = navigationBarTitle;
    //95def4
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x2eb5e4);
    locButton.enabled = false;
    location = [[NSMutableArray alloc]init];
    [self showProgressHudInView:self.view withTitle:@"Loading Location..." andMsg:nil]; 
    //Show Indicator here.
    [self loadConfiguration];
    locationPickerBack.backgroundColor = [UIColor clearColor];
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView 
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{
    return ([location count]);
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row 
            forComponent:(NSInteger)component 
{
    NSString  *title = ((ACELocationInfo*)[location objectAtIndex:row]).name;
    return title;
}

- (void)pickerView:(UIPickerView *)thePickerView 
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
    ACELocationInfo *locInfo = [location objectAtIndex:row];
    NSString *locationTxt = locInfo.name;
    locationText.text = locationTxt;
}

- (void)ACEConnectionManager:(ACEDataManager*)manager didRecieveError:(NSError*)error
{
    [self hideProgressHudInView:self.view] ; 
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to retrieve information. Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
}

- (void)ACEConnectionManager:(ACEDataManager*)_manager didFinishLoadingData:(NSMutableArray*)responseData
{
    [self hideProgressHudInView:self.view] ; 
    [location addObjectsFromArray:responseData];
    [locationPicker reloadAllComponents];
}

- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG
{
    MBProgressHUD *aMBProgressHUD = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    aMBProgressHUD.labelText = aTitle;    
}

- (void) hideProgressHudInView:(UIView*)aView
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
}

- (void)presentView:(UIView*)background show:(BOOL)show
{
    CGRect viewRect = background.frame;
    
    if (show) {
        [self.view addSubview:background];
        viewRect.origin.y = CGRectGetMaxY(self.view.bounds);
        background.frame = viewRect;
        viewRect.origin.y = CGRectGetMaxY(self.view.bounds) - viewRect.size.height;
    }else{
        viewRect.origin.y = CGRectGetMaxY(self.view.bounds) - viewRect.size.height;
        background.frame = viewRect;
        viewRect.origin.y = CGRectGetMaxY(self.view.bounds);
    }
    
    [UIView animateWithDuration:0.25 
                     animations:^{ background.frame = viewRect;}  
                     completion:^(BOOL finished)
     { if(!show) [background removeFromSuperview];}];
    
}

- (IBAction)cancelPicker:(UIBarItem*)sender
{
    //Read From User Defaults.
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *prevLocation = [userDefault valueForKey:key_Location_Name];
    locationText.text = prevLocation;
    
    if (nil == prevLocation) {
        locationText.text = @"Select Location";
    }
    
    [self presentView:locationPickerBack show:NO];
}

- (IBAction)donePicker:(UIBarItem*)sender
{
    //Add to user defaults.
     ACELocationInfo *locInfo = [location objectAtIndex:[locationPicker selectedRowInComponent:0]];
    NSString *locationTxt = locInfo.name;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:locationTxt forKey:key_Location_Name];
    [userDefault setValue:locInfo.URL forKey:key_URL];
    [userDefault synchronize];
    [self presentView:locationPickerBack show:NO];
    locButton.enabled = YES;
}

@end
