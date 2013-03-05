//
//  CurrentSession.m
//  ACE
//
//  Created by Aditi technologies on 7/4/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "CurrentSession.h"
#import "SA_SetUp_GridCustomCell.h"
#import "TAPastDataCustomCell.h"
#import "AppDelegate.h"
#import "IT_Setup_GridCustomCell.h"
#import "LoginPage.h"
#import "Reachability.h"
#import "ACESyncManager.h"
#import "SA_summarizeGridcell.h"
#import "IT_SummarizeGridCell.h"
#import "ACESyncManager.h"

//Mst Option selection
#define kMstSettingButtontag 23948659
#define kMstStatusButtontag 6354634
#define kDiscardAlertViewTag 43565
//SA Constants 

#define kSAnumberofOptions 5
#define kITnumberofOptions 4

#define kSA_SublevelButtontag 1000
#define kSA_TrailTypeButton 1001
#define kSA_StapButton 1002
#define kSA_SummarizeSettingButTag 2000
#define kSA_SummarizeStatusButTag 2001


#define kSAOptionScrollTag 87345
#define kSAScrollUpViewTag 457878
#define kSAScrollUpView_offSet_X 0
#define kSAScrollUpView_offSet_Y 100


#define kSASummariTableTag 1001
#define kSASetUpPageTableTag 1000

#define kActiveStudentNameLableTag 9784
#define kActvieCurriculamLableTag 67234

#define kSaPrimaykeyLblTag 7834

#define kSAEmailSessionSwithTag 675987

#define kSASummarizedButtonTag 378263



//TA Constants
#define kTASummariTableTag 96745
#define kTASetUpPageTableTag 84756

#define kTA_TrailTypeButton 957978
#define kTA_TrainingStepButton 83923
#define kTAFsiBsiTsiButtonTag 9837645

#define kTACurrentStudentNamelblTag 872354
#define kTACurrentCurriculamNamelblTag 8324756

#define kTAoptionPageHorizantalScrollView 93486794
#define kTAStepNumberLableTag 8943569
#define kTAStepDiscroptionLablTag 938745
#define kTATrainingStepLablTag 49347856

#define kTAPrimaykeyLblStepTag 34785
#define kTANoOFTrialButtonTag 347973
#define kTAEmailSessionSwithTag 8945343



//IT Constants
//#define kITnumberofOptions 5
#define kIT_ContextButtontag 1212
#define kIT_MIPButtonTag 5786
#define kIT_StatusButtonTag 73463
#define kIT_TrailTypeButton 1313
#define kIT_StapButton 1002
#define kIT_SummarizeSettingButTag 2000
#define kIT_SummarizeStatusButTag 2001
#define kITOptionScrollTag 346783

#define kITScrollUpViewTag 4576
#define kITScrollUpView_offSet_X 0
#define kTScrollUpView_offSet_Y 100


#define kITSummariTableTag 9999     
#define kITSetUpPageTableTag 9998
#define kActiveITStudentNameLableTag 9000
#define kActvieITCurriculamLableTag 9001
#define kITContextNamelableTag 23784
#define kITEmailSessionSwithTag 946556
//
//#define kSaPrimaykeyLblTag 7834

//SA
@interface SAOPtionButton: UIButton  {
@private
    id SAActiveTrilID;
    
    
}
@property (retain) id SAActiveTrilID;


@end 

@implementation SAOPtionButton

@synthesize SAActiveTrilID;

@end


//TA
@interface TAPromptOPtion: UIButton  {
@private
    id TAPromptname;
    id TAstepID;
    id TAPromptStepID;
    
}
@property (retain) id TAPromptname;
@property (strong) id TAPromptStepID;
@property (strong) id TAstepID;

@end 

@implementation TAPromptOPtion

@synthesize TAPromptname;
@synthesize TAPromptStepID;
@synthesize TAstepID;

@end


@interface TAStepScrollView: UIScrollView  {
@private
    id stepID;
    id stepOrder;
    id stepDiscription;
    
    
}
@property(strong)id stepID;
@property(strong)id stepOrder;
@property(strong)id stepDiscription;
@end 

@implementation TAStepScrollView

@synthesize stepID;
@synthesize stepOrder;
@synthesize stepDiscription;


@end



//IT
@interface ITOPtionButton: UIButton  {
@private
    id ITActiveTrilID;
    
    
}
@property (retain) id ITActiveTrilID;


@end 

@implementation ITOPtionButton

@synthesize ITActiveTrilID;


@end
@interface CurrentSession()

// general Methods 
-(NSString *)getCurrentDate;
-(void)customNavigationitems;
-(void)logOut;
- (NSString *) theFollowingWeekend;
-(void)ImageForStudentAsPerStudentSessionId:(NSString *)sessionId imageNameForSession:(NSString *)imageName;




//SA Methods
-(void)customiseSAView;
-(void)initiateSAData;
-(void)CustomiseSAView_oldSession;
-(void)InitiateSAData_oldSession;
-(void)addSAOptionPageToScrollView;
-(void)SA_oldSummarizeData;
-(UIView *)SAoptionsViewCreation:(NSInteger )tagVal;
-(void)updateSAPastData:(NSString *)sublevelid;
-(void)updateSASteps:(NSString *)sublevelid;
-(void)Default_SA_SublevelSelection;
-(void)Default_SA_TrialTypeSelection;
-(void)Default_SA_StatusSelection;
-(void)Default_SA_SettingSelection;
-(void)Default_SA_StepSelection;
-(void)isSAStartbuttonEnabled;
-(void)ActiveStudentAndCuricullamName;
-(void)AddSAActiveSession;
-(NSString *)insertValveToSAActiveTrial:(NSString *)CurrentTrialNumber optionCliked:(NSString *)valFortrial;
-(NSString *)updateValeInSAActiveTrial:(NSString *)CurrentTrialNumber optionCliked:(NSString *)valFortrial;
-(void)SA_handleSwipeFrom;




//TA Methods
-(void)customiseTAView;
-(void)initiateTAData;
-(void)CustomiseTAView_oldSession;
-(void)InitiateTAData_oldSession;
-(void)Default_TA_TrialTypeSelection;
-(void)Default_TA_TrainigStepSelection;
-(void)Default_TA_StatusSelection;
-(void)Default_TA_SettingSelection;
-(void)TAActiveStudentAndCuricullamName;
-(void)TACreateOPtionPage:(int)numberOfSteps promptOption:(NSMutableArray *)PromptAyy stepsDetail:(NSMutableArray *)stepDetailArry;
-(void)TA_Old_CreateOPtionPage:(int)numberOfSteps promptOption:(NSMutableArray *)promptOptionAyy stepsDetail:(NSMutableArray *)stepDetailArry;
-(void)TA_oldSummarizeData;
-(void)ADDTAActivesession;
-(void)TAPromtOptionSelection:(id)sender;
-(void)TASummarizePageStepGridCreation:(int )numberOfSteps;
-(NSString *)TAGetSelectedOptionForStep:(int)scrollViewTag;
-(NSString *)insertValveTAActiveTrial:(NSString *)CurrentStepNumber optionCliked:(NSString *)valForStep;
-(NSString *)updateValeInTAActiveTrial:(NSString *)CurrentStepNumber optionCliked:(NSString *)valForStep;
-(void)TA_SummaiseDataButtonEnabled;

//IT Methods
-(void)customiseITView;
-(void)initiateITData;
-(void)CustomiseITView_oldSession;
-(void)InitiateITData_oldSession;
-(void)Default_IT_TrialTypeSelection;
-(void)Default_IT_StatusSelection;
-(void)Default_IT_ContextSelection;
-(void)Default_IT_MIPSelection;
-(void)updateITPastData:(NSString *)ContextId;
-(void)updateITSteps:(NSString *)sublevelid;
-(void)addITOptionPageToScrollView;
-(void)addITOptionPageToScrollView_oldSession:(int)numberOfTrials;
-(void)ActiveITStudentAndCuricullamName;
-(UIView *)IToptionsViewCreation:(NSInteger )tagVal;
-(void)ITActiveStudentAndCuricullamName;
-(void)ADDITActiveSession;
-(void)IT_oldSummarize;
-(NSString *)insertValveToITActiveTrial:(NSString *)CurrentTrialNumber optionCliked:(NSString *)valFortrial;
-(NSString *)updateValeInITActiveTrial:(NSString *)CurrentTrialNumber optionCliked:(NSString *)valFortrial;
-(NSString *)insertValveToITPastData:(NSMutableDictionary *)mydict;
-(NSString *)updateValeInITPastData:(NSMutableDictionary *)mydict;
-(void)closeITSession;

  

- (void)beginPush;
- (void) showProgressHudForManualInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideManualSyncProgressHudInView:(UIView*)aView;

//Recommendation Methods.
- (BOOL)showSARecommendationForMoreThanEightyPerc;
- (BOOL)showSARecommendationForLesserThanSixtyPerc;
- (BOOL)showITRecommendationForMoreThanEightyPerc;
- (BOOL)showITRecommendationForLesserThanSixtyPerc;
- (BOOL)showTAFirstRecommendation;
- (BOOL)showTASecondRecommendation;
- (void)showITRecommendations;
- (void)showSARecommendations;
- (void)showTARecommendations;

@end



@implementation CurrentSession

bool flag;
@synthesize StudentCurriculum_lbl;
@synthesize StudentName_lbl;

@synthesize pickerBackground;
@synthesize SA_SetUP_GridTableView,SAOptionScrollView;
@synthesize SA_SetUPUIview;
@synthesize SA_DataEntryUIview;
@synthesize SA_SummarizeUIview;
@synthesize myPickerView;
@synthesize SA_TrailLable;
@synthesize SA_DataEntry_curriculam_lbl;
@synthesize SA_DataEntry_StudentName_lbl;
@synthesize SA_DataEntry_Sublevel_lbl;
@synthesize SA_DataEntry_Skill_lbl;
@synthesize SA_DataEntry_Step_lbl;
@synthesize SA_StudentName_lbl;
@synthesize SA_StudentCurriculum_lbl;
@synthesize SA_SummarizedTableView;
@synthesize SA_Summarize_Sublevel_lbl;
@synthesize SA_Summarize_Skill_lbl;
@synthesize SA_Summarize_Step_lbl;
@synthesize SA_summarizeButton;
@synthesize SAStaffTextField;
@synthesize SAFinishButton;




@synthesize noCurrentSessionLable;
@synthesize SAUIview;
@synthesize TAUIview;
@synthesize ITUIview;



//TA Synthesize

@synthesize TAPastDataTable;
@synthesize TA_SetUPUIview;
@synthesize TA_DataEntryUIview;
@synthesize TA_SummarizeUIview;
@synthesize forwardORbackwardlbl;
@synthesize TAOptionScrollViewHorizantal;
@synthesize TAStaffTextField;
@synthesize TA_StudentName_lbl;
@synthesize TA_StudentCurriculum_lbl;
@synthesize TA_FSIBSITSI_button;
@synthesize TA_FSIBSITSI_lbl;
@synthesize TA_SummarizeButton;
@synthesize TA_numberOfTrialsButton;
@synthesize IT_DataEntry_ContextName_lable;
@synthesize IT_SummaryPage_ContextName_lable;
@synthesize TAFinishButton;



//IT Synthesize

@synthesize IT_DataEntry_curriculam_lbl;
@synthesize IT_TrailLable;
@synthesize IT_SetUPUIview;
@synthesize IT_DataEntryUIview;
@synthesize IT_StudentName_lbl;
@synthesize IT_SummarizeUIview;
@synthesize IT_DataEntry_Step_lbl;
@synthesize IT_DataEntry_Skill_lbl;
@synthesize IT_SetUP_GridTableView;
@synthesize IT_SummarizedTableView;
@synthesize IT_DataEntry_TrialNumber_lbl;
@synthesize IT_DataEntry_StudentName_lbl;
@synthesize ITOptionScrollView;
@synthesize IT_StaffNameTextField;
@synthesize IT_SummarizeButton;
@synthesize ITFinishButton;


@synthesize selectedIndex;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.title = NSLocalizedString(@"Current Session", @"Current Session");
        self.tabBarItem.image = [UIImage imageNamed:@"Tab_CurrentSession_icon"];
        self.navigationItem.title=@"ACE Data Entry";
    }
    return self;
}

-(void)customNavigationitems{
    
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x2eb5e4);
   // self.navigationController.navigationBar.tintColor=[UIColor clearColor];

            UIBarButtonItem *Logout =[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
        self.navigationItem.rightBarButtonItem=Logout;
          
        
}

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
            [self showProgressHudForManualInView:self.view 
                                   withTitle:NSLocalizedString(@"syncing_sessions_title", nil) andMsg:nil];
        
        //Delay the sync for 1 sec. So that the above message can be shown.
        [self performSelector:@selector(beginPush) 
                   withObject:nil 
                   afterDelay:1.0f];
        
    }else{
        [self logOutFromApp];
    }
}

#pragma mark - Push Data to server.

- (void)beginPush
{
    ACESyncManager *syncManager = [ACESyncManager getSyncManager];
    [syncManager addSyncObserver:self];
    [syncManager syncCurriculumWithServer];
}

- (void)ACESyncManageDidFinishSync:(ACESyncManager*)syncManager
{
    [syncManager removeSyncObserver:self];
    [self hideManualSyncProgressHudInView:self.view];
    [self logOutFromApp];
}

- (void)ACESyncManageDidSyncFailed:(ACESyncManager*)syncManager WithFailCount:(int)count
{
    [syncManager removeSyncObserver:self];
    [self hideManualSyncProgressHudInView:self.view];
    [self logOutFromApp];
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


-(NSString *)getCurrentDate{
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"M/d/YYYY"];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];  
    NSString *dateString = [dateFormatter stringFromDate:currDate];
   // NSLog(@"%@",dateString);
    
    
    return dateString;
    
    
}
- (NSUInteger)ordinality {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    return [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:[NSDate date]];
}

- (NSDate *) dateByAddingDays:(NSInteger) numberOfDays {
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = numberOfDays;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    return [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
}

- (NSDate *) dateByMovingToBeginningOfDayInTimeZone:(NSTimeZone*)tz {
    
    NSTimeZone *timezone;
    if (tz)
        timezone = tz;
    else
        timezone = [NSTimeZone systemTimeZone];
    
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:[NSDate date]];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:timezone];
    return [calendar dateFromComponents:parts];
    		
}

- (NSString *) theFollowingWeekend {
    
    NSUInteger myOrdinality = [self ordinality];
    myOrdinality=myOrdinality-1;
    
    NSDate *dateOfFollowingWeekend = [self dateByAddingDays:(7-myOrdinality)%7];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"M/d/YYYY"];
  //  [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];  
    NSString *weekEndDate = [dateFormatter stringFromDate:dateOfFollowingWeekend];
    // NSLog(@"%@",weekEndDate);
        return weekEndDate;
    
}
-(void)ImageForStudentAsPerStudentSessionId:(NSString *)sessionId imageNameForSession:(NSString *)imageName{
    
    NSMutableDictionary *myStudentDiction=[[NSMutableDictionary alloc]init];
    [myStudentDiction setValue:sessionId forKey:@"ActiveStudentSessionId"];
    [myStudentDiction setValue:imageName forKey:@"imagename"];
    
    
    NSMutableArray *myActivesessions=[[NSMutableArray alloc]initWithContentsOfFile:[kActiveStudentSessionPlistPath stringByExpandingTildeInPath]];
    
    [myActivesessions addObject:myStudentDiction];
    
    
    
    [myActivesessions writeToFile:[kActiveStudentSessionPlistPath stringByExpandingTildeInPath] atomically:YES];
    
    myStudentDiction=nil;
    
  
}

#pragma mark MST Options 

- (IBAction)MSTSettingSelection:(id)sender
{
    if(myPickerviewArry) {
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry=[StudentDatabase getMstSetting];
    self.myPickerView.tag=kMstSettingButtontag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in srcolView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kMstSettingButtontag){
                    NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
                    int index = 0;
                    while (index < [myPickerviewArry count]) {
                        NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"mstSettingname"];
                        if ([title isEqualToString:buttonTitle]) {
                            [myPickerView selectRow:index inComponent:0 animated:NO];
                            selectedIndex = index;
                        }
                        index++;
                    }
                  }
            }
        }
    }
}

- (IBAction)MSTStatusSelection:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry = [StudentDatabase getMStStatus];
    self.myPickerView.tag=kMstStatusButtontag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in srcolView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kMstStatusButtontag){
                    NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
                    int index = 0;
                    while (index < [myPickerviewArry count]) {
                        NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"mstStatusName"];
                        if ([title isEqualToString:buttonTitle]) {
                            [myPickerView selectRow:index inComponent:0 animated:NO];
                            selectedIndex = index;
                            break;
                        }
                        index++;
                    }
                }
            }
        }
    }

}

-(UIView *)SAoptionsViewCreation:(NSInteger )tagVal{
    if(SAOptionView)
        SAOptionView=nil;
    int xVal=tagVal*300;
    
    SAOptionView =[[UIView alloc]initWithFrame:CGRectMake(xVal, 0, 300, 185)];
    SAOptionView.tag=tagVal;
    
    UIImage *oImage1 =[UIImage imageNamed:@"green_active_tap_button"];
    UIImage *oImage2 =[UIImage imageNamed:@"green_active_tap_button"];
    UIImage *oImage3 =[UIImage imageNamed:@"red_active_tap_button"];
    UIImage *oImage4 =[UIImage imageNamed:@"red_active_tap_button"];
    UIImage *oImage5 =[UIImage imageNamed:@"orange_active_tap_button"];
    
    UIImage *InoImage1 =[UIImage imageNamed:@"green_inactive_tap_button"];
    UIImage *InoImage2 =[UIImage imageNamed:@"green_inactive_tap_button"];
    UIImage *InoImage3 =[UIImage imageNamed:@"red_inactive_tap_button"];
    UIImage *InoImage4 =[UIImage imageNamed:@"red_inactive_tap_button"];
    UIImage *InoImage5 =[UIImage imageNamed:@"orange_inactive_tap_button"];
    
    for(int i=0;i<kSAnumberofOptions;i++){
        SAOPtionButton *optionButton = [SAOPtionButton buttonWithType:UIButtonTypeCustom];
        [optionButton addTarget:self action:@selector(SAOptionClicked:)
           forControlEvents:UIControlEventTouchUpInside];
        
        if(i==0){
            optionButton.frame = CGRectMake(71, 7,72,62);
            [optionButton setBackgroundImage:oImage1 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage1 forState:UIControlStateNormal];
           
            [optionButton setTitle:@"+" forState:UIControlStateNormal];
            optionButton.tag=i;
        }  if(i==1){
            optionButton.frame = CGRectMake(160, 7,72,62);
            [optionButton setBackgroundImage:oImage2 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage2 forState:UIControlStateNormal];
            [optionButton setTitle:@"+P" forState:UIControlStateNormal];
            optionButton.tag=i;
        }  if(i==2){
            optionButton.frame = CGRectMake(25, 92,72,62);
            [optionButton setBackgroundImage:oImage3 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage3 forState:UIControlStateNormal];
            [optionButton setTitle:@"-" forState:UIControlStateNormal];
            optionButton.tag=i;
        }  if(i==3){
            optionButton.frame = CGRectMake(113, 92,72,62);
            [optionButton setBackgroundImage:oImage4 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage4 forState:UIControlStateNormal];
            [optionButton setTitle:@"-P" forState:UIControlStateNormal];
            optionButton.tag=i;
        }  if(i==4){
            optionButton.frame = CGRectMake(201, 92,72,62);
            [optionButton setBackgroundImage:oImage5 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage5 forState:UIControlStateNormal];
            [optionButton setTitle:@"NR" forState:UIControlStateNormal];
            optionButton.tag=i;
        }
        
       
        
        
        [SAOptionView addSubview:optionButton];
        
    }
    
    
    UILabel *SAprimaryKeylbl =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    SAprimaryKeylbl.text=@"NotAnsweredYet";
    SAprimaryKeylbl.tag=kSaPrimaykeyLblTag;
    
    [SAOptionView addSubview:SAprimaryKeylbl];
    
    
    
    return SAOptionView;
    
}
-(void)SAOptionClicked:(id)sender{
    
    // NSLog(@"SAScrollView contentSize1111111.....%@",NSStringFromCGSize(CGSizeMake(SAOptionScrollView.frame.size.width*SATrailNumber, 0)));
    
    // NSLog(@"offset111 %@",NSStringFromCGPoint(SAOptionScrollView.contentOffset));
    SAOPtionButton *pressedButton = (SAOPtionButton *)sender;
    UIView *superViewOfPressedButton = pressedButton.superview;
    [SA_summarizeButton setEnabled:YES];
   
    
    
    for(UILabel *primaryKeyLbl in superViewOfPressedButton.subviews){
        if([primaryKeyLbl isKindOfClass:[UILabel class]]&& primaryKeyLbl.tag==kSaPrimaykeyLblTag){
            if([primaryKeyLbl.text isEqualToString:@"NotAnsweredYet"]){
                
                primaryKeyLbl.text=[self insertValveToSAActiveTrial:[NSString stringWithFormat:@"%d",superViewOfPressedButton.tag+1] optionCliked:[NSString stringWithFormat:@"%@",pressedButton.titleLabel.text]];
                
                pressedButton.SAActiveTrilID=primaryKeyLbl.text;
                
                //Add new options page 
                /*******************/
            
                UIView *myView = [self SAoptionsViewCreation:SATrailNumber];
                
                [self.SAOptionScrollView addSubview:myView];
                int widthVal=SATrailNumber+1;
                
                [SAOptionScrollView setContentSize:CGSizeMake(SAOptionScrollView.frame.size.width*widthVal, 0)];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5];
                
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                
              //  [SAOptionScrollView setContentOffset:CGPointMake(myView.frame.origin.x, 0)];
                
                [UIView commitAnimations];
               // [SA_summarizeButton setEnabled:NO];
                SATrailNumber++;
                
                /*******************/
                
                
            }else{
                
                [self updateValeInSAActiveTrial:primaryKeyLbl.text optionCliked:[NSString stringWithFormat:@"%@",pressedButton.titleLabel.text]];
            }
        }
    }
    
    
    
    
    
    for(SAOPtionButton *selectedOptions in superViewOfPressedButton.subviews){
        if([selectedOptions isKindOfClass:[UIButton class]]){
            [selectedOptions setSelected:NO];
            
        }
    }
   
   
   
    
  //   NSLog(@"SAScrollView contentSize.....22222%@",NSStringFromCGSize(CGSizeMake(SAOptionScrollView.frame.size.width*SATrailNumber, 0)));
    
   //  NSLog(@"offset222 %@",NSStringFromCGPoint(SAOptionScrollView.contentOffset));
    [sender setSelected:YES];
}


