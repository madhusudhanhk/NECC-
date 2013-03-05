//
//  AddStudentPage.m
//  NECC
//
//  Created by Aditi on 20/06/12.
//  Copyright (c) 2012 Aditi Technology. All rights reserved.
//

#import "AddStudentPage.h"
#import "XTFirstViewController.h"
#import "iCarousel.h"
#import "Reachability.h"
#import "ReachabilityViewController.h"
#import "ACEUtilMethods.h"
#import "ACELocationInfo.h"
#import "ACEStudent.h"
#import "ACESchool.h"
#import "ACETeam.h"
#import "LoginPage.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ACESyncManager.h"

typedef enum {
    eNoneSelected,
    eDataLoaded,
    eSchoolSelected,
    eTeamSelected,
    eAllSelected
}SELECTION_STATE;

@interface AddStudentPage () <UIActionSheetDelegate>

@property (nonatomic, retain) NSMutableArray *studentInformation;
@property (assign) SELECTION_STATE currentState;
@property (assign) int schoolSelectedIndex;
@property (assign) int teamSelectedIndex;
@property (assign) int alertCount;
@property (assign) BOOL isLoadingCurriculum;
@property (retain) NSMutableArray *studentList;
@property (retain) NSMutableArray *displayList;
@property (retain) NSMutableArray *duplicateResultSet;
@property (retain) NSMutableArray *addedStudentSet;

- (void)presentView:(UIView*)background show:(BOOL)show;
- (void)changeStateForSelectionState:(SELECTION_STATE)selState;
- (void)selectSchoolAtIndex:(int)index;
- (void)selectTeamAtIndex:(int)index;
- (void)updateStudentListOnSelectionChangeWithList:(NSMutableArray*)array;
- (void)enableDoneButton:(BOOL)enable;
- (void)loadDisplayList;
- (void)loadStudentListFromDisplayList;
- (void)fetchDetailsForNewlyAddedStudents;
- (void)beginShowingAlertForDuplicateStudents;

@end

@implementation AddStudentPage

@synthesize studentList,duplicateResultSet,addedStudentSet;
@synthesize schoolSelectedIndex, teamSelectedIndex;
@synthesize _SchoolPickerView,_TeamPickerView;
@synthesize studentInformation;
@synthesize currentState;
@synthesize carousal;
@synthesize manager;
@synthesize user;
@synthesize schoolManager;
@synthesize teamManager;
@synthesize studentManager;
@synthesize curriculamManager;
@synthesize curriculamMasterDataManager;
@synthesize studentsList;
@synthesize configManager;
@synthesize studentPickerBackground;
@synthesize alertCount;
@synthesize isLoadingCurriculum;
@synthesize displayList;
@synthesize delegate;

