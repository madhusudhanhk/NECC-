//
//  RequestPassword.m
//  NECC
//
//  Created by Aditi on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RequestPassword.h"
#import "LoginPage.h"
#import "ReachabilityViewController.h"
#import "ACEResetPasswordManager.h"

@interface RequestPassword( )

- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideProgressHudInView:(UIView*)aView;

@end

@implementation RequestPassword
@synthesize passwordRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)backToLoginPage:(id)sender{
     [self dismissModalViewControllerAnimated:YES];
    //LoginPage *passwordRequest = [[LoginPage alloc]initWithNibName:@"LoginPage" bundle:nil];
    //[self presentModalViewController:passwordRequest animated:YES];
    
}


- (void)requestPasswordForACEUser
{
    [self showProgressHudInView:self.view withTitle:@"Loading..." andMsg:nil];
    
    NSString *userId = emailIdValidation.text;
    self.passwordRequest = [[ACEResetPasswordManager alloc]initWithEmailID:userId delegate:self];
    [self.passwordRequest resetPassword];
}


- (void)ACEDataManagerDidResetPassword:(ACEResetPasswordManager*)manager{
    
    [self hideProgressHudInView:self.view];
    UIAlertView *requestAlert = [[UIAlertView alloc]initWithTitle:@"Confirm" message:@"Your password request has been recieved and a new password will be sent to your registered email ID." delegate:self cancelButtonTitle:@"Continue" otherButtonTitles: nil];
    [requestAlert show];
}

- (void)ACEDataManagerDidResetPasswordFailed:(NSError*)error{
    [self hideProgressHudInView:self.view];
    
    UIAlertView *requestAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password request failed. Please try again." 
        delegate:nil 
        cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [requestAlert show];
}

-(IBAction)submit:(id)sender
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) 
        {
            
            if([self validateEmail:[emailIdValidation text]] ==1)
            {
                [emailIdValidation resignFirstResponder];
                [self requestPasswordForACEUser];
               // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You Enter Correct Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                //[alert show];
                
                
            }
            
            else if([emailIdValidation.text isEqualToString:@""])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
                
                
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter valid Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
                
            }

       
        }
     else
       {
            
           UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:kInternetConnectionMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
           [alt    show];
            
       }
        
}

    




- (BOOL)validateEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    NSRange aRange;
    if([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        int indexOfDot = aRange.location;
        NSLog(@"aRange.location:%d - %d",aRange.location, indexOfDot);
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            NSLog(@"topleveldomains:%@",topLevelDomain);
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                return TRUE;
            }
            /*else {
             NSLog(@"TLD DOEST NOT contains topLevelDomain:%@",topLevelDomain);
             }*/
            
        }
    }
    return FALSE;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
	return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [emailIdValidation resignFirstResponder];
   
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    navigationbar.tintColor = UIColorFromRGB(0x2eb5e4);
   // NSString *navigationBarTitle = kApplicationName;
    self.view.backgroundColor =UIColorFromRGB(0xe7e6eb);
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

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

@end