-(void)Default_SA_SublevelSelection{
    if(myPickerviewArry)myPickerviewArry=nil;
    myPickerviewArry=SA_SublevelArry;
    
    
    if(myPickerviewArry.count==0){
        
        
        
        
    }else{
        
        for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SublevelButtontag){
                
                NSString *skillName=[NSString stringWithFormat:@": %@",[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelskill"]];
                [mButton setTitle:[[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelname"]stringByAppendingString:skillName] forState:UIControlStateNormal];
                [mButton setSelected:YES];
                [self performSelector:@selector(updateSAPastData:) withObject:[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelid"]];
                [self performSelector:@selector(updateSASteps:) withObject:[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelid"]];
                  kSASubLevelID=[[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelid"] intValue];
                
            }
        }
    }
    for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SublevelButtontag){
            
            NSString *skillName=[NSString stringWithFormat:@": %@",[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelskill"]];
            [mButton setTitle:[[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelname"]stringByAppendingString:skillName] forState:UIControlStateNormal];
            [mButton setSelected:YES];
            [self performSelector:@selector(updateSAPastData:) withObject:[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelid"]];
            [self performSelector:@selector(updateSASteps:) withObject:[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelid"]];
            
            
        }
    }
}
-(void)Default_SA_TrialTypeSelection{
    
    
    NSMutableArray *mydefaultArry=[[NSMutableArray alloc]init];
    
    
   
    mydefaultArry=[StudentDatabase TrialType];
    
    for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_TrailTypeButton){
            
            [mButton setTitle:[[mydefaultArry objectAtIndex:0] valueForKey:@"trialtype"] forState:UIControlStateNormal];
            mButton.selected=YES;
            [[NSUserDefaults standardUserDefaults]setValue:[[mydefaultArry objectAtIndex:0] valueForKey:@"trialid"] forKey:@"trialid"];
            [[NSUserDefaults standardUserDefaults]setValue:[[mydefaultArry objectAtIndex:0] valueForKey:@"trialtype"] forKey:@"trialtype"];
            kSATrialTypeName=[[mydefaultArry objectAtIndex:0] valueForKey:@"trialtype"];
            kSATrialTypeID=[[mydefaultArry objectAtIndex:0] valueForKey:@"trialid"];
            
            
            
        }
    }
    
    
    mydefaultArry=nil;
    
}


-(void)Default_SA_StatusSelection{
    
    NSMutableArray *mydefaultArry=[[NSMutableArray alloc]init];
    
    
    
    mydefaultArry=[StudentDatabase getMStStatus];
    
    for(UIScrollView *srcolView in self.SA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            
            
            for(UIButton *mButton  in srcolView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SummarizeStatusButTag){
                    
                    [mButton setTitle:[[mydefaultArry objectAtIndex:0] valueForKey:@"mstStatusName"] forState:UIControlStateNormal];
                    mButton.selected=YES;
                    [[NSUserDefaults standardUserDefaults]setValue:[[mydefaultArry objectAtIndex:0] valueForKey:@"mstStatusId"] forKey:@"mstStatusId"];
                    [[NSUserDefaults standardUserDefaults]setValue:[[mydefaultArry objectAtIndex:0] valueForKey:@"mstStatusName"] forKey:@"SAmstStatusName"];
                }
            }
            
            
        }
    }
    
    mydefaultArry=nil;
    
}

- (void)Default_SA_SettingSelection
{
    NSMutableArray *mydefaultArry=[[NSMutableArray alloc]init];
    mydefaultArry=[StudentDatabase getMstSetting];
    
    for(UIScrollView *srcolView in self.SA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in srcolView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SummarizeSettingButTag){
                    
                    [mButton setTitle:[[mydefaultArry objectAtIndex:0] valueForKey:@"mstSettingname"] forState:UIControlStateNormal];
                    mButton.selected=YES;
                    [[NSUserDefaults standardUserDefaults]setValue:[[mydefaultArry objectAtIndex:0] valueForKey:@"mstSettingid"] forKey:@"mstSettingid"];
                }
            }
            
        }
    }
    
    mydefaultArry=nil;
}

-(void)Default_SA_StepSelection{
    
    
   
    
    
    [self performSelector:@selector(updateSASteps:) withObject:[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelid"]];
    

   
    
    for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_StapButton){
            
            [mButton setTitle:[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepName"] forState:UIControlStateNormal];
            mButton.selected=YES;
            SA_DataEntry_Step_lbl.text=[NSString stringWithFormat:@"Step : %@",[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepName"]];
            SA_Summarize_Step_lbl.text=[NSString stringWithFormat:@"Step : %@",[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepName"]];
            kSAStepID=[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepID"];
            
            [[NSUserDefaults standardUserDefaults]setValue:[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepID"] forKey:@"stepID"];
            [[NSUserDefaults standardUserDefaults]setValue:[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepName"] forKey:@"stepName"];
            [self isSAStartbuttonEnabled];
            
        }
    }    
    
   
    
}

-(void)isSAStartbuttonEnabled{
    
    BOOL isSublevelFieldFilled=NO;
    BOOL isTrialTypeFieldFilled=NO;
    BOOL isStepFieldFilled=NO;
    
    for(UIButton *mybuttons in self.SA_SetUPUIview.subviews){
        if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SublevelButtontag && [mybuttons isSelected]){
            
            isSublevelFieldFilled=YES;
            
            
        }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_TrailTypeButton && [mybuttons isSelected]){
            
            isTrialTypeFieldFilled=YES;
            
            
        }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_StapButton && [mybuttons isSelected]){
            
            isStepFieldFilled=YES;
            
            
        }
    }
    
    if(isSublevelFieldFilled && isTrialTypeFieldFilled && isStepFieldFilled){
    
        
        for(UIButton *mybuttons in self.SA_SetUPUIview.subviews){
            if([mybuttons isKindOfClass:[UIButton class]]&& mybuttons.tag==14512){
                
                
                [mybuttons setEnabled:YES];
                
                
            }
        }
        
    }
    
    
}
-(void)isSAFinishButtonEnabled{
    BOOL isSettingFieldFilled=NO;
    BOOL isStatusFieldFilled=NO;
    BOOL isStafFieldFilled=NO;
    [self.SAFinishButton setEnabled:NO];
    for(UIScrollView *scrollView in self.SA_SummarizeUIview.subviews){
        if([scrollView isKindOfClass:[UIScrollView class]]){
            
            
            for(UIButton *mybuttons in scrollView.subviews){
                if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SummarizeSettingButTag && [mybuttons isSelected]){
                    
                    isSettingFieldFilled=YES;
                    
                    
                }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SummarizeStatusButTag && [mybuttons isSelected]){
                    
                    isStatusFieldFilled=YES;
                    
                    
                }
            }
            
            for(UITextField *staffname in scrollView.subviews){
                if([staffname isKindOfClass:[UITextField class]]){
                   
                    
                    
                    if([staffname.text length]>0){
                        isStafFieldFilled=YES;
                        
                    }
                }
            }
        }
    }
    
    
    if(isSettingFieldFilled && isStatusFieldFilled && isStafFieldFilled){
          [self.SAFinishButton setEnabled:YES];
      }
    
    
}
-(void)isITFinishButtonEnabled{
    
    
   
    
    if([IT_StaffNameTextField.text isEqualToString:@""]){
        
        ITFinishButton.enabled=NO;
      
        
    }else{
        
        ITFinishButton.enabled=YES;
        
       
    }
}

-(void)isTAFinishButtonEnabled{
   
    
    if([TAStaffTextField.text isEqualToString:@""]){
        
        TAFinishButton.enabled=NO;
        
        
    }else{
        
        TAFinishButton.enabled=YES;
        
        
    }

}
-(IBAction)StartSASession:(id)sender{
    
    
    BOOL isSublevelFieldFilled=NO;
    BOOL isTrialTypeFieldFilled=NO;
    BOOL isStepFieldFilled=NO;
    
    for(UIButton *mybuttons in self.SA_SetUPUIview.subviews){
        if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SublevelButtontag && [mybuttons isSelected]){
            
            isSublevelFieldFilled=YES;
                       
           
        }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_TrailTypeButton && [mybuttons isSelected]){
            
            isTrialTypeFieldFilled=YES;
            
            
        }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_StapButton && [mybuttons isSelected]){
            
            isStepFieldFilled=YES;
            
            
        }
    }
    
    if(isSublevelFieldFilled && isTrialTypeFieldFilled && isStepFieldFilled){
     
        
        //Add new session to ActiveStudentSession table
        
        kActiveStudentSessionId=[StudentDatabase insertActiveStudentSession:[NSString stringWithFormat:@"%d",kSAStuCurriCulumID] isDirty:@"true" lastSyncDate:[self getCurrentDate]];
        
        [self ImageForStudentAsPerStudentSessionId:kActiveStudentSessionId imageNameForSession:kActiveStudentImageName];
        
        
        
      
        
        
        SA_SetUPUIview.hidden=YES;
        SA_DataEntryUIview.hidden=NO;
        SA_SummarizeUIview.hidden=YES;
        SA_TrailLable.text=@"Trial 1 / 1";
        isNewSessionStartType= oldSession;
        
        if(kSASubLevelID==0){
           
            SA_DataEntry_Sublevel_lbl.text=[NSString stringWithFormat:@"Sub Level : %@",[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelname"]];
            SA_Summarize_Sublevel_lbl.text=[NSString stringWithFormat:@"Sub Level : %@",[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelname"]];
            SA_Summarize_Skill_lbl.text=[NSString stringWithFormat:@"Skill : %@",[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelskill"]];
            
            [[NSUserDefaults standardUserDefaults]setValue:[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelid"] forKey:@"sasublevelid"];
            
            kSASubLevelID=[[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelid"] intValue];
            
            
            SA_DataEntry_Skill_lbl.text=[NSString stringWithFormat:@"Skill : %@",[[SA_SublevelArry objectAtIndex:0] valueForKey:@"sasublevelskill"]];
            
        }
         [self performSelector:@selector(AddSAActiveSession)];
        
    }
    
    
  
    
}
-(IBAction)SA_SummarizeData:(id)sender{
    
    SA_SetUPUIview.hidden=YES;
    SA_DataEntryUIview.hidden=YES;
    SA_SummarizeUIview.hidden=NO;
    
    SASummarizeTrialCount=0;
    
    int plusCount = 0;
    int plusPCount = 0;
    int minusCount = 0 ;
    int minusPCount = 0;
    int NRCount = 0 ;
    
    for(UIView *optionUIview in self.SAOptionScrollView.subviews){
        if([optionUIview isKindOfClass:[UIView class]]){
            
            for(UIButton *optionbutton in optionUIview.subviews){
                if([optionbutton isKindOfClass:[UIButton class]]){
                
                    if([optionbutton isSelected]){
                        if([optionbutton.titleLabel.text isEqualToString:@"+"]){
                            
                            plusCount+=1;
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"+P"]){
                            
                            plusPCount +=1;
                            
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"-"]){
                            minusCount +=1;
                            
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"-P"]){
                            minusPCount +=1;
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"NR"]){
                            
                            NRCount +=1;
                            
                        }
                    }
                }
            }
            
        }
    }
    SASummarizeTrialCount=plusCount+plusPCount+minusCount+minusPCount+NRCount;
    
    if(SASummarizedDict)SASummarizedDict=nil;
    SASummarizedDict=[[NSMutableDictionary alloc]init];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",plusCount] forKey:@"plusCount"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",plusPCount] forKey:@"plusPCount"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",minusCount] forKey:@"minusCount"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",minusPCount] forKey:@"minusPCount"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",NRCount] forKey:@"NRCount"];
    
   // NSString *SAActiveSessionID = [[NSUserDefaults standardUserDefaults]valueForKey:@"SAActiveSessionID"];
   // NSString *sublevelIDCurrentSession=[[NSUserDefaults standardUserDefaults]valueForKey:@"sasublevelid"];
    [[NSUserDefaults standardUserDefaults]valueForKey:@"SAActiveSessionID"];
    [[NSUserDefaults standardUserDefaults]valueForKey:@"sasublevelid"];
    
    
    [SASummarizedDict setValue:kSAActiveSessionID forKey:@"SAActiveSessionID"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",kSASubLevelID] forKey:@"sasublevelid"];
    
    [SA_SummarizedTableView reloadData];
    
    
    kSAPastDataScore=plusCount+plusPCount;
        
    
    //BOOL result= [StudentDatabase updateSAIsSummarizedData:SASummarizedDict];
    [StudentDatabase updateSAIsSummarizedData:SASummarizedDict];
    
    // refresh the buttins in Summarize page.........
    for(UIScrollView *scrollView in self.SA_SummarizeUIview.subviews){
        if([scrollView isKindOfClass:[UIScrollView class]]){
            
            
            for(UIButton *mybuttons in scrollView.subviews){
                if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SummarizeSettingButTag){
                    
                    [mybuttons setSelected:NO];
                    [mybuttons setTitle:@"NA" forState:UIControlStateNormal];
                    
                    
                    
                }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SummarizeStatusButTag){
                    
                    [mybuttons setSelected:NO];
                    [mybuttons setTitle:@"NA" forState:UIControlStateNormal];
                    
                    
                }
            }
        }
    }
   
    [self Default_SA_StatusSelection];
    [self Default_SA_SettingSelection];
    
    
    
    for(UIScrollView *myScrollView in self.SA_SummarizeUIview.subviews){
        
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            for(UISwitch *switc in myScrollView.subviews){
                if([switc isKindOfClass:[UISwitch class]]){
                    [switc setOn:NO];
                    
                }
            }
            
        }
    }
    
    
        kSAEmailSessionDASA=@"false";
     [SAFinishButton setEnabled:NO];
     
    
    
    [self isSAFinishButtonEnabled];
    

}

-(IBAction)SA_ResumeCurrentSession:(id)sender{
    
    
    SA_SetUPUIview.hidden=YES;
    SA_DataEntryUIview.hidden=NO;
    SA_SummarizeUIview.hidden=YES;
    
    [StudentDatabase SAResumeSession:kSAActiveSessionID];
    
    
}

- (IBAction)SA_SublevelSelection:(id)sender
{
    if(myPickerviewArry)myPickerviewArry=nil;
        myPickerviewArry=SA_SublevelArry;
        self.myPickerView.tag=kSA_SublevelButtontag;
        [self.myPickerView reloadAllComponents];
        [self presentView:pickerBackground show:YES];
    
    for(UIButton *mButton  in self.SA_SetUPUIview.subviews) {
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SublevelButtontag){
            NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
            int index = 0;
            while (index < [SA_SublevelArry count]) {
                    NSString *skillName=[NSString stringWithFormat:@": %@",[[SA_SublevelArry objectAtIndex:index] valueForKey:@"sasublevelskill"]];
                skillName = [[[SA_SublevelArry objectAtIndex:index] valueForKey:@"sasublevelname"]stringByAppendingString:skillName];
                if ([buttonTitle isEqualToString:skillName]) {
                    [myPickerView selectRow:index inComponent:0 animated:NO];
                    selectedIndex = index;
                    break;
                }
                
                index++;
            }
        }
    }
    
    
}

- (IBAction)SA_TrailTypeSelection:(id)sender
{
    if(myPickerviewArry){
     myPickerviewArry=nil;   
    }
    
    myPickerviewArry=[StudentDatabase TrialType];
    
    self.myPickerView.tag=kSA_TrailTypeButton;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag == kSA_TrailTypeButton){
            NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
            int index = 0;
            while (index < [myPickerviewArry count]) {
                NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"trialtype"];
                if ([title isEqualToString:buttonTitle]) {
                    [myPickerView selectRow:index inComponent:0 animated:NO];
                    selectedIndex = index;
                    break;
                }
                index++;
            }
        }
    }
    
}

- (IBAction)SA_StepTrailSelection:(id)sender
{
    if(myPickerviewArry)myPickerviewArry=nil;
    myPickerviewArry = SA_StepsAyy;

    self.myPickerView.tag=kSA_StapButton;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_StapButton){
            NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
            int index = 0;
            while (index < [SA_StepsAyy count]) {
                NSString *title = [[SA_StepsAyy objectAtIndex:index] valueForKey:@"stepName"];
                if ([buttonTitle isEqualToString:title]) {
                    [myPickerView selectRow:index inComponent:0 animated:NO];
                    selectedIndex = index;
                    break;
                }
                index++;
            }
        }
    }    
}

- (IBAction)SA_NextAndPreviusTrialClicked:(id)sender{
    UIButton *clickedButton =(UIButton *)sender;
    
   
     // [SA_summarizeButton setEnabled:NO];
    
    if(clickedButton.tag==1){
    
        if(SAOptionScrollView.contentOffset.x>0){
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
        
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
            [SAOptionScrollView setContentOffset:CGPointMake(SAOptionScrollView.contentOffset.x-SAOptionScrollView.frame.size.width, 0)];
            
            [UIView commitAnimations];
            [SA_summarizeButton setEnabled:YES];
        }
    }
    if(clickedButton.tag==2){
       
       // NSLog(@"Frame...%@",NSStringFromCGRect([self SAoptionsViewCreation:SATrailNumber].frame));
        
  //  NSLog(@"ContentSize SA NEXT  .. . %@",NSStringFromCGSize(SAOptionScrollView.contentSize));
  //  NSLog(@"ContentOffset SA NEXT.......%@",NSStringFromCGPoint(SAOptionScrollView.contentOffset));
        
      //if loop to find last trail page  
        
        if(SAOptionScrollView.contentSize.width==SAOptionScrollView.contentOffset.x + SAOptionScrollView.frame.size.width){
            
            
            // find out  option clicked for preaent trail before adding next taril page 
            
            for(UIView *optionView in SAOptionScrollView.subviews){ // list the all UIview inside SAOptionScrollView 
                
               // NSLog(@"option view tag...%d",optionView.tag);
                if([optionView isKindOfClass:[UIView class]]&& optionView.tag==SATrailNumber-1){
                    
                    
                    // list of buttons inside the Uiview 
                    for(UIButton *selectedOptions in optionView.subviews){
                        if([selectedOptions isKindOfClass:[UIButton class]]){
                            
                            
                            
                            if([selectedOptions isSelected]){
                                
                                
                                UIView *myView = [self SAoptionsViewCreation:SATrailNumber];
                                
                                [self.SAOptionScrollView addSubview:myView];
                                
                                [SAOptionScrollView setContentSize:CGSizeMake(SAOptionScrollView.frame.size.width*SATrailNumber, 0)];
                                
                                [UIView beginAnimations:nil context:nil];
                                [UIView setAnimationDuration:0.5];
                                
                                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                                
                                [SAOptionScrollView setContentOffset:CGPointMake(myView.frame.origin.x, 0)];
                                
                                [UIView commitAnimations];
                                
                                 [SA_summarizeButton setEnabled:NO];
                                SATrailNumber++;
                               

                            }
                            
                                                                           
                        }
                    }   
                }else{
                    
                    NSLog(@"else condition ");
                    
                  /*  UIView *myView = [self SAoptionsViewCreation:SATrailNumber];
                    
                    [self.SAOptionScrollView addSubview:myView];
                    
                    [SAOptionScrollView setContentSize:CGSizeMake(SAOptionScrollView.frame.size.width*SATrailNumber, 0)];
                    
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:0.5];
                    
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                    
                    [SAOptionScrollView setContentOffset:CGPointMake(myView.frame.origin.x, 0)];
                    
                    [UIView commitAnimations];
                    
                    SATrailNumber++;
                  */
                    
                   

                    
                }
            }
            
          
            
            
            
        }else if(SAOptionScrollView.contentSize.width!=0 && SAOptionScrollView.contentSize.width!=SAOptionScrollView.contentOffset.x){
            // else just scroll the page with out adding new trail page 
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [SAOptionScrollView setContentOffset:CGPointMake(SAOptionScrollView.contentOffset.x+SAOptionScrollView.frame.size.width, 0)];
            
            [UIView commitAnimations];
            
           

            //int currentTrail = SAOptionScrollView.contentOffset.x/300;
             for(UIView *optionView in SAOptionScrollView.subviews){
        
                 
                 
                  if([optionView isKindOfClass:[UIView class]]){
                 for(UIButton *selectedOptions in optionView.subviews){
                if([selectedOptions isKindOfClass:[UIButton class]]){
                    
                    
                   int currentTrailWidth = SAOptionScrollView.contentOffset.x/300;
                    currentTrailWidth=currentTrailWidth+1;
                    
                    
                    if(![selectedOptions isSelected] && SATrailNumber==currentTrailWidth){
                         //NSLog(@"optionView tag ....%d",optionView.tag);
                        [SA_summarizeButton setEnabled:NO];
                         //NSLog(@"start new session 3");
                        
                    }else{
                         //[SA_summarizeButton setEnabled:NO];
                    }
                    
                    //[SA_summarizeButton setEnabled:YES];
                }
         
                 }
           } 
        }
            
            
            
            
        }
    }
    
   // NSLog(@"offset %@",NSStringFromCGPoint(SAOptionScrollView.contentOffset));
    
    if(SAOptionScrollView.contentOffset.x==0){
        
        
        
        if([[StudentDatabase getSAOldSessionTrialCount:kSAActiveSessionID]intValue] == 0){
            SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",1,1];
        }else{
            SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",1,[[StudentDatabase getSAOldSessionTrialCount:kSAActiveSessionID]intValue]];
            
        }
        
        
        
        
        [SA_summarizeButton setEnabled:YES];
    }else  if(clickedButton.tag==1){
    
        int currentTrail = SAOptionScrollView.contentOffset.x/300;
        
        SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,[[StudentDatabase getSAOldSessionTrialCount:kSAActiveSessionID]intValue]];
        [SA_summarizeButton setEnabled:YES];
    }else  if(SAOptionScrollView.contentSize.width > SAOptionScrollView.contentOffset.x + SAOptionScrollView.frame.size.width){
        
        int currentTrail = SAOptionScrollView.contentOffset.x/300;
        
        SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,[[StudentDatabase getSAOldSessionTrialCount:kSAActiveSessionID]intValue]];
        [SA_summarizeButton setEnabled:YES];
    }
    else{
        
        int currentTrail = SAOptionScrollView.contentOffset.x/300;
        
     SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,SATrailNumber];  
        
        [SA_summarizeButton setEnabled:NO];
    
    }
    
     int currentTrail = SAOptionScrollView.contentOffset.x/300;
    NSString *optionSelected=[StudentDatabase getSAOldSessionTrialOptionForActiveSessionId:kSAActiveSessionID forTrialNumber:[NSString stringWithFormat:@"%d",currentTrail+1]];
    
    if([optionSelected isEqualToString:@""]){
        
        [SA_summarizeButton setEnabled:NO];
    }else{
        
        [SA_summarizeButton setEnabled:YES];
    }
    
    [self showErrorSARecommendations];
    
    
 
    
}

- (IBAction)SA_SummarizePageSettingSelection:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry = [StudentDatabase getMstSetting];
    self.myPickerView.tag=kSA_SummarizeSettingButTag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    NSMutableArray *mydefaultArry=[[NSMutableArray alloc]init];
    mydefaultArry=[StudentDatabase getMstSetting];
    
    for(UIScrollView *srcolView in self.SA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in srcolView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SummarizeSettingButTag){
                    NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
                    int index = 0;
                    while (index < [myPickerviewArry count]) {
                        NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"mstSettingname"];
                        if ([title isEqualToString:buttonTitle]) {
                            [myPickerView selectRow:index inComponent:0 animated:NO];
                            selectedIndex = index;
                            break;
                        }
                        index++;
                    }
                }
            }
        }
    }
}

- (IBAction)SA_SummarizePageStatusSelection:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry=[StudentDatabase getMStStatus];
    self.myPickerView.tag=kSA_SummarizeStatusButTag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIScrollView *srcolView in self.SA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in srcolView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SummarizeStatusButTag){
                    NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
                    int index = 0;
                    while (index < [myPickerviewArry count]) {
                        NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"mstStatusName"];
                        if ([title isEqualToString:buttonTitle]) {
                            [myPickerView selectRow:index inComponent:0 animated:NO];
                            selectedIndex = index;
                            break;
                        }
                        index++;
                    }
                }
            }
        }
    }
}


-(IBAction)SA_DiscardSession:(id)sender{
    
    SA_SetUPUIview.hidden=YES;
    SA_DataEntryUIview.hidden=YES;
    SA_SummarizeUIview.hidden=YES;
    
}
-(IBAction)SA_FinishSession:(id)sender{
 
    UIButton *button =(UIButton*)sender;
    NSLog(@"tag.....%d",button.tag);
    
    BOOL isSettingFieldFilled=NO;
    BOOL isStatusFieldFilled=NO;
     BOOL isStafFieldFilled=NO;
   
    for(UIScrollView *scrollView in self.SA_SummarizeUIview.subviews){
            if([scrollView isKindOfClass:[UIScrollView class]]){
            
            
                for(UIButton *mybuttons in scrollView.subviews){
                    if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SummarizeSettingButTag && [mybuttons isSelected]){
            
                isSettingFieldFilled=YES;
            
            
            }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SummarizeStatusButTag && [mybuttons isSelected]){
            
                isStatusFieldFilled=YES;
            
            
                }
            }
                
                for(UITextField *staffname in scrollView.subviews){
                    if([staffname isKindOfClass:[UITextField class]]){
                        if(![staffname.text isEqualToString:@""]){
                            isStafFieldFilled=YES;
                            
                        }
                    }
                }
        }
    }
    
    if(isSettingFieldFilled && isStatusFieldFilled && isStafFieldFilled){
    
    SA_SetUPUIview.hidden=NO;
    SA_DataEntryUIview.hidden=YES;
    SA_SummarizeUIview.hidden=YES;
    currentSessionType=noCurrentSeeion;
   
    
    [self.SAUIview removeFromSuperview];
    
    
    NSMutableDictionary *finalzeSessionDict = [[NSMutableDictionary alloc]init];
    
    [finalzeSessionDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"mstSettingid"] forKey:@"MstSettingId"];
    [finalzeSessionDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"mstStatusId"] forKey:@"MstStatusId"];
    
    [finalzeSessionDict setValue:kSAActiveSessionID forKey:@"SAActiveSessionID"];
         [finalzeSessionDict setValue:[StudentDatabase getSASessionDate:kSAActiveSessionID] forKey:@"Date"];
    
    
    [finalzeSessionDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"sasublevelid"] forKey:@"sasublevelid"];
    [finalzeSessionDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"stepName"] forKey:@"stepName"];
    [finalzeSessionDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"trialtype"] forKey:@"trialtype"];
    [finalzeSessionDict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"SAmstStatusName"] forKey:@"mstStatusName"];
    [finalzeSessionDict setValue:[NSString stringWithFormat:@"%d/%d",kSAPastDataScore,SASummarizeTrialCount] forKey:@"score"];
    [finalzeSessionDict setValue:SAStaffTextField.text forKey:@"Staff"];
    
    
     
    
        
    // get all option clicked 
        
        int plusCount = 0;
        int plusPCount = 0;
        int minusCount = 0 ;
        int minusPCount = 0;
        int NRCount = 0 ;
        
        for(UIView *optionUIview in self.SAOptionScrollView.subviews){
            if([optionUIview isKindOfClass:[UIView class]]){
                
                for(UIButton *optionbutton in optionUIview.subviews){
                    if([optionbutton isKindOfClass:[UIButton class]]){
                        
                        if([optionbutton isSelected]){
                            if([optionbutton.titleLabel.text isEqualToString:@"+"]){
                                
                                plusCount+=1;
                            }
                            if([optionbutton.titleLabel.text isEqualToString:@"+P"]){
                                
                                plusPCount +=1;
                                
                            }
                            if([optionbutton.titleLabel.text isEqualToString:@"-"]){
                                minusCount +=1;
                                
                            }
                            if([optionbutton.titleLabel.text isEqualToString:@"-P"]){
                                minusPCount +=1;
                            }
                            if([optionbutton.titleLabel.text isEqualToString:@"NR"]){
                                
                                NRCount +=1;
                                
                            }
                        }
                    }
                }
                
            }
        }
        
        [finalzeSessionDict setValue:[NSString stringWithFormat:@"%d",plusCount] forKey:@"plusCount"];
        [finalzeSessionDict setValue:[NSString stringWithFormat:@"%d",plusPCount] forKey:@"plusPCount"];
        [finalzeSessionDict setValue:[NSString stringWithFormat:@"%d",minusCount] forKey:@"minusCount"];
        [finalzeSessionDict setValue:[NSString stringWithFormat:@"%d",minusPCount] forKey:@"minusPCount"];
        [finalzeSessionDict setValue:[NSString stringWithFormat:@"%d",NRCount] forKey:@"NRCount"];
        
      
        [StudentDatabase updateSAIsFinilizedData:finalzeSessionDict];
        
    [StudentDatabase updateSAPastSession:finalzeSessionDict];
    
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:0];
        
        
        
        //Once Finished check network. If network available then initiate Sync.
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {
           [[ACESyncManager getSyncManager] syncCurriculumWithServer];
        }
        
    }
    
   
    
}
-(void)SA_oldSummarizeData{
    
    SA_SetUPUIview.hidden=YES;
    SA_DataEntryUIview.hidden=YES;
    SA_SummarizeUIview.hidden=NO;
    SASummarizeTrialCount=0;
    
    
    
    int plusCount = 0;
    int plusPCount = 0;
    int minusCount = 0 ;
    int minusPCount = 0;
    int NRCount = 0 ;
    
    for(UIView *optionUIview in self.SAOptionScrollView.subviews){
        if([optionUIview isKindOfClass:[UIView class]]){
            
            for(UIButton *optionbutton in optionUIview.subviews){
                if([optionbutton isKindOfClass:[UIButton class]]){
                    
                    if([optionbutton isSelected]){
                        if([optionbutton.titleLabel.text isEqualToString:@"+"]){
                            
                            plusCount+=1;
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"+P"]){
                            
                            plusPCount +=1;
                            
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"-"]){
                            minusCount +=1;
                            
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"-P"]){
                            minusPCount +=1;
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"NR"]){
                            
                            NRCount +=1;
                            
                        }
                    }
                }
            }
            
        }
    }
    
     SASummarizeTrialCount=plusCount+plusPCount+minusCount+minusPCount+NRCount;
    if(SASummarizedDict)SASummarizedDict=nil;
    SASummarizedDict=[[NSMutableDictionary alloc]init];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",plusCount] forKey:@"plusCount"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",plusPCount] forKey:@"plusPCount"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",minusCount] forKey:@"minusCount"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",minusPCount] forKey:@"minusPCount"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",NRCount] forKey:@"NRCount"];
    
    [[NSUserDefaults standardUserDefaults]valueForKey:@"SAActiveSessionID"];
    [[NSUserDefaults standardUserDefaults]valueForKey:@"sasublevelid"];
    
    
    [SASummarizedDict setValue:kSAActiveSessionID forKey:@"SAActiveSessionID"];
    [SASummarizedDict setValue:[NSString stringWithFormat:@"%d",kSASubLevelID] forKey:@"sasublevelid"];
    
    [SA_SummarizedTableView reloadData];
    
    
    kSAPastDataScore=plusCount+plusPCount;
    
    
   [StudentDatabase updateSAIsSummarizedData:SASummarizedDict];
    
    // refresh the buttins in Summarize page.........
    for(UIScrollView *scrollView in self.SA_SummarizeUIview.subviews){
        if([scrollView isKindOfClass:[UIScrollView class]]){
            
            
            for(UIButton *mybuttons in scrollView.subviews){
                if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SummarizeSettingButTag){
                    
                    [mybuttons setSelected:NO];
                    [mybuttons setTitle:@"NA" forState:UIControlStateNormal];
                    
                    
                    
                }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kSA_SummarizeStatusButTag){
                    
                    [mybuttons setSelected:NO];
                    [mybuttons setTitle:@"NA" forState:UIControlStateNormal];
                    
                    
                }
            }
        }
    }
    
    [self Default_SA_StatusSelection];
    [self Default_SA_SettingSelection];
    
    
    
    for(UIScrollView *myScrollView in self.SA_SummarizeUIview.subviews){
        
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            for(UISwitch *switc in myScrollView.subviews){
                if([switc isKindOfClass:[UISwitch class]]){
                    [switc setOn:NO];
                    
                }
            }
            
        }
    }
    
    
     kSAEmailSessionDASA=@"false";
    [SAFinishButton setEnabled:NO];
    
    
    [self isSAFinishButtonEnabled];
}
-(void)addSAOptionPageToScrollView{
    
    
    //rest the scroll view ...
    
    for(UIView *views in self.SAOptionScrollView.subviews){
        if([views isKindOfClass:[UIView class]]){
            [views removeFromSuperview];
            
        }
    }
    
    self.SAOptionScrollView.frame=CGRectMake(10, 120, 300, 185);
    [self.SAOptionScrollView setContentOffset:CGPointMake(0, 0)];
    [self.SAOptionScrollView setContentSize:CGSizeMake(0, 0)];
    
    [self.SAOptionScrollView addSubview:[self SAoptionsViewCreation:kSATrailNumber]];
    
    
}
-(void)addSAOptionPageToScrollView_oldSession:(int )numberOfTrials{
    
    [SA_summarizeButton setEnabled:NO];
    
    //rest the scroll view ...

    for(UIView *views in self.SAOptionScrollView.subviews){
        if([views isKindOfClass:[UIView class]]){
            [views removeFromSuperview];
            
        }
    }
    
    self.SAOptionScrollView.frame=CGRectMake(10, 120, 300, 185);
   [SAOptionScrollView setContentOffset:CGPointMake(0, 0)];
    
    int ContentSizeWidth=0;
    UIView *myOPtionViewForolD;
    NSString *answeredOptionName;
    
    for(int i=0;i<numberOfTrials;i++){
        
        
        ContentSizeWidth=i;
        
        if(answeredOptionName)answeredOptionName=nil;
        answeredOptionName=[StudentDatabase getSAOldSessionTrialOptionForActiveSessionId:kSAActiveSessionID forTrialNumber:[NSString stringWithFormat:@"%d",i+1]];
        
        
        if(myOPtionViewForolD)myOPtionViewForolD=nil;
        
         myOPtionViewForolD=[self SAoptionsViewCreation:i];
        
        for(SAOPtionButton *optionbutton in myOPtionViewForolD.subviews){
            if([optionbutton isKindOfClass:[SAOPtionButton class]] && [optionbutton.titleLabel.text isEqualToString:answeredOptionName]){
                
                [optionbutton setSelected:YES];
                [SA_summarizeButton setEnabled:YES];
                
            }else{
                
            }
        }
        
       
        
        
        for(UILabel *primaryKeyLbl in myOPtionViewForolD.subviews){
            if([primaryKeyLbl isKindOfClass:[UILabel class]]&& primaryKeyLbl.tag==kSaPrimaykeyLblTag){
                
                
                NSString *restunValue=[StudentDatabase getSAOldSessionTrialActiveSessionId:kSAActiveSessionID forTrialNumber:[NSString stringWithFormat:@"%d",i+1]];
                if([restunValue isEqualToString:@""]){
                    
                    
                    primaryKeyLbl.text=@"NotAnsweredYet";
                    
                }else{
                    
                    primaryKeyLbl.text=restunValue;
                    
                }
                
                
                
                
                NSLog(@"Primay key text ....%@",primaryKeyLbl.text);
                
            }
        }
        
        
         [self.SAOptionScrollView addSubview:myOPtionViewForolD];
        
        [SAOptionScrollView setContentSize:CGSizeMake(self.SAOptionScrollView.frame.size.width*numberOfTrials, 0)];
         [SAOptionScrollView setContentOffset:CGPointMake(self.SAOptionScrollView.frame.size.width*ContentSizeWidth, -0)];
        int currentTrail = SAOptionScrollView.contentOffset.x/300;
        
        SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,SATrailNumber];    
    }
   
   
    
    if(myOPtionViewForolD)myOPtionViewForolD=nil;
    myOPtionViewForolD=[self SAoptionsViewCreation:numberOfTrials];
    [self.SAOptionScrollView addSubview:myOPtionViewForolD];
 //   int widthVal=numberOfTrials;
    
     [SAOptionScrollView setContentSize:CGSizeMake(self.SAOptionScrollView.contentSize.width+self.SAOptionScrollView.frame.size.width, 0)];
    SATrailNumber++;
    
   // NSLog(@"SAScrollView contentSize1111111.....%@",NSStringFromCGSize(SAOptionScrollView.contentSize));
    
   // NSLog(@"offset111 %@",NSStringFromCGPoint(SAOptionScrollView.contentOffset));
    
    
    
}

- (void)showSARecommendations
{
    [self showSARecommendationForLesserThanSixtyPerc];
    [self showSARecommendationForMoreThanEightyPerc];
}

-(void)updateSAPastData:(NSString *)sublevelid{
   
    NSMutableArray *resultArry=  [StudentDatabase getSAPastDataForSubLevel:sublevelid];
    
    if([resultArry count]>5){
        int extralCounts =[resultArry count]-5;
        for(int i=0;i<extralCounts;i++){
            [resultArry removeObjectAtIndex:0];
            
        }
    }
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"pastDataId" ascending:YES];
//    [resultArry sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];
  
    SA_PastdataArry = resultArry;
    [SA_SetUP_GridTableView reloadData];
    
   
    
    
}

-(void)updateSASteps:(NSString *)sublevelid{
    
     SA_StepsAyy = [StudentDatabase getSASteps:sublevelid];
    
}
-(void)AddSAActiveSession{
    
    NSMutableArray *myArry=[StudentDatabase getMstSetting];
    
    [[NSUserDefaults standardUserDefaults]setValue:[[myArry objectAtIndex:0] valueForKey:@"mstSettingid"] forKey:@"mstSettingid"];
   
    NSMutableDictionary *myDic=[[NSMutableDictionary alloc]init];
    [myDic setValue:kActiveStudentSessionId forKey:@"ActiveStudentSessionId"];
     [myDic setValue:[[myArry objectAtIndex:0] valueForKey:@"mstSettingid"] forKey:@"MstSettingId"];
    [myDic setValue:@"1" forKey:@"MstStatusId"];
    [myDic setValue:[NSString stringWithFormat:@"%d",kSASubLevelID] forKey:@"SASubLevelId"];
    [myDic setValue:kSATrialTypeID forKey:@"MstTrialTypeId"];
    [myDic setValue:kSAStepID forKey:@"StepId"];
    [myDic setValue:@"0" forKey:@"TotalPlus"];
    [myDic setValue:@"0" forKey:@"TotalPlusP"];
    [myDic setValue:@"0" forKey:@"TotalMinus"];
    [myDic setValue:@"0" forKey:@"TotalMinusP"];
    [myDic setValue:@"0" forKey:@"TotalNR"];
    [myDic setValue:[self getCurrentDate] forKey:@"Date"];
    [myDic setValue:kStaffName forKey:@"Staff"];
    [myDic setValue:[StudentDatabase getMaxSASessionOrder:kSAStuCurriCulumID] forKey:@"Order"];
    [myDic setValue:@"false" forKey:@"IsSummarized"];
    [myDic setValue:@"false" forKey:@"IsFinished"];
    [myDic setValue:@"false" forKey:@"IsEmailEnabled"];
    
    
    kSAActiveSessionID=[StudentDatabase insertSAActiveSession:myDic];
    
    
}

