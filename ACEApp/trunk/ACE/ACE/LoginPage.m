//
//  LoginPage.m
//  NECC
//
//  Created by Parkash Goswami on 20/06/12.
//  Copyright (c) 2012 Aditi technology. All rights reserved.
//

#import "LoginPage.h"
#import "AppDelegate.h"
#import "RequestPassword.h"
#import "Reachability.h"
#import "ReachabilityViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#define myAppDelegate (XTAppDelegate *) [[UIApplication sharedApplication] delegate]
#import "ACEDataCommunicator.h"
#import "JSON.h"
#import "ACEAuthenticationManager.h"
#import "ACEUser.h"
#include "learnMore.h"
#import "ACESyncManager.h"
#import "ACESyncManager.h"
#import "ACEStudent.h"
#import "MBProgressHUD.h"
#import "AECPullManager.h"
#import "ACEUTILMethods.h"

#define generateDict_(...) [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]

#define kLoginAlertTag 5001

@interface LoginPage( )

@property (nonatomic, retain) ACEUser *aceUser;

- (void)AuthenticateUser;
- (void)updateUserDetailsOnLogin;
- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideProgressHudInView:(UIView*)aView;
- (void)initiateCurriculumPull;
- (void)beginPush;
- (void) showProgressHudForManualInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideManualSyncProgressHudInView:(UIView*)aView;
- (void)requestPasswordForACEUser;

@end

@implementation LoginPage

@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize scrollView;
@synthesize authManager;
@synthesize aceUser;
@synthesize curriculamManager;
@synthesize passwordRequest;

int counter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
 
    return self;
}

-(void)textFieldValidation{

    if (userNameTextField.text.length !=0 && passwordTextField.text.length !=0) {

        loginButton.enabled = YES;
    }
    
}

- (IBAction)LoginSucessfulPage:(id)sender
{    
    //[self checkNetworkStatus:nil];
    [userNameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    if([userNameTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""] ){
//        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"User id or Password is Empty" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alert show];
       // loginButton.enabled = NO;
        
    } 
    else {
       // loginButton.enabled = YES;
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {

        RequestPassword *textFieldValidation = [[RequestPassword alloc]init];
        bool result =  [textFieldValidation validateEmail:userNameTextField.text];
        if (result) {
            
            
            if (loginCountCheck ==2) {
                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"If you are unsure of your password, please request a new password or your account will be locked on your next incorrect attempt." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Request Password", nil];
                [alt setTag:1100];
                [alt show];
            
                
                // message = @"If you are unsure of your password, please request a new password or your account will be locked on your next incorrect attempt."; 
            } 
            else{
            [self showProgressHudInView:self.view withTitle:nil andMsg:nil];
            [self AuthenticateUser];
            }
    
        }
        else{
            loginButton.enabled = YES;
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"Incorrect Username" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alt show];
            
        }
        //  
     }
        else{
            
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:kInternetConnectionMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alt    show];
        }
        
        
    }

    
    
    // Added By Madhusudhan 
    currentSessionType=noCurrentSeeion;
    
    
}


- (NSString *)getCurrentDate
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init]; 
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];  
    return ([DateFormatter stringFromDate:[NSDate date]]);
}


#pragma mark - ASIHttp Delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if (alertView.tag ==1100){
        
      
        if (buttonIndex ==0){
            
            loginCountCheck=0;
        }
        
        
        if (buttonIndex ==1) {
            [self showProgressHudInView:self.view withTitle:nil andMsg:nil];
          //  [self AuthenticateUser];
            //Request for password.
            [self requestPasswordForACEUser];
        }
        
        
        
    }
    else if(alertView.tag == kLoginAlertTag)
    {
    
    if([title isEqualToString:@"Continue"])
    {
        
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable)
        {
            
            int UnsyncCount = [ACEUTILMethods getFinishedSessionsCount];
            if (UnsyncCount > 0)
            {
                [self showProgressHudForManualInView:self.view withTitle:NSLocalizedString(@"syncing_sessions_title", nil) andMsg:nil];
                
                //Delay the sync for 1 sec. So that the above message can be shown.
                [self performSelector:@selector(beginPush) 
                           withObject:nil 
                           afterDelay:0.1f]; //Initiate the sync chain.
            }
            else
            {
                //[self initiateCurriculumPull];
            }
            
            //  [[ACESyncManager getSyncManager] syncCurriculumWithServer];
        }
        
        [self updateUserDetailsOnLogin];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setValue:userNameTextField.text forKey:@"uname"];
                [userDefaults synchronize];

        [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarControlerDelegateMethod];    }
    else{
        [self hideProgressHudInView:self.view] ; 
       
//        NSLog(@"cancel");
    }
    }
}

