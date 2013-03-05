//
//  CurrentSession.h
//  ACE
//
//  Created by Aditi technologies on 7/4/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class XTFirstViewController;
@interface CurrentSession : UIViewController<UIAlertViewDelegate>{

    //SA variables
    
    UITableView *SA_SummarizedTableView ;
    UIView *SAOptionView;
    NSMutableArray *myPickerviewArry;
    NSMutableArray *SA_SublevelArry;
    NSMutableArray *SA_PastdataArry;
    NSMutableArray *SA_StepsAyy;
    NSMutableArray *ActiveStudentinfoArry;
    NSMutableDictionary *SASummarizedDict;
    
    
    int SATrailNumber;
    int SASummarizeTrialCount;
    
   
    
      //TA variables
    NSMutableArray *TAPastDataArry;
    NSMutableArray *TATrialStepArry;
    UIScrollView *TASummarizeStepGridscrollView;
    
    
    MstChainingSequence mstChainingSequence;
    
    
   
    
    
    //IT Variables
    UIView *ITOptionView;
    NSMutableArray  *IT_ContextArray;
    NSMutableArray *IT_PastdataArry;
    NSMutableArray *IT_StepsAyy;
    NSMutableDictionary *ITSummarizedDict;
    
    int ITTrailNumber;
     int ITSummarizeTrialCount;
    
    //carousal class variables
    NSString *currentStudentName;
    NSString *currentStudentCurriculumName;
    NSString *currentStudentCurriculumType;

}


@property(nonatomic,strong)IBOutlet UILabel *StudentName_lbl;
@property(nonatomic,strong)IBOutlet UILabel *StudentCurriculum_lbl;

//Selection Property
@property (assign) int selectedIndex;

//SA properties
@property(nonatomic,strong)IBOutlet UIView *SAUIview;
@property(nonatomic,strong)IBOutlet UILabel *noCurrentSessionLable;
@property(nonatomic,strong)IBOutlet UIScrollView *SAOptionScrollView;
@property(nonatomic,strong)IBOutlet UITableView *SA_SetUP_GridTableView ;
@property(nonatomic,strong)IBOutlet UITableView *SA_SummarizedTableView ;
@property(nonatomic,retain)IBOutlet UIView *SA_SetUPUIview;
@property(nonatomic,retain)IBOutlet UIView *SA_DataEntryUIview;
@property(nonatomic,retain)IBOutlet UIView *SA_SummarizeUIview;
@property(nonatomic,retain)IBOutlet UIPickerView *myPickerView;
@property(nonatomic,retain)IBOutlet UIView *pickerBackground;
@property(nonatomic,strong)IBOutlet UILabel *SA_TrailLable;
@property(nonatomic,strong)IBOutlet UILabel *SA_DataEntry_curriculam_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_DataEntry_StudentName_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_DataEntry_Sublevel_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_DataEntry_Skill_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_DataEntry_Step_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_StudentName_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_StudentCurriculum_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_Summarize_Sublevel_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_Summarize_Skill_lbl;
@property(nonatomic,strong)IBOutlet UILabel *SA_Summarize_Step_lbl;
@property(nonatomic,retain)IBOutlet UIButton *SA_summarizeButton;
@property(nonatomic,strong)IBOutlet UITextField *SAStaffTextField;
@property(nonatomic,strong)IBOutlet UIButton *SAFinishButton;


- (void)presentView:(UIView*)background show:(BOOL)show;

//Discard The Session.....

-(IBAction)discardTheSession:(id)sender;



-(IBAction)SA_NextAndPreviusTrialClicked:(id)sender;
-(IBAction)StartSASession:(id)sender;
-(IBAction)SA_SublevelSelection:(id)sender;
-(IBAction)SA_TrailTypeSelection:(id)sender;
-(IBAction)SA_StepTrailSelection:(id)sender;
-(IBAction)SA_SummarizeData:(id)sender;
-(IBAction)SA_SummarizePageSettingSelection:(id)sender;
-(IBAction)SA_SummarizePageStatusSelection:(id)sender;
-(IBAction)SA_ResumeCurrentSession:(id)sender;
-(IBAction)SA_DiscardSession:(id)sender;
-(IBAction)SA_FinishSession:(id)sender;



