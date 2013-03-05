//
//  Options.m
//  NECC
//
//  Created by Aditi on 18/06/12.
//  Copyright (c) 2012 Aditi Technology. All rights reserved.
//

#import "Options.h"
#import "XTFirstViewController.h"
#import "Reachability.h"
#import "ReachabilityViewController.h"
#import "LoginPage.h"
#import "ACESyncManager.h"
#import "ACEStudent.h"
#import "MBProgressHUD.h"
#import "AECPullManager.h"
#import "ACEStudent.h"

@interface  Options()

@property (retain) ACECurriculumPullManager *completePullManager;
@property (assign) BOOL isPartialSync;

- (void)initiateCurriculumPull;
- (void)beginPush;
//- (void) showProgressHudForManualInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
//- (void) hideManualSyncProgressHudInView:(UIView*)aView;
- (void)initiatePartialSync;
- (void)initiatePush;
- (void)presentView:(UIView*)background show:(BOOL)show;
- (void)selectItemInPicker;

@end

@implementation Options
@synthesize loginRequestTime;
@synthesize recomendation;
@synthesize syncTime;
@synthesize curriculamManager;
@synthesize completePullManager;
@synthesize isPartialSync;
@synthesize loginReqTimeBackView;

//#import "ColourFormat.h"


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Options", @"Options");
        self.tabBarItem.image = [UIImage imageNamed:@"Tab_setting_icon"];
        isPartialSync = NO;
    }
    return self;
}


- (IBAction)ShowRecommendations:(id)sender
{
    BOOL showRecommendation = (recomendation.on) ? YES : NO;
    NSUserDefaults *recomendationInfo = [NSUserDefaults standardUserDefaults];
    [recomendationInfo setValue:[NSNumber numberWithBool:showRecommendation] forKey:kRecammondation];
    [recomendationInfo synchronize];

}

- (IBAction)getSyncTime:(id)sender
{
    [self selectItemInPicker];
    [self presentView:loginReqTimeBackView show:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView 
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{
    return ([loginRequestTimeCount count]);
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row 
            forComponent:(NSInteger)component {
    return ([loginRequestTimeCount objectAtIndex:row]);
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    syncTime.text = [loginRequestTimeCount objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)logout
{
   
 if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) 
    {
     NSString *isLoggedOut = @"true";
     NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
     [loggedValue setValue:isLoggedOut forKey:kIsLoggedOut];
     [loggedValue synchronize];

     LoginPage *reference = [[LoginPage alloc]initWithNibName:@"LoginPage" bundle:[NSBundle mainBundle]];
     UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:reference];
     [self.parentViewController presentModalViewController:navController4 animated:YES];
       
    }
   else
   {
    NSString *isLoggedOut = @"true";
    NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
    [loggedValue setValue:isLoggedOut forKey:kIsLoggedOut];
    [loggedValue synchronize];
    
    LoginPage *reference = [[LoginPage alloc]initWithNibName:@"LoginPage" bundle:[NSBundle mainBundle]];
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:reference];
    [self.parentViewController presentModalViewController:navController4 animated:YES];
   }

}
/*
- (void) logOutFromApp
{
    NSString *isLoggedOut = @"true";
    NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
    [loggedValue setValue:isLoggedOut forKey:kIsLoggedOut];
    [loggedValue synchronize];
    LoginPage *reference = [[LoginPage alloc]initWithNibName:@"LoginPage" bundle:[NSBundle mainBundle]];
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:reference];
    [self.parentViewController presentModalViewController:navController4 animated:YES];
}

//Logout
- (void)logOut
{
    //If network available then initiate the push data to server.
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {
        NSString *isLoggedOut = @"true";
        NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
        [loggedValue setValue:isLoggedOut forKey:kIsLoggedOut];
        [loggedValue synchronize];
       [self showProgressHudForManualInView:self.view 
                                withTitle:NSLocalizedString(@"syncing_sessions_title", nil) andMsg:nil];
          //     [self showProgressHudInView:self.view withTitle:NSLocalizedString(@"syncing_sessions_title", nil) andMsg:nil];
        //Delay the sync for 1 sec. So that the above message can be shown.
        [self performSelector:@selector(beginPush) 
                   withObject:nil 
                   afterDelay:1.0f];
        
    }else{
        [self logOutFromApp];
    }
}
- (void) showProgressHudForManualInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG
{
    //Show HUD on main window. This will block the user.
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    
    //Hide HUD if any one displayed before.
    [MBProgressHUD hideHUDForView:mainWindow animated:NO];
    MBProgressHUD *aMBProgressHUD = [MBProgressHUD showHUDAddedTo:mainWindow animated:YES];
    aMBProgressHUD.labelText = aTitle;    
}

- (void) hideManualSyncProgressHudInView:(UIView*)aView
{
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD hideHUDForView:mainWindow animated:YES];
}
 */
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *navigationBarTitle = kApplicationName;
    self.view.backgroundColor =UIColorFromRGB(0xe7e6eb);
    self.navigationController.navigationBar.topItem.title = navigationBarTitle;
    //95def4
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x2eb5e4);
        
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self   action:@selector(logout)];
    
    loginRequestTimeCount = [[NSMutableArray alloc]init];
    [loginRequestTimeCount addObject:@"8"];
    [loginRequestTimeCount addObject:@"10"];
    [loginRequestTimeCount addObject:@"12"];
    [loginRequestTimeCount addObject:@"16"];
    loginReqTimeBackView.backgroundColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = logoutButton; 
    
    if (nil == [[NSUserDefaults standardUserDefaults] 
                valueForKey:kRecammondation]) {
        NSUserDefaults *recomendationInfo = [NSUserDefaults standardUserDefaults];
        [recomendationInfo setValue:[NSNumber numberWithBool:YES] forKey:kRecammondation];
        [recomendationInfo synchronize];
        [recomendation setOn:YES];
    }else{
            [recomendation setOn:NO];
        BOOL showRecommendation = [[[NSUserDefaults standardUserDefaults] 
                                    valueForKey:kRecammondation] boolValue];
        if (showRecommendation) {
            [recomendation setOn:YES];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    syncTime.text =  [[NSUserDefaults standardUserDefaults] objectForKey:kTimerValue];
    
     
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self presentView:loginReqTimeBackView show:NO];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


#pragma mark - Push Methods

- (void)initiatePush
{
    //Once Finished check network. If network available then initiate Sync.
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]
        != kNotReachable) {
        [self showProgressHudInView:self.view withTitle:NSLocalizedString(@"syncing_sessions_title", nil) andMsg:nil];
        
        //Delay the sync for 1 sec. So that the above message can be shown.
        [self performSelector:@selector(beginPush) 
                   withObject:nil 
                   afterDelay:1.0f];
        
    }else{
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:kInternetConnectionMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alt show];
        
    }
}