-(void)updateSAActiveSession{
    
    
    NSMutableDictionary *myDic=[[NSMutableDictionary alloc]init];
    [myDic setValue:@"1" forKey:@"ActiveStudentSessionId"];
    [myDic setValue:@"1" forKey:@"MstSettingId"];
    [myDic setValue:@"1" forKey:@"MstStatusId"];
    [myDic setValue:@"1" forKey:@"SASubLevelId"];
    [myDic setValue:@"1" forKey:@"MstTrialTypeId"];
    [myDic setValue:@"1" forKey:@"StepId"];
    [myDic setValue:@"1" forKey:@"TotalPlus"];
    [myDic setValue:@"0" forKey:@"TotalPlusP"];
    [myDic setValue:@"0" forKey:@"TotalMinus"];
    [myDic setValue:@"0" forKey:@"TotalMinusP"];
    [myDic setValue:@"0" forKey:@"TotalNR"];
    [myDic setValue:[self getCurrentDate] forKey:@"Date"];
    [myDic setValue:kStaffName forKey:@"Staff"];
    [myDic setValue:@"0" forKey:@"Order"];
    [myDic setValue:@"false" forKey:@"IsSummarized"];
    [myDic setValue:@"false" forKey:@"IsFinished"];
    

    
}
-(NSString *)insertValveToSAActiveTrial:(NSString *)CurrentTrialNumber optionCliked:(NSString *)valFortrial{
    
    NSMutableDictionary *myDic=[[NSMutableDictionary alloc]init];
     [[NSUserDefaults standardUserDefaults]valueForKey:@"SAActiveSessionID"];
    
    [myDic setValue:kSAActiveSessionID forKey:@"SAActiveSessionId"];
    [myDic setValue:@"0" forKey:@"TrialNumber"];
    [myDic setValue:@"0" forKey:@"+"];
    [myDic setValue:@"0" forKey:@"+P"];
    [myDic setValue:@"0" forKey:@"-"];
    [myDic setValue:@"0" forKey:@"-P"];
    [myDic setValue:@"0" forKey:@"NR"];
    
    
    
    [myDic setValue:CurrentTrialNumber forKey:@"TrialNumber"];
    [myDic setValue:@"1" forKey:valFortrial];
    
    
    
    NSString *primaryKey = [StudentDatabase insertSAActiveTrial:myDic];
    // store primary key in memory...
    
    [[NSUserDefaults standardUserDefaults]setValue:primaryKey forKey:CurrentTrialNumber];
    
    return primaryKey;
    

}
-(NSString *)updateValeInSAActiveTrial:(NSString *)CurrentTrialNumber optionCliked:(NSString *)valFortrial{
    
    
    NSMutableDictionary *myDic=[[NSMutableDictionary alloc]init];
    [myDic setValue:kSAActiveSessionID forKey:@"SAActiveSessionId"];
    [myDic setValue:@"0" forKey:@"TrialNumber"];
    [myDic setValue:@"0" forKey:@"+"];
    [myDic setValue:@"0" forKey:@"+P"];
    [myDic setValue:@"0" forKey:@"-"];
    [myDic setValue:@"0" forKey:@"-P"];
    [myDic setValue:@"0" forKey:@"NR"];
    
    
    
    //[myDic setValue:CurrentTrialNumber forKey:@"TrialNumber"];
    [myDic setValue:@"1" forKey:valFortrial];
    [myDic setValue:CurrentTrialNumber forKey:@"SAActiveTrialId"];

    NSString *primaryKey = [StudentDatabase updateSAActiveTrial:myDic];

    return primaryKey;
}
-(void)ActiveStudentAndCuricullamName{
    ActiveStudentinfoArry=[StudentDatabase getActiveStudentInfo:kACEStudentID];
    
    NSMutableArray *currilamArry = [StudentDatabase getCurriculamName:[kStuCuriculumId intValue]];
    if(currilamArry.count>0&&ActiveStudentinfoArry.count>0){
        
        
        
        for(UILabel *nameLbl in self.SA_SetUPUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActiveStudentNameLableTag){
                nameLbl.text=[[ActiveStudentinfoArry objectAtIndex:0]valueForKey:@"studentname"];
                kCurrentActiveStudentName=[[ActiveStudentinfoArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }
        }
        for(UILabel *nameLbl in self.SA_DataEntryUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActiveStudentNameLableTag){
                nameLbl.text=[[ActiveStudentinfoArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }
        }
        
        for(UILabel *nameLbl in self.SA_SummarizeUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActiveStudentNameLableTag){
                nameLbl.text=[[ActiveStudentinfoArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }
        }
        
        for(UILabel *nameLbl in self.SA_SetUPUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActvieCurriculamLableTag){
                nameLbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                kCurrentActiveCurriculumName=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                
                
            }
        }
        for(UILabel *nameLbl in self.SA_DataEntryUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActvieCurriculamLableTag){
                nameLbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                
            }
        }
        
        for(UILabel *nameLbl in self.SA_SummarizeUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActvieCurriculamLableTag){
                nameLbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                
            }
        }
    }else{
        
        
        UIAlertView *myAlrt=[[UIAlertView alloc]initWithTitle:@"" message:@"Student name missing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [myAlrt show];
        
    }
        
    
    


    
}
#pragma mark UITableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //SA tables
    if(tableView.tag==kSASummariTableTag) return 2;
    if(tableView.tag==kSASetUpPageTableTag) return [SA_PastdataArry count]+1;
    
    //TA tables
    if(tableView.tag==kTASummariTableTag) return 2;
    if(tableView.tag==kTASetUpPageTableTag) return [TAPastDataArry count]+1;
   
    //IT tables
    
    if(tableView.tag==kITSummariTableTag) return 2;
    if(tableView.tag==kITSetUpPageTableTag) return [IT_PastdataArry count]+1;
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // SA Tables Cell Creation
    
    
    
    //UIImage *firstImage=[UIImage imageNamed:@"datagrid_topleft_curve"];
   // UIImage *middleImage=[UIImage imageNamed:@"datagrid_whitebox"];
    //UIImage *lastImage=[UIImage imageNamed:@"datagrid_topright_curve"];
    
    if(tableView.tag==kSASetUpPageTableTag){
        
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        
        SA_SetUp_GridCustomCell *cell = (SA_SetUp_GridCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) 
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SA_SetUp_GridCustomCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        } 
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if(indexPath.row==0){
            
           
            
            cell.dateLable.text= @"Date";
           

            cell.stepLable.text= @"Step";
            cell.typeLable.text= @"Type";
            cell.scoreLable.text= @"Score";
            cell.statusLable.text= @"Status";
            cell.textLabel.textColor = [UIColor blackColor];
            
            //cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0]; 
        }else{
          
            
            
            
            cell.dateLable.text= [[SA_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"date"];
            cell.stepLable.text= [[SA_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"step"];
            cell.typeLable.text= [[SA_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"type"];
            cell.scoreLable.text= [[SA_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"score"];
            cell.statusLable.text= [[SA_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"status"];
            
            cell.dateLable.font = [UIFont fontWithName:@"Helvetica" size:12.0];
            cell.stepLable.font = [UIFont fontWithName:@"Helvetica" size:12.0];
            cell.typeLable.font = [UIFont fontWithName:@"Helvetica" size:12.0];
            cell.scoreLable.font = [UIFont fontWithName:@"Helvetica" size:12.0];
            
            
            //cutumize frame......
            cell.frame= CGRectMake(0, 0, cell.frame.size.width, 24);
            
            cell.dateLable.frame=CGRectMake(cell.dateLable.frame.origin.x,-1, cell.dateLable.frame.size.width, cell.dateLable.frame.size.height);
            cell.stepLable.frame=CGRectMake(cell.stepLable.frame.origin.x, -1, cell.stepLable.frame.size.width, cell.stepLable.frame.size.height);
            cell.typeLable.frame=CGRectMake(cell.typeLable.frame.origin.x, -1, cell.typeLable.frame.size.width, cell.typeLable.frame.size.height);
            
            cell.scoreLable.frame=CGRectMake(cell.scoreLable.frame.origin.x, -1, cell.scoreLable.frame.size.width, cell.scoreLable.frame.size.height);
            cell.statusLable.frame=CGRectMake(cell.statusLable.frame.origin.x, -1, cell.statusLable.frame.size.width, cell.statusLable.frame.size.height);
              cell.stepLable.frame=CGRectMake(cell.stepLable.frame.origin.x, -1, cell.stepLable.frame.size.width, cell.stepLable.frame.size.height);
              cell.typeLable.frame=CGRectMake(cell.typeLable.frame.origin.x, -1, cell.typeLable.frame.size.width, cell.typeLable.frame.size.height);
            
            
            
        }
        
        return cell;
        
    }else if(tableView.tag==kSASummariTableTag){
        
        /*
        static NSString *cellString = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellString];
        }
        
        if(tableView.tag==kSASummariTableTag){
            if(indexPath.row==0){
                
                NSString *headerlable = @"  +               +P                  -                 -P                  NR ";
                
                cell.textLabel.text = headerlable;
                cell.textLabel.textColor = [UIColor blackColor];
                
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0]; 
            }else{
                NSString *plusCount = [SASummarizedDict valueForKey:@"plusCount"];
                NSString *plusPCount= [SASummarizedDict valueForKey:@"plusPCount"];
                NSString *minusCount= [SASummarizedDict valueForKey:@"minusCount"];
                NSString *minusPcount= [SASummarizedDict valueForKey:@"minusPCount"];
                NSString *NRCount= [SASummarizedDict valueForKey:@"NRCount"];
                
                NSString *headerlable =[NSString stringWithFormat: @" %@ / %d        %@ / %d              %@ / %d           %@ / %d              %@ / %d",plusCount,SATrailNumber,plusPCount,SATrailNumber,
                                        minusCount,SATrailNumber,minusPcount,SATrailNumber,NRCount,SATrailNumber];
                
                
                cell.textLabel.text = headerlable;
                cell.textLabel.textColor = [UIColor blackColor];
                
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0]; 
            }
        }
        
        
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        
         */
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        
        SA_summarizeGridcell *cell = (SA_summarizeGridcell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) 
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SA_summarizeGridcell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        } 
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if(indexPath.row==0){
            
            
            
            cell.pcount.text= @"+";
            
            
            cell.pPcount.text= @"+P";
            cell.mcount.text= @"-";
            cell.mPcount.text= @"-P";
            cell.NRcount.text= @"NR";
            cell.textLabel.textColor = [UIColor blackColor];
            
            //cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0]; 
        }else{
            
            
            
            
            cell.pcount.text=[NSString stringWithFormat:@"%@/%d", [SASummarizedDict valueForKey:@"plusCount"],SASummarizeTrialCount];
            cell.pPcount.text= [NSString stringWithFormat:@"%@/%d",[SASummarizedDict valueForKey:@"plusPCount"],SASummarizeTrialCount];
            cell.mcount.text=[NSString stringWithFormat:@"%@/%d",[SASummarizedDict valueForKey:@"minusCount"],SASummarizeTrialCount] ;
            cell.mPcount.text=  [NSString stringWithFormat:@"%@/%d",[SASummarizedDict valueForKey:@"minusPCount"],SASummarizeTrialCount];
            cell.NRcount.text= [NSString stringWithFormat:@"%@/%d",[SASummarizedDict valueForKey:@"NRCount"],SASummarizeTrialCount];
            
            // cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        }
        
        return cell;

    }
    
   
    // TA Table Cell Creation
    if(tableView.tag==kTASetUpPageTableTag){
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        
        TAPastDataCustomCell *cell = (TAPastDataCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) 
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TAPastDataCustomCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        } 
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
       
        if(indexPath.row==0){
            
            
            NSString *chainString=[StudentDatabase getMstChainingSequence:kTACurrentCurriculamId];
            
            
            
            
            if([chainString isEqualToString:@"Forward"]){
             cell.FSIlbl.text=@"LSI";
            }
            
            if([chainString isEqualToString:@"Backward"]){
                cell.FSIlbl.text= @"FSI";
            }
            
            if([chainString isEqualToString:@"Total Task"]){
                
                cell.FSIlbl.text= @"TSI";
            }
                
        }
        if(indexPath.row>0){
            
            
            
            cell.datelbl.text= [[TAPastDataArry objectAtIndex:indexPath.row-1] valueForKey:@"date"];
             //cell.datelbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"datagrid_topleft_curve"]];
            cell.trialTypelbl.text=[[TAPastDataArry objectAtIndex:indexPath.row-1] valueForKey:@"trialtype"];
            cell.FSIlbl.text=[[TAPastDataArry objectAtIndex:indexPath.row-1] valueForKey:@"stepIndipendent"];
            cell.trainingSteplbl.text=[[TAPastDataArry objectAtIndex:indexPath.row-1] valueForKey:@"trainingStep"];
            cell.promptStep.text= [[TAPastDataArry objectAtIndex:indexPath.row-1] valueForKey:@"promptstep"];
            
           // cell.textLabel.textColor = [UIColor blackColor];
            
                              
                   cell.datelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0]; 
                 cell.trialTypelbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
             cell.FSIlbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
             cell.promptStep.font=[UIFont fontWithName:@"Helvetica" size:12.0];
             cell.trainingSteplbl.font=[UIFont fontWithName:@"Helvetica" size:12.0];
                
            
            //cutumize frame......
            cell.frame= CGRectMake(0, 0, cell.frame.size.width, 24);
            
            cell.datelbl.frame=CGRectMake(cell.datelbl.frame.origin.x,-4, cell.datelbl.frame.size.width, cell.datelbl.frame.size.height);
            cell.trialTypelbl.frame=CGRectMake(cell.trialTypelbl.frame.origin.x, -5, cell.trialTypelbl.frame.size.width, cell.trialTypelbl.frame.size.height);
            cell.FSIlbl.frame=CGRectMake(cell.FSIlbl.frame.origin.x, -4, cell.FSIlbl.frame.size.width, cell.FSIlbl.frame.size.height);
            
            cell.trainingSteplbl.frame=CGRectMake(cell.trainingSteplbl.frame.origin.x, -5, cell.trainingSteplbl.frame.size.width, cell.trainingSteplbl.frame.size.height);
          
            cell.promptStep.frame=CGRectMake(cell.promptStep.frame.origin.x, -5, cell.promptStep.frame.size.width, cell.promptStep.frame.size.height);
           

        }
        return cell;
        
    }
    if(tableView.tag==kITSetUpPageTableTag){
        
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        
        IT_Setup_GridCustomCell *cell = (IT_Setup_GridCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) 
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IT_Setup_GridCustomCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        } 
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if(indexPath.row==0){
            
            
            
            cell.WeekEndingLabel.text= @"Week Ending";
            
            
            cell.TrialTypeLabel.text= @"Trial Type";
            cell.totalOppLabel.text= @"+/TotalOpp";
            cell.mPP.text= @"MIP";
            
            cell.textLabel.textColor = [UIColor blackColor];
            
            //cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0]; 
        }else{
            
            
            
            int totalTrail=[[[IT_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"totalplus"] intValue]+[[[IT_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"totalplusP"] intValue]+[[[IT_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"totalMinus"] intValue]+[[[IT_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"totalNR"] intValue];
            
            
            
            
            cell.WeekEndingLabel.text= [[IT_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"weekending"];
            cell.TrialTypeLabel.text= [[IT_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"trialtype"];
            cell.totalOppLabel.text= [NSString stringWithFormat:@"%@/%d",[[IT_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"totalplus"],totalTrail];
            cell.mPP.text= [[IT_PastdataArry objectAtIndex:indexPath.row-1] valueForKey:@"mip"];
            
            // cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
            
            //cutumize frame......
            cell.frame= CGRectMake(0, 0, cell.frame.size.width, 22);
            
            cell.WeekEndingLabel.frame=CGRectMake(cell.WeekEndingLabel.frame.origin.x,-5, cell.WeekEndingLabel.frame.size.width, cell.WeekEndingLabel.frame.size.height);
            cell.TrialTypeLabel.frame=CGRectMake(cell.TrialTypeLabel.frame.origin.x,-5, cell.TrialTypeLabel.frame.size.width, cell.TrialTypeLabel.frame.size.height);
            cell.totalOppLabel.frame=CGRectMake(cell.totalOppLabel.frame.origin.x,-5, cell.totalOppLabel.frame.size.width, cell.totalOppLabel.frame.size.height);
            cell.mPP.frame=CGRectMake(cell.mPP.frame.origin.x,-5, cell.mPP.frame.size.width, cell.mPP.frame.size.height);
        }
        
        return cell;
        
    }else if(tableView.tag==kITSummariTableTag){
        
        
         static NSString *simpleTableIdentifier = @"SimpleTableCell";
        IT_SummarizeGridCell *cell = (IT_SummarizeGridCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) 
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IT_SummarizeGridCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        } 
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  
        
            if(indexPath.row==0){
                /*
                NSString *headerlable = @"  +                      +P                       -                      NR ";
                
                cell.textLabel.text = headerlable;
                cell.textLabel.textColor = [UIColor blackColor];
                
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0];
                 */
                
                cell.plable.text=@"+";
                cell.pPlable.text=@"+P";
                cell.mlable.text=@"-";
                cell.NRlable.text=@"NR";
                
                
            }else{
                
                NSString *plusCount = [ITSummarizedDict valueForKey:@"plusCount"];
                NSString *plusPCount= [ITSummarizedDict valueForKey:@"plusPCount"];
                NSString *minusCount= [ITSummarizedDict valueForKey:@"minusCount"];
               
                NSString *NRCount= [ITSummarizedDict valueForKey:@"NRCount"];
               /* 
                NSString *headerlable =[NSString stringWithFormat: @"  %@ / %d              %@ / %d                 %@ / %d                        %@ / %d",plusCount,kITTrialNumbers,plusPCount,kITTrialNumbers,
                                        minusCount,kITTrialNumbers,NRCount,kITTrialNumbers];
                
                
                cell.textLabel.text = headerlable;
                cell.textLabel.textColor = [UIColor blackColor];
                
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0]; 
                 */
                
                cell.plable.text=[NSString stringWithFormat:@"%@/%d",plusCount,ITSummarizeTrialCount];
                cell.pPlable.text=[NSString stringWithFormat:@"%@/%d",plusPCount,ITSummarizeTrialCount];
                cell.mlable.text=[NSString stringWithFormat:@"%@/%d",minusCount,ITSummarizeTrialCount];
                cell.NRlable.text=[NSString stringWithFormat:@"%@/%d",NRCount,ITSummarizeTrialCount];
              
                cell.plable.frame=CGRectMake(cell.plable.frame.origin.x,-5, cell.plable.frame.size.width, cell.plable.frame.size.height);
                cell.pPlable.frame=CGRectMake(cell.pPlable.frame.origin.x,-5, cell.pPlable.frame.size.width, cell.pPlable.frame.size.height);
                cell.mlable.frame=CGRectMake(cell.mlable.frame.origin.x,-5, cell.mlable.frame.size.width, cell.mlable.frame.size.height);
                cell.NRlable.frame=CGRectMake(cell.NRlable.frame.origin.x,-5, cell.NRlable.frame.size.width, cell.NRlable.frame.size.height);
            }
       
        
        
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    
    return nil;

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(tableView.tag==kITSummariTableTag){
        
        
        if(indexPath.row==0){
            return 33;
        }else{
            
            return 23;
            
            
        }
    }
    if(tableView.tag==kITSetUpPageTableTag){
        
        
        if(indexPath.row==0){
            return 33;
        }else{
            
            return 22;
            
            
        }
    }
    if(indexPath.row==0){
       // return 30;
    }
     if(tableView.tag==kSASetUpPageTableTag ){
         
         if(indexPath.row==0){
              return 33;
         }else{
             
             return 22;
             
             
         }
         
     }
    if(tableView.tag==kTASetUpPageTableTag){
        
        if(indexPath.row==0){
            return 33;
        }else{
            
            return 22;
            
            
        }
        
    }
    
    
    return 30;
    
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //From every where call this method to update the values.
    [self persistValueForPickerView:pickerView forRow:row inComponent:component];
}


#pragma mark -
#pragma mark Picker View Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
    
    for(UIScrollView *scrollView in self.SA_SummarizeUIview.subviews){
        if([scrollView isKindOfClass:[UIScrollView class]] && scrollView.tag==kSAScrollUpViewTag){
            
           // [scrollView setContentOffset:CGPointMake(kSAScrollUpView_offSet_X, kSAScrollUpView_offSet_Y)];
            
        }
    }
    
    
	return [myPickerviewArry count];
}

- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row 
          forComponent:(NSInteger)component reusingView:(UIView *)view{

    UILabel* label = (UILabel*)view;
    
    if (view == nil) {
        label= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        label.textAlignment = UITextAlignmentLeft;
        label.backgroundColor=[UIColor clearColor];
    }
    
    if(thePickerView.tag==kSA_SublevelButtontag){
        
        NSString *skillName=[NSString stringWithFormat:@": %@",[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelskill"]];
         label.text = [[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelname"]stringByAppendingString:skillName];
        return label;
        
        
    } if(thePickerView.tag==kSA_StapButton){
        
        label.text =  [[SA_StepsAyy objectAtIndex:row] valueForKey:@"stepName"];
        return label;
    
    }if(thePickerView.tag==kSA_TrailTypeButton){
        
        label.text =  [[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
        return label;
        
    }if(thePickerView.tag==kSA_SummarizeSettingButTag){
        
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstSettingname"];
        return label;
        
        
    }if(thePickerView.tag==kSA_SummarizeStatusButTag){
         
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"];
        return label;
    
    }if(thePickerView.tag==kTA_TrailTypeButton){
         
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
        return label;
        
    }if(thePickerView.tag==kTA_TrainingStepButton){
         
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"stepname"];
        return label;
        
    }if(thePickerView.tag==kMstSettingButtontag){
         
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstSettingname"];
        return label;
        
        
    }if(thePickerView.tag==kMstStatusButtontag){
         
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"];
        return label;
        
    }if(thePickerView.tag==kTANoOFTrialButtonTag){
         
        label.text =[myPickerviewArry objectAtIndex:row];
        return label;
        
    }if(thePickerView.tag==kIT_ContextButtontag){
         
        label.text = [[IT_ContextArray objectAtIndex:row] valueForKey:@"Name"];
        return label;
        
    } if(thePickerView.tag==kIT_TrailTypeButton){
         
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
        return label;
        
    } if(thePickerView.tag==kIT_MIPButtonTag){
         
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"Name"];
        return label;
        
    }  if(thePickerView.tag==kIT_StatusButtonTag){
         
        label.text = [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"];
        return label;
        
    }
    
   return nil;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView 
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
    /*
    if(thePickerView.tag==kSA_SublevelButtontag){
        return [[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelskill"];
        
    }if(thePickerView.tag==kSA_StapButton){
        return [[SA_StepsAyy objectAtIndex:row] valueForKey:@"stepName"];
        
    }if(thePickerView.tag==kSA_TrailTypeButton){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
        
    }if(thePickerView.tag==kSA_SummarizeSettingButTag){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstSettingname"];
        
    }if(thePickerView.tag==kSA_SummarizeStatusButTag){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"];
        
    }if(thePickerView.tag==kTA_TrailTypeButton){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
        
    }if(thePickerView.tag==kTA_TrainingStepButton){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"stepname"];
        
    }if(thePickerView.tag==kMstSettingButtontag){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstSettingname"];
        
    }if(thePickerView.tag==kMstStatusButtontag){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"];
        
    }if(thePickerView.tag==kTANoOFTrialButtonTag){
        return [myPickerviewArry objectAtIndex:row];
        
    }
    if(thePickerView.tag==kIT_ContextButtontag){
        return [[IT_ContextArray objectAtIndex:row] valueForKey:@"Name"];
    }
    if(thePickerView.tag==kIT_TrailTypeButton){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
        
    }
    if(thePickerView.tag==kIT_MIPButtonTag){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"Name"];
        
    }  if(thePickerView.tag==kIT_StatusButtonTag){
        return [[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"];
        
    }
	
     
     */
    return nil;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView 
    widthForComponent:(NSInteger)component {
    CGFloat guessedPickerInsetWidth = 24;
    CGFloat pickerWidth = self.view.frame.size.width - guessedPickerInsetWidth;
   
    return pickerWidth * 0.9; // only two others, make them 30% each
}

#pragma SA Customize Views 

- (void)customiseSAView
{
    // customise SA_SetUP_GridTableView table view 
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"datagrid_table.png"]];
    [SA_SetUP_GridTableView setFrame:self.SA_SetUP_GridTableView.frame]; 
    self.SA_SetUP_GridTableView.backgroundView = tempImageView;
    self.SA_SetUP_GridTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    // customise SA_SetUP_GridTableView table view 
    
    UIImageView *tempImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"datagrid5col2col.png"]];
    [SA_SummarizedTableView setFrame:self.SA_SummarizedTableView.frame]; 
    self.SA_SummarizedTableView.backgroundView = tempImageView1;
    self.SA_SummarizedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
    for(UIButton *mybuttons in self.SA_SetUPUIview.subviews){
        if([mybuttons isKindOfClass:[UIButton class]]&& mybuttons.tag!=14512){
              [mybuttons setTitle:@"NA" forState:UIControlStateNormal];
            
            [mybuttons setSelected:NO];
            
            
        }
    }
    
   
    for(UIButton *mybuttons in self.SA_SetUPUIview.subviews){
        if([mybuttons isKindOfClass:[UIButton class]]&& mybuttons.tag==14512){
            
            
            [mybuttons setEnabled:NO];
            
            
        }
    }
    
    
    [self addSAOptionPageToScrollView];
   
}
-(void)initiateSAData{
    
    for(UIButton *mybutton in self.SA_SetUPUIview.subviews){
        if([mybutton isKindOfClass:[UIButton class]]){
            //[mybutton setEnabled:YES];
            
        }
    }
    [SA_summarizeButton setEnabled:NO];

    SA_SublevelArry = [StudentDatabase getSASublevels:kSAStuCurriCulumID];// TODO need to handle for TA IT too
   
    if(SA_SublevelArry.count>0){
        
        [self performSelector:@selector(ActiveStudentAndCuricullamName)];
        [self performSelector:@selector(Default_SA_SublevelSelection)]; // TODO need to handle for TA IT too
        [self performSelector:@selector(Default_SA_TrialTypeSelection)];
        [self performSelector:@selector(Default_SA_StepSelection)];
        for(UIButton *mybutton in self.SA_SetUPUIview.subviews){
            if([mybutton isKindOfClass:[UIButton class]]&& mybutton.tag!=14512){
                [mybutton setEnabled:YES];
                
            }
        }
        
    }else{
        [self performSelector:@selector(ActiveStudentAndCuricullamName)];
        if(SA_PastdataArry)SA_PastdataArry=nil;
        [SA_SetUP_GridTableView reloadData];
        
        UIAlertView *myAllertView =[[UIAlertView alloc]initWithTitle:@"" message:@"No skill has been introduced for this curriculum" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [myAllertView show];
        
        if(SA_PastdataArry)SA_PastdataArry=nil;
        [SA_SetUP_GridTableView reloadData];
        
        for(UIButton *mybutton in self.SA_SetUPUIview.subviews){
            if([mybutton isKindOfClass:[UIButton class]]){
                [mybutton setEnabled:NO];
                
            }
        }
    }
    
    
    
    
}
-(void)CustomiseSAView_oldSession{
    
    [SA_summarizeButton setEnabled:YES];
    // customise SA_SetUP_GridTableView table view 
    
    UIImageView *tempImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"datagrid5col2col.png"]];
    [SA_SummarizedTableView setFrame:self.SA_SummarizedTableView.frame]; 
    self.SA_SummarizedTableView.backgroundView = tempImageView1;
    self.SA_SummarizedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSAOptionPageToScrollView_oldSession:SATrailNumber];
    
}
-(void)InitiateSAData_oldSession{
    
    
     //  [SA_summarizeButton setEnabled:NO];
           
        [self performSelector:@selector(old_ActiveStudentAndCuricullamName)];
        [self performSelector:@selector(SA_setLablesName)]; // TODO need to handle for TA IT too
        
        
   

}
-(void)old_ActiveStudentAndCuricullamName{
    
    
    
    for(UILabel *nameLbl in self.SA_DataEntryUIview.subviews){
        if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActiveStudentNameLableTag){
           
            nameLbl.text=kCurrentActiveStudentName;
        }
    }
    
    for(UILabel *nameLbl in self.SA_SummarizeUIview.subviews){
        if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActiveStudentNameLableTag){
          
             nameLbl.text=kCurrentActiveStudentName;
        }
    }
    
   
    for(UILabel *nameLbl in self.SA_DataEntryUIview.subviews){
        if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActvieCurriculamLableTag){
           
         
            nameLbl.text=kCurrentActiveCurriculumName;
            
        }
    }
    
    for(UILabel *nameLbl in self.SA_SummarizeUIview.subviews){
        if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActvieCurriculamLableTag){
           
             nameLbl.text=kCurrentActiveCurriculumName;
        }
    }
    

}
-(void)SA_setLablesName{
    
    SA_DataEntry_Sublevel_lbl.text=[NSString stringWithFormat:@"Sub Level : %@",[StudentDatabase getSkillName:[NSString stringWithFormat:@"%d",kSASubLevelID]]];
    
    SA_Summarize_Sublevel_lbl.text=[NSString stringWithFormat:@"Sub Level : %@",[StudentDatabase getSkillName:[NSString stringWithFormat:@"%d",kSASubLevelID]]];
    SA_Summarize_Skill_lbl.text=[NSString stringWithFormat:@"Skill : %@",[StudentDatabase getSublevelName:[NSString stringWithFormat:@"%d",kSASubLevelID]]];
    SA_DataEntry_Skill_lbl.text=[NSString stringWithFormat:@"Skill : %@",[StudentDatabase getSublevelName:[NSString stringWithFormat:@"%d",kSASubLevelID]]];
     SA_DataEntry_Step_lbl.text=[NSString stringWithFormat:@"Step : %@",[StudentDatabase getStepName:kSAStepID]];
    SA_Summarize_Step_lbl.text=[NSString stringWithFormat:@"Step : %@",[StudentDatabase getStepName:kSAStepID]];
   // int currentTrail = SAOptionScrollView.contentOffset.x/300;
    
   // SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,SATrailNumber];
//    SA_TrailLable.text=[NSString stringWithFormat:@"Trail %d / %d",1,SATrailNumber];
}

#pragma mark TA Customize Views
-(void)customiseTAView{
    
    
    
    TAOptionScrollViewHorizantal.contentSize= CGSizeMake(0, 0);
    TAOptionScrollViewHorizantal.contentOffset=CGPointMake(0, 0);
    
    
    // customise TAPastDataTable table view 
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"datagrid_table_TA.png"]];
    [TAPastDataTable setFrame:self.TAPastDataTable.frame]; 
    self.TAPastDataTable.backgroundView = tempImageView;
    self.TAPastDataTable.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    NSString *chainString=[StudentDatabase getMstChainingSequence:kTACurrentCurriculamId];
    
    
    if(chainString){
        
        self.forwardORbackwardlbl.text=[NSString stringWithFormat:@"%@ Chain",chainString];
    }
    
    NSString *chainStringID=[StudentDatabase getMstChainingSequenceID:kTACurrentCurriculamId];
    
    if([chainStringID isEqualToString:@"745"]){
        
        self.TA_FSIBSITSI_lbl.text=@"LSI :";
    }else if([chainStringID isEqualToString:@"746"]){
        self.TA_FSIBSITSI_lbl.text=@"FSI :";
        
    }else if([chainStringID isEqualToString:@"747"]){
        self.TA_FSIBSITSI_lbl.text=@"TSI :";
        
        
    }
    
    
    
    
    // handle for Totla Task .....
    
    
    if([chainString isEqualToString:@"Total Task"]){
        
        for(UIButton *myButton in self.TA_SetUPUIview.subviews){
            if([myButton isKindOfClass:[UIButton class]]&& myButton.tag==kTA_TrainingStepButton){
                myButton.hidden=YES;
                
            }
        }
        
        for(UILabel *myLable in self.TA_SetUPUIview.subviews){
            if([myLable isKindOfClass:[UILabel class]]&& myLable.tag==kTA_TrainingStepButton){
                myLable.hidden=YES;
                
            }
        }
        for(UIButton *myLable in self.TA_DataEntryUIview.subviews){
            if([myLable isKindOfClass:[UIButton class]]&& myLable.tag==56856){
                myLable.enabled=NO;
                
            }
        }
        
      
    }else{
        for(UIButton *myButton in self.TA_SetUPUIview.subviews){
            if([myButton isKindOfClass:[UIButton class]]&& myButton.tag==kTA_TrainingStepButton){
                myButton.hidden=NO;
                
            }
        }
        
        for(UILabel *myLable in self.TA_SetUPUIview.subviews){
            if([myLable isKindOfClass:[UILabel class]]&& myLable.tag==kTA_TrainingStepButton){
                myLable.hidden=NO;
                
            }
        }
        for(UIButton *myLable in self.TA_DataEntryUIview.subviews){
            if([myLable isKindOfClass:[UIButton class]]&& myLable.tag==56856){
                
                myLable.enabled=YES;
                
            }
        }
    }
    
    
}

-(void)CustomiseTAView_oldSession{
    
    
    TAOptionScrollViewHorizantal.contentSize= CGSizeMake(0, 0);
    TAOptionScrollViewHorizantal.contentOffset=CGPointMake(0, 0);
    
    
    [self TAActiveStudentAndCuricullamName];
    NSString *chainString=[StudentDatabase getMstChainingSequence:kTACurrentCurriculamId];
    
    
    if(chainString){
        self.TA_FSIBSITSI_lbl.text=[NSString stringWithFormat:@"%@ Chain",chainString];
     
    }
    
    
    
    // handle for Totla Task .....
    
    
    if([chainString isEqualToString:@"Total Task"]){
        
        for(UIButton *myButton in self.TA_SetUPUIview.subviews){
            if([myButton isKindOfClass:[UIButton class]]&& myButton.tag==kTA_TrainingStepButton){
                myButton.hidden=YES;
                
            }
        }
        
        for(UILabel *myLable in self.TA_SetUPUIview.subviews){
            if([myLable isKindOfClass:[UILabel class]]&& myLable.tag==kTA_TrainingStepButton){
                myLable.hidden=YES;
                
            }
        }
        for(UIButton *myLable in self.TA_DataEntryUIview.subviews){
            if([myLable isKindOfClass:[UIButton class]]&& myLable.tag==56856){
                myLable.enabled=NO;
                
            }
        }
        
        
    }else{
        for(UIButton *myButton in self.TA_SetUPUIview.subviews){
            if([myButton isKindOfClass:[UIButton class]]&& myButton.tag==kTA_TrainingStepButton){
                myButton.hidden=NO;
                
            }
        }
        
        for(UILabel *myLable in self.TA_SetUPUIview.subviews){
            if([myLable isKindOfClass:[UILabel class]]&& myLable.tag==kTA_TrainingStepButton){
                myLable.hidden=NO;
                
            }
        }
        for(UIButton *myLable in self.TA_DataEntryUIview.subviews){
            if([myLable isKindOfClass:[UIButton class]]&& myLable.tag==56856){
                
                myLable.enabled=YES;
                
            }
        }
    }
    
    
    
    // retain the Sessions
    
    
    NSMutableArray *promptAyy=[StudentDatabase getTAPromptOption:kTACurrentCurriculamId];
    
    [StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    
   // kTAMstPromptStepId=[[[promptAyy objectAtIndex:0]valueForKey:@"PromptID"] intValue];
    //kTAStepID=[[[[StudentDatabase getTATrainignSteps:kTACurrentCurriculamId]objectAtIndex:0]valueForKey:@"StepID"] intValue];
    kTATotalNUmberofOptionsInStep=promptAyy.count;
    
    
    
    self.TA_SetUPUIview.hidden=YES;
    self.TA_DataEntryUIview.hidden=NO;
    
    NSMutableArray *StepDetailArry=[StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    if(TATrialStepArry)TATrialStepArry=nil;
    TATrialStepArry=StepDetailArry;
    
    kTATotalNUmberOfStepsForSession=[StepDetailArry count];
    
    //setting Step lable text
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepNumberLableTag){
            steplabl.text=[NSString stringWithFormat:@"Step %d / %d",1,kTATotalNUmberOfStepsForSession];
            
        }
    }
    
    
    //setting Step Discription text
    
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
            steplabl.text=[NSString stringWithFormat:@"%@",[[StepDetailArry objectAtIndex:0]valueForKey:@"stepdiscription" ]];
            
        }
    }
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTATrainingStepLablTag){
           
            if(kTATraingStepID==0){
                 steplabl.text=@"Training Step : NA";
                
            }else{
                steplabl.text= [NSString stringWithFormat:@"Training Step : %d",kTATraingStepID];
            }
            
            
        }
    }
    
    for(UILabel *steplabl in self.TA_SummarizeUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
            steplabl.text=[NSString stringWithFormat:@"%@",[[StepDetailArry objectAtIndex:0]valueForKey:@"stepdiscription" ]];
            
        }
    }
    
    for(UILabel *steplabl in self.TA_SummarizeUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTATrainingStepLablTag){
            if(kTATraingStepID==0){
                steplabl.text=@"Training Step : NA";
                
            }else{
                steplabl.text= [NSString stringWithFormat:@"Training Step : %d",kTATraingStepID];
            }

            
            
        }
    }
    
    
       
    if(kTATraingStepID==0){
        for(UIButton *myskipButton in self.TA_DataEntryUIview.subviews){
            if([myskipButton isKindOfClass:[UIButton class]]&& myskipButton.tag==56856){
                
                myskipButton.enabled=NO;
                
            }
        }
    }else{
        for(UIButton *myskipButton in self.TA_DataEntryUIview.subviews){
            if([myskipButton isKindOfClass:[UIButton class]]&& myskipButton.tag==56856){
                
                myskipButton.enabled=YES;
                
            }
        }
    }
    
   // [self TA_Old_CreateOPtionPage:[StepDetailArry count] promptOption:promptAyy stepsDetail:StepDetailArry];
    promptAyy=nil;     
    StepDetailArry=nil;
    
    
    NSString *chainStringID=[StudentDatabase getMstChainingSequenceID:kTACurrentCurriculamId];
    
    if([chainStringID isEqualToString:@"745"]){
        
        self.TA_FSIBSITSI_lbl.text=@"LSI :";
    }else if([chainStringID isEqualToString:@"746"]){
        self.TA_FSIBSITSI_lbl.text=@"FSI :";
        
    }else if([chainStringID isEqualToString:@"747"]){
        self.TA_FSIBSITSI_lbl.text=@"TSI :";
        
        
    }
    

}
-(void)clearTACashes{
 
    
    for(UIScrollView *myScrollView in self.TAOptionScrollViewHorizantal.subviews){
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            [myScrollView removeFromSuperview];
            
        }
        
    }

}

