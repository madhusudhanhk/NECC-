//
//  ActiveSession.m
//  ACE
//
//  Created by Aditi technologies on 7/31/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "ActiveSession.h"
#import "ActiveSessionCustomCell.h"
#import "AppDelegate.h"
#import "ReachabilityViewController.h"
#import "LoginPage.h"
#import "MyActiveSessions.h"
#import "ACESyncManager.h"
#import "MBProgressHUD.h"

#define kcurriculumTypeSA @"1"
#define kcurriculumTypeTA @"3"
#define kcurriculumTypeIT @"2"

@interface ActiveSession()

-(void)customNavigationitems;
-(void)logOut;
-(NSString *)getImageforActiveStudentSessionId:(NSString *)activeStudentSessionId;
- (void)beginPush;
- (void) showProgressHudForManualInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideManualSyncProgressHudInView:(UIView*)aView;
  
@end

@implementation ActiveSession
@synthesize noRecordLable;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
       
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = NSLocalizedString(@"Active Sessions", @"Active Sessions");
        self.tabBarItem.image = [UIImage imageNamed:@"Tab_ActiveSession_icon"];
        self.navigationItem.title=kApplicationName;
        
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)customNavigationitems{
    
     self.navigationController.navigationBar.tintColor=UIColorFromRGB(0x2eb5e4);
   
    // self.navigationController.navigationBar.tintColor=[UIColor clearColor];
    
    UIBarButtonItem *Logout =[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.rightBarButtonItem=Logout;
    
    
}

    -(void)logout{
       // ReachabilityViewController *connection = [[ReachabilityViewController alloc]init];
        
        
//        if ([connection checkForWIFIConnection]==NO) {
//            
//        }
//        else{
            NSString *isLoggedOut = @"true";
            NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
            [loggedValue setValue:isLoggedOut forKey:kIsLoggedOut];
            [loggedValue synchronize];
            LoginPage *reference = [[LoginPage alloc]initWithNibName:@"LoginPage" bundle:[NSBundle mainBundle]];
            UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:reference];
            [self.parentViewController presentModalViewController:navController4 animated:YES];
       // }
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


-(NSString *)getImageforActiveStudentSessionId:(NSString *)activeStudentSessionId{
    
    
   // NSLog(@"activeStudentSessionId...%@",activeStudentSessionId);
    
    NSString *imageName;
      NSMutableArray *myActivesessions=[[NSMutableArray alloc]initWithContentsOfFile:[kActiveStudentSessionPlistPath stringByExpandingTildeInPath]];
    
    for(int i=0;i<myActivesessions.count;i++){
        
        
        if([[[myActivesessions objectAtIndex:i]valueForKey:@"ActiveStudentSessionId"]isEqualToString:activeStudentSessionId]){
            
            imageName=[[myActivesessions objectAtIndex:i]valueForKey:@"imagename"];
            
        }
    }
 
    myActivesessions=nil;
    return imageName;
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        //self.tableView.backgroundColor =UIColorFromRGB(0xe7e6eb);
    [self customNavigationitems];
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(myActiveSessionsArray)myActiveSessionsArray=nil;
    myActiveSessionsArray=[StudentDatabase getAllActiveSessions];
    if(myActiveSessionsArray.count==0){
        
        [self.view addSubview:self.noRecordLable];
        
        NSLog(@"no active seesion frame ...%@",NSStringFromCGRect(noRecordLable.frame));
        
        self.tableView.separatorColor=[UIColor clearColor];
          self.view.backgroundColor=UIColorFromRGB(0xe7e6eb);
    }else{
        
        [self.noRecordLable removeFromSuperview];
        self.tableView.separatorColor=[UIColor lightGrayColor];
        
        self.view.backgroundColor=[UIColor whiteColor];
        
        
        
        
    }
    [self.tableView reloadData];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [myActiveSessionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ActiveSessionCustomCell";
    
    ActiveSessionCustomCell *cell = (ActiveSessionCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) 
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ActiveSessionCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    MyActiveSessions *activesessions=[myActiveSessionsArray objectAtIndex:indexPath.row];
    
    
    cell.curiculumName.text=activesessions.curiculumName;
    cell.studentName.text=activesessions.studentName;
    cell.studentImage.image=[UIImage imageNamed:[self getImageforActiveStudentSessionId:activesessions.activeStudentsessionId]];
    
    if([activesessions.curiculumType isEqualToString:@"1"]){
        
        cell.typeDiscription.text=[NSString stringWithFormat:@"Sublevel : %@",activesessions.discription];
        
    }if([activesessions.curiculumType isEqualToString:@"2"]){
      
        cell.typeDiscription.text=[NSString stringWithFormat:@"Context : %@",activesessions.discription];
    
    }else{
       // cell.typeDiscription.text=nil;
        
    }
    
    
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  70;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [self showProgressHudInView:[[UIApplication sharedApplication] keyWindow] withTitle:@"Loading Location..." andMsg:nil];
    
    // get current date/time
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
   /// [dateFormatter release];
    NSLog(@"User's current time in their preference format 1 :%@",currentTime);
    
    //NSLog(@"Array at index:%@",indexPath.row);
    MyActiveSessions *activeStudentSessions=[myActiveSessionsArray objectAtIndex:indexPath.row];
    NSLog(@"Array at index:%@",[myActiveSessionsArray objectAtIndex:indexPath.row]);
    kACEStudentID=activeStudentSessions.aceStudentId;
    kStuCuriculumId=activeStudentSessions.stucurrilumId;
    kActiveStudentSessionId=activeStudentSessions.activeStudentsessionId;
    
    if([activeStudentSessions.curiculumType isEqualToString:kcurriculumTypeSA]){
        
       // NSLog(@"curriculum type ....%@",activeStudentSessions.curiculumType);
        
        
        
        // set SA parameters to activevate the Session.....
        
        currentSessionType=typeSA;
        
         NSMutableArray *oldDataArry=[StudentDatabase getSAOldSessionDetailsForActiveSessionId:activeStudentSessions.activeSessionId];
        
      //  int tp=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalp"]intValue];
     //   int tpP=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalpP"]intValue];
//int tm=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalm"]intValue];
     //   int tmP=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalmP"]intValue];
      //  int tNR=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalNR"]intValue];
        
      //  kSATrialNumberForOldsession=tp+tpP+tm+tmP+tNR;
        kSATrialNumberForOldsession=[[StudentDatabase getSAOldSessionTrialCount:activeStudentSessions.activeSessionId]intValue];
        if(kSATrialNumberForOldsession==0){
            kSATrialNumberForOldsession=1;
            
        }
        
        kSAActiveSessionID=activeStudentSessions.activeSessionId;
        kCurrentActiveStudentName=activeStudentSessions.studentName;
        kCurrentActiveCurriculumName=activeStudentSessions.curiculumName;
        
        
        [[NSUserDefaults standardUserDefaults]setValue:[[oldDataArry objectAtIndex:0]valueForKey:@"sublevelId"]forKey:@"sasublevelid"];
        
        
        kSASubLevelID=[[[oldDataArry objectAtIndex:0]valueForKey:@"sublevelId"]intValue];
        kSATrialTypeID=[[oldDataArry objectAtIndex:0]valueForKey:@"mstTrialtypeId"];
        kSATrialTypeName=[StudentDatabase getTrialTypeNme:kSATrialTypeID];
        kSAStepID=[[oldDataArry objectAtIndex:0]valueForKey:@"stepid"];
        kisCurrentSessionSummarized=[[oldDataArry objectAtIndex:0]valueForKey:@"isSummarized"];
        
        
        
        
    }else if([activeStudentSessions.curiculumType isEqualToString:kcurriculumTypeTA]){

               // NSLog(@"curriculum type ....%@",activeStudentSessions.curiculumType);
        
        // set TA parameters to activevate the Session.....

        currentSessionType=typeTA;
          NSMutableArray *oldDataArry=[StudentDatabase getTAOldSessionDetailsForActiveSessionId:activeStudentSessions.activeSessionId];
        kTAActiveSessionID=[activeStudentSessions.activeSessionId intValue];
        kTACurrentCurriculamId=[[[oldDataArry objectAtIndex:0]valueForKey:@"tacuriculumid"]intValue];
        kTAStepID=[[[oldDataArry objectAtIndex:0]valueForKey:@"stepid"]intValue];
        kTATraingStepID=[[StudentDatabase getTATrainingStepName:[NSString stringWithFormat:@"%d",kTAStepID]] intValue];
        kTAFsiBsiTsiName =[StudentDatabase getTATrainingStepName:[NSString stringWithFormat:@"%d",kTAStepID]];
        kisCurrentSessionSummarized=[[oldDataArry objectAtIndex:0]valueForKey:@"isSummarized"];
        kTAMstPromptStepId=[[[oldDataArry objectAtIndex:0]valueForKey:@"mstPromptID"] intValue];
        
    }else if([activeStudentSessions.curiculumType isEqualToString:kcurriculumTypeIT]){
        
              //  NSLog(@"curriculum type ....%@",activeStudentSessions.curiculumType);
        
        currentSessionType=typeIT;
        
        NSMutableArray *oldDataArry=[StudentDatabase getITOldSessionDetailsForActiveSessionId:activeStudentSessions.activeSessionId];
        
      //  int tp=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalp"]intValue];
    //    int tpP=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalpP"]intValue];
     //   int tm=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalm"]intValue];
        
      //  int tNR=[[[oldDataArry objectAtIndex:0]valueForKey:@"totalNR"]intValue];
        
       // kITTrialNumberForOldsession=tp+tpP+tm+tNR;
        kITTrialNumberForOldsession=[[StudentDatabase getITOldSessionTrialCount:activeStudentSessions.activeSessionId]intValue];
        if(kITTrialNumberForOldsession==0){
            kITTrialNumberForOldsession=1;
        }
        kITActiveSessionId=activeStudentSessions.activeSessionId;
        kITContextName=[StudentDatabase getITContextName:[[oldDataArry objectAtIndex:0]valueForKey:@"contextid"]];
        kITContextId=[[oldDataArry objectAtIndex:0]valueForKey:@"contextid"];
        
        
        kCurrentActiveStudentName=activeStudentSessions.studentName;
        kCurrentActiveCurriculumName=activeStudentSessions.curiculumName;
        kisCurrentSessionSummarized=[[oldDataArry objectAtIndex:0]valueForKey:@"isSummarized"];

        
    }
    
    
    isNewSessionStartType=oldSession;
    
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] changeTabBarButton:1];
    

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


@end