#pragma mark - MBProgressHud

- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG
{
    MBProgressHUD *aMBProgressHUD = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    aMBProgressHUD.labelText = aTitle;    
}

- (void) hideProgressHudInView:(UIView*)aView
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
}

-(IBAction)RequestPassword{
    
    RequestPassword *passwordRequest = [[RequestPassword alloc]initWithNibName:@"RequestPassword" bundle:nil];
    [self presentModalViewController:passwordRequest animated:YES];
    //[self.navigationController pushViewController:reference animated:YES];
    
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
	return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [userNameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  
    NSLog(@"began editing");
    //loginButton.enabled = YES;

        [scrollView adjustOffsetToIdealIfNeeded];
}

- (void)textDidChange:(NSNotification*)notification
{
    loginButton.userInteractionEnabled = NO;
    loginButton.alpha = 0.5f;
    
    if (![userNameTextField.text isEqualToString:@""] && ![passwordTextField.text isEqualToString:@""]
        && nil != userNameTextField.text && nil != passwordTextField.text) {
        loginButton.userInteractionEnabled = YES;
        loginButton.alpha = 1.0f;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
       //  [self textFieldValidation];
}

//ABOUT US Functionality
-(IBAction)aboutUs:(id)sender{
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.acenecc.org"]];
}

//Learn More Page call
-(IBAction)learnMore:(id)sender{

    learnMore *reference = [[learnMore alloc]initWithNibName:@"learnMore" bundle:nil];
    reference.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.parentViewController presentModalViewController:reference animated:YES];
  
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *navigationBarTitle = kApplicationName;
    self.view.backgroundColor =UIColorFromRGB(0xe7e6eb);
    self.navigationController.navigationBar.topItem.title = navigationBarTitle;
    //loginButton.enabled = NO;
    //95def4
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x2eb5e4);

    counter = 0;
    scrollView.bounces = NO;
    
    loginButton.userInteractionEnabled = NO;
    loginButton.alpha = 0.5f;
    
    //Listen for notification UITextFieldTextDidChangeNotification
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(textDidChange:) 
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setScrollView:nil];
    passwordTextField.text = @"";
    userNameTextField.text = @""; 
}

- (void)viewWillAppear:(BOOL)animated
{ 

    loginCountCheck=0;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    passwordTextField.text = nil;
    userNameTextField.text = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    return UIInterfaceOrientationIsPortrait(interfaceOrientation);

}

- (void)AuthenticateUser
{
    //For testing values are hard coded. Uncomment below lines.3
    

    // self.authManager = [[ACEAuthenticationManager alloc] initWithUser:@"neccdev@aditi.com" password:@"Welcome01!" andDeviceId:@"aksdj-akd-994-kfk" delegate:self];
   // [self.authManager validateUser];
  //  return;

    //End comment above code ater testing.
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *uniqueIdentifier = [device uniqueIdentifier];
    NSString *userName = userNameTextField.text;
    NSString *password = passwordTextField.text;
    self.authManager = [[ACEAuthenticationManager alloc] initWithUser:userName 
                                                             password:password 
                                                          andDeviceId:uniqueIdentifier 
                                                             delegate:self];
   [self.authManager validateUser];
}