#pragma mark TA Customize DATA
-(void)initiateTAData{
    
    if(TAPastDataArry)TAPastDataArry=nil;
   
    
    
     [self TAActiveStudentAndCuricullamName];
    [self performSelector:@selector(Default_TA_TrialTypeSelection)];
    [self Default_TA_TrainigStepSelection];
    
    
    NSMutableArray *resultArry=  [StudentDatabase getTAPastData:kTACurrentCurriculamId];
   
    if(resultArry.count>0){
        
       
        if([resultArry count]>5){
            int extralCounts =[resultArry count]-5;
            for(int i=0;i<extralCounts;i++){
                [resultArry removeObjectAtIndex:0];
                
            }
        }
        
        
        for(int i =0;i<resultArry.count;i++){
            
            
            NSString *dateString = [[resultArry objectAtIndex:i]valueForKey:@"date"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            // this is imporant - we set our input date format to match our input string
            // if format doesn't match you'll get nil from your string, so be careful
            [dateFormatter setDateFormat:@"M/d/yyyy"];
            NSDate *dateFromString = [[NSDate alloc] init];
            // voila!
            dateFromString = [dateFormatter dateFromString:dateString];
            
            
            
            
            NSMutableDictionary *mydiction=[resultArry objectAtIndex:i];
            [mydiction setValue:dateFromString forKey:@"dateFromString"];
            [resultArry replaceObjectAtIndex:i withObject:mydiction];
            
            
            
            
        }
        
        
        
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"dateFromString" ascending:YES];
        [resultArry sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];
        TAPastDataArry = resultArry;
        
        //[TAPastDataTable reloadData];
         [TAPastDataTable reloadData];
        
                      
        for(UIButton *mybutton in self.TA_SetUPUIview.subviews){
            if([mybutton isKindOfClass:[UIButton class]]&& mybutton.tag==2112){
                [mybutton setEnabled:YES];
                
            }
        }   
    }else{
         [TAPastDataTable reloadData];
        /*
        UIAlertView *myAllertView =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No records found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [myAllertView show];
        
        for(UIButton *mybutton in self.TA_SetUPUIview.subviews){
            if([mybutton isKindOfClass:[UIButton class]]&& mybutton.tag==2112){
                [mybutton setEnabled:NO];
                
            }
        }
        */
        
        
    }
   
    
    
    
}


-(void)InitiateTAData_oldSession{
    
    
    // get prompt for TA curriculum
    //  StepID
    NSMutableArray *promptAyy=[StudentDatabase getTAPromptOption:kTACurrentCurriculamId];
    
    [StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    
    kTAMstPromptStepId=[[[promptAyy objectAtIndex:0]valueForKey:@"PromptID"] intValue];
    
    kTATotalNUmberofOptionsInStep=promptAyy.count;
    
    
    
        
    
   
    
    
    
    
    
    
    
    NSMutableArray *StepDetailArry=[StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    if(TATrialStepArry)TATrialStepArry=nil;
    [StepDetailArry removeObjectAtIndex:0];
    
    TATrialStepArry=StepDetailArry;
    
    kTATotalNUmberOfStepsForSession=[StepDetailArry count];
    
    //setting Step lable text
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepNumberLableTag){
            steplabl.text=[NSString stringWithFormat:@"Step %d / %d",1,kTATotalNUmberOfStepsForSession];
            
        }
    }
    
    
    //setting Step Discription text
    
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
            steplabl.text=[NSString stringWithFormat:@"%@",[[StepDetailArry objectAtIndex:0]valueForKey:@"stepdiscription" ]];
            
        }
    }
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTATrainingStepLablTag){
            if(kTATraingStepID==0){
                steplabl.text=@"Training Step : NA";
                
            }else{
                steplabl.text= [NSString stringWithFormat:@"Training Step : %d",kTATraingStepID];
            }
            
        }
    }
    
    for(UILabel *steplabl in self.TA_SummarizeUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
            steplabl.text=[NSString stringWithFormat:@"%@",[[StepDetailArry objectAtIndex:0]valueForKey:@"stepdiscription" ]];
            
        }
    }
    
    for(UILabel *steplabl in self.TA_SummarizeUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTATrainingStepLablTag){
            if(kTATraingStepID==0){
                steplabl.text=@"Training Step : NA";
                
            }else{
                steplabl.text= [NSString stringWithFormat:@"Training Step : %d",kTATraingStepID];
            }

            
        }
    }
    
    
    
    
    [self TA_Old_CreateOPtionPage:[StepDetailArry count] promptOption:promptAyy stepsDetail:StepDetailArry];
    promptAyy=nil;     
    StepDetailArry=nil;
    
}
-(void)Default_TA_TrialTypeSelection{
    
    
    NSMutableArray *myDefaultArry=[[NSMutableArray alloc]init];
    
    
    myDefaultArry=[StudentDatabase TrialType];
    
    for(UIButton *mButton  in self.TA_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kTA_TrailTypeButton){
            
            [mButton setTitle:[[myDefaultArry objectAtIndex:0] valueForKey:@"trialtype"] forState:UIControlStateNormal];
            [mButton setSelected:YES];
            
            kTATrialTypeName=[[myDefaultArry objectAtIndex:0] valueForKey:@"trialtype"];
            
            kMstTrialType=[[[myDefaultArry objectAtIndex:0] valueForKey:@"trialid"] intValue];
            
            //  [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialid"] forKey:@"trialid"];
            // [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"] forKey:@"trialtype"];
            
        }
    }
    
    myDefaultArry=nil;
    
}

-(void)Default_TA_TrainigStepSelection{
    
     NSMutableArray *myDefaultArry=[[NSMutableArray alloc]init];
        
    myDefaultArry=[StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    
    for(UIButton *mButton  in self.TA_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kTA_TrainingStepButton){
            
            [mButton setTitle:[[myDefaultArry objectAtIndex:0] valueForKey:@"stepname"] forState:UIControlStateNormal];
            kTATraingStepID=[[[myDefaultArry objectAtIndex:0] valueForKey:@"stepname"]intValue];
            kTAStepID=[[[myDefaultArry objectAtIndex:0] valueForKey:@"StepID"]intValue];
            
            if(kTATraingStepID==0){
                
                for(UIButton *mybutton in self.TA_SetUPUIview.subviews){
                    if([mybutton isKindOfClass:[UIButton class]]&& mybutton.tag==2112){
                        //   [mybutton setEnabled:NO];
                        
                    }
                }
            }
                        
        }
    }
    
    myDefaultArry=nil;
    
}

-(void)Default_TA_StatusSelection{
    
    NSMutableArray *mydefaultArry=[[NSMutableArray alloc]init];
    
    
    
    mydefaultArry=[StudentDatabase getMStStatus];
    
    for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            
            
            for(UIButton *mButton  in srcolView.subviews){
                
                
                
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kMstStatusButtontag){
                    
                    [mButton setTitle:[[mydefaultArry objectAtIndex:0] valueForKey:@"mstStatusName"] forState:UIControlStateNormal];
                    kTAMstStatusID=[[[mydefaultArry objectAtIndex:0] valueForKey:@"mstStatusId"]intValue];
                    
                    //  [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialid"] forKey:@"trialid"];
                    // [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"] forKey:@"trialtype"];
                    
                }
            }
            
            
            
        }
    }
    mydefaultArry=nil;
    
}

- (void)Default_TA_SettingSelection
{
    NSMutableArray *mydefaultArry=[[NSMutableArray alloc]init];
    mydefaultArry=[StudentDatabase getMstSetting];
    
    for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in srcolView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kMstSettingButtontag){
                    [mButton setTitle:[[mydefaultArry objectAtIndex:0] valueForKey:@"mstSettingname"] forState:UIControlStateNormal];
                    kTAMstSettingID=[[[mydefaultArry objectAtIndex:0] valueForKey:@"mstSettingid"]intValue];
                }
            }
        }
    }
    
    mydefaultArry=nil;
}

-(void)TAActiveStudentAndCuricullamName{
    
    
    NSMutableArray *StdArry = [StudentDatabase getActiveStudentInfo:kACEStudentID];
    NSMutableArray *currilamArry = [StudentDatabase getCurriculamName:[kStuCuriculumId intValue]];
    if(StdArry.count>0&&currilamArry.count>0){
        
        
        
        kTACurrentStudentName=[[StdArry objectAtIndex:0]valueForKey:@"studentname"];
        kTACurrentCurilulumName=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
        
        
        for(UILabel *lbl in self.TA_SetUPUIview.subviews){
            if([lbl isKindOfClass:[UILabel class]]&& lbl.tag==kTACurrentStudentNamelblTag){
                lbl.text=[[StdArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }
        }
        
        for(UILabel *lbl in self.TA_SetUPUIview.subviews){
            if([lbl isKindOfClass:[UILabel class]]&& lbl.tag==kTACurrentCurriculamNamelblTag){
                lbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                
            }
        }
        for(UILabel *lbl in self.TA_DataEntryUIview.subviews){
            if([lbl isKindOfClass:[UILabel class]]&& lbl.tag==kTACurrentStudentNamelblTag){
                lbl.text=[[StdArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }
        }
        for(UILabel *lbl in self.TA_DataEntryUIview.subviews){
            if([lbl isKindOfClass:[UILabel class]]&& lbl.tag==kTACurrentCurriculamNamelblTag){
                lbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                
            }
        }for(UILabel *lbl in self.TA_SummarizeUIview.subviews){
            if([lbl isKindOfClass:[UILabel class]]&& lbl.tag==kTACurrentStudentNamelblTag){
                lbl.text=[[StdArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }
        }
        for(UILabel *lbl in self.TA_SummarizeUIview.subviews){
            if([lbl isKindOfClass:[UILabel class]]&& lbl.tag==kTACurrentCurriculamNamelblTag){
                lbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                
            }
        }
    }
    StdArry=nil;

    
}
-(void)TACreateOPtionPage:(int)numberOfSteps promptOption:(NSMutableArray *)promptOptionAyy stepsDetail:(NSMutableArray *)stepDetailArry{
    
    for(int i=0;i<promptOptionAyy.count; i++){
        if([[[promptOptionAyy objectAtIndex:i]valueForKey:@"Promptname"] isEqualToString:@"I"]){
            id object = [promptOptionAyy objectAtIndex:i];
            [promptOptionAyy removeObjectAtIndex:i];
            [promptOptionAyy insertObject:object atIndex:0];
        }
    }
    
    
    for(UIScrollView *myScrollView in self.TAOptionScrollViewHorizantal.subviews){
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            [myScrollView removeFromSuperview];
            
        }
                                                              
    }
    
        UIImage *optionFirstImage=[UIImage imageNamed:@"summery_green_button"];
        UIImage *optionMiddleImage=[UIImage imageNamed:@"summery_blue_button"];
        UIImage *optionLastImage=[UIImage imageNamed:@"summery_red_button"];
       UIImage *SelectedoptionFirstImage=[UIImage imageNamed:@"active_summery_green_button"];
        UIImage *SelectedoptionMiddleImage=[UIImage imageNamed:@"active_summery_blue_button"];
        UIImage *SelectedoptionLastImage=[UIImage imageNamed:@"active_summery_red_button"];
    
    
    for(int j = 0 ; j < kTATotalNUmberOfStepsForSession ; j++){
        
        int promptViewXval=self.TAOptionScrollViewHorizantal.frame.size.width*j+60;
        
        TAStepScrollView *scrollview = [[TAStepScrollView alloc] initWithFrame:CGRectMake(promptViewXval, 0, self.TAOptionScrollViewHorizantal.frame.size.width, self.TAOptionScrollViewHorizantal.frame.size.height)];   
        int Xval= 10;
        int Yval= 10;
        int padding = 10;
        int width = 160;
        int height = 30;
        
        
        for(int i = 0; i< kTATotalNUmberofOptionsInStep; i++) { 
            
             
            
            TAPromptOPtion *Optionbutton = [TAPromptOPtion buttonWithType:UIButtonTypeCustom];
              [Optionbutton addTarget:self 
                    action:@selector(TAPromtOptionSelection:)
            forControlEvents:UIControlEventTouchDown];
            
           
            
           
            [Optionbutton setBackgroundImage:optionMiddleImage forState:UIControlStateNormal];
            
           
            [Optionbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            
           /* if(i==0) {
                
                [Optionbutton setTitle:@"I" forState:UIControlStateNormal]; [Optionbutton setBackgroundImage:optionFirstImage forState:UIControlStateNormal];
              Optionbutton.TAPromptStepID=@"0";
                
                
                
                
                [Optionbutton setBackgroundImage:SelectedoptionFirstImage forState:UIControlStateSelected];
                
                
                Optionbutton.tag=i;
            
            }else  if(i==kTATotalNUmberofOptionsInStep-1) {
                
                [Optionbutton setTitle:@"-" forState:UIControlStateNormal]; [Optionbutton setBackgroundImage:optionLastImage forState:UIControlStateNormal];
                [Optionbutton setBackgroundImage:SelectedoptionMiddleImage forState:UIControlStateSelected];
                
                 Optionbutton.TAPromptStepID=[[promptOptionAyy objectAtIndex:i-1]valueForKey:@"PromptID"];
                Optionbutton.tag=[[[promptOptionAyy objectAtIndex:i-1]valueForKey:@"PromptID"] intValue];;
            }else{ */
            
                
                [Optionbutton setTitle:[[promptOptionAyy objectAtIndex:i]valueForKey:@"Promptname"] forState:UIControlStateNormal];
                Optionbutton.tag=[[[promptOptionAyy objectAtIndex:i]valueForKey:@"PromptID"] intValue];
                [Optionbutton setBackgroundImage:SelectedoptionMiddleImage forState:UIControlStateSelected];
                
                Optionbutton.TAPromptStepID=[[promptOptionAyy objectAtIndex:i]valueForKey:@"PromptID"];
          
            
            if([Optionbutton.titleLabel.text isEqualToString:@"I"]){
                
                [Optionbutton setBackgroundImage:optionFirstImage forState:UIControlStateNormal];
                [Optionbutton setBackgroundImage:SelectedoptionFirstImage forState:UIControlStateSelected];
                
            }else if([Optionbutton.titleLabel.text isEqualToString:@"-"]){
                
                [Optionbutton setBackgroundImage:optionLastImage forState:UIControlStateNormal];
                [Optionbutton setBackgroundImage:SelectedoptionLastImage forState:UIControlStateSelected];
                
            }else{
               
                [Optionbutton setBackgroundImage:optionMiddleImage forState:UIControlStateNormal];
                [Optionbutton setBackgroundImage:SelectedoptionMiddleImage forState:UIControlStateSelected];

            }
           /* if([Optionbutton.titleLabel.text isEqualToString:@"NA"]){
                [Optionbutton setTitle:@"-" forState:UIControlStateNormal];
            }else{
                
            }*/
            
                
                
                
         //   }
            
         //   NSLog(@"kTATraingStepID...%d",kTATraingStepID);
            
            NSString *chekPromt=[StudentDatabase checkPromptStatus:kTACurrentCurriculamId];
            if([chekPromt isEqualToString:@"0"]){
                
                Optionbutton.hidden=NO;
                
            }else if(kTATraingStepID==j+1 && [Optionbutton.titleLabel.text isEqualToString:@"-"] ){
                
                Optionbutton.hidden=YES;
                
            }else{
                
                Optionbutton.hidden=NO;
            }

            if(kTATraingStepID==0 && [Optionbutton.titleLabel.text isEqualToString:@"-"]){
             
                kTAMstPromptStepId=Optionbutton.tag;
                kMstPromptStepName=@"NA";
                
            }
            
            Optionbutton.frame = CGRectMake(Xval, Yval,width,height);
           
            
            Yval +=height+padding;
            [scrollview addSubview:Optionbutton];
            
            
        }  
        
        
        //
        
        UILabel *keeptracklbl=[[UILabel alloc]init];
        keeptracklbl.text=@"NotAnsweredYet";
        keeptracklbl.tag=kTAPrimaykeyLblStepTag;
        [scrollview addSubview:keeptracklbl];
        
        scrollview.contentSize = CGSizeMake(scrollview.frame.size.width, Yval);   
        scrollview.backgroundColor=[UIColor clearColor];
        scrollview.showsHorizontalScrollIndicator=NO;
        scrollview.showsVerticalScrollIndicator=NO;
        scrollview.tag=j;
        scrollview.stepID=[[stepDetailArry objectAtIndex:j]valueForKey:@"StepID"];
        scrollview.stepOrder=[[stepDetailArry objectAtIndex:j]valueForKey:@"order"];
        scrollview.stepDiscription=[[stepDetailArry objectAtIndex:j]valueForKey:@"stepdiscription"];
        
        
        
       // NSLog(@" scrollview.stepID 1 ,...%@", scrollview.stepID);
        
        
        [self.TAOptionScrollViewHorizantal addSubview:scrollview];
    }
    
  
   // self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATotalNUmberOfStepsForSession, 0 );  
    if(kTATraingStepID==0){
       
        self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATotalNUmberOfStepsForSession, 0 );
    }else{
        
         self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATraingStepID+1, 0 );
    }
   
          
    
    
} 

-(void)TA_Old_CreateOPtionPage:(int)numberOfSteps promptOption:(NSMutableArray *)promptOptionAyy stepsDetail:(NSMutableArray *)stepDetailArry{
   
    
    for(int i=0;i<promptOptionAyy.count; i++){
        if([[[promptOptionAyy objectAtIndex:i]valueForKey:@"Promptname"] isEqualToString:@"I"]){
            id object = [promptOptionAyy objectAtIndex:i];
            [promptOptionAyy removeObjectAtIndex:i];
            [promptOptionAyy insertObject:object atIndex:0];
        }
    }
    
    for(UIScrollView *myScrollView in self.TAOptionScrollViewHorizantal.subviews){
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            [myScrollView removeFromSuperview];
            
        }
        
    }
    UIImage *optionFirstImage=[UIImage imageNamed:@"summery_green_button"];
    UIImage *optionMiddleImage=[UIImage imageNamed:@"summery_blue_button"];
    UIImage *optionLastImage=[UIImage imageNamed:@"summery_red_button"];
    UIImage *SelectedoptionFirstImage=[UIImage imageNamed:@"active_summery_green_button"];
    UIImage *SelectedoptionMiddleImage=[UIImage imageNamed:@"active_summery_blue_button"];
    UIImage *SelectedoptionLastImage=[UIImage imageNamed:@"active_summery_red_button"];    
    
    for(int j = 0 ; j < kTATotalNUmberOfStepsForSession ; j++){
        
        int promptViewXval=self.TAOptionScrollViewHorizantal.frame.size.width*j+60;
        
        TAStepScrollView *scrollview = [[TAStepScrollView alloc] initWithFrame:CGRectMake(promptViewXval, 0, self.TAOptionScrollViewHorizantal.frame.size.width, self.TAOptionScrollViewHorizantal.frame.size.height)];   
        int Xval= 10;
        int Yval= 10;
        int padding = 10;
        int width = 160;
        int height = 30;
        
        kTATotalNUmberofOptionsInStep=promptOptionAyy.count;
        
        for(int i = 0; i< kTATotalNUmberofOptionsInStep; i++) { 
            
            
            
            TAPromptOPtion *Optionbutton = [TAPromptOPtion buttonWithType:UIButtonTypeCustom];
            [Optionbutton addTarget:self 
                             action:@selector(TAPromtOptionSelection:)
                   forControlEvents:UIControlEventTouchDown];
            
            
            
            
            [Optionbutton setBackgroundImage:optionMiddleImage forState:UIControlStateNormal];
            
            [Optionbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            
        /*    if(i==0) {
                
                [Optionbutton setTitle:@"I" forState:UIControlStateNormal]; [Optionbutton setBackgroundImage:optionFirstImage forState:UIControlStateNormal];
                Optionbutton.TAPromptStepID=@"0";
                
                
                
                
                [Optionbutton setBackgroundImage:SelectedoptionFirstImage forState:UIControlStateSelected];
                
                
                Optionbutton.tag=i;
                
            }else if(i==kTATotalNUmberofOptionsInStep-1) {
                
                [Optionbutton setTitle:@"-" forState:UIControlStateNormal]; [Optionbutton setBackgroundImage:optionLastImage forState:UIControlStateNormal];
                [Optionbutton setBackgroundImage:SelectedoptionMiddleImage forState:UIControlStateSelected];
                
                Optionbutton.TAPromptStepID=0;
                Optionbutton.tag=i;
            }else{
                */
            
                [Optionbutton setTitle:[[promptOptionAyy objectAtIndex:i]valueForKey:@"Promptname"] forState:UIControlStateNormal];
                Optionbutton.tag=[[[promptOptionAyy objectAtIndex:i]valueForKey:@"PromptID"] intValue];
                [Optionbutton setBackgroundImage:SelectedoptionLastImage forState:UIControlStateSelected];
                
                Optionbutton.TAPromptStepID=[[promptOptionAyy objectAtIndex:i]valueForKey:@"PromptID"];
            if([Optionbutton.titleLabel.text isEqualToString:@"I"]){
                
                [Optionbutton setBackgroundImage:optionFirstImage forState:UIControlStateNormal];
                [Optionbutton setBackgroundImage:SelectedoptionFirstImage forState:UIControlStateSelected];
                
            }else if([Optionbutton.titleLabel.text isEqualToString:@"-"]){
                
                [Optionbutton setBackgroundImage:optionLastImage forState:UIControlStateNormal];
                [Optionbutton setBackgroundImage:SelectedoptionLastImage forState:UIControlStateSelected];
                
            }else{
                
                [Optionbutton setBackgroundImage:optionMiddleImage forState:UIControlStateNormal];
                [Optionbutton setBackgroundImage:SelectedoptionMiddleImage forState:UIControlStateSelected];
                
            }
          /*  if([Optionbutton.titleLabel.text isEqualToString:@"NA"]){
                
                  [Optionbutton setTitle:@"-" forState:UIControlStateNormal];
            }else{
                
                  //[Optionbutton setTitle:[[promptOptionAyy objectAtIndex:i-1]valueForKey:@"Promptname"] forState:UIControlStateNormal];
            }
                */
            
                
            //}
            
            NSString *chekPromt=[StudentDatabase checkPromptStatus:kTACurrentCurriculamId];
            if([chekPromt isEqualToString:@"0"]){
                
                 Optionbutton.hidden=NO;
                
            }else if(kTATraingStepID==j+1 && [Optionbutton.titleLabel.text isEqualToString:@"-"] ){
                
                Optionbutton.hidden=YES;
                
            }else{
                
                Optionbutton.hidden=NO;
            }
            
            
            NSString *promptStepid=[StudentDatabase getTAOldSessionStepsPromptForActiveSessionId:[NSString stringWithFormat:@"%d",kTAActiveSessionID] forStep:[[stepDetailArry objectAtIndex:j]valueForKey:@"StepID"]];
          
            
            if([promptStepid isEqualToString:Optionbutton.TAPromptStepID]){
                
                 //NSLog(@"promptStepid title ..%@",Optionbutton.titleLabel.text);
                
                
                [Optionbutton setSelected:YES];
                
                
            }else{
                
                 
                
                [Optionbutton setSelected:NO];
            }
            
            
            if(kTATraingStepID==0 && [Optionbutton.titleLabel.text isEqualToString:@"-"]){
                
                kTAMstPromptStepId=Optionbutton.tag;
                kMstPromptStepName=@"NA";
                
            }
            
            
            Optionbutton.frame = CGRectMake(Xval, Yval,width,height);
            
            Yval +=height+padding;
            [scrollview addSubview:Optionbutton];
            
            
        }  
        
        
        //
        
        UILabel *keeptracklbl=[[UILabel alloc]init];
        keeptracklbl.tag=kTAPrimaykeyLblStepTag;
       
        
         NSString *promptStepid=[StudentDatabase getTAOldSessionStepsPromptForActiveSessionId:[NSString stringWithFormat:@"%d",kTAActiveSessionID] forStep:[[stepDetailArry objectAtIndex:j]valueForKey:@"StepID"]];
        if([promptStepid isEqualToString:@"Not yet Done"]){
            
            keeptracklbl.text=@"NotAnsweredYet";
             
        }else{
            
           
            
            keeptracklbl.text=[StudentDatabase getTAOldSessionTrialID:[NSString stringWithFormat:@"%d",kTAActiveSessionID] forStep:[[stepDetailArry objectAtIndex:j]valueForKey:@"StepID"]];
        }
        
        [scrollview addSubview:keeptracklbl];
        
        
        scrollview.contentSize = CGSizeMake(scrollview.frame.size.width, Yval);   
        scrollview.backgroundColor=[UIColor clearColor];
        scrollview.showsHorizontalScrollIndicator=NO;
        scrollview.showsVerticalScrollIndicator=NO;
        scrollview.tag=j;
        scrollview.stepID=[[stepDetailArry objectAtIndex:j]valueForKey:@"StepID"];
        scrollview.stepOrder=[[stepDetailArry objectAtIndex:j]valueForKey:@"order"];
        scrollview.stepDiscription=[[stepDetailArry objectAtIndex:j]valueForKey:@"stepdiscription"];
        
        
        
        
        
        [self.TAOptionScrollViewHorizantal addSubview:scrollview];
    }
    
    
   // self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATotalNUmberOfStepsForSession, 0 );  
    
    if(kTATraingStepID !=0){
        
        
        NSString *promptStepid=[StudentDatabase getTAOldSessionStepsPromptForActiveSessionId:[NSString stringWithFormat:@"%d",kTAActiveSessionID] forStep:[[stepDetailArry objectAtIndex:kTATraingStepID-1]valueForKey:@"StepID"]];
        
        
        if( [promptStepid isEqualToString:@"Not yet Done"]){
            
            
            self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATraingStepID+1, 0 );
        }else{
            
            self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATotalNUmberOfStepsForSession, 0 ); 
        }
    }else{
         self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATotalNUmberOfStepsForSession, 0 ); 
    }
    
    
        

    
    
} 

-(void)ADDTAActivesession{
    
    NSMutableArray *mydefaultArry=[[NSMutableArray alloc]init];
    
    
    
    mydefaultArry=[StudentDatabase getMstSetting];
    
     kTAMstSettingID=[[[mydefaultArry objectAtIndex:0] valueForKey:@"mstSettingid"]intValue];
    
    NSMutableDictionary *myDic=[[NSMutableDictionary alloc]init];
    [myDic setValue:kActiveStudentSessionId forKey:@"ActiveStudentSessionId"];
    [myDic setValue:[NSString stringWithFormat:@"%d",kTACurrentCurriculamId] forKey:@"TACurriculumId"];
    [myDic setValue:[NSString stringWithFormat:@"%d",kMstTrialType] forKey:@"MstTrialTypeId"];
    [myDic setValue:[NSString stringWithFormat:@"%d",kTAStepID] forKey:@"TATrainingStepId"];
    [myDic setValue:[NSString stringWithFormat:@"%d",kTAMstPromptStepId] forKey:@"MstPromptStepId"];
    [myDic setValue:kStaffName forKey:@"Staff"];
    [myDic setValue:[NSString stringWithFormat:@"%d",kTAStepID] forKey:@"TAStepIndependentId"];
    [myDic setValue:[NSString stringWithFormat:@"%d",kTAMstSettingID] forKey:@"MstSetttingId"];
    [myDic setValue:@"1" forKey:@"MstStatusId"];
    [myDic setValue:@"1" forKey:@"NoOfTrials"];
    [myDic setValue:[self getCurrentDate] forKey:@"Date"];
    [myDic setValue:[StudentDatabase getMaxTASessionOrder:[kStuCuriculumId intValue]] forKey:@"Order"];
    [myDic setValue:@"false" forKey:@"IsSummarized"];
    [myDic setValue:@"false" forKey:@"IsFinished"];
    [myDic setValue:@"false" forKey:@"IsEmailEnabled"];
   
    
    
    [StudentDatabase addNewSeesionToTAActiveSessionTable:myDic];
    
    mydefaultArry=nil;
    
}

-(void)TAPromtOptionSelection:(id)sender{
    
    
    TAPromptOPtion *prompt=(TAPromptOPtion *)sender;
  
    
    UIButton *pressedButton = (UIButton *)sender;
    UIView *superViewOfPressedUIview = pressedButton.superview;
    TAStepScrollView *superViewOfPressedButton=(TAStepScrollView *)superViewOfPressedUIview;
    
    
    int trianingStep=superViewOfPressedButton.tag+1;
    
    if(trianingStep==kTATraingStepID){
        
        kTAMstPromptStepId=prompt.tag;
        TA_SummarizeButton.enabled=YES;
        kMstPromptStepName=prompt.titleLabel.text;
        
         self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATotalNUmberOfStepsForSession, 0 ); 
        
    }else if(kTATraingStepID==0){
        
        
       // kTAMstPromptStepId=prompt.tag;
        //TA_SummarizeButton.enabled=YES;
    }else{
        // kTAMstPromptStepId=prompt.tag;
         //TA_SummarizeButton.enabled=NO;
    }
    
 //   NSLog(@" scrollview.stepID 2 ,...%@", superViewOfPressedButton.stepID);
    for(UILabel *primaryKeyLbl in superViewOfPressedButton.subviews){
        if([primaryKeyLbl isKindOfClass:[UILabel class]]&& primaryKeyLbl.tag==kTAPrimaykeyLblStepTag){
            if([primaryKeyLbl.text isEqualToString:@"NotAnsweredYet"]){
                
               
                // NSLog(@"primary key text NotAnsweredYet %@",primaryKeyLbl.text);
                primaryKeyLbl.text=[self insertValveTAActiveTrial:superViewOfPressedButton.stepID optionCliked:prompt.TAPromptStepID];
                
            }else{
                
               // NSLog(@"primary key text %@",primaryKeyLbl.text);
                
               [self updateValeInTAActiveTrial:primaryKeyLbl.text optionCliked: prompt.TAPromptStepID];            
            }
        }
    }
    
    
    
    
    
    for(UIButton *selectedOptions in superViewOfPressedButton.subviews){
        if([selectedOptions isKindOfClass:[UIButton class]]){
            [selectedOptions setSelected:NO];
            
        }
    }
    [sender setSelected:YES];
    
   
    
    
}

