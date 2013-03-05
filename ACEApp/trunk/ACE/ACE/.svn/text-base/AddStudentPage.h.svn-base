//
//  AddStudentPage.h
//  NECC
//
//  Created by Aditi on 20/06/12.
//  Copyright (c) 2012 Aditi Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALPickerView.h"
#import "iCarousel.h"
#import "XTFirstViewController.h"
#import "AppDelegate.h"
#import "ACEAuthenticationManager.h"
#import "ACEUser.h"
#import "ACESchoolsManager.h"
#import "ACETeamsManager.h"
#import "ACEStudentsDataManager.h"
#import "ACECurriculumDetailsManager.h"
#import "ACEMasterDataManager.h"
#import "ACEConfigurationManager.h"
#import "MBProgressHUD.h"

@interface AddStudentPage : UIViewController<iCarouselDataSource, iCarouselDelegate,ALPickerViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>
{
    NSMutableArray *_listOfStudent;
    NSMutableArray *_listOfStudentId;
    IBOutlet UIPickerView *_SchoolPickerView;
    IBOutlet UIPickerView *_TeamPickerView;
    IBOutlet UILabel *ACEstudent;
    IBOutlet UILabel *ACEschool;
    IBOutlet UILabel *ACEteam;
    IBOutlet UIButton *_School;
    IBOutlet UIButton *_Team;
    IBOutlet UIButton *_Student;
    IBOutlet UIButton *_Done;
    NSMutableData *responseData;
    NSMutableArray *dataForSchool;
    NSMutableArray *dataForTeam;
    NSMutableArray *dataForStudent;
    bool flag;
    ALPickerView *MultiCheckpickerView;
    NSMutableDictionary *selectionStates;
    NSMutableArray *pickerRowValueCount;
    IBOutlet UINavigationBar *Navigationbar;
    iCarousel *carousal;
    NSMutableArray *studentNameArray;
    AppDelegate * appDelegate;
    NSMutableArray *CurrentuserId;
    MBProgressHUD *HUD;
    int checkCounter;
    int  indexValue;
   // ACEUser *aceUser;
    XTFirstViewController  *mainClass;
    NSMutableArray  *duplicateStudent;
    
    //Picker 
    IBOutlet UIView *schoolPickerBackground;
    IBOutlet UIView *teamPickerBAckground;
   
    //Button Images
    IBOutlet UIImageView *schoolButtonBackground;
    IBOutlet UIImageView *teamButtonBackground;
    IBOutlet UIImageView *studentButtonBackground;
    
    //Add new Implementation
    NSMutableArray *studentList;
    NSMutableArray *displayList;
    NSMutableArray *duplicateStudentList;
}

@property (unsafe_unretained)  id  delegate;
@property (nonatomic, retain) ACEAuthenticationManager *manager;
@property (nonatomic, retain) ACEUser *user;
@property (nonatomic, retain) ACESchoolsManager *schoolManager;
@property (nonatomic, retain) ACETeamsManager *teamManager;
@property (nonatomic, retain) ACEStudentsDataManager *studentManager;
@property (nonatomic, retain) ACECurriculumDetailsManager *curriculamManager;
@property (nonatomic, retain) ACEMasterDataManager *curriculamMasterDataManager;
@property (nonatomic, retain) ACEConfigurationManager *configManager;
@property (nonatomic, retain) NSMutableArray *studentsList;
@property (nonatomic, retain) IBOutlet iCarousel *carousal;
@property(nonatomic,retain)  IBOutlet UIPickerView *_SchoolPickerView;
@property(nonatomic,retain)  IBOutlet UIPickerView *_TeamPickerView;
@property(nonatomic,retain)  IBOutlet UIView *studentPickerBackground;

-(IBAction)addMultipleStudent;
-(IBAction)addSchool:(id)sender;
-(IBAction)addTeam:(id)sender;
-(IBAction)cancelButton:(id)sender;
-(IBAction)submitButton:(id)sender;

-(id)initWithCarousel:(iCarousel *)carsl;
- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideProgressHudInView:(UIView*)aView;
- (void)beginPush;
- (void) showProgressHudForManualInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideManualSyncProgressHudInView:(UIView*)aView;
- (BOOL)showSequencedAlertFrom:(NSInteger)alertIndex;

- (IBAction)cancelPicker:(UIBarItem*)sender;
- (IBAction)donePicker:(UIBarItem*)sender;

- (IBAction)studentCancelPicker:(UIBarItem*)sender;
- (IBAction)stuentDonePicker:(UIBarItem*)sender;

@end

@interface AddStudentPage (AddStudentPage)

- (void)AddStudentPageDidAddedStudents:(AddStudentPage*)studentPage;

@end