- (void)beginPush
{
    ACESyncManager *syncManager = [ACESyncManager getSyncManager];
    [syncManager addSyncObserver:self];
    [syncManager syncCurriculumWithServer];
}

- (void)ACESyncManageDidFinishSync:(ACESyncManager*)syncManager
{
    [syncManager removeSyncObserver:self];
 
    if (isPartialSync) {
        [self initiatePartialSync];
    }else{
            [self initiateCurriculumPull];
    }
}

- (void)ACESyncManageDidSyncFailed:(ACESyncManager*)syncManager WithFailCount:(int)count
{
    [syncManager removeSyncObserver:self];
    
    if (isPartialSync) {
        [self initiatePartialSync];
    }else{
        [self initiateCurriculumPull];
    }
}

- (void)ACEConnectionManager:(ACEDataManager*)manager didRecieveError:(NSError*)error
{
    [self hideProgressHudInView:self.view];
     self.curriculamManager = nil;
}

#pragma mark - Complete Sync

- (IBAction)syncwithServer:(UIButton*)sync;
{
    isPartialSync = NO;
    [self initiatePush];
}

- (void)initiateCurriculumPull
{
    NSMutableArray *studIDs = [[NSMutableArray alloc] init];
    NSArray *addedStud = [StudentDatabase getAddedStudents];
    for (NSDictionary *studDict in addedStud) {
        ACEStudent *newStud = [[ACEStudent alloc] init];
        newStud.ID = [[studDict valueForKey:@"StudentId"] intValue];
        newStud.name = [studDict valueForKey:@"Name"];
        [studIDs addObject:newStud];
        newStud = nil;
    }
    
    if ([studIDs count] > 0) {
        [self showProgressHudInView:self.view 
                          withTitle:NSLocalizedString(@"Loading Curriculum Details...", nil) andMsg:nil];
        
        NSString *sessionToken =  [StudentDatabase getLoggedInUserSessionId];
        self.completePullManager = [[ACECurriculumPullManager alloc] initWithStudentIds:studIDs
                                                                                  token:sessionToken
                                                                               delegate:self];
        [self.completePullManager loadCurriculamDetails];
    }else{
        [self hideProgressHudInView:self.view];
    }
}