- (id)initWithCarousel:(iCarousel *)carsl
{
    self = [super initWithNibName:@"AddStudentPage" bundle:nil];
    if (self) {
        carousal = carsl;
        self.studentList = [[NSMutableArray alloc] init];
        self.displayList = [[NSMutableArray alloc] init];
        self.duplicateResultSet = [[NSMutableArray alloc] init];
        self.addedStudentSet = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc 
{
    self.duplicateResultSet = nil;
    self.displayList  = nil;
    self.duplicateResultSet = nil;
    self.addedStudentSet = nil;
    self.delegate = nil;
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadSchoolList
{
    self.schoolManager = [[ACESchoolsManager alloc] initWithUserId:[kACEUserId intValue]
                                                             token:kLoginSessionId                                                        delegate:self];
    
    [self.schoolManager loadSchoolList];
}

- (void)loadTeamList:(int )currentSchoolId
{
    self.teamManager = [[ACETeamsManager alloc] initWithUserId:[kACEUserId intValue] 
                                                      schoolID:currentSchoolId
                                                         token:kLoginSessionId 
                                                      delegate:self];
    
    [self.teamManager loadTeamsList];
}

- (void)loadStudentManager:(int)currentTeamId
{
    ACETeam *team = [[ACETeam alloc] init];
    team.ID = currentTeamId;
    team.name = @"Team";
    self.studentManager = [[ACEStudentsDataManager alloc] initWithTeam:team
                                                                 token:kLoginSessionId
                                                              delegate:self];
    
    [self.studentManager loadStudentsList];
    team = nil;
}

- (void)loadConfiguration
{
    self.configManager = [[ACEConfigurationManager alloc]  initWithDelegate:self];
    [self.configManager getConfugurationXML];
}

- (void)loadCurriculamList:(NSArray *)studentIdDetails
{
    //Load all students data.
    self.curriculamManager = [[ACECurriculumDetailsManager alloc] initWithStudentIds:self.addedStudentSet
                                                                               token:kLoginSessionId  
                                                                            delegate:self];
    [self.curriculamManager loadCurriculamDetails];
}

- (void)loadCurriculamMasterData
{
    self.curriculamMasterDataManager = [[ACEMasterDataManager alloc] initWithToken:kLoginSessionId 
                                                                          delegate:self];
    [self.curriculamMasterDataManager loadCurriculamMasterData];
}

- (void)ACEConnectionManager:(ACEDataManager*)manager didRecieveResponse:(NSDictionary*)responseDataValue
{
    
}

- (void)ACEConnectionManager:(ACEDataManager*)manager didLoginSuscessfull:(NSMutableArray*)responseDataValue
{
    if ([responseDataValue count] > 0) {
        self.user = [responseDataValue objectAtIndex:0];
        [self loadSchoolList];
    }
}

- (void)ACEConnectionManagerDidLoginFailed:(ACEDataManager*)manager isAccountLocked:(BOOL)isLocked
{
    [self hideProgressHudInView:self.view] ; 
}

- (void)ACEConnectionManager:(ACEDataManager*)manager didRecieveError:(NSError*)error
{
    isLoadingCurriculum = NO;
    [self hideProgressHudInView:self.view] ;
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to retrieve information. Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    
}

- (void)ACEConnectionManager:(ACEDataManager*)_manager didFinishLoadingData:(NSMutableArray*)responseDataValue
{
    [self hideProgressHudInView:self.view] ;
   
    if(_manager.requestType == eSchoolListReq){
        
        [dataForSchool removeAllObjects];
 
        for (ACESchool *school in responseDataValue) {
            [dataForSchool addObject:school];
            [school print];
        }
        
        [_SchoolPickerView reloadAllComponents]; 
        
        if ([dataForSchool count] > 0) {
            self.schoolSelectedIndex = -1;
            currentState = eDataLoaded;
            [self changeStateForSelectionState:currentState];
            [self selectSchoolAtIndex:self.schoolSelectedIndex];
        }
        
    }else if(_manager.requestType == eTeamList) {
     
        [dataForTeam removeAllObjects];
 
        for (ACETeam *team in responseDataValue) {
            [dataForTeam addObject:team];
            [team print];
        }
        
        self.teamSelectedIndex = -1;
        
        if ([dataForTeam count] > 0) {
            [_TeamPickerView reloadAllComponents];
            currentState = eSchoolSelected;
            self.teamSelectedIndex = -1;
            [self changeStateForSelectionState:currentState];
            [self selectTeamAtIndex:self.teamSelectedIndex];
        }
        
    } else if(_manager.requestType == eStudentList) {
        
        [self.studentList removeAllObjects];
        [self.displayList removeAllObjects];
        [self.studentList addObjectsFromArray:responseDataValue];
        currentState = eTeamSelected;
        [self changeStateForSelectionState:currentState];

    } else if(_manager.requestType == eCurriculamDetails){
            [self loadCurriculamMasterData];
    }
}


#pragma mark - End

//Curriculum Delegate Start
- (void)ACECurriculamDetailsManagerDidREcieveAllCurriculum:(ACEDataManager*)manager 
                                     withFailureDictionary:(NSDictionary*)dct
{
    if (nil == dct) {
        
        if ([self.delegate respondsToSelector:@selector(AddStudentPageDidAddedStudents:)]) {
            [self.delegate AddStudentPageDidAddedStudents:self];
        }
        [self dismissModalViewControllerAnimated:YES]; 
        
    }else{
        
        NSString *names = @"";
        NSEnumerator *enumerator = [dct objectEnumerator];
        NSString *value;
        while ((value = [enumerator nextObject])) {
            names = [names stringByAppendingString:[NSString stringWithFormat:@" %@, ",value]];
        }
        
        NSString *msg = [NSString stringWithFormat:@"Couldn't get curriculum details for  %@",names];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                        message:msg
                                                       delegate:self 
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        alert.tag =  601;
        [alert show];
    }
   
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showProgressHudInView:self.view withTitle:nil andMsg:nil];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tabBarController.tabBarItem.title= @"Curricula";
   NSString *navigationBarTitle = @"Add Student";
    self.view.backgroundColor =UIColorFromRGB(0xe7e6eb);
   self.navigationController.navigationBar.topItem.title = navigationBarTitle;
   
    kLoginSessionId = [StudentDatabase getSessionId];
    kACEUserId = [StudentDatabase ACEUserIdFromACEUserTableForAddUserPage];
    [self loadSchoolList];
    
    CurrentuserId =  [[NSMutableArray alloc]init];
    dataForSchool = [[NSMutableArray alloc]init];
    dataForTeam = [[NSMutableArray alloc]init];
    dataForStudent = [[NSMutableArray alloc]init];
    _listOfStudent = [[NSMutableArray alloc]init];
    _listOfStudentId = [[NSMutableArray alloc]init];
   
    selectionStates = [[NSMutableDictionary alloc] init];
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x2eb5e4);
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.rightBarButtonItem = homeButton; 
    
    MultiCheckpickerView = [[ALPickerView alloc] initWithFrame:CGRectMake(0, 150, 0, 0)];
	MultiCheckpickerView.delegate = self;
    CGRect frame = MultiCheckpickerView.frame;
    frame.origin.y = CGRectGetMaxY(studentPickerBackground.frame) - frame.size.height;
    MultiCheckpickerView.frame = frame;
	[studentPickerBackground addSubview:MultiCheckpickerView];
    
    currentState = eNoneSelected;
    [self changeStateForSelectionState:currentState];
    
    schoolPickerBackground.backgroundColor = [UIColor clearColor];
    teamPickerBAckground.backgroundColor = [UIColor clearColor];
    studentPickerBackground.backgroundColor = [UIColor clearColor];
    self.schoolSelectedIndex = self.teamSelectedIndex = -1;
    
    [self enableDoneButton:NO];
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
     NSString *isLoggedOut = @"true";
     NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
     [loggedValue setValue:isLoggedOut forKey:kIsLoggedOut];
     [loggedValue synchronize];
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
 
- (IBAction)cancelButton:(id)sender
{    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)submitButton:(id)sender
{
    NSString *studentTeam = ACEteam.text;
    NSString *studentSchool = ACEschool.text;
    self.alertCount = 0;
    
    if ([[Reachability reachabilityForInternetConnection] 
                        currentReachabilityStatus] != kNotReachable)  {
        
       NSArray *addStud = [StudentDatabase getStudentDetailsForUser:kACEUserIDFromTable];
        [self.addedStudentSet removeAllObjects];
        
        for (ACEStudent *student in self.studentList) {
            [student print];
            if (student.isSelected) {
                BOOL isExist = [StudentDatabase verifyStudentEntryOnInsertion:student.name 
                                                                             :studentTeam 
                                                                             :studentSchool];
                if (isExist) {
                    self.alertCount++;
                    [self.duplicateResultSet addObject:student];
                }else{
                    [self.addedStudentSet addObject:student];
                }
            }
        }
        
        if (([addStud count] + 
                        [self.addedStudentSet count] + [self.duplicateResultSet count]) > 10) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" 
                                                           message:@"‘You have reached the limit of 10 students. Please remove one in order to add another." 
                                                          delegate:nil 
                                                 cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
        } else {
            
            //Check Count and Start Showing Alerts otherwise start downloading.
            if (self.alertCount > 0) {
                [self beginShowingAlertForDuplicateStudents];
            }else{
                if ([self.addedStudentSet count] > 0) {
                    [self fetchDetailsForNewlyAddedStudents];
                }else{
                    [self dismissModalViewControllerAnimated:YES]; 
                }
            }
        }
    }
}

- (void)fetchDetailsForNewlyAddedStudents
{
    [self showProgressHudInView:self.view withTitle:@"Retrieving Student Details..." andMsg:nil];
    
    //Date 
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init]; 
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];  
    NSString *currentDate = [DateFormatter stringFromDate:[NSDate date]];
    NSString *studentTeam = ACEteam.text;
    NSString *studentSchool = ACEschool.text;
    
    for (ACEStudent *student in self.addedStudentSet) {
        [student print];    
        int iepQuarter = 0;
 
        if (nil != student.IEPQuarter && 
            ![[NSNull null] isEqual:student.IEPQuarter]) {
            iepQuarter = [student.IEPQuarter intValue];
        }
        
        [StudentDatabase 
             insertStudentDetailInCarrousal:kACEUserIDFromTable :student.ID 
            :student.name 
             :studentSchool 
             :studentTeam 
             :currentDate
             andQuarter:iepQuarter];
    }
    
    [self loadCurriculamList:self.addedStudentSet];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{   
    if (alertView.tag == 601) {
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    
    if (self.alertCount > 0) {
        [self beginShowingAlertForDuplicateStudents];
    }else{
        if ([self.addedStudentSet count] > 0) {
            [self fetchDetailsForNewlyAddedStudents];
        }else{
            [self dismissModalViewControllerAnimated:YES]; 
        }
    }
}   

- (void)beginShowingAlertForDuplicateStudents
{
    self.alertCount--;
    ACEStudent *student = [self.duplicateResultSet lastObject];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" 
                                                   message:[NSString stringWithFormat:@"Student '%@' already exists",student.name] 
                                                  delegate:self 
                                         cancelButtonTitle:@"Ok" 
                                         otherButtonTitles: nil];
    [self.duplicateResultSet removeObject:student];
    [alert show];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait 
                        || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView 
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{
    if (thePickerView == _SchoolPickerView) {
        return [dataForSchool count];
    }else{    
        return [dataForTeam count];
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView 
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (thePickerView == _SchoolPickerView) {
        ACESchool *ace= [dataForSchool objectAtIndex:row];
        return ace.name;
    }else{
        ACETeam *ace= [dataForTeam objectAtIndex:row];
        return ace.name;       
    }
}


- (void)pickerView:(UIPickerView *)thePickerView 
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (thePickerView == _SchoolPickerView) {
       ACESchool *ace = [dataForSchool objectAtIndex:row];
       ACEschool.text=ace.name;
    } else{
        ACETeam *ace= [dataForTeam objectAtIndex:row];
        ACEteam.text=ace.name;
    }
}

#pragma mark ALPickerView delegate methods

- (NSInteger)numberOfRowsForPickerView:(ALPickerView *)pickerView 
{
    return [self.displayList count];
}

- (NSString *)pickerView:(ALPickerView *)pickerView textForRow:(NSInteger)row 
{
    ACEStudent  *ace= [self.displayList objectAtIndex:row];
	return ace.name;
}

- (BOOL)pickerView:(ALPickerView *)pickerView selectionStateForRow:(NSInteger)row 
{
    ACEStudent  *ace= [self.displayList objectAtIndex:row];
    return ace.isSelected;
}

- (void)pickerView:(ALPickerView *)pickerView didCheckRow:(NSInteger)row 
{
	ACEStudent *ace= [self.displayList objectAtIndex:row];
    ace.isSelected = YES;
    [self updateStudentListOnSelectionChangeWithList:self.displayList];
}

- (void)pickerView:(ALPickerView *)pickerView didUncheckRow:(NSInteger)row 
{
    ACEStudent *ace= [self.displayList objectAtIndex:row];
    ace.isSelected = NO;
    [self updateStudentListOnSelectionChangeWithList:self.displayList];
}

- (void)updateStudentListOnSelectionChangeWithList:(NSMutableArray*)array
{
    NSString *addedStudList = @"";
    for (ACEStudent *student in array) {
        if (student.isSelected) {
            addedStudList = [addedStudList 
                             stringByAppendingString:[NSString stringWithFormat:@"%@;",student.name]];
        }
    }
    
    ACEstudent.text = addedStudList;
    
    if (![addedStudList isEqualToString:@""]) {
        [self enableDoneButton:YES];
    }else{
        [self enableDoneButton:NO];
    }
}

- (IBAction)addSchool:(id)sender
{
    if (self.schoolSelectedIndex != -1) {
        [_SchoolPickerView selectRow:self.schoolSelectedIndex 
                         inComponent:0 animated:NO];
    }
    
    [self presentView:schoolPickerBackground show:YES];
    currentState = eDataLoaded;
    [self changeStateForSelectionState:currentState];
}

- (IBAction)addTeam:(id)sender
{
    if (self.teamSelectedIndex != -1) {
        [_TeamPickerView selectRow:self.teamSelectedIndex 
                         inComponent:0 animated:NO];
    }
    
    [self presentView:teamPickerBAckground show:YES];
    currentState = eSchoolSelected;
    [self changeStateForSelectionState:currentState];
}

- (void)loadDisplayList
{
    [self.displayList removeAllObjects];
    
    //Perform Deep Copy.
    for (ACEStudent *student in self.studentList) {
        ACEStudent *newStudent = [[ACEStudent alloc] init];
        newStudent.ID = student.ID;
        newStudent.name = student.name;
        newStudent.IEPQuarter = student.IEPQuarter;
        newStudent.isSelected = student.isSelected;
        [self.displayList addObject:newStudent];
        newStudent = nil;
    }
}

- (void)loadStudentListFromDisplayList
{
    [self.studentList removeAllObjects];
    
    //Perform Deep Copy.
    for (ACEStudent *student in self.displayList) {
        ACEStudent *newStudent = [[ACEStudent alloc] init];
        newStudent.ID = student.ID;
        newStudent.name = student.name;
        newStudent.IEPQuarter = student.IEPQuarter;
        newStudent.isSelected = student.isSelected;
        [self.studentList addObject:newStudent];
        newStudent = nil;
    }
}

- (IBAction)addMultipleStudent
{
    [self.displayList removeAllObjects];
    [self loadDisplayList];
    [MultiCheckpickerView reloadAllComponents];
    [self presentView:studentPickerBackground show:YES];
}    

- (void) showProgressHudInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG
{
    MBProgressHUD *aMBProgressHUD = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    aMBProgressHUD.labelText = aTitle;    
}

- (void) hideProgressHudInView:(UIView*)aView
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
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

- (void)changeStateForSelectionState:(SELECTION_STATE)selState
{
    _School.userInteractionEnabled  =     _Team.userInteractionEnabled = _Student.userInteractionEnabled = NO;
    schoolButtonBackground.alpha = teamButtonBackground.alpha = studentButtonBackground.alpha = 0.4f;
    
    if (selState == eDataLoaded) {
        _School.userInteractionEnabled = YES;
        schoolButtonBackground.alpha = 1.0f;
    }else if (selState == eSchoolSelected) {
        _School.userInteractionEnabled  =     _Team.userInteractionEnabled = YES;
        schoolButtonBackground.alpha = teamButtonBackground.alpha = 1.0f;
    }else if(selState == eTeamList){
        _School.userInteractionEnabled  =     _Team.userInteractionEnabled = _Student.userInteractionEnabled = YES;
        schoolButtonBackground.alpha = teamButtonBackground.alpha = studentButtonBackground.alpha = 1.0f;
    }
}

- (IBAction)studentCancelPicker:(UIBarItem*)sender
{
    [self.displayList removeAllObjects];
    [self presentView:studentPickerBackground show:NO];
    [self updateStudentListOnSelectionChangeWithList:self.studentList];
}

- (IBAction)stuentDonePicker:(UIBarItem*)sender
{
    [self presentView:studentPickerBackground show:NO];
    [self loadStudentListFromDisplayList];
    [self updateStudentListOnSelectionChangeWithList:self.studentList];
}

#define kSchoolPickerCancelTag 5001
#define kTeamPickerCancelTag 5002

- (IBAction)cancelPicker:(UIBarItem*)sender
{
    if (sender.tag == kSchoolPickerCancelTag) {
    
        if (self.schoolSelectedIndex == -1) {
           
            kGetCurrentValueForSchoolId = -1;
            kGetCurrentValueForTeamId = -1;
            ACEschool.text = @"";
            ACEteam.text = @"";
            ACEstudent.text = @"";
            [self.studentList removeAllObjects];
            currentState = eDataLoaded;
            
        }else{
            currentState = eSchoolSelected;
            ACESchool *ace= [dataForSchool 
                             objectAtIndex:self.schoolSelectedIndex];
            ACEschool.text = ace.name;
        }
        
        [self presentView:schoolPickerBackground show:NO];
        [self changeStateForSelectionState:currentState];
        
    }else if(sender.tag == kTeamPickerCancelTag){
        
        if (self.teamSelectedIndex == -1) {
          
            kGetCurrentValueForTeamId = -1;
            ACEteam.text = @"";
            ACEstudent.text = @"";
            currentState = eSchoolSelected;
            
        }else{
            ACETeam *ace= [dataForTeam objectAtIndex:self.teamSelectedIndex];
            ACEteam.text=ace.name;
            currentState = eTeamSelected;
        }
        
        [self presentView:teamPickerBAckground show:NO];
        [self changeStateForSelectionState:currentState];
        
    }
}

#define kSchoolPickerDoneTag 5003
#define kTeamPickerDoneTag 5004

- (IBAction)donePicker:(UIBarItem*)sender
{
    if (sender.tag == kSchoolPickerDoneTag) {
        
        [self presentView:schoolPickerBackground show:NO];
        self.schoolSelectedIndex = [_SchoolPickerView selectedRowInComponent:0];
        [self selectSchoolAtIndex:self.schoolSelectedIndex];
        
    }else if(sender.tag == kTeamPickerDoneTag){
        
        [self presentView:teamPickerBAckground show:NO];
        self.teamSelectedIndex = [_TeamPickerView selectedRowInComponent:0];
        [self selectTeamAtIndex:self.teamSelectedIndex];
        
    }
}

- (void)selectSchoolAtIndex:(int)index
{
    if (index != -1) {
        
        ACESchool *ace= [dataForSchool objectAtIndex:index];
        ACEschool.text=ace.name;
        kGetCurrentValueForSchoolId = ace.ID;
        kGetCurrentValueForTeamId = -1;
        ACEteam.text = @"";
        ACEstudent.text = @"";
        [_SchoolPickerView selectRow:index inComponent:0 animated:NO];
        [self loadTeamList:kGetCurrentValueForSchoolId];
       
    }else{
        
        kGetCurrentValueForSchoolId = -1;
        kGetCurrentValueForTeamId = -1;
        ACEschool.text = @"";
        ACEteam.text = @"";
        ACEstudent.text = @"";
    }
}

- (void)selectTeamAtIndex:(int)index
{
    if (index != -1) {
        
        ACETeam *ace= [dataForTeam objectAtIndex:index];
        ACEteam.text=ace.name;
        kGetCurrentValueForTeamId = ace.ID;
        ACEstudent.text = @"";
        [self.studentList removeAllObjects];
        [self loadStudentManager:kGetCurrentValueForTeamId];
    
    } else{
    
        kGetCurrentValueForTeamId = -1;
        ACEstudent.text = @"";
        ACEteam.text = @"";
        [self.studentList removeAllObjects];
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{ }

- (void)enableDoneButton:(BOOL)enable
{
    _Done.enabled = enable;
    _Done.userInteractionEnabled = enable;
}

@end
