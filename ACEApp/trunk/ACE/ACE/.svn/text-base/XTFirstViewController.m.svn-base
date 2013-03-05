//
//  XTFirstViewController.m
//  NECC
//
//  Created by Aditi on 18/06/12.
//  Copyright (c) 2012 __NECC_Mobile_Application__. All rights reserved.
//

#import "XTFirstViewController.h"
#import "curriculaListView.h"
#import "LoginPage.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "ReachabilityViewController.h"
#import "MyActiveSessions.h"
#import "CurrentSession.h"
#import "ACESyncManager.h"
#import "MBProgressHUD.h"
#define myAppDelegate (XTAppDelegate *) [[UIApplication sharedApplication] delegate]
#define NUMBER_OF_ITEMS 10
#define NUMBER_OF_VISIBLE_ITEMS 10
#define ITEM_SPACING 110.0f
#define INCLUDE_PLACEHOLDERS YES
#define NEGATIVE_Value -1
bool count =1;
int counter = 1;
BOOL buttonValue;
static NSString *CellClassName = @"curriculaListView";



@interface XTFirstViewController () <UIActionSheetDelegate>


@property (nonatomic, retain) NSMutableArray *studentInformation;
@property (nonatomic, retain) NSMutableArray *studentSchool;
@property (nonatomic, retain) NSMutableArray *studentTeam;
@property (nonatomic, retain) NSMutableArray *items;

@end

@implementation XTFirstViewController
@synthesize carousel;
@synthesize studentInformation;
@synthesize studentSchool;
@synthesize studentTeam;
@synthesize curriculamList;
@synthesize listOfCurrilum;
@synthesize items;
@synthesize currentItemView;
@synthesize currentItemIndex;



#pragma mark -Set up for carousal
- (void)setUp
{
    
    
    
    studentInformation = [StudentDatabase getStudentDetailsForUser:kACEUserIDFromTable];
    
    self.items = [NSMutableArray array];
    for (int i = 0; i < NUMBER_OF_ITEMS; i++)
    {
        [items addObject:[NSNumber numberWithInt:i]];
    }
    
    
    // studentInformation = [StudentDatabase getStudentDetailsForUser:[NSString stringWithFormat:@"%d",3]];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Curricula", @"Curricula");
        self.tabBarItem.image = [UIImage imageNamed:@"Tab_Curricula_icon"];
        [self setUp];
        cellLoader = [UINib nibWithNibName:CellClassName bundle:[NSBundle mainBundle]];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

#pragma mark -
#pragma mark Delete Carousal for student

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0)
    {
        //map button index to carousel type
        iCarouselType type = buttonIndex;
        
        //carousel can smoothly animate between types
        [UIView beginAnimations:nil context:nil];
        carousel.type = type;
        [UIView commitAnimations];
        
    }
}


//inside button on top of minus button
- (void)buttonTapped1:(UIButton *)sender{
    
    
    NSInteger index = carousel.currentItemIndex;
    // studentInformation = [StudentDatabase getStudentDetailsForUser:[NSString stringWithFormat:@"%d",5]];
    studentInformation = [StudentDatabase getStudentDetailsForUser:kACEUserIDFromTable];
        NSString *studentNameText =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:index] valueForKey:@"studentName"]];
    
    [[[UIAlertView alloc] initWithTitle:@"Alert"
                                message:[NSString stringWithFormat:@"If you remove this student, any unfinished active sessions will be lost. Are you sure you want to remove '%@' from the list of students?",studentNameText]
                               delegate:self
                      cancelButtonTitle:@"Yes"
                      otherButtonTitles:@"No",nil] show];
    
    
}