-(void)TASummarizePageStepGridCreation:(int )numberOfSteps{
    
    
    numberOfSteps=numberOfSteps+1;
    
    
    for(UIScrollView *myScrollView in self.TA_SummarizeUIview.subviews){
        if([myScrollView isKindOfClass:[UIScrollView class]]&&myScrollView.tag==47685){
            [myScrollView removeFromSuperview];
            
        }
    }
    
    kTSIcount=0;
    
     if(TASummarizeStepGridscrollView)TASummarizeStepGridscrollView=nil;
    
    UIImage *firstImage=[UIImage imageNamed:@"datagrid_topleft_curve"];
    UIImage *middleImage=[UIImage imageNamed:@"datagrid_whitebox"];
   // UIImage *lastImage=[UIImage imageNamed:@"datagrid_whitebox"];
     UIImage *lastHeaderRightImage=[UIImage imageNamed:@"datagrid_topright_curve"];
     UIImage *lastFooterRightImage=[UIImage imageNamed:@"datagrid_bottomright_curve"];
    
    UIImage *firstFooterImage=[UIImage imageNamed:@"datagrid_bottompleft_curve_footer"];
    
    numberOfSteps=numberOfSteps;
    
    int mainXval=self.view.frame.size.width+middleImage.size.width*numberOfSteps;
    mainXval=mainXval/2;
    
    
    TASummarizeStepGridscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 60,300,middleImage.size.height*2)];   
   
    TASummarizeStepGridscrollView.tag=47685;
    CGFloat xval=0;
    CGFloat yHeaderval=0;
    CGFloat yFooterval=middleImage.size.height;
    NSInteger viewcount= numberOfSteps;  
    UILabel *headerLable;
    UILabel *footerLable;
    UIFont *font;
    for(int i = 0; i< viewcount; i++) {
        
        if(headerLable)headerLable=nil;
        if(footerLable)footerLable=nil;
        
        
        headerLable=[[UILabel alloc]initWithFrame:CGRectMake(xval, yHeaderval, middleImage.size.width, middleImage.size.height)];
        
        
        font = [UIFont systemFontOfSize:10];
        headerLable.font =font;
        headerLable.backgroundColor = [UIColor colorWithPatternImage:middleImage];
        headerLable.textAlignment = UITextAlignmentCenter;
        if(i==0){
             headerLable.text=@"Step";
             headerLable.backgroundColor = [UIColor colorWithPatternImage:firstImage];
        }else if(i==viewcount-1){
             headerLable.text=[NSString stringWithFormat:@"%d",i];
             headerLable.backgroundColor = [UIColor colorWithPatternImage:lastHeaderRightImage];
        }else{
            headerLable.text=[NSString stringWithFormat:@"%d",i];
        }
        

       
        
        footerLable=[[UILabel alloc]initWithFrame:CGRectMake(xval, yFooterval-5, middleImage.size.width, middleImage.size.height)];
       // footerLable.text=@"Footer";
        footerLable.textAlignment = UITextAlignmentCenter;
        font = [UIFont systemFontOfSize:10];
        footerLable.font =font;
        
         footerLable.backgroundColor = [UIColor colorWithPatternImage:middleImage];
        
        if(i==0){
            //footerLable.frame=CGRectMake(xval-2, yFooterval-2, firstFooterImage.size.width, firstFooterImage.size.height);
            
            footerLable.text=@"Data";
             footerLable.backgroundColor = [UIColor colorWithPatternImage:firstFooterImage];
        }else if(i==viewcount-1){
        footerLable.text=[self TAGetSelectedOptionForStep:i-1];
        footerLable.backgroundColor = [UIColor colorWithPatternImage:lastFooterRightImage];
        }else{
            footerLable.text=[self TAGetSelectedOptionForStep:i-1];
            if([[self TAGetSelectedOptionForStep:i-1] isEqualToString:@"I"]){

                kTSIcount+=1;
                
            }
        }
            
        if(i==kTATraingStepID && i!=0){
            footerLable.textColor=[UIColor greenColor];
            headerLable.textColor=[UIColor greenColor];
            //footerLable.backgroundColor=[UIColor greenColor];
            //headerLable.backgroundColor=[UIColor greenColor];

            
            kMstPromptStepName=footerLable.text;
            
        }
        
        [TASummarizeStepGridscrollView addSubview:footerLable];
         [TASummarizeStepGridscrollView addSubview:headerLable];
        xval+=middleImage.size.width;
        
    }    
    TASummarizeStepGridscrollView.contentSize = CGSizeMake(middleImage.size.width*numberOfSteps, 0);  
    TASummarizeStepGridscrollView.showsHorizontalScrollIndicator=NO;
    
    [self.TA_SummarizeUIview addSubview:TASummarizeStepGridscrollView];
    
   
    
    
    
}
-(NSString *)TAGetSelectedOptionForStep:(int)scrollViewTag{
    
    
    NSString *returnString;
    
    for(UIScrollView *optionScrillView in self.TA_DataEntryUIview.subviews){
        if([optionScrillView isKindOfClass:[UIScrollView class]]&& optionScrillView.tag==kTAoptionPageHorizantalScrollView){
            
            for(UIScrollView *verticleScrollView in optionScrillView.subviews){
                if([verticleScrollView isKindOfClass:[UIScrollView class]]&& verticleScrollView.tag==scrollViewTag){
                    
                    for(UIButton *selectedButton in verticleScrollView.subviews){
                        if([selectedButton isKindOfClass:[UIButton class]]){
                            if([selectedButton isSelected]){
                                returnString = selectedButton.titleLabel.text;
                                
                            }
                        }
                    }
                    
                    
                }
            }
            
            
            
            
        }
    }
    
    return returnString;
    
}



-(NSString *)insertValveTAActiveTrial:(NSString *)CurrentStepNumber optionCliked:(NSString *)valForStep{
    
    NSMutableDictionary *myDiction=[[NSMutableDictionary alloc]init];
    [myDiction setValue:[NSString stringWithFormat:@"%d",kTAActiveSessionID] forKey:@"TAActiveSessionId"];
    [myDiction setValue:CurrentStepNumber forKey:@"TAStepId"];
    [myDiction setValue:valForStep forKey:@"TAPromptStepId"];
    
    
        
    NSString *returnsString =[StudentDatabase insertInToTAActiveTrial:myDiction];
    return returnsString;
    
    
}
-(NSString *)updateValeInTAActiveTrial:(NSString *)CurrentStepNumber optionCliked:(NSString *)valForStep{
   
    
    NSMutableDictionary *myDiction=[[NSMutableDictionary alloc]init];
     [myDiction setValue:valForStep forKey:@"TAPromptStepID"]; 
    [myDiction setValue:CurrentStepNumber forKey:@"TAActivetrialId"];
    
    
    
   [StudentDatabase updateInToTAActiveTrial:myDiction];
    return nil;
}

#pragma mark TA functions implementaion
-(IBAction)TA_SkipTpStep:(id)sender{
    int Xval=kTATraingStepID-1;
    
   
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    TAOptionScrollViewHorizantal.contentOffset=CGPointMake(Xval*TAOptionScrollViewHorizantal.frame.size.width, 0);
    [UIView commitAnimations];
    
    // Setting Step Number
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepNumberLableTag){
            steplabl.text=[NSString stringWithFormat:@"Step %d / %d",kTATraingStepID,kTATotalNUmberOfStepsForSession];
            
        }
    }
    
    //setting Step Discription text
    
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
            steplabl.text=[NSString stringWithFormat:@"%@",[[TATrialStepArry objectAtIndex:kTATraingStepID-1]valueForKey:@"stepdiscription" ]];
            
        }
    }
}

- (IBAction)TA_TrailTypeSelection:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry=[StudentDatabase TrialType];
    self.myPickerView.tag=kTA_TrailTypeButton;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIButton *mButton  in self.TA_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kTA_TrailTypeButton){
            NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
            int index = 0;
            while (index < [myPickerviewArry count]) {
                NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"trialtype"];
                if ([title isEqualToString:buttonTitle]) {
                    [myPickerView selectRow:index inComponent:0 animated:NO];
                    selectedIndex = index;
                    break;
                }
                index++;
            }
         }
    }
}

- (IBAction)TA_TrainingStepSelection:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry=[StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    
    if(myPickerviewArry.count > 0){
        self.myPickerView.tag=kTA_TrainingStepButton;
        [self.myPickerView reloadAllComponents];
        [self presentView:pickerBackground show:YES];
        
         if(myPickerView.tag==kTA_TrainingStepButton&& ![self.TA_SetUPUIview isHidden]){
             for(UIButton *mybutton in self.TA_SetUPUIview.subviews){
                 if([mybutton isKindOfClass:[UIButton class]]&& mybutton.tag==83923){
                int index = 0;
                NSString *buttonTitle = [mybutton titleForState:UIControlStateNormal];
                while (index < [myPickerviewArry count]) {
                    NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"stepname"];
                    if ([title isEqualToString:buttonTitle]) {
                        [myPickerView selectRow:index inComponent:0 animated:NO];
                        selectedIndex = index;
                        break;
                    }
                    index++;
                }
            }
        }
        } else if(myPickerView.tag==kTA_TrainingStepButton && ![self.TA_SummarizeUIview isHidden]){
            for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
                if([srcolView isKindOfClass:[UIScrollView class]]){
                    for(UIButton *mButton  in srcolView.subviews){
                        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kTA_TrainingStepButton){
                            NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
                            int index = 0;
                            while (index < [myPickerviewArry count]) {
                                NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"stepname"];
                                if ([title isEqualToString:buttonTitle]) {
                                    [myPickerView selectRow:index inComponent:0 animated:NO];
                                    selectedIndex = index;
                                    break;
                                }
                                index++;
                            }
                        }
                    }
                }
            }
        }
    }else{
        
        
        UIAlertView *myAllertView =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No records found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [myAllertView show];
        
        for(UIButton *mybutton in self.TA_SetUPUIview.subviews){
            if([mybutton isKindOfClass:[UIButton class]]&& mybutton.tag==2112){
                 [mybutton setEnabled:NO];
                
            }
        }
    }
}

- (IBAction)TAFsiBsiTsiSelection:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry=[StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    self.myPickerView.tag=kTAFsiBsiTsiButtonTag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
}

- (IBAction)TANumberOfTrials:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    self.myPickerView.tag=kTANoOFTrialButtonTag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
        if([srcolView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in srcolView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==347973){
                    int index = 0;
                    NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
                    while (index < [myPickerviewArry count]) {
                        NSString *title = [myPickerviewArry objectAtIndex:index];
                        if ([title isEqualToString:buttonTitle]) {
                            [myPickerView selectRow:index inComponent:0 animated:NO];
                            selectedIndex = index;
                            break;
                        }
                        index++;
                    }
                }
            }
        }
    }
}

-(IBAction)TA_StartSession:(id)sender{
 
    // get prompt for TA curriculum
  //  StepID
    NSMutableArray *promptAyy=[StudentDatabase getTAPromptOption:kTACurrentCurriculamId];
   
    [StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    
    kTAMstPromptStepId=[[[promptAyy objectAtIndex:0]valueForKey:@"PromptID"] intValue];
    //kTAStepID=[[[[StudentDatabase getTATrainignSteps:kTACurrentCurriculamId]objectAtIndex:0]valueForKey:@"StepID"] intValue];
    kTATotalNUmberofOptionsInStep=promptAyy.count;
   
    
    
    //Add new session to ActiveStudentSession table
   
    kActiveStudentSessionId=[StudentDatabase insertActiveStudentSession:kStuCuriculumId isDirty:@"true" lastSyncDate:[self getCurrentDate]];
    [self ImageForStudentAsPerStudentSessionId:kActiveStudentSessionId imageNameForSession:kActiveStudentImageName];
    

    
    
    //adding data to TAActiveSession Table
    [self performSelector:@selector(ADDTAActivesession)];
    
    
    
    
    
    
    
    self.TA_SetUPUIview.hidden=YES;
    self.TA_DataEntryUIview.hidden=NO;
   isNewSessionStartType= oldSession;
    NSMutableArray *StepDetailArry=[StudentDatabase getTATrainignSteps:kTACurrentCurriculamId];
    if(TATrialStepArry)TATrialStepArry=nil;
    [StepDetailArry removeObjectAtIndex:0];
    
    TATrialStepArry=StepDetailArry;
    
  kTATotalNUmberOfStepsForSession=[StepDetailArry count];
    
    //setting Step lable text
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepNumberLableTag){
            steplabl.text=[NSString stringWithFormat:@"Step %d / %d",1,kTATotalNUmberOfStepsForSession];
            
        }
    }
    
    
    //setting Step Discription text
    
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
            steplabl.text=[NSString stringWithFormat:@"%@",[[StepDetailArry objectAtIndex:0]valueForKey:@"stepdiscription" ]];
            
        }
    }
    
    for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTATrainingStepLablTag){
            if(kTATraingStepID==0){
                steplabl.text=@"Training Step : NA";
                
            }else{
                steplabl.text= [NSString stringWithFormat:@"Training Step : %d",kTATraingStepID];
            }
            
        }
    }

    for(UILabel *steplabl in self.TA_SummarizeUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
            steplabl.text=[NSString stringWithFormat:@"%@",[[StepDetailArry objectAtIndex:0]valueForKey:@"stepdiscription" ]];
            
        }
    }
    
    for(UILabel *steplabl in self.TA_SummarizeUIview.subviews){
        if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTATrainingStepLablTag){
            if(kTATraingStepID==0){
                steplabl.text=@"Training Step : NA";
                
            }else{
                steplabl.text= [NSString stringWithFormat:@"Training Step : %d",kTATraingStepID];
            }
            
        }
    }
    
   
    /*
    for(UIButton *mytrainingButton in self.TA_SetUPUIview.subviews){
        if([mytrainingButton isKindOfClass:[UIButton class]]&& mytrainingButton.tag==83923){
            
            if([mytrainingButton.titleLabel.text isEqualToString:@"NA"]){
             
                for(UIButton *myskipButton in self.TA_DataEntryUIview.subviews){
                    if([myskipButton isKindOfClass:[UIButton class]]&& myskipButton.tag==56856){
                        
                        myskipButton.enabled=NO;
                        
                    }
                }
                
            }
            
        }
    }
    */
    
    if(kTATraingStepID==0){
        for(UIButton *myskipButton in self.TA_DataEntryUIview.subviews){
            if([myskipButton isKindOfClass:[UIButton class]]&& myskipButton.tag==56856){
                
               // TA_SummarizeButton.enabled=NO;
                myskipButton.enabled=NO;
                
            }
        }
    }else{
        for(UIButton *myskipButton in self.TA_DataEntryUIview.subviews){
            if([myskipButton isKindOfClass:[UIButton class]]&& myskipButton.tag==56856){
                 
              //  TA_SummarizeButton.enabled=NO;
                myskipButton.enabled=YES;
                
            }
        }
    }
    
     [self TACreateOPtionPage:[StepDetailArry count] promptOption:promptAyy stepsDetail:StepDetailArry];
    promptAyy=nil;     
    StepDetailArry=nil;
    
    
    
    
}

-(IBAction)TA_SummariseData:(id)sender{
    
   
    NSString *promptSelectForTrainigStep=[StudentDatabase checkTASessionPromptIsSelected:kTAActiveSessionID forTrainingStepId:kTAStepID];
    
    if(kTATraingStepID!=0){
        
        if([promptSelectForTrainigStep isEqualToString:@"0"]){
            NSString *chainStringID=[StudentDatabase getMstChainingSequenceID:kTACurrentCurriculamId];
            
            if([chainStringID isEqualToString:@"747"]){
                
                UIAlertView *myAlertView =[[UIAlertView alloc]initWithTitle:@"" message:@"Total Task TA's require data for all steps.  Please fill in data for all steps then summarize data." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
                
            }else{
                
                UIAlertView *myAlertView =[[UIAlertView alloc]initWithTitle:@"" message:@"You cannot summarize session data without first entering data for the training step.  Please enter data for the training step and then summarize data." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
                
            }
            
            
            
        }else{
            
            [self TA_SummaiseDataButtonEnabled];
            
            
        } 
    
    
    }else{
        
         NSString *promptSelected=[StudentDatabase checkTASessionPromptIsSelected:kTAActiveSessionID];
         NSString *chainStringID=[StudentDatabase getMstChainingSequenceID:kTACurrentCurriculamId];
        if([chainStringID isEqualToString:@"747"]&& [promptSelected intValue]!=kTATotalNUmberOfStepsForSession){
                            
            
            
                UIAlertView *myAlertView =[[UIAlertView alloc]initWithTitle:@"" message:@"Total Task TA's require data for all steps.  Please fill in data for all steps then click 'Finish'." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
           
            
        }else if(![chainStringID isEqualToString:@"747"]&&[promptSelected isEqualToString:@"0"]){
            
           
                
                UIAlertView *myAlertView =[[UIAlertView alloc]initWithTitle:@"" message:@"To Summarize Session,  enter data for atleast one step." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
                
            
            
            
        }else{
            
         [self TA_SummaiseDataButtonEnabled];
            
        }
    }
    
    
    [self isTAFinishButtonEnabled];
    
        
}

- (void)showTARecommendations
{
    [self showTAFirstRecommendation];
    [self showTASecondRecommendation];
}

-(void)TA_SummaiseDataButtonEnabled{
    
    
    
    [StudentDatabase updateTAActiveSessionOnSummasize:[NSString stringWithFormat:@"%d",kTAMstPromptStepId] TAActiveSessionId:[NSString stringWithFormat:@"%d",kTAActiveSessionID]];
    
    
    
    [self TASummarizePageStepGridCreation:kTATotalNUmberOfStepsForSession];
    [self Default_TA_StatusSelection];
    [self Default_TA_SettingSelection];
    
    
    
    for(UIScrollView *myScrollView in self.TA_SummarizeUIview.subviews){
        
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            for(UISwitch *switc in myScrollView.subviews){
                if([switc isKindOfClass:[UISwitch class]]){
                    [switc setOn:NO];
                    
                }
            }
            
        }
    }
    kTAEmailSessionDATA=@"false";
 //   TA_FSIBSITSI_button.titleLabel.text=kTAFsiBsiTsiName;
    kTANoOfTrial=1;
    TA_numberOfTrialsButton.titleLabel.text=@"1";
    TA_SetUPUIview.hidden=YES;
    TA_DataEntryUIview.hidden=YES;
    TA_SummarizeUIview.hidden=NO;
    
    NSString *chainStringID=[StudentDatabase getMstChainingSequenceID:kTACurrentCurriculamId];
    
    if([chainStringID isEqualToString:@"745"]){
        
        self.TA_FSIBSITSI_lbl.text=@"LSI :";
        
        if(kTATraingStepID==0){
            
             [TA_FSIBSITSI_button setTitle:@"NA" forState:UIControlStateNormal];
            kTAFsiBsiTsi=kTAStepID;
            
        }else if([kTAFsiBsiTsiName intValue]==kTATotalNUmberOfStepsForSession && [kMstPromptStepName isEqualToString:@"I"]){
            
            //  TA_FSIBSITSI_button.titleLabel.text=[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]];
            [TA_FSIBSITSI_button setTitle:[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]] forState:UIControlStateNormal];
             kTAFsiBsiTsi=[[[TATrialStepArry objectAtIndex:[TA_FSIBSITSI_button.titleLabel.text intValue]-1] valueForKey:@"StepID"]intValue];
            
        }else if([kTAFsiBsiTsiName intValue]!=1){
            
            //TA_FSIBSITSI_button.titleLabel.text=[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]-1];
            [TA_FSIBSITSI_button setTitle:[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]-1] forState:UIControlStateNormal];
             kTAFsiBsiTsi=[[[TATrialStepArry objectAtIndex:[TA_FSIBSITSI_button.titleLabel.text intValue]-1] valueForKey:@"StepID"]intValue];
        }else{
            
             [TA_FSIBSITSI_button setTitle:[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]] forState:UIControlStateNormal];
             kTAFsiBsiTsi=[[[TATrialStepArry objectAtIndex:[TA_FSIBSITSI_button.titleLabel.text intValue]-1] valueForKey:@"StepID"]intValue];
        }
        
        
        
    }else if([chainStringID isEqualToString:@"746"]){
        
        self.TA_FSIBSITSI_lbl.text=@"FSI :";
       
        if(kTATraingStepID==0){
            
           [TA_FSIBSITSI_button setTitle:@"NA" forState:UIControlStateNormal];
           kTAFsiBsiTsi=kTAStepID;
            
        }else if([kTAFsiBsiTsiName intValue]==1 && [kMstPromptStepName isEqualToString:@"I"]){
            
       //  TA_FSIBSITSI_button.titleLabel.text=[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]];
        [TA_FSIBSITSI_button setTitle:[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]] forState:UIControlStateNormal];
              kTAFsiBsiTsi=[[[TATrialStepArry objectAtIndex:[TA_FSIBSITSI_button.titleLabel.text intValue]-1] valueForKey:@"StepID"]intValue];
            
        }else if([kTAFsiBsiTsiName intValue]!=kTATotalNUmberOfStepsForSession){
             [TA_FSIBSITSI_button setTitle:[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]+1] forState:UIControlStateNormal];
              kTAFsiBsiTsi=[[[TATrialStepArry objectAtIndex:[TA_FSIBSITSI_button.titleLabel.text intValue]-1] valueForKey:@"StepID"]intValue];
           // TA_FSIBSITSI_button.titleLabel.text=[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]+1];
        }else{
            [TA_FSIBSITSI_button setTitle:[NSString stringWithFormat:@"%d",[kTAFsiBsiTsiName intValue]] forState:UIControlStateNormal];
              kTAFsiBsiTsi=[[[TATrialStepArry objectAtIndex:[TA_FSIBSITSI_button.titleLabel.text intValue]-1] valueForKey:@"StepID"]intValue];
        }
        
    }else if([chainStringID isEqualToString:@"747"]){
        
        
        int totalIcount=0;
       // NSString *promptStepid;
        
        for(int i=0;i<kTATotalNUmberOfStepsForSession;i++){
            
            
            if([[self TAGetSelectedOptionForStep:i] isEqualToString:@"I"]){
                
                totalIcount+=1;
                
            }            
        }
        if(totalIcount==0){
            
             [TA_FSIBSITSI_button setTitle:@"NA" forState:UIControlStateNormal];
            
        }else{
             [TA_FSIBSITSI_button setTitle:[NSString stringWithFormat:@"%d",totalIcount] forState:UIControlStateNormal];
            // kTAFsiBsiTsi=totalIcount;
            kTAFsiBsiTsi=[[[TATrialStepArry objectAtIndex:totalIcount-1] valueForKey:@"StepID"]intValue];
            
        }
       
        self.TA_FSIBSITSI_lbl.text=@"TSI :";
        //TA_FSIBSITSI_button.titleLabel.text=[NSString stringWithFormat:@"%d",kTSIcount];
        
       
        
        
    }

}
-(IBAction)TAResumeSession:(id)sender{
    
    TA_SetUPUIview.hidden=YES;
    TA_DataEntryUIview.hidden=NO;
    TA_SummarizeUIview.hidden=YES;
    [StudentDatabase TAResumeSession:[NSString stringWithFormat:@"%d",kTAActiveSessionID]];
    

}
-(IBAction)EmailSessionData:(id)sender{
    
    UISwitch *myswitch = (UISwitch *)sender;
    if(myswitch.on){
        
        if(myswitch.tag==kSAEmailSessionSwithTag){
            
            kSAEmailSessionDASA=@"true";
            
        }else if(myswitch.tag==kTAEmailSessionSwithTag){
         
            kTAEmailSessionDATA=@"true";
        }else if(myswitch.tag==kITEmailSessionSwithTag){
            
            kITEmailSessionDATA=@"true";
        }
        
    } else{
        
        if(myswitch.tag==kSAEmailSessionSwithTag){
            
            kSAEmailSessionDASA=@"false";
            
            
        }else if(myswitch.tag==kTAEmailSessionSwithTag){
            
             kTAEmailSessionDATA=@"false";
            
        }else if(myswitch.tag==kITEmailSessionSwithTag){
            
            kITEmailSessionDATA=@"false";
            
        }
               
    }
    
}
-(IBAction)TAFinishSession:(id)sender{
    
    NSMutableDictionary *myFinishdiction =[[NSMutableDictionary alloc]init];
    [myFinishdiction setValue:[NSString stringWithFormat:@"%d",kTAMstPromptStepId] forKey:@"MstPromptStepId"];
    [myFinishdiction setValue:TAStaffTextField.text forKey:@"Staff"];
    [myFinishdiction setValue:[NSString stringWithFormat:@"%d",kTAFsiBsiTsi] forKey:@"TAStepIndependentId"];
    [myFinishdiction setValue:[NSString stringWithFormat:@"%@",TA_FSIBSITSI_button.titleLabel.text] forKey:@"TAStepIndependentName"];
    [myFinishdiction setValue:[NSString stringWithFormat:@"%d",kTAMstSettingID] forKey:@"MstSetttingId"];
    [myFinishdiction setValue:[NSString stringWithFormat:@"%d",kTAMstStatusID] forKey:@"MstStatusId"];
    [myFinishdiction setValue:[NSString stringWithFormat:@"%d",kTANoOfTrial] forKey:@"NoOfTrials"];
    [myFinishdiction setValue:[self getCurrentDate] forKey:@"Date"];
    //[myFinishdiction setValue:@"1" forKey:@"order"];
    [myFinishdiction setValue:kTAEmailSessionDATA forKey:@"IsEmailEnabled"];
    [myFinishdiction setValue:[NSString stringWithFormat:@"%d",kTAActiveSessionID] forKey:@"sessionID"];
   
   BOOL resultStatus= [StudentDatabase updateTAActiveSessionOnFinish:myFinishdiction];
    resultStatus=[StudentDatabase insertInToTAPastSession:myFinishdiction];
    
    
        
    if(resultStatus){
        
        self.TA_SetUPUIview.hidden=YES;
        self.TA_DataEntryUIview.hidden=YES;
        self.TA_SummarizeUIview.hidden=YES;
        currentSessionType=noCurrentSeeion;
        
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:0];
        
        //Once session is finished sync the data.
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {
            [[ACESyncManager getSyncManager] syncCurriculumWithServer];
        }
        
    }
    
    
}
-(IBAction)TADiscaedSession:(id)sender{
 
    
    self.TA_SetUPUIview.hidden=YES;
    self.TA_DataEntryUIview.hidden=YES;
    self.TA_SummarizeUIview.hidden=YES;
    
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:0];
    
}
-(IBAction)TA_NextAndPreviusTrialClicked:(id)sender{
 
    
    UIButton *clickedButton =(UIButton *)sender;
    
    
    // [SA_summarizeButton setEnabled:NO];
    
    if(clickedButton.tag==1){
        
      
        
        if(TAOptionScrollViewHorizantal.contentOffset.x>0){
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [TAOptionScrollViewHorizantal setContentOffset:CGPointMake(TAOptionScrollViewHorizantal.contentOffset.x-TAOptionScrollViewHorizantal.frame.size.width, 0)];
            
            [UIView commitAnimations];
            
            
            
            int offsetXval = TAOptionScrollViewHorizantal.contentOffset.x;
            offsetXval=offsetXval/TAOptionScrollViewHorizantal.frame.size.width;
            offsetXval+=1;
            
            // Setting Step Number
            for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
                if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepNumberLableTag){
                    steplabl.text=[NSString stringWithFormat:@"Step %d / %d",offsetXval,kTATotalNUmberOfStepsForSession];
                    
                }
            }
            
            //setting Step Discription text
            
            
            for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
                if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
                    steplabl.text=[NSString stringWithFormat:@"%@",[[TATrialStepArry objectAtIndex:offsetXval-1]valueForKey:@"stepdiscription" ]];
                    
                }
            }
           
        }
    }else if(clickedButton.tag==2){
       
        int TAoffsetXval = TAOptionScrollViewHorizantal.contentOffset.x;
        TAoffsetXval=TAoffsetXval/TAOptionScrollViewHorizantal.frame.size.width;
      //  NSLog(@"Offset...%d , training step.... %d",TAoffsetXval,kTATraingStepID);
        
        
         NSString *promptStepid=[StudentDatabase getTAOldSessionStepsPromptForActiveSessionId:[NSString stringWithFormat:@"%d",kTAActiveSessionID] forStep:[[TATrialStepArry objectAtIndex:TAoffsetXval]valueForKey:@"StepID"]];
        
        TAoffsetXval+=1;
        if(TAoffsetXval==kTATraingStepID && [promptStepid isEqualToString:@"Not yet Done"]){
            
            
            UIAlertView *myalertView=[[UIAlertView alloc]initWithTitle:@"" message:@"You cannot move to the next step without first entering data for the training step.  Please enter data for the training step." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [myalertView show];
            
            
        }else{
       
            self.TAOptionScrollViewHorizantal.contentSize=CGSizeMake(self.TAOptionScrollViewHorizantal.frame.size.width*kTATotalNUmberOfStepsForSession, 0 );
            
            
            double frameSize=TAOptionScrollViewHorizantal.frame.size.width+TAOptionScrollViewHorizantal.contentOffset.x;
            //     NSLog(@"Content offset: %@, mode: %@ , frameSize %f",NSStringFromCGPoint(TAOptionScrollViewHorizantal.contentOffset),NSStringFromCGSize(TAOptionScrollViewHorizantal.contentSize), frameSize);
            
            if(frameSize < TAOptionScrollViewHorizantal.contentSize.width){
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5];
                
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                
                [TAOptionScrollViewHorizantal setContentOffset:CGPointMake(TAOptionScrollViewHorizantal.contentOffset.x+TAOptionScrollViewHorizantal.frame.size.width, 0)];
                
                [UIView commitAnimations];
                
                
                
                int offsetXval = TAOptionScrollViewHorizantal.contentOffset.x;
                offsetXval=offsetXval/TAOptionScrollViewHorizantal.frame.size.width;
                NSLog(@"Offset...%d , training step.... %d",offsetXval,kTATraingStepID);
                
                offsetXval+=1;
                
                // Setting Step Number
                for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
                    if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepNumberLableTag){
                        steplabl.text=[NSString stringWithFormat:@"Step %d / %d",offsetXval,kTATotalNUmberOfStepsForSession];
                        
                    }
                }
                
                //setting Step Discription text
                
                
                for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
                    if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
                        steplabl.text=[NSString stringWithFormat:@"%@",[[TATrialStepArry objectAtIndex:offsetXval-1]valueForKey:@"stepdiscription" ]];
                        
                    }
                }
            }
            
            
        }
     
       
    }
    
   
}
-(void)TA_oldSummarizeData{
    
   /* BOOL result=[StudentDatabase updateTAActiveSessionOnSummasize:[NSString stringWithFormat:@"%d",kTAMstPromptStepId] TAActiveSessionId:[NSString stringWithFormat:@"%d",kTAActiveSessionID]];
    
    
    
    [self TASummarizePageStepGridCreation:kTATotalNUmberOfStepsForSession];
    [self Default_TA_StatusSelection];
    [self Default_TA_SettingSelection];
    
    
    
    for(UIScrollView *myScrollView in self.TA_SummarizeUIview.subviews){
        
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            for(UISwitch *switc in myScrollView.subviews){
                if([switc isKindOfClass:[UISwitch class]]){
                    [switc setOn:NO];
                    
                }
            }
            
        }
    }
    
     kTAEmailSessionDATA=@"false";
     TA_FSIBSITSI_button.titleLabel.text=kTAFsiBsiTsiName;
    TA_numberOfTrialsButton.titleLabel.text=@"1";
    kTANoOfTrial=1;
    
    TA_SetUPUIview.hidden=YES;
    TA_DataEntryUIview.hidden=YES;
    TA_SummarizeUIview.hidden=NO;
    */
    
    /*
    NSString *promptSelectForTrainigStep=[StudentDatabase checkTASessionPromptIsSelected:kTAActiveSessionID forTrainingStepId:kTAStepID-1];
    
    if(kTATraingStepID!=0){
        
        if([promptSelectForTrainigStep isEqualToString:@"0"]){
            NSString *chainStringID=[StudentDatabase getMstChainingSequenceID:kTACurrentCurriculamId];
            
            if([chainStringID isEqualToString:@"747"]){
                
                UIAlertView *myAlertView =[[UIAlertView alloc]initWithTitle:@"" message:@"Total Task TA's require data for all steps.  Please fill in data for all steps then click 'Finish'." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
                
            }else{
                
                UIAlertView *myAlertView =[[UIAlertView alloc]initWithTitle:@"" message:@"You cannot summarize session data without first entering data for the training step.  Please enter data for the training step and then click 'Finish'." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
                
            }
            
            
            
        }else{
            
            [self TA_SummaiseDataButtonEnabled];
            
            
        } 
        
        
    }else{
        
        NSString *promptSelected=[StudentDatabase checkTASessionPromptIsSelected:kTAActiveSessionID];
        
        if([promptSelected isEqualToString:@"0"]){
            
            
            NSString *chainStringID=[StudentDatabase getMstChainingSequenceID:kTACurrentCurriculamId];
            
            if([chainStringID isEqualToString:@"747"]){
                
                UIAlertView *myAlertView =[[UIAlertView alloc]initWithTitle:@"" message:@"Total Task TA's require data for all steps.  Please fill in data for all steps then click 'Finish'." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
                
            }else{
                
                UIAlertView *myAlertView =[[UIAlertView alloc]initWithTitle:@"" message:@"You cannot summarize session data without first entering data for the training step.  Please enter data for the training step and then click 'Finish'." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
                
            }
            
            
        }else{
            
            [self TA_SummaiseDataButtonEnabled];
            
        }
    }
    
    
*/
    

    [self TA_SummaiseDataButtonEnabled];
    [self isTAFinishButtonEnabled];
}
#pragma mark UItextfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    [self isSAFinishButtonEnabled];
    
    [self isITFinishButtonEnabled];
    [self isTAFinishButtonEnabled];
    
    
    return YES;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    //return (newLength > 10) ? NO : YES;
    
    
    
    NSCharacterSet *acceptedInput = [NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS];
    
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if (![acceptedInput characterIsMember:c] || newLength > 10) {
            return NO;
        }
    }
    return YES;
}