- (void)ACECurriculumPullManagerDidFinishCurriculumLoading:(ACECurriculumPullManager*)pullManager
{
    self.completePullManager = nil;
    [self hideProgressHudInView:self.view];
    //Added by Madhusudhan , This is enable currentSessionType to noCurrentSession
    currentSessionType=noCurrentSeeion;
}

- (void)ACECurriculumPullManagerDidFail:(ACECurriculumPullManager*)pullManager error:(NSError*)error
{
    self.completePullManager = nil;
    [self hideProgressHudInView:self.view];
    
    

}

#pragma mark - Partial Sync

- (IBAction)partialSyncWithServer:(UIButton*)button
{
    isPartialSync = YES;
    [self initiatePush];
}

- (void)initiatePartialSync
{
    //If no of student is 0 then don't initiate pull.
    if ([StudentDatabase countOfAddedStudents] <= 0) {
        [self hideProgressHudInView:self.view];
        return;
    }
    
    [self showProgressHudInView:self.view withTitle:NSLocalizedString(@"version_check_title", nil) andMsg:nil];
    AECPullManager *pullManager = [AECPullManager getPullSyncManager];
    [pullManager addSyncObserver:self];
    [pullManager initiatePull];
}

- (void)ACEPullManager:(AECPullManager*)manager shouldChangeTitleTo:(NSString*)title
{
    [self showProgressHudInView:self.view withTitle:title andMsg:nil];
}

- (void)ACEPullManagerDidFinishLoading:(AECPullManager *)manager
{
    [self hideProgressHudInView:self.view];
    [manager removeSyncObserver:self];
}

- (void)ACEPullManagerDidFinishLoading:(AECPullManager *)manager 
          didReceiveErrorWithErrorText:(NSString*)errorText andError:(NSError*)error
{
    [self hideProgressHudInView:self.view];
    [manager removeSyncObserver:self];
}

#pragma mark - Showin/Hiding Indicator

- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG
{
    //Show HUD on main window. This will block the user.
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    
    //Hide HUD if any one displayed before.
    [MBProgressHUD hideHUDForView:mainWindow animated:NO];
    MBProgressHUD *aMBProgressHUD = [MBProgressHUD showHUDAddedTo:mainWindow animated:YES];
    aMBProgressHUD.labelText = aTitle;    
}

- (void) hideProgressHudInView:(UIView*)aView
{
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD hideHUDForView:mainWindow animated:YES];
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

- (IBAction)pickerCancel:(UIBarItem*)sender
{
    syncTime.text =  [[NSUserDefaults standardUserDefaults] objectForKey:kTimerValue]; 
    [self presentView:loginReqTimeBackView show:NO];
}

- (IBAction)pickerDone:(UIBarItem*)sender
{
    int index = [loginRequestTime selectedRowInComponent:0];
 
    if (index != -1) {
        syncTime.text = [loginRequestTimeCount objectAtIndex:index];
        NSString *timerSet = syncTime.text;
        NSUserDefaults *timerSetValue = [NSUserDefaults standardUserDefaults];
        [timerSetValue setValue:timerSet forKey:kTimerValue];
        [timerSetValue synchronize];
    }
    
    [self presentView:loginReqTimeBackView show:NO];
}

- (void)selectItemInPicker
{
    NSUserDefaults *timerSetValue = [NSUserDefaults standardUserDefaults];
    NSString *selectedTime = [timerSetValue valueForKey:kTimerValue];
    
    if ([selectedTime isEqualToString:@"8"]) {
        [loginRequestTime selectRow:0 inComponent:0 animated:NO];
    }else if([selectedTime isEqualToString:@"10"]) {
        [loginRequestTime selectRow:1 inComponent:0 animated:NO];
    }else if([selectedTime isEqualToString:@"12"]) {
        [loginRequestTime selectRow:2 inComponent:0 animated:NO];
    }else if([selectedTime isEqualToString:@"16"]) {
        [loginRequestTime selectRow:3 inComponent:0 animated:NO];
    }
}

@end