//outsidebutton top of uiview
- (void)buttonTapped:(UIButton *)sender
{
    
	//get item index for button
    
    
    if (count) 
    {
        for(UIImageView * imag in carousel.currentItemView.subviews)
        {
            
            if([imag isKindOfClass:[UIView class]]&& imag.tag==3467)
            {
                
                
                imag.image=[UIImage imageNamed:@"Delete_Active_slide.png"];
                
                
            }
            
            
        }
        count=false;
    }
    else
    {
        for(UIImageView * imag in carousel.currentItemView.subviews)
        {
            if([imag isKindOfClass:[UIView class]]&& imag.tag==3467)
            {
                
                
                imag.image=[UIImage imageNamed:@"In_Active_slide.png"];
                
                
            }
            
        }
        count=true;           
    }
    
    
    
	for(UIButton * btn in carousel.currentItemView.subviews)
    {
        if([btn isKindOfClass:[UIView class]]&& btn.tag==10002)
        {
            
            btn.enabled = YES;
            [self.view bringSubviewToFront:btn];
            btn.hidden = FALSE;
            
            
            
            
            
        }
    }
    
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Yes"])
    {
        NSLog(@"Button YES was selected.");
        if (carousel.numberOfItems > 0)
        {
            NSInteger index = carousel.currentItemIndex;
            // studentInformation = [StudentDatabase getStudentDetailsForUser:[NSString stringWithFormat:@"%d",5]];
            studentInformation = [StudentDatabase getStudentDetailsForUser:kACEUserIDFromTable];
            [listOfCurrilum reloadData];
            NSString *studentIDText =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:index] valueForKey:@"studentID"]];
            
            if ([studentInformation count]==1) {
                [curriculamArray removeAllObjects];
            }
             
            //[StudentDatabase delateCurriculumDetailsForStudent:[NSString stringWithFormat:@"%d",[studentIDText intValue]]];
             NSLog(@"Before Count %d",[curriculamArray count]);
            
            [StudentDatabase delateDetailsForStudent:[NSString stringWithFormat:@"%d",[studentIDText intValue]]]; 
            currentSessionType=noCurrentSeeion;
            
            [listOfCurrilum reloadData];
            NSLog(@"After Count %d",[curriculamArray count]);
            [carousel removeItemAtIndex:index animated:YES];
            
            //[listOfCurrilum reloadData];
            //  NSLog(@"Student Info:%@",[studentInformation objectAtIndex:index]);
            
            [studentInformation removeObjectAtIndex:index];
            [carousel reloadData];
            
            [listOfCurrilum reloadData];
          
        }
    }
    else if([title isEqualToString:@"No"]){
        
        
        for(UIImageView * imag in carousel.currentItemView.subviews)
        {
            if([imag isKindOfClass:[UIView class]]&& imag.tag==3467)
            {
                
                
                imag.image=[UIImage imageNamed:@"In_Active_slide.png"];
                
                
            }
        }
        
        for(UIButton * btn in carousel.currentItemView.subviews)
        {
            if([btn isKindOfClass:[UIView class]]&& btn.tag==10002)
            {
                
                btn.enabled = NO;
                
                
            }
        }
        
        
    }
    
}


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSLog(@"user id:%d",kACEUserIDFromTable);
    kLastUser =@"0";
    //kACEUserIDFromTable = [StudentDatabase ACEUserIdFromACEUserTable:[kACEUserId intValue]];
    //  studentInformation = [StudentDatabase getStudentDetailsForUser:[NSString stringWithFormat:@"%d",5]];
    studentInformation = [StudentDatabase getStudentDetailsForUser:kACEUserIDFromTable];
    
    return [studentInformation count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    //this also affects the appearance of circular-type carousels
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *studentNameLabel = nil;
    UILabel *studentSchoolLabel = nil;
    UILabel *studentTeamLabel = nil;
    
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slide.png"]];
        UIImageView  *currentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"user%d.png",index]]];
        currentImage.frame = CGRectMake(25, 10, 50, 65);
        
        currentImage.tag=3467;
        
        [view addSubview:currentImage];
        view.layer.doubleSided = NO; //prevent back side of view from showing
        
        
        
        UIButton *btnImages = [UIButton buttonWithType:UIButtonTypeCustom];
        btnImages.frame = view.frame;
        btnImages.tag = 10001;
        btnImages.enabled = TRUE;
        [btnImages addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btnImages];
        
        
        
        UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDelete.frame = CGRectMake(75,5,45,20);
        btnDelete.tag = 10002;
        btnDelete.hidden = TRUE;
        [btnDelete addTarget:self action:@selector(buttonTapped1:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btnDelete];
        
        //Label setting for student name
        studentNameLabel = [[UILabel alloc] initWithFrame:view.bounds];
        studentNameLabel.backgroundColor = [UIColor clearColor];
        studentNameLabel.textColor = [UIColor brownColor];
        studentNameLabel.frame = CGRectMake(10,35,100,100);
        studentNameLabel.textAlignment = UITextAlignmentCenter;
        studentNameLabel.font = [studentNameLabel.font fontWithSize:14];
        [view addSubview:studentNameLabel];
        
        //label setting for student school
        studentSchoolLabel = [[UILabel alloc] initWithFrame:view.bounds];
        studentSchoolLabel.backgroundColor = [UIColor clearColor];
        studentSchoolLabel.textColor = [UIColor blackColor];
        studentSchoolLabel.frame = CGRectMake(10,48,100,100);
        studentSchoolLabel.textAlignment = UITextAlignmentCenter;
        studentSchoolLabel.font = [studentSchoolLabel.font fontWithSize:10];
        [view addSubview:studentSchoolLabel];
        
        //label setting for student Team
        studentTeamLabel = [[UILabel alloc] initWithFrame:view.bounds];
        studentTeamLabel.backgroundColor = [UIColor clearColor];
        studentTeamLabel.textColor = [UIColor blackColor];
        studentTeamLabel.frame = CGRectMake(10,60,100,100);
        studentTeamLabel.textAlignment = UITextAlignmentCenter;
        studentTeamLabel.font = [studentTeamLabel.font fontWithSize:10];
        [view addSubview:studentTeamLabel];
    }
    else
    {
        studentNameLabel = [[view subviews] lastObject];
        studentSchoolLabel = [[view subviews] lastObject];
        studentTeamLabel = [[view subviews] lastObject];
    }
    
    
    
    if([studentInformation count] >0){
        
        NSString *studentNameText =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:index] valueForKey:@"studentName"]];
        NSString *studentSchoolText =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:index] valueForKey:@"studentSchool"]];
        NSString *studentTeamText =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:index] valueForKey:@"studentTeam"]];
        
        //set label
        studentNameLabel.text = studentNameText;
        studentSchoolLabel.text = studentSchoolText;
        studentTeamLabel.text = studentTeamText;
        
        
    }
    else{
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Message" message:@"No Record Found Please add new record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alrt show];
        
        
    }
    
    
    return view;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{    
    
    // Current index
    NSInteger currentIndex = carousel.currentItemIndex;
    NSLog(@"current index = %i",currentIndex);
    NSLog(@"user id:%d",kACEUserIDFromTable);
    
    // studentInformation = [StudentDatabase getStudentDetailsForUser:[NSString stringWithFormat:@"%d",5]];
    studentInformation = [StudentDatabase getStudentDetailsForUser:kACEUserIDFromTable];
    if (NEGATIVE_Value<currentIndex)
    {
        
        for(UIImageView * imag in carousel.currentItemView.subviews)
        {
            if([imag isKindOfClass:[UIView class]]&& imag.tag==3467)
            {
                imag.image=[UIImage imageNamed:[NSString stringWithFormat:@"In_Active_slide.png",currentIndex]];
                imag.frame = CGRectMake(0,0,116,124);
                UIImageView  *currentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"user%d.png",currentIndex]]];
                currentImage.frame = CGRectMake(25, 10, 60, 65);
                currentImage.tag=3467;
                
                [imag addSubview:currentImage];
                imag.layer.doubleSided = NO;                
            }
        }
        
        
        
    }
    
    if ([studentInformation count]==0)
    {
        noResultFound.hidden = NO;
    }
    else
    {
     
        

       [listOfCurrilum reloadData];

        noResultFound.hidden = YES;
        NSString *studentIDText =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:currentIndex] valueForKey:@"studentID"]];
        curriculamInformationArray = [StudentDatabase getCarriculamDetailsForStudent:[NSString stringWithFormat:@"%@",studentIDText]];

        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"curriculamObjective" ascending:TRUE];
        [curriculamInformationArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        if(curriculamArray) curriculamArray = nil;
        curriculamArray = [[NSMutableArray alloc] init];
         [listOfCurrilum reloadData];
        if ([curriculamInformationArray count]==0) 
        {
            
            [listOfCurrilum reloadData];
            noResultFoundInCurriculam.hidden = NO;
        }
        
        else{
            noResultFoundInCurriculam.hidden = YES;
            
            for (int i =0; i<[curriculamInformationArray count]; i++) 
            {
                
                
                NSString *studentCarriculamNameText =[NSString stringWithFormat:@"%@",[[curriculamInformationArray objectAtIndex:i] valueForKey:@"curriculamName"]];
                NSString *studentCarriculamObjectiveText =[NSString stringWithFormat:@"%@",[[curriculamInformationArray objectAtIndex:i] valueForKey:@"curriculamType"]];
                NSString *studentCurriculamTypeText =[NSString stringWithFormat:@"%@",[[curriculamInformationArray objectAtIndex:i] valueForKey:@"curriculamObjective"]];
                
                [listOfCurrilum reloadData];
                
                if(curriculamItemList)curriculamItemList=nil;
                
                curriculamItemList = [[curriculamListItem alloc] init];
                curriculamItemList.curriculamName = studentCarriculamNameText;
                curriculamItemList.curriculamType = studentCarriculamObjectiveText;
                curriculamItemList.curriculamObjective = studentCurriculamTypeText;    
                [curriculamArray addObject:curriculamItemList];
                
                [listOfCurrilum reloadData];
                
            }
        }
    } 

    NSString *timerSet = kLastUser;
    NSUserDefaults *timerSetValue = [NSUserDefaults standardUserDefaults];
    [timerSetValue setValue:timerSet forKey:kPosition];
    [timerSetValue synchronize];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kPosition] isEqualToString:@"1"]) {
        
        [carousel scrollToItemAtIndex:[studentInformation count]-1 duration:0];
        [carousel reloadData];
    }
    kLastUser = @"0";


    }


