//
//  RequestPassword.h
//  NECC
//
//  Created by Aditi on 25/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACEResetPasswordManager.h"

@interface RequestPassword : UIViewController<UITextFieldDelegate>{
    
   IBOutlet UINavigationBar *navigationbar;
    IBOutlet UITextField *emailIdValidation;
    ACEResetPasswordManager *passwordRequest;
}
@property(nonatomic,retain)ACEResetPasswordManager *passwordRequest;
-(IBAction)backToLoginPage:(id)sender;
-(IBAction)submit:(id)sender;
- (BOOL)validateEmail:(NSString *)inputText;
@end