- (void)ACEConnectionManager:(ACEDataManager*)manager didLoginSuscessfull:(NSMutableArray*)responseData
{
    if ([responseData count] > 0) 
    {
        self.aceUser = [responseData objectAtIndex:0];
        kACEUserId = [NSString stringWithFormat:@"%d",self.aceUser.ACEUserId];
        NSString *loginClick = @"1";
        NSUserDefaults *loginValue = [NSUserDefaults standardUserDefaults];
        [loginValue setValue:loginClick forKey:kClickCheckInLogin];
        [loginValue synchronize];
        kACEUserIDFromTable = 0;
        kLoginSessionId = @"";
        kLoginSessionId = self.aceUser.SessionId;
        NSString *isLoggedOut = @"false";
        NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
        [loggedValue setValue:isLoggedOut forKey:kIsLoggedOut];
        [loggedValue synchronize];
        int numberOfUser = [StudentDatabase getUserCount];
        bool count = [StudentDatabase userIDCountForLogin:kACEUserId];
        
        if (count) 
        {
            if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable)
            {
                
                int UnsyncCount = [ACEUTILMethods getFinishedSessionsCount];
                if (UnsyncCount > 0)
                {
                    [self showProgressHudForManualInView:self.view withTitle:NSLocalizedString(@"syncing_sessions_title", nil) andMsg:nil];
                    
                    //Delay the sync for 1 sec. So that the above message can be shown.
                    [self performSelector:@selector(beginPush) 
                               withObject:nil 
                               afterDelay:0.1f]; //Initiate the sync chain.
                }else
                {
                    [self initiateCurriculumPull];
                }
            }

            [StudentDatabase updateACEUserTable:kLoginSessionId :[self getCurrentDate] :kLastSyncTime :kACEUserId];
            kACEUserIDFromTable = [StudentDatabase ACEUserIdFromACEUserTable:[kACEUserId intValue]];
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarControlerDelegateMethod];

        }
        else
        { 
    
        if (numberOfUser!=0) {

            [self hideProgressHudInView:self.view] ;
            
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"New User Login" message:[NSString stringWithFormat:@"This device contains session data of the previous user, '%@'. If you continue to login, all summarized data will be synced and any unsummarized data will be lost. Do you wish to proceed?",[[NSUserDefaults standardUserDefaults] objectForKey:@"uname"]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
            alt.tag = kLoginAlertTag;
            [alt show];
            
        }else
        {
            
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setValue:userNameTextField.text forKey:@"uname"];
                    [userDefaults synchronize];

            [self updateUserDetailsOnLogin];
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarControlerDelegateMethod];
        }
        }
    }
    else{
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to retrieve information. Please try again"
                                                    delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alt show];

    }
    NSString *timerTimeSet = @"1";
    NSUserDefaults *loginSet = [NSUserDefaults standardUserDefaults];
    [loginSet setValue:timerTimeSet forKey:kClickLoginOnBackground];
    [loginSet synchronize];
}

- (void)ACEConnectionManagerDidLoginFailed:(ACEDataManager*)manager isAccountLocked:(BOOL)isLocked 
                         loginAttemptCount:(int)count
{
    [self hideProgressHudInView:self.view] ;
    NSString *title = nil;
    NSString *message = nil;

        
    if (isLocked) {
        //title = @"Account Locked"
        
        message = @"Your account has been locked. Please contact the administrator for assistance.";
        loginCountCheck = count;
    }
     
      else  if (count ==2) {
            message = @"Incorrect username or password";
           loginCountCheck = count;
        }
        
        else if (count <2) {
            
            // title = @"Login Failed";
            message = @"Incorrect username or password";
           loginCountCheck = count;
        } 
    
 //   }
       
    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:title message:message 
                                                 delegate:self
                                        cancelButtonTitle:@"OK" 
                                        otherButtonTitles: nil];
    [alrt show];
}

- (void)ACEConnectionManager:(ACEDataManager*)manager didRecieveError:(NSError*)error
{
    if (eSyncData) {
        [self showProgressHudForManualInView:self.view withTitle:NSLocalizedString(@"version_check_title", nil) andMsg:nil];
        self.curriculamManager = nil;
        [self initiateCurriculumPull];
    }
  
    [self hideProgressHudInView:self.view] ;
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to retrieve information. Please try again"
                                                delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
}