-(void)carouselDidScroll:(iCarousel *)_carousel
{
    NSInteger currentIndex = carousel.currentItemIndex;
    if (NEGATIVE_Value<_carousel.currentItemIndex)
    {

        for(UIImageView * imag in carousel.currentItemView.subviews)
        {
            if([imag isKindOfClass:[UIView class]]&& imag.tag==3467)
            {
                imag.image=[UIImage imageNamed:[NSString stringWithFormat:@"slide.png",currentIndex]];
                imag.frame = CGRectMake(0,0,116,124);
                UIImageView  *currentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"user%d.png",currentIndex]]];
                currentImage.frame = CGRectMake(25, 10, 60, 65);
                currentImage.tag=3467;
                
                [imag addSubview:currentImage];
                imag.layer.doubleSided = NO;                 
         //  [listOfCurrilum reloadData];
            }
        }
        
    }
  // kLastUser = @"0";
}


- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return ITEM_SPACING;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    noResultFound.hidden = YES;
    noResultFoundInCurriculam.hidden = YES;
    NSString *navigationBarTitle = kApplicationName;
    self.view.backgroundColor =UIColorFromRGB(0xe7e6eb);
    self.carousel.backgroundColor = UIColorFromRGB(0xe7e6eb);
    self.navigationController.navigationBar.topItem.title = navigationBarTitle;
    carousel.type = iCarouselTypeCoverFlow;
    self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x2eb5e4);
  listOfCurrilum.bounces = NO;
  
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
      UIBarButtonItem *addStudent = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self 
     action:@selector(addStudent)];
 //  UIBarButtonItem *addStudent = [[UIBarButtonItem alloc] initWithTitle:@"Add Student" style:UIBarButtonItemStylePlain target:self action:@selector(addStudent)];
    self.navigationItem.rightBarButtonItem = logoutButton; 
    self.navigationItem.leftBarButtonItem = addStudent;
	
}