#pragma mark UIView Touch delegate 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    if(self.myPickerView){
//        [self.myPickerView removeFromSuperview];
//    }
    
    
    
    
    for(UIScrollView *scrollView in self.SA_SummarizeUIview.subviews){
        
        for(UITextField *txt in scrollView.subviews){
            if([txt isKindOfClass:[UITextField class]]){
                [txt resignFirstResponder];
                
            }
        }
        
        if([scrollView isKindOfClass:[UIScrollView class]] && scrollView.tag==kSAScrollUpViewTag&&scrollView.contentOffset.y==kSAScrollUpView_offSet_Y){
            
           // [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x-kSAScrollUpView_offSet_X, scrollView.contentOffset.y-kSAScrollUpView_offSet_Y)];
            
        }
    }
    
    for(UIScrollView *scrollView in self.TA_SummarizeUIview.subviews){
        
        for(UITextField *txt in scrollView.subviews){
            if([txt isKindOfClass:[UITextField class]]){
                [txt resignFirstResponder];
                
            }
        }
        
        
    }
}

#pragma mark UIscrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    /*//SAOptions scrollview.....
    
    if(scrollView.tag==kSAOptionScrollTag){
        
        
        for(UIView *optionView in SAOptionScrollView.subviews){ // list the all UIview inside SAOptionScrollView 
            
            // NSLog(@"option view tag...%d",optionView.tag);
            if([optionView isKindOfClass:[UIView class]]&& optionView.tag==SATrailNumber-1){
                
                
                // list of buttons inside the Uiview 
                for(UIButton *selectedOptions in optionView.subviews){
                    if([selectedOptions isKindOfClass:[UIButton class]]){
                        
                        if([selectedOptions isSelected]){
                            
                            SA_summarizeButton.enabled=YES;
                            
                            
                        }
                    }
                }
            }
            
        }   
    }
     */
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 
    
    
    if(scrollView.tag==kSAOptionScrollTag){
       // NSLog(@"content size ....%@",NSStringFromCGSize(scrollView.contentSize));
       // NSLog(@"offset .....%@",NSStringFromCGPoint(scrollView.contentOffset));
        
     /*   for(UIView *optionView in SAOptionScrollView.subviews){ // list the all UIview inside SAOptionScrollView 
            
             NSLog(@"option view tag...%d",optionView.tag);
            if([optionView isKindOfClass:[UIView class]]&& optionView.tag==SATrailNumber-1){
                
                
                // list of buttons inside the Uiview 
                for(UIButton *selectedOptions in optionView.subviews){
                    if([selectedOptions isKindOfClass:[UIButton class]]){
                        
                        if([selectedOptions isSelected]){
                            
                            SA_summarizeButton.enabled=YES;
                            
                        
                        }else{
                             SA_summarizeButton.enabled=NO;
                        }
                    }
                }
            }
            
        } */
        
     //   NSLog(@"content size ....%@",NSStringFromCGSize(scrollView.contentSize));
    //    NSLog(@"offset .....%@",NSStringFromCGPoint(scrollView.contentOffset));
        
        
        int offsetXval = scrollView.contentOffset.x;
        offsetXval=offsetXval/scrollView.frame.size.width;
        //offsetXval+=1;
        
        if(offsetXval==SATrailNumber-1){
            
            
            for(UIView *optionView in SAOptionScrollView.subviews){ // list the all UIview inside SAOptionScrollView 
                
                //NSLog(@"option view tag...%d",optionView.tag);
              //  if([optionView isKindOfClass:[UIView class]]&& optionView.tag==SATrailNumber-1){
                    
                    
                    // list of buttons inside the Uiview 
                    for(UIButton *selectedOptions in optionView.subviews){
                        if([selectedOptions isKindOfClass:[UIButton class]]){
                            
                            if([selectedOptions isSelected]){
                                
                                SA_summarizeButton.enabled=YES;
                                
                                
                            }else{
                                SA_summarizeButton.enabled=NO;
                            }
                        }
                    }
                //}
                
            }
            
        }else{
            SA_summarizeButton.enabled=YES;
        }
        
        
        if(SAOptionScrollView.contentOffset.x==0){
            
            SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",1,[[StudentDatabase getSAOldSessionTrialCount:kSAActiveSessionID]intValue]];
        }else  if(SAOptionScrollView.contentSize.width > SAOptionScrollView.contentOffset.x + SAOptionScrollView.frame.size.width){
            
            int currentTrail = SAOptionScrollView.contentOffset.x/300;
            
            SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,[[StudentDatabase getSAOldSessionTrialCount:kSAActiveSessionID]intValue]];
        }
        else{
            
            int currentTrail = SAOptionScrollView.contentOffset.x/300;
            
            SA_TrailLable.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,SATrailNumber];   
            
        }
        
        
        int currentTrail = SAOptionScrollView.contentOffset.x/300;
        NSString *optionSelected=[StudentDatabase getSAOldSessionTrialOptionForActiveSessionId:kSAActiveSessionID forTrialNumber:[NSString stringWithFormat:@"%d",currentTrail+1]];
        
        if([optionSelected isEqualToString:@""]){
            
            [SA_summarizeButton setEnabled:NO];
        }else{
            
            [SA_summarizeButton setEnabled:YES];
        }

        [self showErrorSARecommendations];
        
    }
    
    if(scrollView.tag==kTAoptionPageHorizantalScrollView){
        
        int offsetXval = scrollView.contentOffset.x;
        offsetXval=offsetXval/scrollView.frame.size.width;
        offsetXval+=1;
        
        // Setting Step Number
        for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
            if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepNumberLableTag){
                steplabl.text=[NSString stringWithFormat:@"Step %d / %d",offsetXval,kTATotalNUmberOfStepsForSession];
                
            }
        }
        
        //setting Step Discription text
        
        
        for(UILabel *steplabl in self.TA_DataEntryUIview.subviews){
            if([steplabl isKindOfClass:[UILabel class]] && steplabl.tag==kTAStepDiscroptionLablTag){
                steplabl.text=[NSString stringWithFormat:@"%@",[[TATrialStepArry objectAtIndex:offsetXval-1]valueForKey:@"stepdiscription" ]];
                
            }
        }

        
        
      
        
    }
    
    
    if(scrollView.tag==kITOptionScrollTag){
        
        int offsetXval = scrollView.contentOffset.x;
        offsetXval=offsetXval/scrollView.frame.size.width;
        //offsetXval+=1;
        
        if(offsetXval==kITTrialNumbers-1){
            
            
            for(UIView *optionView in ITOptionScrollView.subviews){ // list the all UIview inside SAOptionScrollView 
                
               
                for(UIButton *selectedOptions in optionView.subviews){
                    if([selectedOptions isKindOfClass:[UIButton class]]){
                        
                        if([selectedOptions isSelected]){
                            
                            IT_SummarizeButton.enabled=YES;
                            
                            
                        }else{
                            IT_SummarizeButton.enabled=NO;
                        }
                    }
                }
                               
            }
            
        }else{
            IT_SummarizeButton.enabled=YES;
        }
        
        
        
        
        if(ITOptionScrollView.contentOffset.x==0){
            
            
            if([[StudentDatabase getITOldSessionTrialCount:kITActiveSessionId]intValue] == 0){
                IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",1,1];
            }else{
                IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",1,[[StudentDatabase getITOldSessionTrialCount:kITActiveSessionId]intValue]];
                
            }
            
        }else  if(ITOptionScrollView.contentSize.width > ITOptionScrollView.contentOffset.x + ITOptionScrollView.frame.size.width){
            
            int currentTrail = ITOptionScrollView.contentOffset.x/300;
            
            IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,[[StudentDatabase getITOldSessionTrialCount:kITActiveSessionId]intValue]];
            
        }else{
            
            int currentTrail = ITOptionScrollView.contentOffset.x/300;
            
            IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,kITTrialNumbers];   
            
        }
        
        int currentTrail = ITOptionScrollView.contentOffset.x/300;
        NSString *optionClicked=[StudentDatabase getITOldSessionTrialOptionForActiveSessionId:kITActiveSessionId forTrialNumber:[NSString stringWithFormat:@"%d",currentTrail+1]];
        if([optionClicked isEqualToString:@""]){
            [IT_SummarizeButton setEnabled:NO];
        }else{
            [IT_SummarizeButton setEnabled:YES];
        }
    }
    
    
    
   
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
   
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //NSLog(@"Dis scroll.....");
    
   // NSLog(@"SAScrollView contentSize.....%@",NSStringFromCGSize(CGSizeMake(SAOptionScrollView.frame.size.width*SATrailNumber, 0)));
    
    //NSLog(@"ContentSize .. . %@",NSStringFromCGSize(SAOptionScrollView.contentSize));
   // NSLog(@"ContentOffset.......%@",NSStringFromCGPoint(SAOptionScrollView.contentOffset));
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
  //  NSLog(@"scrollling...");
    
}
-(void)customiseITView{
    // customise SA_SetUP_GridTableView table view 
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"datagrid5col3row.png"]];
    UIImageView *tempImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"datagrid4col2row.png"]];
    [IT_SetUP_GridTableView setFrame:self.IT_SetUP_GridTableView.frame]; 
    self.IT_SetUP_GridTableView.backgroundView = tempImageView;
    self.IT_SetUP_GridTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [IT_SummarizedTableView setFrame:self.IT_SummarizedTableView.frame]; 
    self.IT_SummarizedTableView.backgroundView = tempImageView1;
    self.IT_SummarizedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    for(UIButton *mybuttons in self.IT_SetUPUIview.subviews){
        if([mybuttons isKindOfClass:[UIButton class]]&& mybuttons.tag!=14512 ){
            [mybuttons setTitle:@"NA" forState:UIControlStateNormal];
            
            [mybuttons setSelected:NO];
            
            
        }
    }
    
     [self addITOptionPageToScrollView];
    
    
}


-(void)initiateITData{
    for(UIButton *mybutton in self.IT_SetUPUIview.subviews){
        if([mybutton isKindOfClass:[UIButton class]]){
            [mybutton setEnabled:YES];
            
        }
    }
    
    
    if(IT_ContextArray)IT_ContextArray=nil;
    IT_ContextArray = [StudentDatabase getITContext:kITStuCurriCulumID];// TODO need to handle for TA IT too
    if(IT_ContextArray.count>0){

        [self performSelector:@selector(Default_IT_ContextSelection)]; // TODO need to handle for TA IT too
        [self performSelector:@selector(Default_IT_TrialTypeSelection)];
    }else{
        if(IT_PastdataArry)IT_PastdataArry=nil;
        UIAlertView *altView =[[UIAlertView alloc]initWithTitle:@"" message:@"All available contexts might have active sessions or no context has been introduced for this curriculum." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        for(UIButton *mybutton in self.IT_SetUPUIview.subviews){
            if([mybutton isKindOfClass:[UIButton class]]){
                [mybutton setEnabled:NO];
                
            }
        }
    }
        
    [IT_SummarizeButton setEnabled:NO];
    
    [IT_SetUP_GridTableView reloadData];
    
    [self ActiveITStudentAndCuricullamName];
}
-(void)CustomiseITView_oldSession{
 
 
    //[IT_SummarizeButton setEnabled:NO];
    
    UIImageView *tempImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"datagrid4col2row.png"]];
      [IT_SummarizedTableView setFrame:self.IT_SummarizedTableView.frame]; 
    self.IT_SummarizedTableView.backgroundView = tempImageView1;
    self.IT_SummarizedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self addITOptionPageToScrollView_oldSession:kITTrialNumbers];
    
    // set name for Context lable
    
    for(UILabel *contextNamelbl in self.IT_DataEntryUIview.subviews){
        if([contextNamelbl isKindOfClass:[UILabel class]]&& contextNamelbl.tag==kITContextNamelableTag){
            contextNamelbl.text=[NSString stringWithFormat:@"Context : %@",kITContextName];
            
        }
    }
    
    for(UILabel *contextNamelbl in self.IT_SummarizeUIview.subviews){
        if([contextNamelbl isKindOfClass:[UILabel class]]&& contextNamelbl.tag==kITContextNamelableTag){
            contextNamelbl.text=[NSString stringWithFormat:@"Context : %@",kITContextName];
            
        }
    }

    IT_DataEntry_ContextName_lable.text=[NSString stringWithFormat:@"Name : %@",[StudentDatabase getContextNameForContextId:kITContextId]];
    IT_SummaryPage_ContextName_lable.text=[NSString stringWithFormat:@"Name : %@",[StudentDatabase getContextNameForContextId:kITContextId]];
   //  IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",1,kITTrialNumbers];
    
}
-(void)InitiateITData_oldSession{
    
     [self ActiveITStudentAndCuricullamName];
}
-(void)Default_IT_TrialTypeSelection{
    
   
    NSMutableArray *myDefaultArry=[[NSMutableArray alloc]init];
    
   
    myDefaultArry=[StudentDatabase TrialType];
    
    
    for(UIButton *mButton  in self.IT_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_TrailTypeButton){
            
            [mButton setTitle:[[myDefaultArry objectAtIndex:0] valueForKey:@"trialtype"] forState:UIControlStateNormal];
            [mButton setSelected:YES];
            kIT_MstTrialTypeId=[[myDefaultArry objectAtIndex:0] valueForKey:@"trialid"];
            kIT_MstTrialTypeName=[[myDefaultArry objectAtIndex:0] valueForKey:@"trialtype"];
            
        }
    }
    
    myDefaultArry=nil;
    
}

-(void)Default_IT_StatusSelection{
    
    NSMutableArray *mydefaultArry=[[NSMutableArray alloc]init];
    
    
    
    mydefaultArry=[StudentDatabase getMStStatus];
    
    
    for(UIScrollView *myScrollView in self.IT_SummarizeUIview.subviews){
        
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            
            
            for(UIButton *mButton  in myScrollView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_StatusButtonTag){
                    
                    [mButton setTitle:[[mydefaultArry objectAtIndex:0] valueForKey:@"mstStatusName"] forState:UIControlStateNormal];
                    
                    kIT_StatusId=[[mydefaultArry objectAtIndex:0] valueForKey:@"mstStatusId"];
                    
                    
                    
                }
            }
        }
    }
    mydefaultArry=nil;
    
}

-(void)addITOptionPageToScrollView{
    
    
    for(UIView *views in self.ITOptionScrollView.subviews){
        if([views isKindOfClass:[UIView class]]){
            [views removeFromSuperview];
            
        }
    }
    
    self.ITOptionScrollView.frame=CGRectMake(10, 120, 300, 185);
    [ITOptionScrollView setContentOffset:CGPointMake(0, 0)];
    [ITOptionScrollView setContentSize:CGSizeMake(0, 0)];
    
    [self.ITOptionScrollView addSubview:[self IToptionsViewCreation:kITTrailNumber]];
    
    
}
-(void)addITOptionPageToScrollView_oldSession:(int)numberOfTrials{
    
    //rest the scroll view ...
     [IT_SummarizeButton setEnabled:NO];
    for(UIView *views in self.ITOptionScrollView.subviews){
        if([views isKindOfClass:[UIView class]]){
            [views removeFromSuperview];
            
        }
    }
    
    self.ITOptionScrollView.frame=CGRectMake(10, 120, 300, 185);
    [ITOptionScrollView setContentOffset:CGPointMake(0, 0)];
    
    int ContentSizeWidth=0;
    UIView *myOPtionViewForolD;
    NSString *answeredOptionName;
    
    for(int i=0;i<numberOfTrials;i++){
        
        
        ContentSizeWidth=i;
        
        if(answeredOptionName)answeredOptionName=nil;
        answeredOptionName=[StudentDatabase getITOldSessionTrialOptionForActiveSessionId:kITActiveSessionId forTrialNumber:[NSString stringWithFormat:@"%d",i+1]];
        
        
        if(myOPtionViewForolD)myOPtionViewForolD=nil;
        
        myOPtionViewForolD=[self IToptionsViewCreation:i];
        
        for(ITOPtionButton *optionbutton in myOPtionViewForolD.subviews){
            if([optionbutton isKindOfClass:[ITOPtionButton class]] && [optionbutton.titleLabel.text isEqualToString:answeredOptionName]){
                
                [optionbutton setSelected:YES];
                [IT_SummarizeButton setEnabled:YES];
                
            }else{
               // 
            }
        }
        
        
        for(UILabel *primaryKeyLbl in myOPtionViewForolD.subviews){
            if([primaryKeyLbl isKindOfClass:[UILabel class]]&& primaryKeyLbl.tag==kSaPrimaykeyLblTag){
                
                
                NSString *restunValue=[StudentDatabase getITOldSessionTrialActiveSessionId:kITActiveSessionId forTrialNumber:[NSString stringWithFormat:@"%d",i+1]];
               
                
                
                
                if([restunValue isEqualToString:@""]){
                    
                    
                    primaryKeyLbl.text=@"NotAnsweredYet";
                    
                }else{
                    
                    primaryKeyLbl.text=restunValue;
                    
                }
                // NSLog(@"Primay key text ....%@",primaryKeyLbl.text);
                
            }
        }

      //  int ContentSizeWidthOffSet=ContentSizeWidth+1;
        
        
        [self.ITOptionScrollView addSubview:myOPtionViewForolD];
        
        [ITOptionScrollView setContentOffset:CGPointMake(self.ITOptionScrollView.frame.size.width*ContentSizeWidth, 0)];
        
        [ITOptionScrollView setContentSize:CGSizeMake(self.ITOptionScrollView.frame.size.width*numberOfTrials, 0)];
         IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",ContentSizeWidth+1,kITTrialNumbers];
    }
    
    if(myOPtionViewForolD)myOPtionViewForolD=nil;
    
    myOPtionViewForolD=[self IToptionsViewCreation:numberOfTrials];
     [self.ITOptionScrollView addSubview:myOPtionViewForolD];
    [ITOptionScrollView setContentSize:CGSizeMake(self.ITOptionScrollView.contentSize.width+self.ITOptionScrollView.frame.size.width, 0)];
    kITTrialNumbers++;
    
    
}
-(void)closeITSession{
    
    self.IT_SetUPUIview.hidden=YES;
    self.IT_DataEntryUIview.hidden=YES;
    self.IT_SummarizeUIview.hidden=YES;
    currentSessionType=noCurrentSeeion;
     [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:0];
}


-(UIView *)IToptionsViewCreation:(NSInteger )tagVal{
    if(ITOptionView)
        ITOptionView=nil;
    int xVal=tagVal*300;
    
    ITOptionView =[[UIView alloc]initWithFrame:CGRectMake(xVal, 0, 300, 185)];
    ITOptionView.tag=tagVal;
    
    UIImage *oImage1 =[UIImage imageNamed:@"green_active_tap_button"];
    UIImage *oImage2 =[UIImage imageNamed:@"green_active_tap_button"];
    UIImage *oImage3 =[UIImage imageNamed:@"red_active_tap_button"];
 //   UIImage *oImage4 =[UIImage imageNamed:@"red_active_tap_button"];
    UIImage *oImage5 =[UIImage imageNamed:@"orange_active_tap_button"];
    
    UIImage *InoImage1 =[UIImage imageNamed:@"green_inactive_tap_button"];
    UIImage *InoImage2 =[UIImage imageNamed:@"green_inactive_tap_button"];
    UIImage *InoImage3 =[UIImage imageNamed:@"red_inactive_tap_button"];
   // UIImage *InoImage4 =[UIImage imageNamed:@"red_inactive_tap_button"];
    UIImage *InoImage5 =[UIImage imageNamed:@"orange_inactive_tap_button"];
    
    for(int i=0;i<kITnumberofOptions;i++){
        ITOPtionButton *optionButton = [ITOPtionButton buttonWithType:UIButtonTypeCustom];
        [optionButton addTarget:self action:@selector(ITOptionClicked:)
               forControlEvents:UIControlEventTouchUpInside];
        
        if(i==0){
            optionButton.frame = CGRectMake(71, 7,72,62);
            [optionButton setBackgroundImage:oImage1 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage1 forState:UIControlStateNormal];
            
            [optionButton setTitle:@"+" forState:UIControlStateNormal];
            optionButton.tag=i;
        }  if(i==1){
            optionButton.frame = CGRectMake(160, 7,72,62);
            [optionButton setBackgroundImage:oImage2 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage2 forState:UIControlStateNormal];
            [optionButton setTitle:@"+P" forState:UIControlStateNormal];
            optionButton.tag=i;
        }  if(i==2){
            optionButton.frame = CGRectMake(71, 92,72,62);
            [optionButton setBackgroundImage:oImage3 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage3 forState:UIControlStateNormal];
            [optionButton setTitle:@"-" forState:UIControlStateNormal];
            optionButton.tag=i;
        }  if(i==3){
            optionButton.frame = CGRectMake(160, 92,72,62);
            [optionButton setBackgroundImage:oImage5 forState:UIControlStateSelected];
            [optionButton setBackgroundImage:InoImage5 forState:UIControlStateNormal];
            [optionButton setTitle:@"NR" forState:UIControlStateNormal];
            optionButton.tag=i;
        }
        
        
        
        
        [ITOptionView addSubview:optionButton];
        
    }
    
    
    UILabel *SAprimaryKeylbl =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    SAprimaryKeylbl.text=@"NotAnsweredYet";
    SAprimaryKeylbl.tag=kSaPrimaykeyLblTag;
    
    [ITOptionView addSubview:SAprimaryKeylbl];
    
    
    
    return ITOptionView;
    
}
-(void)ITOptionClicked:(id)sender{
    
    
    ITOPtionButton *pressedButton = (ITOPtionButton *)sender;
    UIView *superViewOfPressedButton = pressedButton.superview;
    
    [IT_SummarizeButton setEnabled:YES];
    
    
    for(UILabel *primaryKeyLbl in superViewOfPressedButton.subviews){
        if([primaryKeyLbl isKindOfClass:[UILabel class]]&& primaryKeyLbl.tag==kSaPrimaykeyLblTag){
            if([primaryKeyLbl.text isEqualToString:@"NotAnsweredYet"]){
                
                primaryKeyLbl.text=[self insertValveToITActiveTrial:[NSString stringWithFormat:@"%d",superViewOfPressedButton.tag+1] optionCliked:[NSString stringWithFormat:@"%@",pressedButton.titleLabel.text]];
                
           
                
                UIView *myView = [self IToptionsViewCreation:kITTrialNumbers];
                
                [self.ITOptionScrollView addSubview:myView];
                int widthVal=kITTrialNumbers+1;
                
                [ITOptionScrollView setContentSize:CGSizeMake(ITOptionScrollView.frame.size.width*widthVal, 0)];
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5];
                
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                
               // [ITOptionScrollView setContentOffset:CGPointMake(myView.frame.origin.x, 0)];
                
                [UIView commitAnimations];
                [IT_SummarizeButton setEnabled:YES];
                kITTrialNumbers++;
                
                
            }else{
                
                
                [self updateValeInITActiveTrial:primaryKeyLbl.text optionCliked:[NSString stringWithFormat:@"%@",pressedButton.titleLabel.text]];
            }
        }
    }
    
    
    
    
    
    for(ITOPtionButton *selectedOptions in superViewOfPressedButton.subviews){
        if([selectedOptions isKindOfClass:[UIButton class]]){
            [selectedOptions setSelected:NO];
            
        }
    }
    
    
    
    
    
    [sender setSelected:YES];
}


- (void)showITRecommendations
{
    //Show Recommendations.
    [self showITRecommendationForMoreThanEightyPerc];
    [self showITRecommendationForLesserThanSixtyPerc];
}

-(void)updateITPastData:(NSString *)ContextId{
    
    NSMutableArray *resultArry=  [StudentDatabase getITPastData:ContextId];
    
    
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"weekending" ascending:YES];
    //[resultArry sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];
   // [resultArry sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];

    
    for(int i =0;i<resultArry.count;i++){
        
        
        NSString *dateString = [[resultArry objectAtIndex:i]valueForKey:@"weekending"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"M/d/yyyy"];
        NSDate *dateFromString = [[NSDate alloc] init];
        // voila!
        dateFromString = [dateFormatter dateFromString:dateString];
        
        
        
        
        NSMutableDictionary *mydiction=[resultArry objectAtIndex:i];
        [mydiction setValue:dateFromString forKey:@"dateFromString"];
        [resultArry replaceObjectAtIndex:i withObject:mydiction];
        
        
        
        
    }
    
    
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"dateFromString" ascending:YES];
    [resultArry sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];

    
    
    if([resultArry count]>3){
        int extralCounts =[resultArry count]-3;
        for(int i=0;i<extralCounts;i++){
            [resultArry removeObjectAtIndex:0];
            
        }
    }
    
    if(IT_PastdataArry)IT_PastdataArry=nil;
   
    
    
    IT_PastdataArry = resultArry;
    [IT_SetUP_GridTableView reloadData];
}

-(void)updateITSteps:(NSString *)sublevelid{
    
    SA_StepsAyy = [StudentDatabase getSASteps:sublevelid];
    
}



-(void)Default_IT_ContextSelection{
    
    if(myPickerviewArry)myPickerviewArry=nil;
    myPickerviewArry=IT_ContextArray;
    
    
    if(myPickerviewArry.count==0){
        
        
        
        
    }else{
        
        for(UIButton *mButton  in self.IT_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_ContextButtontag){
                
                [mButton setTitle:[[myPickerviewArry objectAtIndex:0] valueForKey:@"Name"] forState:UIControlStateNormal];
                [mButton setSelected:YES];
                
                [self performSelector:@selector(updateITPastData:) withObject:[[IT_ContextArray objectAtIndex:0] valueForKey:@"ContextID"]];
                kITContextId=  [[IT_ContextArray objectAtIndex:0] valueForKey:@"ContextID"];
                kITContextName= [[IT_ContextArray objectAtIndex:0] valueForKey:@"Name"];
               }
        }
    }
    for(UIButton *mButton  in self.IT_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_ContextButtontag){
            
            [mButton setTitle:[[myPickerviewArry objectAtIndex:0] valueForKey:@"Name"] forState:UIControlStateNormal];
           
            [mButton setSelected:YES];
            
            [self performSelector:@selector(updateITPastData:) withObject:[[IT_ContextArray objectAtIndex:0] valueForKey:@"ContextID"]];
            kITContextId=  [[IT_ContextArray objectAtIndex:0] valueForKey:@"ContextID"];
            kITContextName= [[IT_ContextArray objectAtIndex:0] valueForKey:@"Name"];
            
        }
    }
    
}

-(void)Default_IT_MIPSelection{
    
    NSMutableArray *myMIPArray=[StudentDatabase getITMIP:[kStuCuriculumId intValue]];
    
    
    for(UIScrollView *myScrollView in self.IT_SummarizeUIview.subviews){
        
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            
            
            for(UIButton *mButton  in myScrollView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_MIPButtonTag){
                    
                    [mButton setTitle:[[myMIPArray objectAtIndex:0] valueForKey:@"Name"] forState:UIControlStateNormal];
                    
                    kIT_ACEITMIPId=[[myMIPArray objectAtIndex:0] valueForKey:@"ACEITMIPId"];
                    kIT_ACEITMIPName=[[myMIPArray objectAtIndex:0] valueForKey:@"Name"];
                    
                    
                    
                }
            }
        }
    }
    
    myMIPArray=nil;
    
}