- (void)updateUserDetailsOnLogin
{

     //NSString *isLoggedOutValue = @"false";
    
    [StudentDatabase deleteUserFromACEUserTable];
    
    

    [StudentDatabase insertACEUserDetail:kACEUserId :self.aceUser.SessionId
                                        :[self getCurrentDate]
                                        :@"2012-01-01 00:00:00":@"false":kStaffName:kUserName]; 
    
    
    NSLog(@"Data from DB %d",[StudentDatabase ACEUserIdFromACEUserTable:[kACEUserId intValue]]);
    kACEUserIDFromTable = [StudentDatabase ACEUserIdFromACEUserTable:[kACEUserId intValue]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userNameTextField.text forKey:@"uname"];
    [userDefaults synchronize];

}

#pragma mark - Manual Sync Related Methods

- (void)beginPush
{
    ACESyncManager *syncManager = [ACESyncManager getSyncManager];
    [syncManager addSyncObserver:self];
    [syncManager syncCuroculumWithServerInSynchronosMode];
}

- (void)ACESyncManageDidFinishSync:(ACESyncManager*)syncManager
{
    [syncManager removeSyncObserver:self];
    [self initiateCurriculumPull];
}

- (void)ACESyncManageDidSyncFailed:(ACESyncManager*)syncManager WithFailCount:(int)count
{
    [syncManager removeSyncObserver:self];
    [self initiateCurriculumPull];
}

//Curriculum Pull Related Methods on Manual Sync

- (void)initiateCurriculumPull
{
    //If no of student is 0 then don't initiate pull.
    if ([StudentDatabase countOfAddedStudents] <= 0 ) {
        [self hideManualSyncProgressHudInView:self.view];
        return;
    }
    
    [self showProgressHudForManualInView:self.view 
                               withTitle:NSLocalizedString(@"version_check_title", nil) andMsg:nil];
    AECPullManager *pullManager = [AECPullManager getPullSyncManager];
    [pullManager addSyncObserver:self];
    [pullManager initiatePull];
}

- (void)ACEPullManager:(AECPullManager*)manager shouldChangeTitleTo:(NSString*)title
{
    [self showProgressHudForManualInView:self.view withTitle:title andMsg:nil];
}

- (void)ACEPullManagerDidFinishLoading:(AECPullManager *)manager
{
    [self hideManualSyncProgressHudInView:self.view];
    [manager removeSyncObserver:self];
    
  
    
    
}

- (void)ACEPullManagerDidFinishLoading:(AECPullManager *)manager 
          didReceiveErrorWithErrorText:(NSString*)errorText andError:(NSError*)error
{
    [self hideManualSyncProgressHudInView:self.view];
    [manager removeSyncObserver:self];
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

#pragma mark - Methods related to request Password

- (void)requestPasswordForACEUser
{
    [self hideProgressHudInView:self.view];
    [self showProgressHudInView:self.view withTitle:@"Loading..." andMsg:nil];
    NSString *userId = userNameTextField.text;
    self.passwordRequest = [[ACEResetPasswordManager alloc]initWithEmailID:userId delegate:self];
    [self.passwordRequest resetPassword];
}


- (void)ACEDataManagerDidResetPassword:(ACEResetPasswordManager*)manager{
    
    [self hideProgressHudInView:self.view];
    UIAlertView *requestAlert = [[UIAlertView alloc]initWithTitle:@"Confirm" message:@"Your password request has been recieved and a new password will be sent to your registered email ID." delegate:self cancelButtonTitle:@"Continue" otherButtonTitles: nil];
    [requestAlert show];
    self.passwordRequest = nil;
}

- (void)ACEDataManagerDidResetPasswordFailed:(NSError*)error{
    [self hideProgressHudInView:self.view];
    
    UIAlertView *requestAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password request failed. Please try again." 
                                                         delegate:nil 
                                                cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [requestAlert show];
    self.passwordRequest = nil;
}


@end