//Call AddStudent class to add student in carrousal view
-(void)addStudent{
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {
            AddStudentPage *reference = [[AddStudentPage alloc] initWithCarousel:carousel];
            reference.delegate = self;
     UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:reference];
    
    [self.parentViewController presentModalViewController:navController4 animated:YES];
    //[self.navigationController pushViewController:reference animated:YES];
  }
        else{
            
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:kInternetConnectionMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alt show];
        }
    
}


- (void)AddStudentPageDidAddedStudents:(AddStudentPage*)studentPage
{
    [carousel reloadData];
    [listOfCurrilum reloadData];
    
    if ([studentInformation count] > 0) {
        NSString *timerSet = kLastUser;
        NSUserDefaults *timerSetValue = [NSUserDefaults standardUserDefaults];
        [timerSetValue setValue:timerSet forKey:kPosition];
        [timerSetValue synchronize];
        kLastUser = @"1";
        [carousel scrollWithoutContentChangeToItemAtIndex:0];
        [carousel reloadData];
        [self carouselDidEndScrollingAnimation:carousel];
        [carousel scrollToItemAtIndex:([studentInformation count] - 1) animated:YES];
    }
    
}

//Logout Method

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



//R
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    //   NSLog(@"Curriculam List Array Count = %i",[curriculamArray count]);
    return [curriculamArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"CrriculaCell";
    tableView.bounces=NO;
    
    curriculaListView *cell = (curriculaListView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[curriculaListView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    
    //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    {
        //MyActiveSessions *activeStudentSessions=[myActiveSessionsArray objectAtIndex:indexPath.row];
        curriculamListItem *curriculamListForTable = [curriculamArray objectAtIndex:indexPath.row];
        
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
        cell.NamedPicture.text  = curriculamListForTable.curriculamName;
        cell.Type.text = curriculamListForTable.curriculamType;
        cell.Objective.text = curriculamListForTable.curriculamObjective;
    }
    
    return cell;
}



#pragma mark - Table view delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSInteger currentIndex = carousel.currentItemIndex;
    
    //for All kACEStudentID , kStudentCurriculamID
    
    //kStudentCurriculamID
    
    //for SA   kSAStuCurriCulumID
    //for TA   kTACurrentCurriculamId
    // kACEStudentID=[NSString stringWithFormat:@"%@",kACEUserIDFromTable];
   //  MyActiveSessions *activeStudentSessions=[myActiveSessionsArray objectAtIndex:indexPath.row];
   

 // MyActiveSessions *activeStudentSessions =[[MyActiveSessions alloc]init];
    if ([myActiveSessionsArray count]>=10) {
        
                NSLog(@"Array Count:%d",[myActiveSessionsArray count]);
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"You have reached the limit of 10 active sessions. Please finish one session in order to add another." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alt show];
        NSIndexPath *tableSelection = [listOfCurrilum indexPathForSelectedRow];
        [listOfCurrilum deselectRowAtIndexPath:tableSelection animated:NO];
    }
    else{
        
      
     kActiveStudentImageName=[NSString stringWithFormat:@"user%d.png",currentIndex];
        
        isNewSessionStartType=newSession;
        
        //NSInteger currentIndex = carousel.currentItemIndex;
        
        NSString *studentIDText =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:currentIndex] valueForKey:@"studentID"]];
        currentSessionStudentName =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:currentIndex] valueForKey:@"studentName"]];
        kACEStudentID = studentIDText;
        
        curriculamInformationArray = [StudentDatabase getCarriculamDetailsForStudent:[NSString stringWithFormat:@"%@",studentIDText]];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"curriculamObjective" ascending:TRUE];
        [curriculamInformationArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        currentSessionSelectionType =[NSString stringWithFormat:@"%@",[[curriculamInformationArray objectAtIndex:indexPath.row] valueForKey:@"curriculamType"]];
        currentSessionCurriculumName =[NSString stringWithFormat:@"%@",[[curriculamInformationArray objectAtIndex:indexPath.row] valueForKey:@"curriculamName"]];
        currentSessionStudentCurriculumId =[NSString stringWithFormat:@"%@",[[curriculamInformationArray objectAtIndex:indexPath.row] valueForKey:@"studentCurriculamID"]];
        currentSessionStuCurriculumId  =[NSString stringWithFormat:@"%@",[[curriculamInformationArray objectAtIndex:indexPath.row] valueForKey:@"stuCurriculamID"]];
        
        
        kStudentCurriculamID = [currentSessionStudentCurriculumId intValue];
        kStuCuriculumId= currentSessionStuCurriculumId;
        
        
        kTACurrentCurriculamId = [[StudentDatabase getTACurricilumID:[currentSessionStuCurriculumId intValue]] intValue];
       //  currentSessionType = currentSessionSelectionType;
        //[StudentDatabase getTACurricilumID:kStudentCurriculamID];
        // kStudentCurriculamID
       NSString *versionMatch = [StudentDatabase   isVersionMatchedCheck:[kStuCuriculumId intValue]];
        
      if (versionMatch.length !=0 && [versionMatch isEqualToString:@"false"]) {

           UIAlertView *alt =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"This curriculum has been updated. Please sync data before you start a new session." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
          [alt  show];
          NSIndexPath *tableSelection = [listOfCurrilum indexPathForSelectedRow];
          [listOfCurrilum deselectRowAtIndexPath:tableSelection animated:NO];
        }
       else{
            kActiveStudentSessionId =[NSString stringWithFormat:@"%d",[StudentDatabase GetActiveSessionIdForSATAIT:[currentSessionStuCurriculumId intValue]]];
            if ([currentSessionSelectionType isEqualToString:@"SA"]) {
                activeSessionCountForSA = [StudentDatabase SAActiveSessionCount:[currentSessionStuCurriculumId intValue]];
               
                
                if (activeSessionCountForSA ==1) {
                    
                    currentSessionType=typeSA;
                    int activeSessionIdValue = [StudentDatabase activeSessionIdForSATAIT:[currentSessionStuCurriculumId intValue]];
                    NSMutableArray *oldDataArry=[StudentDatabase getSAOldSessionDetailsForActiveSessionId:[NSString stringWithFormat:@"%d",activeSessionIdValue ]];
                    
//                    int tp=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalp"]intValue];
//                    int tpP=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalpP"]intValue];
//                    int tm=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalm"]intValue];
//                    int tmP=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalmP"]intValue];
//                    int tNR=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalNR"]intValue];
                    
                    //  kSATrialNumberForOldsession=tp+tpP+tm+tmP+tNR;
                    kSATrialNumberForOldsession=[[StudentDatabase getSAOldSessionTrialCount:[NSString stringWithFormat:@"%d",activeSessionIdValue ]]intValue];
                    if(kSATrialNumberForOldsession==0){
                        kSATrialNumberForOldsession=1;
                        
                    }
                    
                    kSAActiveSessionID=[NSString stringWithFormat:@"%d",activeSessionIdValue ];
                    kCurrentActiveStudentName=currentSessionStudentName;
                    kCurrentActiveCurriculumName=currentSessionCurriculumName;
                    
                    
                    
                     [[NSUserDefaults standardUserDefaults]setValue:[[oldDataArry objectAtIndex:0]valueForKey:@"sublevelId"]forKey:@"sasublevelid"];
                    
                    kSASubLevelID=[[[oldDataArry objectAtIndex:0]valueForKey:@"sublevelId"]intValue];
                    kSATrialTypeID=[[oldDataArry objectAtIndex:0]valueForKey:@"mstTrialtypeId"];
                    kSAStepID=[[oldDataArry objectAtIndex:0]valueForKey:@"stepid"];
                     kisCurrentSessionSummarized=[[oldDataArry objectAtIndex:0]valueForKey:@"isSummarized"];
                    isNewSessionStartType=oldSession;
                    
                    
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:1];
                    
                }
                else{
                    currentSessionType = typeSA;
                    kSAStuCurriCulumID = [currentSessionStuCurriculumId intValue];
                    
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:1];
                    //[(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarControlerDelegateMethod];
                    // [self.tabBarController setSelectedIndex:1];        
                    
                    
                }
                
                
            }
            else if([currentSessionSelectionType isEqualToString:@"TA"]){
                activeSessionCountForTA = [StudentDatabase TAActiveSessionCount:[currentSessionStuCurriculumId intValue]];

                
                
                               
                if (activeSessionCountForTA ==1) {
                    // set TA parameters to activevate the Session.....
                    
                    currentSessionType=typeTA;
                    int activeSessionIdValue = [StudentDatabase activeSessionIdForSATAIT:[currentSessionStuCurriculumId intValue]];
                    NSMutableArray *oldDataArry=[StudentDatabase getTAOldSessionDetailsForActiveSessionId:[NSString stringWithFormat:@"%d",activeSessionIdValue ]];
                    kTAActiveSessionID=activeSessionIdValue;
                    kTACurrentCurriculamId=[[[oldDataArry objectAtIndex:0]valueForKey:@"tacuriculumid"]intValue];
                    kTAStepID=[[[oldDataArry objectAtIndex:0]valueForKey:@"stepid"]intValue];
                    kTATraingStepID=[[StudentDatabase getTATrainingStepName:[NSString stringWithFormat:@"%d",kTAStepID]] intValue];
                    kTAFsiBsiTsiName =[StudentDatabase getTATrainingStepName:[NSString stringWithFormat:@"%d",kTAStepID]];
                    kisCurrentSessionSummarized=[[oldDataArry objectAtIndex:0]valueForKey:@"isSummarized"];
                    kTAMstPromptStepId=[[[oldDataArry objectAtIndex:0]valueForKey:@"mstPromptID"] intValue];
                    isNewSessionStartType=oldSession;
                    
                    
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:1];
                    
                }
                else {
                    
                    kTACurrentCurriculamId=[[StudentDatabase getTACurricilumID:[currentSessionStuCurriculumId intValue]] intValue];
                    
                    currentSessionType = typeTA;
                    
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:1];
                }
                
                
                
                
                
            }
            
            else{
                
                // UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"IT Selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                //[alt show];
                currentSessionType = typeIT;
                kITStuCurriCulumID= [currentSessionStuCurriculumId intValue];
                
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:1];
                
            }  
            
            
            
            
        }

  }
            
   
    
        
}
- (CGFloat)tableView:(UITableView *)tableView 
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
    tempView.backgroundColor=[UIColor blackColor];
    // tempView.backgroundColor = UIColorFromRGB(0x2eb5e4);
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0,300,22)];
    tempLabel.backgroundColor=[UIColor clearColor]; 
    tempLabel.shadowColor = [UIColor clearColor];
    //tempLabel.shadowOffset = CGSizeMake(0,2);
    tempLabel.textColor = [UIColor whiteColor]; //here u can change the text color of header
    tempLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    tempLabel.font = [UIFont boldSystemFontOfSize:12];
    tempLabel.text=@"Student Curriculum";
    
    [tempView addSubview:tempLabel];
    
    return tempView;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 40;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

#pragma mark- Program Comman Methods

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    if(myActiveSessionsArray)myActiveSessionsArray=nil;
    myActiveSessionsArray=[StudentDatabase getAllActiveSessions];
    [self carouselDidEndScrollingAnimation:carousel];
    
   // [listOfCurrilum reloadData];

    
    NSIndexPath *tableSelection = [listOfCurrilum indexPathForSelectedRow];
    [listOfCurrilum deselectRowAtIndexPath:tableSelection animated:NO];
    }

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [listOfCurrilum reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait 
    || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;

//return (interfaceOrientation = UIInterfaceOrientationPortraitUpsideDown);
}



@end