- (IBAction)IT_ContextSelection:(id)sender
{
    if(myPickerviewArry)myPickerviewArry=nil;
    myPickerviewArry=IT_ContextArray;
    self.myPickerView.tag=kIT_ContextButtontag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIButton *mButton  in self.IT_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_ContextButtontag){
            NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
            int index = 0;
            while (index < [myPickerviewArry count]) {
                NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"Name"];
                if ([title isEqualToString:buttonTitle]) {
                    [myPickerView selectRow:index inComponent:0 animated:NO];
                    selectedIndex = index;
                    break;
                }
                index++;
            }
        }
    }
}

- (IBAction)IT_TrailTypeSelection:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    myPickerviewArry=[StudentDatabase TrialType];
    self.myPickerView.tag=kIT_TrailTypeButton;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIButton *mButton  in self.IT_SetUPUIview.subviews){
        if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_TrailTypeButton){
            NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
            int index = 0;
            while (index < [myPickerviewArry count]) {
                NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"trialtype"]; 
                if ([title isEqualToString:buttonTitle]) {
                    [myPickerView selectRow:index inComponent:0 animated:NO];
                    selectedIndex = index;
                    break;
                }
                index++;
            }
        }
    }
}

-(IBAction)StartITSession:(id)sender{
    
    
    BOOL isContextFieldFilled=NO;
    BOOL isTrialTypeFieldFilled=NO;
    
    
    for(UIButton *mybuttons in self.SA_SetUPUIview.subviews){
        if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kIT_ContextButtontag && [mybuttons isSelected]){
            
            isContextFieldFilled=YES;
            
            
        }if([mybuttons isKindOfClass:[UIButton class]]&&mybuttons.tag==kIT_TrailTypeButton && [mybuttons isSelected]){
            
            isTrialTypeFieldFilled=YES;
            
            
        }
    }
    
  //  if(isContextFieldFilled && isTrialTypeFieldFilled){
    
    
    
    kITMIPId=[[[StudentDatabase getFirstITMIP:[kStuCuriculumId intValue]]objectAtIndex:0]valueForKey:@"ACEITMIPId"];
    //Add new session to ActiveStudentSession table
    
    kActiveStudentSessionId=[StudentDatabase insertActiveStudentSession:kStuCuriculumId isDirty:@"true" lastSyncDate:[self getCurrentDate]];
    
    [self ImageForStudentAsPerStudentSessionId:kActiveStudentSessionId imageNameForSession:kActiveStudentImageName];
    
    
    
    //adding data to TAActiveSession Table
    [self performSelector:@selector(ADDITActiveSession)];
    
    
    // set name for Context lable
    
    for(UILabel *contextNamelbl in self.IT_DataEntryUIview.subviews){
        if([contextNamelbl isKindOfClass:[UILabel class]]&& contextNamelbl.tag==kITContextNamelableTag){
            contextNamelbl.text=[NSString stringWithFormat:@"Context : %@",kITContextName];
            
        }
    }
    
    for(UILabel *contextNamelbl in self.IT_SummarizeUIview.subviews){
        if([contextNamelbl isKindOfClass:[UILabel class]]&& contextNamelbl.tag==kITContextNamelableTag){
            contextNamelbl.text=[NSString stringWithFormat:@"Context : %@",kITContextName];
            
        }
    }
    
    IT_SetUPUIview.hidden=YES;
    IT_DataEntryUIview.hidden=NO;
    IT_SummarizeUIview.hidden=YES;
    IT_DataEntry_TrialNumber_lbl.text=@"Trial 1 / 1";
     isNewSessionStartType= oldSession;
        
    
    IT_DataEntry_ContextName_lable.text=[NSString stringWithFormat:@"Name : %@",[StudentDatabase getContextNameForContextId:kITContextId]];
    IT_SummaryPage_ContextName_lable.text=[NSString stringWithFormat:@"Name : %@",[StudentDatabase getContextNameForContextId:kITContextId]];
    
    
  //  }
    
    
}

-(IBAction)IT_SummarizeData:(id)sender{
    
    IT_SetUPUIview.hidden=YES;
    IT_DataEntryUIview.hidden=YES;
    IT_SummarizeUIview.hidden=NO;
        
    
    
   
    
    
    ITSummarizeTrialCount=0;
    
    
    int plusCount = 0;
    int plusPCount = 0;
    int minusCount = 0 ;
    
    int NRCount = 0 ;
    
    for(UIView *optionUIview in self.ITOptionScrollView.subviews){
        if([optionUIview isKindOfClass:[UIView class]]){
            
            for(UIButton *optionbutton in optionUIview.subviews){
                if([optionbutton isKindOfClass:[UIButton class]]){
                    
                    if([optionbutton isSelected]){
                        if([optionbutton.titleLabel.text isEqualToString:@"+"]){
                            
                            plusCount+=1;
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"+P"]){
                            
                            plusPCount +=1;
                            
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"-"]){
                            minusCount +=1;
                            
                        }
                        
                        if([optionbutton.titleLabel.text isEqualToString:@"NR"]){
                            
                            NRCount +=1;
                            
                        }
                    }
                }
            }
            
        }
    }
    
    ITSummarizeTrialCount=plusCount+plusPCount+minusCount+NRCount;
    
    if(ITSummarizedDict)ITSummarizedDict=nil;
    ITSummarizedDict=[[NSMutableDictionary alloc]init];
    [ITSummarizedDict setValue:[NSString stringWithFormat:@"%d",plusCount] forKey:@"plusCount"];
    [ITSummarizedDict setValue:[NSString stringWithFormat:@"%d",plusPCount] forKey:@"plusPCount"];
    [ITSummarizedDict setValue:[NSString stringWithFormat:@"%d",minusCount] forKey:@"minusCount"];
    
    [ITSummarizedDict setValue:[NSString stringWithFormat:@"%d",NRCount] forKey:@"NRCount"];
    [ITSummarizedDict setValue:kITActiveSessionId forKey:@"ITActiveSessionId"];
    

//    
    [IT_SummarizedTableView reloadData];
    
    
   
    
    
    [StudentDatabase updateITIsSummarizedData:ITSummarizedDict];
    
    
    [self Default_IT_StatusSelection];
    [self Default_IT_MIPSelection];
    
    for(UIScrollView *myScrollView in self.IT_SummarizeUIview.subviews){
        
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            for(UISwitch *switc in myScrollView.subviews){
                if([switc isKindOfClass:[UISwitch class]]){
                    [switc setOn:NO];
                    
                }
            }
            
        }
    }
    
     kITEmailSessionDATA=@"false";
    [self isITFinishButtonEnabled];
    
}


-(IBAction)IT_NextAndPreviusTrialClicked:(id)sender{
    UIButton *clickedButton =(UIButton *)sender;
    
    
    //[IT_SummarizeButton setEnabled:NO];
    
    if(clickedButton.tag==1){
        
        if(ITOptionScrollView.contentOffset.x>0){
            [IT_SummarizeButton setEnabled:YES];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [ITOptionScrollView setContentOffset:CGPointMake(ITOptionScrollView.contentOffset.x-ITOptionScrollView.frame.size.width, 0)];
            
            [UIView commitAnimations];
        }
    }
    if(clickedButton.tag==2){
        
        // NSLog(@"Frame...%@",NSStringFromCGRect([self SAoptionsViewCreation:SATrailNumber].frame));
        
       //  NSLog(@"ContentSize .. . %@",NSStringFromCGSize(SAOptionScrollView.contentSize));
          // NSLog(@"ContentOffset.......%@",NSStringFromCGPoint(SAOptionScrollView.contentOffset));
        
        //if loop to find last trail page  
        
        if(ITOptionScrollView.contentSize.width==ITOptionScrollView.contentOffset.x + ITOptionScrollView.frame.size.width){
            
            
            // find out  option clicked for present trail before adding next taril page 
            
            for(UIView *optionView in ITOptionScrollView.subviews){ // list the all UIview inside ITOptionScrollView 
                
                 NSLog(@"option view tag...%d",optionView.tag);
                if([optionView isKindOfClass:[UIView class]]&& optionView.tag==kITTrialNumbers-1){
                    
                    
                    // list of buttons inside the Uiview 
                    for(UIButton *selectedOptions in optionView.subviews){
                        if([selectedOptions isKindOfClass:[UIButton class]]){
                            
                            
                            int currentTrail = ITOptionScrollView.contentSize.width/300;
                            
                            
                            
                            if([selectedOptions isSelected]){
                                
                                
                                UIView *myView = [self IToptionsViewCreation:kITTrialNumbers];
                                
                                [self.ITOptionScrollView addSubview:myView];
                                
                                [ITOptionScrollView setContentSize:CGSizeMake(ITOptionScrollView.frame.size.width*kITTrialNumbers, 0)];
                                
                                [UIView beginAnimations:nil context:nil];
                                [UIView setAnimationDuration:0.5];
                                
                                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                                
                                [ITOptionScrollView setContentOffset:CGPointMake(myView.frame.origin.x, 0)];
                                
                                [UIView commitAnimations];
                                [IT_SummarizeButton setEnabled:NO];
                                kITTrialNumbers++;
                            }else if(![selectedOptions isSelected] && currentTrail==kITTrialNumbers-1){
                             
                                //[ITOptionScrollView setContentOffset:CGPointMake(ITOptionScrollView.frame.size.width*currentTrail, 0)];
                            }
                            
                        }
                    }   
                }else{
                    
             //No need to do any thing if not recent trial 
                    
                }
            }
            
            
            
            
        }else if(ITOptionScrollView.contentSize.width!=0 && ITOptionScrollView.contentSize.width
                 !=ITOptionScrollView.contentOffset.x){
            // else just scroll the page with out adding new trail page 
            [IT_SummarizeButton setEnabled:YES];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [ITOptionScrollView setContentOffset:CGPointMake(ITOptionScrollView.contentOffset.x+ITOptionScrollView.frame.size.width, 0)];
            
            [UIView commitAnimations];
            
            
            for(UIView *optionView in ITOptionScrollView.subviews){
                
                for(UIButton *selectedOptions in optionView.subviews){
                    if([selectedOptions isKindOfClass:[UIButton class]]){
                        
                        
                        
                        if([selectedOptions isSelected]){
                            
                            [IT_SummarizeButton setEnabled:YES];
                        }else{
                            [IT_SummarizeButton setEnabled:NO];
                        }
                    }
                }
            }
        }
    }
    
    //NSLog(@"offset %@",NSStringFromCGPoint(SAOptionScrollView.contentOffset));
    
    if(ITOptionScrollView.contentOffset.x==0){
        
        
        if([[StudentDatabase getITOldSessionTrialCount:kITActiveSessionId]intValue] == 0){
            IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",1,1];
        }else{
            IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",1,[[StudentDatabase getITOldSessionTrialCount:kITActiveSessionId]intValue]];
            
        }

    }else  if(clickedButton.tag==1){
        
        int currentTrail = ITOptionScrollView.contentOffset.x/300;
        
        IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,[[StudentDatabase getITOldSessionTrialCount:kITActiveSessionId]intValue]];
       
    }else  if(ITOptionScrollView.contentSize.width > ITOptionScrollView.contentOffset.x + ITOptionScrollView.frame.size.width){
        
        int currentTrail = ITOptionScrollView.contentOffset.x/300;
        
        IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,[[StudentDatabase getITOldSessionTrialCount:kITActiveSessionId]intValue]];
       
    }else{
        
        int currentTrail = ITOptionScrollView.contentOffset.x/300;
        
        IT_DataEntry_TrialNumber_lbl.text=[NSString stringWithFormat:@"Trial %d / %d",currentTrail+1,kITTrialNumbers];   
        
    }
    int currentTrail = ITOptionScrollView.contentOffset.x/300;
    NSString *optionClicked=[StudentDatabase getITOldSessionTrialOptionForActiveSessionId:kITActiveSessionId forTrialNumber:[NSString stringWithFormat:@"%d",currentTrail+1]];
    
    if([optionClicked isEqualToString:@""]){
        [IT_SummarizeButton setEnabled:NO];
    }else{
        [IT_SummarizeButton setEnabled:YES];
    }
    
}

- (IBAction)IT_ResumeSession:(id)sender 
{
    self.IT_SummarizeUIview.hidden=YES;
    self.IT_DataEntryUIview.hidden=NO;
    self.IT_SetUPUIview.hidden=YES;
    [StudentDatabase ITResumeSession:kITActiveSessionId];
}

- (IBAction)IT_MIPbuttonClicked:(id)sender
{
    if(myPickerviewArry)myPickerviewArry=nil;
    myPickerviewArry=[StudentDatabase getITMIP:[kStuCuriculumId intValue]];
    self.myPickerView.tag=kIT_MIPButtonTag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIScrollView *myScrollView in self.IT_SummarizeUIview.subviews){
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in myScrollView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_MIPButtonTag){
                    NSString *buttonTite = [mButton titleForState:UIControlStateNormal];
                    int index = 0;
                    while (index < [myPickerviewArry count]) {
                        NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"Name"];
                        if ([title isEqualToString:buttonTite]) {
                            [myPickerView selectRow:index inComponent:0 animated:NO];
                            selectedIndex = index;
                            break;
                        }
                        index++;
                    }
                }
            }
        }
    }

}

- (IBAction)IT_StatusButtonClicked:(id)sender
{
    if(myPickerviewArry){
        myPickerviewArry=nil;   
    }
    
    myPickerviewArry=[StudentDatabase getMStStatus];
    self.myPickerView.tag=kIT_StatusButtonTag;
    [self.myPickerView reloadAllComponents];
    [self presentView:pickerBackground show:YES];
    
    for(UIScrollView *myScrollView in self.IT_SummarizeUIview.subviews){
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            for(UIButton *mButton  in myScrollView.subviews){
                if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_StatusButtonTag){
                    NSString *buttonTitle = [mButton titleForState:UIControlStateNormal];
                    int index = 0;
                    while (index < [myPickerviewArry count]) {
                        NSString *title = [[myPickerviewArry objectAtIndex:index] valueForKey:@"mstStatusName"];
                        if ([title isEqualToString:buttonTitle]) {
                            [myPickerView selectRow:index inComponent:0 animated:NO];
                            selectedIndex = index;
                            break;
                        }
                        index++;
                    }
                }
            }
        }
    }

}

-(IBAction)IT_FinishsessionClicked:(id)sender{
    
    
    
    NSMutableDictionary *dataDiction;
    
    int plusCount = 0;
    int plusPCount = 0;
    int minusCount = 0 ;
    
    int NRCount = 0 ;
    
    for(UIView *optionUIview in self.ITOptionScrollView.subviews){
        if([optionUIview isKindOfClass:[UIView class]]){
            
            for(UIButton *optionbutton in optionUIview.subviews){
                if([optionbutton isKindOfClass:[UIButton class]]){
                    
                    if([optionbutton isSelected]){
                        if([optionbutton.titleLabel.text isEqualToString:@"+"]){
                            
                            plusCount+=1;
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"+P"]){
                            
                            plusPCount +=1;
                            
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"-"]){
                            minusCount +=1;
                            
                        }
                        
                        if([optionbutton.titleLabel.text isEqualToString:@"NR"]){
                            
                            NRCount +=1;
                            
                        }
                    }
                }
            }
            
        }
    }
    
    if(dataDiction)dataDiction=nil;
    dataDiction=[[NSMutableDictionary alloc]init];
    [dataDiction setValue:[NSString stringWithFormat:@"%d",plusCount] forKey:@"TotalPlus"];
    [dataDiction setValue:[NSString stringWithFormat:@"%d",plusPCount] forKey:@"TotalPlusP"];
    [dataDiction setValue:[NSString stringWithFormat:@"%d",minusCount] forKey:@"TotalMinus"];
    [dataDiction setValue:[NSString stringWithFormat:@"%d",NRCount] forKey:@"TotalNR"];
    [dataDiction setValue:[self theFollowingWeekend] forKey:@"WeekEnding"];
    [dataDiction setValue:kIT_MstTrialTypeName forKey:@"TrialType"];
    [dataDiction setValue:@"NA" forKey:@"Opportunities"];
    [dataDiction setValue:kIT_ACEITMIPName forKey:@"MIP"];
    [dataDiction setValue:kIT_ACEITMIPId forKey:@"MIPid"];
    [dataDiction setValue:@"1" forKey:@"Order"];
    [dataDiction setValue:kITContextId forKey:@"ITContextId"];
    [dataDiction setValue:IT_StaffNameTextField.text forKey:@"staff"];
    [dataDiction setValue:kIT_StatusId forKey:@"statusid"];
    [dataDiction setValue:[self getCurrentDate] forKey:@"date"];
    [dataDiction setValue:kITEmailSessionDATA forKey:@"isEmailed"];
    [dataDiction setValue:kITActiveSessionId forKey:@"ITActiveSessionId"];
    
    
   
    
      
    
    NSString *fileExist=[StudentDatabase checkFileExistForWeekEnd:[self theFollowingWeekend] forContextId:kITContextId];
   
    
        
    
    if([fileExist isEqualToString:@"1"]){
                
        [self updateValeInITPastData:dataDiction];
        
    }else if([fileExist isEqualToString:@"0"]){
        
        
         [self insertValveToITPastData:dataDiction];
        
    }
    
    // uptdate ITActivesession by setting isFinished value ...
    
    [StudentDatabase updateITIsFinishedData:dataDiction];
    
   [self performSelector:@selector(closeITSession)];
    
    //Once Finished check network. If network available then initiate Sync.
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {
        [[ACESyncManager getSyncManager] syncCurriculumWithServer];
    }
    
}
-(void)IT_oldSummarize{
    
    IT_SetUPUIview.hidden=YES;
    IT_DataEntryUIview.hidden=YES;
    IT_SummarizeUIview.hidden=NO;
    
    
    ITSummarizeTrialCount=0;
    
    
    
    
    
    int plusCount = 0;
    int plusPCount = 0;
    int minusCount = 0 ;
    
    int NRCount = 0 ;
    
    for(UIView *optionUIview in self.ITOptionScrollView.subviews){
        if([optionUIview isKindOfClass:[UIView class]]){
            
            for(UIButton *optionbutton in optionUIview.subviews){
                if([optionbutton isKindOfClass:[UIButton class]]){
                    
                    if([optionbutton isSelected]){
                        if([optionbutton.titleLabel.text isEqualToString:@"+"]){
                            
                            plusCount+=1;
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"+P"]){
                            
                            plusPCount +=1;
                            
                        }
                        if([optionbutton.titleLabel.text isEqualToString:@"-"]){
                            minusCount +=1;
                            
                        }
                        
                        if([optionbutton.titleLabel.text isEqualToString:@"NR"]){
                            
                            NRCount +=1;
                            
                        }
                    }
                }
            }
            
        }
    }
    
    ITSummarizeTrialCount=plusCount+plusPCount+minusCount+NRCount;
    
    if(ITSummarizedDict)ITSummarizedDict=nil;
    ITSummarizedDict=[[NSMutableDictionary alloc]init];
    [ITSummarizedDict setValue:[NSString stringWithFormat:@"%d",plusCount] forKey:@"plusCount"];
    [ITSummarizedDict setValue:[NSString stringWithFormat:@"%d",plusPCount] forKey:@"plusPCount"];
    [ITSummarizedDict setValue:[NSString stringWithFormat:@"%d",minusCount] forKey:@"minusCount"];
    
    [ITSummarizedDict setValue:[NSString stringWithFormat:@"%d",NRCount] forKey:@"NRCount"];
    [ITSummarizedDict setValue:kITActiveSessionId forKey:@"ITActiveSessionId"];
    
    
    //    
    [IT_SummarizedTableView reloadData];
    
    
    
    
    
    [StudentDatabase updateITIsSummarizedData:ITSummarizedDict];
    
    
    [self Default_IT_StatusSelection];
    [self Default_IT_MIPSelection];
    
    for(UIScrollView *myScrollView in self.IT_SummarizeUIview.subviews){
        
        if([myScrollView isKindOfClass:[UIScrollView class]]){
            for(UISwitch *switc in myScrollView.subviews){
                if([switc isKindOfClass:[UISwitch class]]){
                    [switc setOn:NO];
                    
                }
            }
            
        }
    }
    
    kITEmailSessionDATA=@"false";
    [self isITFinishButtonEnabled];
    

}
-(void)ADDITActiveSession{
    
    NSMutableDictionary *myDic=[[NSMutableDictionary alloc]init];
    [myDic setValue:kActiveStudentSessionId forKey:@"ActiveStudentSessionId"];
    [myDic setValue:kIT_MstTrialTypeId forKey:@"MstTrialTypeId"];
    [myDic setValue:kITContextId forKey:@"ITContextId"];
    [myDic setValue:kITMIPId forKey:@"ITMIPId"];
    [myDic setValue:kIT_StatusId forKey:@"MstStatusId"];
    [myDic setValue:@"" forKey:@"StepId"];
    [myDic setValue:@"0" forKey:@"TotalPlus"];
    [myDic setValue:@"0" forKey:@"TotalPlusP"];
    [myDic setValue:@"0" forKey:@"TotalMinus"];
    [myDic setValue:@"0" forKey:@"TotalNR"];
    [myDic setValue:[self getCurrentDate] forKey:@"Date"];
    [myDic setValue:[self theFollowingWeekend] forKey:@"WeekendDate"];
    [myDic setValue:@"" forKey:@"Staff"];
    [myDic setValue:[StudentDatabase getMaxITSessionOrder:kITStuCurriCulumID] forKey:@"Order"];
    [myDic setValue:@"false" forKey:@"IsSummarized"];
    [myDic setValue:@"false" forKey:@"IsFinished"];
    [myDic setValue:@"false" forKey:@"IsEmailEnabled"];
    
    
    
    kITActiveSessionId= [StudentDatabase addNewSeesionToITActiveSessionTable:myDic];
    
    
    
}
-(NSString *)insertValveToITActiveTrial:(NSString *)CurrentTrialNumber optionCliked:(NSString *)valFortrial{
   
    
    NSMutableDictionary *myDic=[[NSMutableDictionary alloc]init];
   
    
    [myDic setValue:kITActiveSessionId forKey:@"ITActiveSessionId"];
    
    [myDic setValue:@"0" forKey:@"+"];
    [myDic setValue:@"0" forKey:@"+P"];
    [myDic setValue:@"0" forKey:@"-"];
    [myDic setValue:@"0" forKey:@"-P"];
    [myDic setValue:@"0" forKey:@"NR"];
    
    
    
    [myDic setValue:CurrentTrialNumber forKey:@"TrialNumber"];
    [myDic setValue:@"1" forKey:valFortrial];
    
    
    
    NSString *primaryKey = [StudentDatabase insertInToITActiveTrial:myDic];
  
    
    return primaryKey;
}
-(NSString *)updateValeInITActiveTrial:(NSString *)CurrentTrialNumber optionCliked:(NSString *)valFortrial{
    
    NSMutableDictionary *myDic=[[NSMutableDictionary alloc]init];
    [myDic setValue:kSAActiveSessionID forKey:@"SAActiveSessionId"];
    [myDic setValue:@"0" forKey:@"TrialNumber"];
    [myDic setValue:@"0" forKey:@"+"];
    [myDic setValue:@"0" forKey:@"+P"];
    [myDic setValue:@"0" forKey:@"-"];
    [myDic setValue:@"0" forKey:@"NR"];
    
    
    
    //[myDic setValue:CurrentTrialNumber forKey:@"TrialNumber"];
    [myDic setValue:@"1" forKey:valFortrial];
    [myDic setValue:CurrentTrialNumber forKey:@"ITActiveSessionId"];
    
    NSString *primaryKey = [StudentDatabase updateInToITActiveTrial:myDic];
    
    return primaryKey;

}
-(NSString *)insertValveToITPastData:(NSMutableDictionary *)mydict{
    
    
    NSString *resultString=[StudentDatabase insertInToITPastData:mydict];
    return resultString;
    
}
-(NSString *)updateValeInITPastData:(NSMutableDictionary *)mydict{
    
   
    
    NSMutableArray *pastDict=[StudentDatabase getpastDATAFileExistForWeekEnd:[self theFollowingWeekend] forContextId:kITContextId];
    
    
    NSMutableDictionary *dict =[pastDict objectAtIndex:0];
    
    int totalp=[[dict valueForKey:@"TotalPlus"] intValue]+[[mydict valueForKey:@"TotalPlus"] intValue];
    int totalpP=[[dict valueForKey:@"TotalPlusP"]intValue]+[[mydict valueForKey:@"TotalPlusP"] intValue];
    int totalm=[[dict valueForKey:@"TotalMinus"]intValue]+[[mydict valueForKey:@"TotalMinus"] intValue];
    int totalNR=[[dict valueForKey:@"TotalNR"]intValue]+[[mydict valueForKey:@"TotalNR"] intValue];
    
    [mydict setValue:[NSString stringWithFormat:@"%d",totalp] forKey:@"TotalPlus"];
    [mydict setValue:[NSString stringWithFormat:@"%d",totalpP] forKey:@"TotalPlusP"];
    [mydict setValue:[NSString stringWithFormat:@"%d",totalm] forKey:@"TotalMinus"];
    [mydict setValue:[NSString stringWithFormat:@"%d",totalNR] forKey:@"TotalNR"];
    [mydict setValue:kITContextId forKey:@"ITContextId"];
    
    
    NSString *resultString=[StudentDatabase updateInToITPastData:mydict];
    
    return resultString;
    
    
}
-(void)ActiveITStudentAndCuricullamName{
    if(ActiveStudentinfoArry)ActiveStudentinfoArry=nil;
    
    ActiveStudentinfoArry=[StudentDatabase getActiveStudentInfo:kACEStudentID];
    
     NSMutableArray *currilamArry = [StudentDatabase getCurriculamName:[kStuCuriculumId intValue]];
    if(ActiveStudentinfoArry.count>0&&currilamArry.count>0){
        
        
        
        for(UILabel *nameLbl in self.IT_SetUPUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActiveITStudentNameLableTag){
                nameLbl.text=[[ActiveStudentinfoArry objectAtIndex:0]valueForKey:@"studentname"];
                kCurrentActiveStudentName=[[ActiveStudentinfoArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActvieITCurriculamLableTag){
                nameLbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                kCurrentActiveCurriculumName=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
            }
        }
        for(UILabel *nameLbl in self.IT_DataEntryUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActiveITStudentNameLableTag){
                nameLbl.text=[[ActiveStudentinfoArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActvieITCurriculamLableTag){
                nameLbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                
            }
        }
        
        for(UILabel *nameLbl in self.IT_SummarizeUIview.subviews){
            if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActiveITStudentNameLableTag){
                nameLbl.text=[[ActiveStudentinfoArry objectAtIndex:0]valueForKey:@"studentname"];
                
            }if([nameLbl isKindOfClass:[UILabel class]]&& nameLbl.tag==kActvieITCurriculamLableTag){
                nameLbl.text=[[currilamArry objectAtIndex:0]valueForKey:@"studentcurriculamname"];
                
            }
        }

    }
        
        
    
}




#pragma Mark progress View

- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG
{
    MBProgressHUD *aMBProgressHUD = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    aMBProgressHUD.labelText = aTitle;    
}

- (void) hideProgressHudInView:(UIView*)aView
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
}


#pragma mark -
#pragma mark UIPickerViewDataSource
#pragma mark - View lifecycle


-(void)currentSessionSelectionInformation{
   
    currentStudentCurriculumName =  currentSessionCurriculumName;
    currentStudentCurriculumType =  currentSessionSelectionType;
    currentStudentName = currentSessionStudentName;
    isNewSessionStartType=newSession;
    [self getCurrentDate];
}
-(IBAction)discardTheSession:(id)sender{
    
    
    UIAlertView *disCardAlertView=[[UIAlertView alloc]initWithTitle:@"Warning " message:@"Are you sure you want to discard all the data collected in this session?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    disCardAlertView.tag=kDiscardAlertViewTag;
    disCardAlertView.delegate=self;
         [disCardAlertView show];
    
    
    /*
    
    */
    
     
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if(actionSheet.tag == kDiscardAlertViewTag){
        
        
        
        if (buttonIndex == 1)
        {
            
            BOOL result =[StudentDatabase discardSession:kActiveStudentSessionId];
            
            if(result){
                
                
                
                //[self.view addSubview:noCurrentSessionLable];
                currentSessionType=noCurrentSeeion;
                
                
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:0];
                
            }else{
                UIAlertView *myalert =[[UIAlertView alloc]initWithTitle:@"Error" message:@"Not able to Discard the Session" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myalert show];
                
            }  
        }    
        
        
    }
                       
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =UIColorFromRGB(0xe7e6eb);
    // Do any additional setup after loading the view from its nib.
    [self customNavigationitems];
    pickerBackground.backgroundColor = [UIColor clearColor];
        
    SA_SetUPUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    SA_DataEntryUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    SA_SummarizeUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    
    
    
    TA_SetUPUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    TA_DataEntryUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    TA_SummarizeUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    
    
    
    IT_SetUPUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    IT_DataEntryUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    IT_SummarizeUIview.backgroundColor =UIColorFromRGB(0xe7e6eb);
    
   
    
}
-(void) appWasResumed
{
    [self.TAStaffTextField resignFirstResponder];
    [self.SAStaffTextField resignFirstResponder];
    [self.IT_StaffNameTextField resignFirstResponder];
    //If you are changing positions of items, you might want to do that here too.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWasResumed) name:UIApplicationWillEnterForegroundNotification object:nil];
       
    
    kStaffName=[[NSUserDefaults standardUserDefaults]valueForKey:@"kStaffName"];
    
    SAStaffTextField.text=kStaffName;
    
    TAStaffTextField.text = kStaffName;
    IT_StaffNameTextField.text = kStaffName;
    if(currentSessionType==typeSA){
        
        if(isNewSessionStartType==newSession){
            
            self.SAUIview.hidden=NO;
           
            [self.view addSubview:SAUIview];
            SA_SetUPUIview.hidden=NO;
            SA_DataEntryUIview.hidden=YES;
            SA_SummarizeUIview.hidden=YES;
           
            
            
            [self customiseSAView];
            [self initiateSAData];
            SATrailNumber=1;
            kSASubLevelID=0;
            [self showSARecommendations];
            
        }else if(isNewSessionStartType==oldSession){
            self.SAUIview.hidden=NO;
            [self.view addSubview:SAUIview];
            
                       
            
            //call method to add options page for all old trials ...
            
            SATrailNumber=kSATrialNumberForOldsession;
           // SASummarizeTrialCount=kSATrialNumberForOldsession;
            
            [self CustomiseSAView_oldSession];
            [self InitiateSAData_oldSession];
            
            
            
            if([kisCurrentSessionSummarized isEqualToString:@"true"]){
                
                SA_SetUPUIview.hidden=YES;
                SA_DataEntryUIview.hidden=YES;
                SA_SummarizeUIview.hidden=NO;
                [self SA_oldSummarizeData];
                
                
            }else{
                
                
                SA_SetUPUIview.hidden=YES;
                SA_DataEntryUIview.hidden=NO;
                SA_SummarizeUIview.hidden=YES;
              //  [self showSARecommendations];
                
            }
            

        }
        
        
    }if(currentSessionType==typeTA){
        
        
        if(isNewSessionStartType==newSession){
            
            self.TAUIview.hidden=NO;
           

            [self.view addSubview:TAUIview];
            TA_SetUPUIview.hidden=NO;
            TA_DataEntryUIview.hidden=YES;
            TA_SummarizeUIview.hidden=YES;
            
            
            [self customiseTAView];
            [self initiateTAData];
            [self showTARecommendations];
            
        }else if(isNewSessionStartType==oldSession){
            
                      // [self showProgressHudInView:self.TAUIview withTitle:@"Loading Location..." andMsg:nil];
            [self CustomiseTAView_oldSession];
            [self InitiateTAData_oldSession];
            
            
            if([kisCurrentSessionSummarized isEqualToString:@"true"]){
                
                self.TAUIview.hidden=NO;
                
                
                [self.view addSubview:TAUIview];
                TA_SetUPUIview.hidden=YES;
                TA_DataEntryUIview.hidden=YES;
                TA_SummarizeUIview.hidden=NO;
                [self TA_oldSummarizeData];
                
                
                
            }else{
                
                
                self.TAUIview.hidden=NO;
                
                
                [self.view addSubview:TAUIview];
                TA_SetUPUIview.hidden=YES;
                TA_DataEntryUIview.hidden=NO;
                TA_SummarizeUIview.hidden=YES;
                
                
               // [self showTARecommendations];
            }
        }
        
    }if(currentSessionType==typeIT){
        
        
        
        
        if(isNewSessionStartType==newSession){
           
           self.ITUIview.hidden=NO;
            [self.view addSubview:ITUIview];
            IT_SetUPUIview.hidden=NO;
            IT_DataEntryUIview.hidden=YES;
            IT_SummarizeUIview.hidden=YES;
            kITTrialNumbers=1;
            
            [self customiseITView];
            [self initiateITData];
            [self showITRecommendations];
            
        }else if(isNewSessionStartType==oldSession){
            
            
           
            
          //call method to add options page for all old trials ...
           
            kITTrialNumbers=kITTrialNumberForOldsession;
            
            [self CustomiseITView_oldSession];
            [self InitiateITData_oldSession];
            
            if([kisCurrentSessionSummarized isEqualToString:@"true"]){
                
                self.ITUIview.hidden=NO;
                [self.view addSubview:ITUIview];
                IT_SetUPUIview.hidden=YES;
                IT_DataEntryUIview.hidden=YES;
                IT_SummarizeUIview.hidden=NO;
                
                [self IT_oldSummarize];
                
                
            }else{
                
                self.ITUIview.hidden=NO;
                [self.view addSubview:ITUIview];
                IT_SetUPUIview.hidden=YES;
                IT_DataEntryUIview.hidden=NO;
                IT_SummarizeUIview.hidden=YES;
                
                [self showITRecommendations];
                
            }

            
            
        }
        

    }if(currentSessionType==noCurrentSeeion){
        NSLog(@"Curretnt type is noCurrentSeeion");
        self.SAUIview.hidden=YES;
        self.ITUIview.hidden=YES;
        self.TAUIview.hidden=YES;
        [self.view addSubview:noCurrentSessionLable];
        
        NSLog(@"No current session frame...%@",NSStringFromCGRect(noCurrentSessionLable.frame));
        
        
    }
    
  // [self showProgressHudInView:self.view withTitle:@"Loading Location..." andMsg:nil];
    [self hideProgressHudInView:[[UIApplication sharedApplication] keyWindow]] ;
    // get current date/time
   
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [SAStaffTextField resignFirstResponder];
    [TAStaffTextField resignFirstResponder];
    [IT_StaffNameTextField resignFirstResponder];
    
    if(currentSessionType==typeSA && isNewSessionStartType==oldSession){
   
       
        
        kSATrialNumberForOldsession=[[StudentDatabase getSAOldSessionTrialCount:kSAActiveSessionID]intValue];;

        NSMutableArray *oldDataArry=[StudentDatabase getSAOldSessionDetailsForActiveSessionId:kSAActiveSessionID];
         kisCurrentSessionSummarized=[[oldDataArry objectAtIndex:0]valueForKey:@"isSummarized"];
        
    }if(currentSessionType==typeTA){
        
         //isNewSessionStartType=oldSession;
        
    }if(currentSessionType==typeIT && isNewSessionStartType==oldSession){
       
        
         //isNewSessionStartType=oldSession;
        
       
        kITTrialNumberForOldsession=[[StudentDatabase getITOldSessionTrialCount:kITActiveSessionId]intValue];
      
        NSMutableArray *oldDataArry=[StudentDatabase getITOldSessionDetailsForActiveSessionId:kITActiveSessionId];
        kisCurrentSessionSummarized=[[oldDataArry objectAtIndex:0]valueForKey:@"isSummarized"];
        
    }if(currentSessionType==noCurrentSeeion){
       
              
        //isNewSessionStartType= newSession;
        
    }

    
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [self persistValueForPickerView:myPickerView 
                             forRow:selectedIndex 
                        inComponent:0];
    [self presentView:pickerBackground show:NO];
//    [self 
}

