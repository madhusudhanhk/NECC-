//
//  LoginPage.h
//  NECC
//
//  Created by Aditi on 20/06/12.
//  Copyright (c) 2012 Aditi technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ACECurriculumDetailsManager.h"
#import "ACEResetPasswordManager.h"

@class Reachability;
@class TPKeyboardAvoidingScrollView;
@class ACEAuthenticationManager;
@class ACEUser;

@interface LoginPage : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
    IBOutlet UINavigationBar *loginBar;
    IBOutlet UITextField *userNameTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UIButton *loginButton;
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
    MBProgressHUD *HUD;
    IBOutlet TPKeyboardAvoidingScrollView *scrollView;
    ACEAuthenticationManager *authManager;
    ACEUser *aceUser;
    ACEResetPasswordManager *passwordRequest;
}

@property (nonatomic, retain) ACEAuthenticationManager *authManager;
@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property(strong,nonatomic) UITextField *userNameTextField;
@property(strong,nonatomic) UITextField *passwordTextField;
@property (retain) ACECurriculumDetailsManager *curriculamManager;
@property(nonatomic,retain)ACEResetPasswordManager *passwordRequest;

- (IBAction)LoginSucessfulPage:(id)sender;
- (IBAction)RequestPassword;
//- (void) checkNetworkStatus:(NSNotification *)notice;
- (NSString *)getCurrentDate;
//- (BOOL)validateEmail:(NSString *)inputText;
- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideProgressHudInView:(UIView*)aView;
-(IBAction)aboutUs:(id)sender;
//-(NSScanner *)hexaConversion;
-(IBAction)learnMore:(id)sender;
@end
