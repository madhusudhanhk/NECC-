//
//  LocationController.h
//  ACE
//
//  Created by Test on 06/08/2012.
//  Copyright (c) 2012 Aditi Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACEConfigurationManager.h"
#import "MBProgressHUD.h"
@interface LocationController : UIViewController<MBProgressHUDDelegate>
{
    
    NSMutableArray *location;
    UIButton *selectLocation;
    UILabel *locationText;
    IBOutlet UIPickerView *locationPicker;
    IBOutlet UINavigationBar *locationBar;
    IBOutlet UIButton *locButton;
    IBOutlet UIView *locationPickerBack;
    bool check;
    MBProgressHUD *HUD;
    bool count;
}

@property(nonatomic,retain)IBOutlet UILabel *locationText;
@property (nonatomic, retain) ACEConfigurationManager *configManager;

-(IBAction)selectLocation:(id)sender;
-(IBAction)continueButton:(id)sender;
- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideProgressHudInView:(UIView*)aView;

- (IBAction)cancelPicker:(UIBarItem*)sender;
- (IBAction)donePicker:(UIBarItem*)sender;

@end
