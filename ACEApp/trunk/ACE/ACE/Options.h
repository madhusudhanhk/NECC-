//
//  Options.h
//  NECC
//
//  Created by Aditi on 18/06/12.
//  Copyright (c) 2012 Aditi Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACECurriculumDetailsManager.h"
#import "MBProgressHUD.h"
#import "ACECurriculumPullManager.h"


#define kIsFullSyncEnabled 1

@interface Options : UIViewController
{
UISwitch *recomendation;
//UISwitch *wifi;
UIPickerView *loginRequestTime;
NSMutableArray *loginRequestTimeCount;
UILabel *syncTime;
NSString *showRecom;
NSString *showTimer;
bool flag;    
MBProgressHUD *HUD;
     UIView *loginReqTimeBackView;
}

@property (nonatomic,retain)IBOutlet UISwitch *recomendation;
//@property (nonatomic,retain)IBOutlet UISwitch *wifi;
@property (nonatomic,retain)IBOutlet UIPickerView *loginRequestTime;
@property (nonatomic,retain)IBOutlet UILabel *syncTime;
@property (nonatomic,retain)IBOutlet UIView *loginReqTimeBackView;

@property (retain) ACECurriculumDetailsManager *curriculamManager;

-(IBAction)ShowRecommendations:(id)sender;
//-(IBAction)autoSyncWiFi:(id)sender;
-(IBAction)getSyncTime:(id)sender;

- (IBAction)syncwithServer:(UIButton*)sync;
- (IBAction)partialSyncWithServer:(UIButton*)button;
//-(void)StoreNote;
//-(void)timedifference:(NSString *)loginTime;
//- (NSString *)getCurrentDate;
- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideProgressHudInView:(UIView*)aView;

- (IBAction)pickerCancel:(UIBarItem*)sender;
- (IBAction)pickerDone:(UIBarItem*)sender;

@end