- (IBAction)pickerDone:(UIBarItem*)sender
{
    [self persistValueForPickerView:myPickerView 
                             forRow:[myPickerView selectedRowInComponent:0] 
                        inComponent:0];
    [self presentView:pickerBackground show:NO];
    
    if (myPickerView.tag == kSA_SublevelButtontag) {
        [self showSARecommendations];
    }else if(myPickerView.tag == kIT_ContextButtontag){
        [self showITRecommendations];
    }
}

- (void)persistValueForPickerView:(UIPickerView *)pickerView 
                      forRow:(NSInteger)row inComponent:(NSInteger)component
{
    // report the selection to the UI label
    
    //SA Page handling
    
    if(pickerView.tag==kSA_SublevelButtontag){
        for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SublevelButtontag){
                NSString *skillName=[NSString stringWithFormat:@": %@",[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelskill"]];
                [mButton setTitle:[[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelname"]stringByAppendingString:skillName] forState:UIControlStateNormal];
                
                SA_DataEntry_Sublevel_lbl.text=[NSString stringWithFormat:@"Sub Level : %@",[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelname"]];
                SA_Summarize_Sublevel_lbl.text=[NSString stringWithFormat:@"Sub Level : %@",[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelname"]];
                SA_Summarize_Skill_lbl.text=[NSString stringWithFormat:@"Skill : %@",[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelskill"]];
                
                [[NSUserDefaults standardUserDefaults]setValue:[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelid"] forKey:@"sasublevelid"];
                
                kSASubLevelID=[[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelid"] intValue];
                
                
                SA_DataEntry_Skill_lbl.text=[NSString stringWithFormat:@"Skill : %@",[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelskill"]];
                
                
                [self performSelector:@selector(updateSAPastData:) withObject:[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelid"]];
                [self performSelector:@selector(updateSASteps:) withObject:[[SA_SublevelArry objectAtIndex:row] valueForKey:@"sasublevelid"]];
                
                
                //update Step dropdown also .......
                
                for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
                    if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_StapButton){
                        
                        [mButton setTitle:[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepName"] forState:UIControlStateNormal];
                        mButton.selected=YES;
                        SA_DataEntry_Step_lbl.text=[NSString stringWithFormat:@"Step : %@",[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepName"]];
                        SA_Summarize_Step_lbl.text=[NSString stringWithFormat:@"Step : %@",[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepName"]];
                        kSAStepID=[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepID"];
                        
                        [[NSUserDefaults standardUserDefaults]setValue:[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepID"] forKey:@"stepID"];
                        [[NSUserDefaults standardUserDefaults]setValue:[[SA_StepsAyy objectAtIndex:0] valueForKey:@"stepName"] forKey:@"stepName"];
                        [self isSAStartbuttonEnabled];
                        
                    }
                }
                
                
                
            }
        }
    }
    if(pickerView.tag==kSA_TrailTypeButton){
        for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_TrailTypeButton){
                
                [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"] forState:UIControlStateNormal];
                mButton.selected=YES;
                [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialid"] forKey:@"trialid"];
                [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"] forKey:@"trialtype"];
                kSATrialTypeName=[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
                kSATrialTypeID=[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialid"];
                
                
                
            }
        }
    }
    if(pickerView.tag==kSA_StapButton){
        for(UIButton *mButton  in self.SA_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_StapButton){
                
                [mButton setTitle:[[SA_StepsAyy objectAtIndex:row] valueForKey:@"stepName"] forState:UIControlStateNormal];
                mButton.selected=YES;
                SA_DataEntry_Step_lbl.text=[NSString stringWithFormat:@"Step : %@",[[SA_StepsAyy objectAtIndex:row] valueForKey:@"stepName"]];
                SA_Summarize_Step_lbl.text=[NSString stringWithFormat:@"Step : %@",[[SA_StepsAyy objectAtIndex:row] valueForKey:@"stepName"]];
                kSAStepID=[[SA_StepsAyy objectAtIndex:row] valueForKey:@"stepID"];
                
                [[NSUserDefaults standardUserDefaults]setValue:[[SA_StepsAyy objectAtIndex:row] valueForKey:@"stepID"] forKey:@"stepID"];
                [[NSUserDefaults standardUserDefaults]setValue:[[SA_StepsAyy objectAtIndex:row] valueForKey:@"stepName"] forKey:@"stepName"];
                [self isSAStartbuttonEnabled];
                
            }
        }
    }
    
    if(pickerView.tag==kSA_SummarizeSettingButTag){
        
        for(UIScrollView *srcolView in self.SA_SummarizeUIview.subviews){
            if([srcolView isKindOfClass:[UIScrollView class]]){
                
                for(UIButton *mButton  in srcolView.subviews){
                    if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SummarizeSettingButTag){
                        
                        [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstSettingname"] forState:UIControlStateNormal];
                        mButton.selected=YES;
                        [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstSettingid"] forKey:@"mstSettingid"];
                    }
                }
                
            }
        }
        
    }
    
    if(pickerView.tag==kSA_SummarizeStatusButTag){
        
        
        for(UIScrollView *srcolView in self.SA_SummarizeUIview.subviews){
            if([srcolView isKindOfClass:[UIScrollView class]]){
                
                
                for(UIButton *mButton  in srcolView.subviews){
                    if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kSA_SummarizeStatusButTag){
                        
                        [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"] forState:UIControlStateNormal];
                        mButton.selected=YES;
                        [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusId"] forKey:@"mstStatusId"];
                        [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"] forKey:@"SAmstStatusName"];
                    }
                }
                
                
            }
        }
        
        
    }
    
    
    for(UIScrollView *scrollView in self.SA_SummarizeUIview.subviews){
        if([scrollView isKindOfClass:[UIScrollView class]] && scrollView.tag==kSAScrollUpViewTag){
            
           // [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x-kSAScrollUpView_offSet_X, scrollView.contentOffset.y-kSAScrollUpView_offSet_Y)];
            
        }
    }
    
    
    
    //TA Page handling
    if(pickerView.tag==kTA_TrailTypeButton){
        for(UIButton *mButton  in self.TA_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kTA_TrailTypeButton){
                
                [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"] forState:UIControlStateNormal];
                kTATrialTypeName=[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
                
                kMstTrialType=[[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialid"] intValue];
                
            }
        }
    }
    if(pickerView.tag==kTA_TrainingStepButton&& ![self.TA_SetUPUIview isHidden]){
        for(UIButton *mButton  in self.TA_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kTA_TrainingStepButton){
                
                [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"stepname"] forState:UIControlStateNormal];
                kTATraingStepID=[[[myPickerviewArry objectAtIndex:row] valueForKey:@"stepname"]intValue];
                kTAStepID=[[[myPickerviewArry objectAtIndex:row] valueForKey:@"StepID"]intValue];
                kTAFsiBsiTsi=[[[myPickerviewArry objectAtIndex:row] valueForKey:@"StepID"]intValue];
                kTAFsiBsiTsiName=[[myPickerviewArry objectAtIndex:row] valueForKey:@"stepname"];
                
                if(kTATraingStepID==0){
                    
                    for(UIButton *mybutton in self.TA_SetUPUIview.subviews){
                        if([mybutton isKindOfClass:[UIButton class]]&& mybutton.tag==2112){
                            //   [mybutton setEnabled:NO];
                            
                        }
                    }
                }
                
            }
        }
    }
    if(pickerView.tag==kTA_TrainingStepButton && ![self.TA_SummarizeUIview isHidden] ){
        
        for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
            if([srcolView isKindOfClass:[UIScrollView class]]){
                    for(UIButton *mButton  in srcolView.subviews){
                            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kTA_TrainingStepButton){
                        
                        [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"stepname"] forState:UIControlStateNormal];
                        kTAFsiBsiTsi=[[[myPickerviewArry objectAtIndex:row] valueForKey:@"StepID"]intValue];
                        kTAFsiBsiTsiName=[[myPickerviewArry objectAtIndex:row] valueForKey:@"stepname"];
                        
                        
                    }
                }
            }
        }
        
        
    }   
    if(pickerView.tag==kMstStatusButtontag){
        
        for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
            if([srcolView isKindOfClass:[UIScrollView class]]){
                
                
                for(UIButton *mButton  in srcolView.subviews){
                    
                    
                    
                    if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kMstStatusButtontag){
                        
                        [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"] forState:UIControlStateNormal];
                        kTAMstStatusID=[[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusId"]intValue];
                        
                        //  [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialid"] forKey:@"trialid"];
                        // [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"] forKey:@"trialtype"];
                        
                    }
                }
                
                
                
            }
        }
        
        
    }if(pickerView.tag==kMstSettingButtontag){
        
        
        for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
            if([srcolView isKindOfClass:[UIScrollView class]]){
                
                
                for(UIButton *mButton  in srcolView.subviews){
                    
                    
                    if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kMstSettingButtontag){
                        
                        [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstSettingname"] forState:UIControlStateNormal];
                        kTAMstSettingID=[[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstSettingid"]intValue];
                        
                        //  [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialid"] forKey:@"trialid"];
                        // [[NSUserDefaults standardUserDefaults]setValue:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"] forKey:@"trialtype"];
                        
                    }
                }
            }
        }
    }
    
    if(pickerView.tag==kTANoOFTrialButtonTag){
        
        
        for(UIScrollView *srcolView in self.TA_SummarizeUIview.subviews){
            if([srcolView isKindOfClass:[UIScrollView class]]){
                
                
                for(UIButton *mButton  in srcolView.subviews){
                    
                    
                    if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kTANoOFTrialButtonTag){
                        
                        [mButton setTitle:[myPickerviewArry objectAtIndex:row] forState:UIControlStateNormal];
                        kTANoOfTrial=[[myPickerviewArry objectAtIndex:row]intValue];
                        
                        
                    }
                }
            }
        }
        
        
    }
    
    //IT Picker View Handeling
    
    if(pickerView.tag==kIT_ContextButtontag){
        for(UIButton *mButton  in self.IT_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_ContextButtontag){
                
                [mButton setTitle:[[IT_ContextArray objectAtIndex:row] valueForKey:@"Name"] forState:UIControlStateNormal];
                [mButton setSelected:YES];
                
                [self performSelector:@selector(updateITPastData:) withObject:[[IT_ContextArray objectAtIndex:row] valueForKey:@"ContextID"]];
                kITContextId=  [[IT_ContextArray objectAtIndex:row] valueForKey:@"ContextID"];
                kITContextName= [[IT_ContextArray objectAtIndex:row] valueForKey:@"Name"];
            }
        }
    }
    if(pickerView.tag==kIT_TrailTypeButton){
        for(UIButton *mButton  in self.IT_SetUPUIview.subviews){
            if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_TrailTypeButton){
                
                [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"] forState:UIControlStateNormal];
                [mButton setSelected:YES];
                kIT_MstTrialTypeId=[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialid"];
                kIT_MstTrialTypeName=[[myPickerviewArry objectAtIndex:row] valueForKey:@"trialtype"];
                
            }
        }
    }if(pickerView.tag==kIT_MIPButtonTag){
        
        
        for(UIScrollView *myScrollView in self.IT_SummarizeUIview.subviews){
            
            if([myScrollView isKindOfClass:[UIScrollView class]]){
                
                
                for(UIButton *mButton  in myScrollView.subviews){
                    if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_MIPButtonTag){
                        
                        [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"Name"] forState:UIControlStateNormal];
                        
                        kIT_ACEITMIPId=[[myPickerviewArry objectAtIndex:row] valueForKey:@"ACEITMIPId"];
                        kIT_ACEITMIPName=[[myPickerviewArry objectAtIndex:row] valueForKey:@"Name"];
                        
                    }
                }
            }
        }
        
    }if(pickerView.tag==kIT_StatusButtonTag){
        
        for(UIScrollView *myScrollView in self.IT_SummarizeUIview.subviews){
            if([myScrollView isKindOfClass:[UIScrollView class]]){
                for(UIButton *mButton  in myScrollView.subviews){
                    if([mButton isKindOfClass:[UIButton class]]&& mButton.tag==kIT_StatusButtonTag){
                        [mButton setTitle:[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusName"] forState:UIControlStateNormal];
                        kIT_StatusId=[[myPickerviewArry objectAtIndex:row] valueForKey:@"mstStatusId"];
                        
                    }
                }
            }
        }
    }
}

#pragma mark - Recommendation Methods

- (BOOL)showSARecommendationForMoreThanEightyPerc
{
    BOOL isRecommendationShown = NO;
    
    BOOL showRecommendation = [[[NSUserDefaults standardUserDefaults] 
                                valueForKey:kRecammondation] boolValue];
    if (!showRecommendation) 
        return isRecommendationShown;
    
    int count = [SA_PastdataArry count];
    
    if (count >= 2) {
        NSDictionary *item1 = [SA_PastdataArry objectAtIndex:(count - 1)];
        NSDictionary *item2 = [SA_PastdataArry objectAtIndex:(count - 2)];
        
        NSString *trialType1 = [item1 valueForKey:@"type"];
        NSString *trialType2 = [item2 valueForKey:@"type"];
        
        if (![trialType1 isEqualToString:@"MT"] && ![trialType2 isEqualToString:@"MT"] &&
            nil != trialType1 && nil != trialType2) {
            
            //First Trial
            int plus_1 = [[item1 valueForKey:@"plus"] intValue];
            int plusP_1 = [[item1 valueForKey:@"plusP"] intValue];
            int minus_1 = [[item1 valueForKey:@"minus"] intValue];
            int minusP_1 = [[item1 valueForKey:@"minusP"] intValue];
            int nr_1  = [[item1 valueForKey:@"NR"] intValue];
            
            //Second Trial 
            int plus_2 = [[item2 valueForKey:@"plus"] intValue];
            int plusP_2 = [[item2 valueForKey:@"plusP"] intValue];
            int minus_2 = [[item2 valueForKey:@"minus"] intValue];
            int minusP_2 = [[item2 valueForKey:@"minusP"] intValue];
            int nr_2  = [[item2 valueForKey:@"NR"] intValue];

            int correctIndependentStep1 = plus_1;
            int totalOpportunitues1 = (plus_1 + plusP_1 + minus_1 + minusP_1 + nr_1);
           
            int correctIndependentStep2 = plus_2;
            int totalOpportunitues2 = (plus_2 + plusP_2 + minus_2 + minusP_2 + nr_2);
            
       
            CGFloat ratio1 = (CGFloat)((CGFloat)correctIndependentStep1 / (CGFloat)totalOpportunitues1);
            int percentage1 = (ratio1 * 100);

            CGFloat ratio2 = (CGFloat)((CGFloat)correctIndependentStep2 / (CGFloat)totalOpportunitues2);
            int percentage2 = (ratio2 * 100);
            
            if (percentage1 >= 80 && percentage2 >= 80) {
                isRecommendationShown = YES;
                //Show Alert.
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                                message:NSLocalizedString(@"SA_message_1", nil) 
                                                               delegate:nil 
                                                      cancelButtonTitle:@"Ok" 
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    
    return isRecommendationShown;
}

- (BOOL)showSARecommendationForLesserThanSixtyPerc
{
    BOOL isRecommendationShown = NO;
    
    BOOL showRecommendation = [[[NSUserDefaults standardUserDefaults] 
                                valueForKey:kRecammondation] boolValue];
    if (!showRecommendation) 
        return isRecommendationShown;
    
    int count = [SA_PastdataArry count];
   
    if (count >= 2) {
        NSDictionary *item1 = [SA_PastdataArry objectAtIndex:(count - 1)];//Last Item
        NSDictionary *item2 = [SA_PastdataArry objectAtIndex:(count - 2)];//Second Last Item
        NSString *score1 = [item1 valueForKey:@"score"];
        NSString *score2 = [item2 valueForKey:@"score"];
        NSArray *score1Components = [score1 componentsSeparatedByString:@"/"];
        NSArray *score2Components = [score2 componentsSeparatedByString:@"/"];
        int  percent1 = 0;
        int percent2 = 0;
        
        if ([score1Components count] >= 2) {
            int part1 = [[score1Components objectAtIndex:0] intValue];
            int part2 = [[score1Components objectAtIndex:1] intValue];
            percent1 = (CGFloat)((CGFloat) part1 / (CGFloat) part2) * 100;
        }
        
        if ([score2Components count] >= 2) {
            int part1 = [[score2Components objectAtIndex:0] intValue];
            int part2 = [[score2Components objectAtIndex:1] intValue];
            percent2 = (CGFloat)((CGFloat) part1 / (CGFloat) part2) * 100;
        }
        
        if (percent1 <= 60 && percent2 <= 60) {
            isRecommendationShown = YES;
            //Show Alert.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                            message:NSLocalizedString(@"SA_message_2", nil) 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    
    return isRecommendationShown;
}

- (BOOL)showITRecommendationForMoreThanEightyPerc
{
    BOOL isRecommendationShown = NO;
    
    BOOL showRecommendation = [[[NSUserDefaults standardUserDefaults] 
                                valueForKey:kRecammondation] boolValue];
    if (!showRecommendation) 
        return isRecommendationShown;
    
    int count = [IT_PastdataArry count];
    
    if (count >= 2) {
        NSDictionary *item1 = [IT_PastdataArry objectAtIndex:(count - 1)]; //Last Item
        NSDictionary *item2 = [IT_PastdataArry objectAtIndex:(count - 2)]; //Second Last Item
        NSString *trialType1 = [item1 valueForKey:@"trialtype"];
        NSString *trialType2 = [item2 valueForKey:@"trialtype"];
 
        if (![trialType1 isEqualToString:@"MT"] && ![trialType2 isEqualToString:@"MT"] &&
            nil != trialType1 && nil != trialType2) {
            
            //Trial Values 1st set
            int totalPlus_1 = [[item1 valueForKey:@"totalplus"] intValue];
            int totalPlusP_1 = [[item1 valueForKey:@"totalplusP"] intValue];
            int totalMinus_1 = [[item1 valueForKey:@"totalMinus"] intValue];
            int totalNR_1 = [[item1 valueForKey:@"totalNR"] intValue];
            
            //Trial Values 2nd set
            int totalPlus_2 = [[item2 valueForKey:@"totalplus"] intValue];
            int totalPlusP_2 = [[item2 valueForKey:@"totalplusP"] intValue];
            int totalMinus_2 = [[item2 valueForKey:@"totalMinus"] intValue];
            int totalNR_2 = [[item2 valueForKey:@"totalNR"] intValue];
            
          //  int totalPlusAndPlusP1 = totalPlus_1 + totalPlusP_1;
            //int totalPlusAndPlusP2 = totalPlus_2 + totalPlusP_2;
            
            
            int totalPlusAndPlusP1 = totalPlus_1 ;
            int totalPlusAndPlusP2 = totalPlus_2 ;

            
            int totalOpportunities1 = totalPlus_1 + totalPlusP_1 + totalMinus_1 + totalNR_1;
            int totalOpportunities2 = totalPlus_2 + totalPlusP_2 + totalMinus_2 + totalNR_2;
            
            CGFloat ratio1 = (CGFloat)((CGFloat) totalPlusAndPlusP1 / (CGFloat) totalOpportunities1);
            CGFloat ratio2 = (CGFloat)((CGFloat) totalPlusAndPlusP2 / (CGFloat) totalOpportunities2);
            
            int percentage1 = ratio1 * 100;
            int percentage2 = ratio2 * 100;
            
            if (percentage1 >= 80 && percentage2 >= 80) { //Show Alert if both are above 80%
                isRecommendationShown = YES;
                //Show Alert.
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                                message:NSLocalizedString(@"IT_message_1", nil) 
                                                               delegate:nil 
                                                      cancelButtonTitle:@"Ok" 
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    
    return isRecommendationShown;
}

- (BOOL)showITRecommendationForLesserThanSixtyPerc
{
    BOOL isRecommendationShown = NO;
    
    BOOL showRecommendation = [[[NSUserDefaults standardUserDefaults] 
                                valueForKey:kRecammondation] boolValue];
    if (!showRecommendation) 
        return isRecommendationShown;
    
    int count = [IT_PastdataArry count];
    
    if (count >= 2) {
        
        NSDictionary *item1 = [IT_PastdataArry objectAtIndex:(count - 1)]; //Last Item
        NSDictionary *item2 = [IT_PastdataArry objectAtIndex:(count - 2)]; //Second Last Item
        
        //Trial Values 1st set
        int totalPlus_1 = [[item1 valueForKey:@"totalplus"] intValue];
        int totalPlusP_1 = [[item1 valueForKey:@"totalplusP"] intValue];
        int totalMinus_1 = [[item1 valueForKey:@"totalMinus"] intValue];
        int totalNR_1 = [[item1 valueForKey:@"totalNR"] intValue];
            
        //Trial Values 2nd set
        int totalPlus_2 = [[item2 valueForKey:@"totalplus"] intValue];
        int totalPlusP_2 = [[item2 valueForKey:@"totalplusP"] intValue];
        int totalMinus_2 = [[item2 valueForKey:@"totalMinus"] intValue];
        int totalNR_2 = [[item2 valueForKey:@"totalNR"] intValue];
        
        int totalPlusAndPlusP1 = totalPlus_1 + totalPlusP_1;
        int totalPlusAndPlusP2 = totalPlus_2 + totalPlusP_2;
        
        int totalOpportunities1 = totalPlus_1 + totalPlusP_1 + totalMinus_1 + totalNR_1;
        int totalOpportunities2 = totalPlus_2 + totalPlusP_2 + totalMinus_2 + totalNR_2;
        
        CGFloat ratio1 = (CGFloat)((CGFloat) totalPlusAndPlusP1 / (CGFloat) totalOpportunities1);
        CGFloat ratio2 = (CGFloat)((CGFloat) totalPlusAndPlusP2 / (CGFloat) totalOpportunities2);
        
        int percentage1 = ratio1 * 100;
        int percentage2 = ratio2 * 100;
        
        if (percentage1 <= 60 && percentage2 <= 60) { //Consider both percentage
            isRecommendationShown = YES;
            //Show Alert.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                       message:NSLocalizedString(@"IT_message_2", nil) 
                                      delegate:nil 
                             cancelButtonTitle:@"Ok" 
                             otherButtonTitles:nil];
            [alert show];
        }
    }
    
    return isRecommendationShown;
}

- (BOOL)showTAFirstRecommendation
{
    BOOL isRecommendationShown = NO;
    
    BOOL showRecommendation = [[[NSUserDefaults standardUserDefaults] 
                                valueForKey:kRecammondation] boolValue];
    if (!showRecommendation) 
        return isRecommendationShown;
    
    int count = [TAPastDataArry count];
    NSString *chainString=[StudentDatabase getMstChainingSequence:kTACurrentCurriculamId];
    
    if (count >= 2 && ([chainString isEqualToString:@"Forward"] 
                       || [chainString isEqualToString:@"Backward"])) {
 
        NSDictionary *item1 = [TAPastDataArry objectAtIndex:(count - 1)]; //Last Item
        NSDictionary *item2 = [TAPastDataArry objectAtIndex:(count - 2)]; //Second Last Item
        
        NSString *trainingStep1 = [item1 valueForKey:@"trainingStep"];
        NSString *trainingStep2 = [item2 valueForKey:@"trainingStep"];
        
        NSString *promptStep1 = [item1 valueForKey:@"promptstep"];
        NSString *promptStep2 = [item2 valueForKey:@"promptstep"];
        
        if ([trainingStep1 isEqualToString:trainingStep2]) { //If same training step.
            if ([promptStep1 isEqualToString:@"I"] && [promptStep2 isEqualToString:@"I"]) {
                //Show Alert.
                isRecommendationShown = YES;
                //Show Alert.
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                                message:NSLocalizedString(@"TA_message_1", nil) 
                                                               delegate:nil 
                                                      cancelButtonTitle:@"Ok" 
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    
    return isRecommendationShown;
}

- (BOOL)showTASecondRecommendation
{
    BOOL isRecommendationShown = NO;
    
    BOOL showRecommendation = [[[NSUserDefaults standardUserDefaults] 
                                valueForKey:kRecammondation] boolValue];
    if (!showRecommendation) 
        return isRecommendationShown;
        
    int count = [TAPastDataArry count];
    NSString *chainString=[StudentDatabase getMstChainingSequence:kTACurrentCurriculamId];
    
    if (count >= 5 && [chainString isEqualToString:@"Total Task"]) { //Here need to analyze all 5 sessions.
        
        int stepIndependent_1 = [[[TAPastDataArry objectAtIndex:0] 
                                  valueForKey:@"stepIndipendent"] intValue];
        int stepIndependent_2 = [[[TAPastDataArry objectAtIndex:1] 
                                  valueForKey:@"stepIndipendent"] intValue];
        int stepIndependent_3 = [[[TAPastDataArry objectAtIndex:2] 
                                  valueForKey:@"stepIndipendent"] intValue];
        int stepIndependent_4 = [[[TAPastDataArry objectAtIndex:3] 
                                  valueForKey:@"stepIndipendent"] intValue];
        int stepIndependent_5 = [[[TAPastDataArry objectAtIndex:4] 
                                  valueForKey:@"stepIndipendent"] intValue];
        
        int totalNoOfSteps = [StudentDatabase 
                              getTAStepsCountForCurriculumWithCurriculumId:kTACurrentCurriculamId];
        if(totalNoOfSteps != 0){
            CGFloat avg1 = ((((CGFloat)stepIndependent_1 + (CGFloat)stepIndependent_2 + (CGFloat)stepIndependent_3) / totalNoOfSteps)) / 3; 
            CGFloat avg2 = ((((CGFloat)stepIndependent_3 + (CGFloat)stepIndependent_4 + (CGFloat)stepIndependent_5) / totalNoOfSteps)) / 3;  
            int perc1 = avg1 * 100;
            int perc2 = avg2 * 100;
            
            if (perc2 != 100 && perc2 <= perc1) {
                //Show Alert.
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                                message:NSLocalizedString(@"TA_message_2", nil) 
                                                               delegate:nil 
                                                      cancelButtonTitle:@"Ok" 
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
        
}
    
    return isRecommendationShown;
}
-(void)showErrorSARecommendations{
    
    
    BOOL showRecommendation = [[[NSUserDefaults standardUserDefaults] 
                                valueForKey:kRecammondation] boolValue];
    
    if(SAOptionScrollView.contentSize.width==SAOptionScrollView.contentOffset.x + SAOptionScrollView.frame.size.width && showRecommendation && ![kSATrialTypeName isEqualToString:@"BL"]){
        //         NSLog(@"start new session ");
        int tOtalErrorCount=0;
        int consecutiveErrorCount=0;
        
        
        for(UIView *optionView in SAOptionScrollView.subviews){
            
            if([optionView isKindOfClass:[UIView class]]&& optionView.tag!=SATrailNumber-1){
                for(UIButton *selectedOptions in optionView.subviews){
                    if([selectedOptions isKindOfClass:[UIButton class]]){
                        
                        if([selectedOptions.titleLabel.text isEqualToString:@"-"] || [selectedOptions.titleLabel.text isEqualToString:@"-P"]){
                            if([selectedOptions isSelected]){
                                
                                tOtalErrorCount=tOtalErrorCount+1;
                                
                            }
                        }
                        
                    }
                }
                
                
                
            }
            
            if([optionView isKindOfClass:[UIView class]]){
                
                if(optionView.tag==SATrailNumber-2 || optionView.tag==SATrailNumber-3){
                    
                    
                    for(UIButton *selectedOptions in optionView.subviews){
                        if([selectedOptions isKindOfClass:[UIButton class]]){
                            
                            if([selectedOptions.titleLabel.text isEqualToString:@"-"] || [selectedOptions.titleLabel.text isEqualToString:@"-P"]){
                                if([selectedOptions isSelected]){
                                    
                                    consecutiveErrorCount=consecutiveErrorCount+1;
                                    
                                }
                            }
                            
                        }
                    }
                    
                    
                }   
            }
            
            
        }
        
        if(tOtalErrorCount>2 && consecutiveErrorCount>1){
            
            UIAlertView *showAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"There have now been 3 errors and 2 consecutive errors during this session. " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [showAlert show];
            
        }else if(tOtalErrorCount>2){
            
            UIAlertView *showAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"There have now been 3 errors during this session." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [showAlert show];
            
        }else if(consecutiveErrorCount>1){
            
            UIAlertView *showAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"There have now been 2 consecutive errors during this session." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [showAlert show];
            
        }
    }
    
    
}
@end