//TA properties
@property(nonatomic,strong)IBOutlet UIView *TAUIview;
@property(nonatomic,strong)IBOutlet UITableView *TAPastDataTable;
@property(nonatomic,retain)IBOutlet UIView *TA_SetUPUIview;
@property(nonatomic,retain)IBOutlet UIView *TA_DataEntryUIview;
@property(nonatomic,retain)IBOutlet UIView *TA_SummarizeUIview;
@property(nonatomic,retain)IBOutlet UILabel *forwardORbackwardlbl;
@property(nonatomic,strong)IBOutlet UIScrollView *TAOptionScrollViewHorizantal;
@property(nonatomic,strong)IBOutlet UITextField *TAStaffTextField;
@property(nonatomic,strong)IBOutlet UILabel *TA_StudentName_lbl;
@property(nonatomic,strong)IBOutlet UILabel *TA_StudentCurriculum_lbl;
@property(nonatomic,strong)IBOutlet UILabel *TA_FSIBSITSI_lbl;
@property(nonatomic,retain)IBOutlet UIButton *TA_FSIBSITSI_button;
@property(nonatomic,retain)IBOutlet UIButton *TA_SummarizeButton;
@property(nonatomic,retain)IBOutlet UIButton *TA_numberOfTrialsButton;
@property(nonatomic,strong)IBOutlet UIButton *TAFinishButton;



-(IBAction)TA_TrailTypeSelection:(id)sender;
-(IBAction)TA_TrainingStepSelection:(id)sender;
-(IBAction)TA_StartSession:(id)sender;
-(IBAction)TA_SkipTpStep:(id)sender;
-(IBAction)TA_SummariseData:(id)sender;
-(IBAction)TANumberOfTrials:(id)sender;
-(IBAction)TAResumeSession:(id)sender;
-(IBAction)TAFsiBsiTsiSelection:(id)sender;
-(IBAction)EmailSessionData:(id)sender;
-(IBAction)TAFinishSession:(id)sender;
-(IBAction)TADiscaedSession:(id)sender;
-(IBAction)TA_NextAndPreviusTrialClicked:(id)sender;



//MST selection methods
-(IBAction)MSTSettingSelection:(id)sender;
-(IBAction)MSTStatusSelection:(id)sender;



//IT properties
@property(nonatomic,strong)IBOutlet UIView *ITUIview;
@property(nonatomic,strong)IBOutlet UIScrollView *ITOptionScrollView;
@property(nonatomic,strong)IBOutlet UITableView *IT_SetUP_GridTableView ;
@property(nonatomic,strong)IBOutlet UITableView *IT_SummarizedTableView ;
@property(nonatomic,retain)IBOutlet UIView *IT_SetUPUIview;
@property(nonatomic,retain)IBOutlet UIView *IT_DataEntryUIview;
@property(nonatomic,retain)IBOutlet UIView *IT_SummarizeUIview;
@property(nonatomic,strong)IBOutlet UILabel *IT_TrailLable;
@property(nonatomic,strong)IBOutlet UILabel *IT_DataEntry_curriculam_lbl;
@property(nonatomic,strong)IBOutlet UILabel *IT_DataEntry_StudentName_lbl;
@property(nonatomic,strong)IBOutlet UILabel *IT_DataEntry_TrialNumber_lbl;
@property(nonatomic,strong)IBOutlet UILabel *IT_DataEntry_Skill_lbl;
@property(nonatomic,strong)IBOutlet UILabel *IT_DataEntry_Step_lbl;
@property(nonatomic,strong)IBOutlet UILabel *IT_StudentName_lbl;
@property(nonatomic,retain)IBOutlet UITextField *IT_StaffNameTextField;
@property(nonatomic,retain)IBOutlet UIButton *IT_SummarizeButton;
@property(nonatomic,strong)IBOutlet UILabel *IT_DataEntry_ContextName_lable;
@property(nonatomic,strong)IBOutlet UILabel *IT_SummaryPage_ContextName_lable;
@property(nonatomic,strong)IBOutlet UIButton *ITFinishButton;


-(IBAction)StartITSession:(id)sender;
-(IBAction)IT_ContextSelection:(id)sender;
-(IBAction)IT_TrailTypeSelection:(id)sender;
-(IBAction)IT_SummarizeData:(id)sender;
-(IBAction)IT_NextAndPreviusTrialClicked:(id)sender;
-(IBAction)IT_ResumeSession:(id)sender;
-(IBAction)IT_MIPbuttonClicked:(id)sender;
-(IBAction)IT_StatusButtonClicked:(id)sender;
-(IBAction)IT_FinishsessionClicked:(id)sender;



- (void)logOut;
-(void)currentSessionSelectionInformation;


- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideProgressHudInView:(UIView*)aView;

- (IBAction)pickerCancel:(UIBarItem*)sender;
- (IBAction)pickerDone:(UIBarItem*)sender;

- (void)persistValueForPickerView:(UIPickerView *)pickerView 
                           forRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)selectItemInPicker;

-(void)showErrorSARecommendations;


@end
