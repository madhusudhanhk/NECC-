//
//  AppDelegate.m
//  ACE
//
//  Created by Aditi technologies on 7/4/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "AppDelegate.h"
#import "XTFirstViewController.h"
#import "Options.h"
#import "LoginPage.h"
#import "AddStudentPage.h"
#import "ACEDataCommunicator.h"
#import "JSON.h"
#import "ActiveSession.h"
#import "LocationController.h"
#import "CurrentSession.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "ACEUTILMethods.h"
#import "ACESyncManager.h"

//#define dict_(...) [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]

@interface AppDelegate()
-(void)databaseSetUp;
- (NSMutableArray *)myACEStudentList;
-(void) checkAndCreateDatabase;
//-(void)Authenticate;
//-(void)mySchoolName;
-(void)createPathForActiveSessionPlist;
- (void)registerForNetworkActivity:(BOOL)registr;

@property (strong) Reachability *rechability;

@end

@implementation AppDelegate
@synthesize viewController;
@synthesize getDetails;
@synthesize locationViewController;
@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize rechability;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasRunBefore = [defaults boolForKey:@"FirstRun"];
    [self databaseSetUp];
     [self performSelectorOnMainThread:@selector(createPathForActiveSessionPlist) withObject:nil waitUntilDone:YES];  
    
    //if application launch before
    if (hasRunBefore) {
        //checl if location url is selected or not
         if([[NSUserDefaults standardUserDefaults] objectForKey:key_URL] == nil) 
         {
             [defaults setBool:YES forKey:@"FirstRun"];
             self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
             self.locationViewController = [[LocationController   alloc]initWithNibName:@"LocationController" bundle:nil];
             UINavigationController *navController5 = [[UINavigationController alloc] initWithRootViewController:locationViewController];
             self.window.rootViewController=navController5;
             [self.window makeKeyAndVisible];

         }
         else{
            
             
             //check for isLoggedOut value
             NSLog(@"IsloggedVale :%@",[[NSUserDefaults standardUserDefaults] objectForKey:kIsLoggedOut]);
             if ([[[NSUserDefaults standardUserDefaults] objectForKey:kIsLoggedOut] isEqualToString:@"true"]) 
             {
                 self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                 self.viewController = [[LoginPage alloc] initWithNibName:@"LoginPage" bundle:nil];
                 UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:viewController];
                 self.window.rootViewController = navController4;
                 [self.window makeKeyAndVisible];
 
             }
             else{
                 //check for location page button click
                   if([[[NSUserDefaults standardUserDefaults] objectForKey:kClickCheckInLocation] isEqualToString:@"0"])
                   {
                       self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                       
                       self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                       self.locationViewController = [[LocationController   alloc]initWithNibName:@"LocationController" bundle:nil];
                       UINavigationController *navController5 = [[UINavigationController alloc] initWithRootViewController:locationViewController];
                       self.window.rootViewController=navController5;
                       [self.window makeKeyAndVisible];

                   }
                   else
                   {
                       //check condiation for login page wheather it is already login or not
                       if ([[[NSUserDefaults standardUserDefaults] objectForKey:kClickCheckInLogin] isEqualToString:@"0"]) 
                       {
                           
                           self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                           
                           self.viewController = [[LoginPage alloc] initWithNibName:@"LoginPage" bundle:nil];
                           UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:viewController];
                           self.window.rootViewController = navController4;
                           [self.window makeKeyAndVisible];  
                           
                       }
                       else{
                           NSString *loginTime = [StudentDatabase getLoginTime:kACEUserIDFromTable];
                           NSLog(@"LoginTime:%@",loginTime);
                          // NSString *tm = loginTime;
                           //tm = [tm substringFromIndex:11];
                           // tm = [tm substringToIndex:[tm length] - 3];
                           //NSLog(@"Final:%@",tm);
                           [self    timedifference:loginTime]; 
                           NSString *timerValue= [[NSUserDefaults standardUserDefaults] objectForKey:kTimerValue];
                           NSString *time = [self    timedifference:loginTime];
                           NSLog(@"Timer Value:%@",timerValue);
                           
                           NSString *hh = time;
                           NSLog(@"Final:%@",hh);                           
                           hh = [hh substringToIndex:[hh length] - 3];
                           NSLog(@"Final:%@",hh); 
                           NSString *timerTimeSet = @"0";
                           NSUserDefaults *loginSet = [NSUserDefaults standardUserDefaults];
                           [loginSet setValue:timerTimeSet forKey:kClickLoginOnBackground];
                           [loginSet synchronize];
                           //check for time difference between current time and login time
                           if ([hh intValue] >= [kTimeDifference intValue] )
                           {
                               self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                               
                               self.viewController = [[LoginPage alloc] initWithNibName:@"LoginPage" bundle:nil];
                               UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:viewController];
                               self.window.rootViewController = navController4;
                               [self.window makeKeyAndVisible];
                               
                           }
                           else
                           {
                               [self tabBarControlerDelegateMethod]; 
                           }
                           
                       }
                       

                       
                   }
                }
            }
        
        }
    
    //Launch App but location not selected.
    else if (!hasRunBefore) {
            [defaults setBool:YES forKey:@"FirstRun"];
        // by default set kRecammondation to yes...
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] 
                                                     forKey:kRecammondation];
        
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.locationViewController = [[LocationController   alloc]initWithNibName:@"LocationController" bundle:nil];
            UINavigationController *navController5 = [[UINavigationController alloc] initWithRootViewController:locationViewController];
            self.window.rootViewController=navController5;
            [self.window makeKeyAndVisible];      
            [defaults synchronize];   
        NSString *isLoggedOut = @"0";
        NSUserDefaults *loggedValue = [NSUserDefaults standardUserDefaults];
        [loggedValue setValue:isLoggedOut forKey:kClickCheckInLocation];
        [loggedValue synchronize];
        NSString *loginClick = @"0";
        NSUserDefaults *loginValue = [NSUserDefaults standardUserDefaults];
        [loginValue setValue:loginClick forKey:kClickCheckInLogin];
        [loginValue synchronize];
        NSString *timerSet = @"8";
        NSUserDefaults *timerSetValue = [NSUserDefaults standardUserDefaults];
        [timerSetValue setValue:timerSet forKey:kTimerValue];
        [timerSetValue synchronize];
//        NSString *timerTimeSet = @"0";
//        NSUserDefaults *loginSet = [NSUserDefaults standardUserDefaults];
//        [loginSet setValue:timerTimeSet forKey:kClickLoginOnBackground];
//        [loginSet synchronize];
  
    }
    
    self.rechability = [Reachability reachabilityForInternetConnection];
    [self registerForNetworkActivity:YES];
    
    return YES; 
}
    

  
-(void)createPathForActiveSessionPlist{
    // Check if the kActiveStudentSessionPlistPath  has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the kActiveStudentSessionPlistPath and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:[kActiveStudentSessionPlistPath stringByExpandingTildeInPath]];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the kActiveStudentSessionPlistPath from the application to the users filesystem
	
	    
    NSMutableArray *ActiveSessionAyy=[[NSMutableArray alloc]init];
    
    [ActiveSessionAyy writeToFile:[kActiveStudentSessionPlistPath stringByExpandingTildeInPath] atomically:YES];
    
    ActiveSessionAyy=nil;
}
-(NSString *)timedifference:(NSString *)loginTime{
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm a"];  
    NSDate *date1 = [df dateFromString:loginTime];
    NSDate *date2 = [df dateFromString:[self getCurrentDate]];
    NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
    
    
    int hours = (int)interval / 3600;             // integer division to get the hours part
    int minutes = (interval - (hours*3600)) / 60;
    //int seconds = (interval -(minutes*3600))/60;
    // interval minus hours part (in seconds) divided by 60 yields minutes
    NSString *timeDiff = [NSString stringWithFormat:@"%d:%02d", hours, minutes];
//        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
//        NSDateComponents *components = [gregorianCalendar components:unitFlags
//                                                            fromDate:date1
//                                                              toDate:date2
//                                                             options:0];
//    
    
      NSLog(@"Time Difference:%@",timeDiff);
    //NSLog(@"Time Difference:%@",components);
    return timeDiff;
    
}
- (NSString *)getCurrentDate
{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init]; 
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];  
    
    NSLog(@"Current Time:%@",[DateFormatter stringFromDate:[NSDate date]]);
    return ([DateFormatter stringFromDate:[NSDate date]]);
    
}


-(void)databaseSetUp{
        // Setup some globals
        databaseName = kDatabaseName;
        
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        [self checkAndCreateDatabase];
        
        
        
    }
-(void) checkAndCreateDatabase{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	
}

- (NSMutableArray *)myACEStudentList{
    
    
    
    // Setup some globals
    NSString  *databaseName1 = kDatabaseName;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath1 = [documentsDir stringByAppendingPathComponent:databaseName1];
    
    
    // Setup the database object
	sqlite3 *database;
    
    if (sqlite3_open([databasePath1 UTF8String], &database) == SQLITE_OK) 
    {
        const char* sqlStatement = "Select Name,TeamName, ACEUserId from ACEStudent";
        sqlite3_stmt* statement;
        
        if( sqlite3_prepare_v2(database, sqlStatement, -1, &statement, NULL) == SQLITE_OK ) 
        {
            while( sqlite3_step(statement) == SQLITE_ROW ){
              NSString *sID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(database) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
    return nil;    
}


-(void)tabBarControlerDelegateMethod{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *Curricula = [[XTFirstViewController alloc] initWithNibName:@"XTFirstViewController" bundle:nil];
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:Curricula];
    UIViewController *CurrentSessionSetup = [[CurrentSession alloc] initWithNibName:@"CurrentSession" bundle:nil];
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:CurrentSessionSetup];
    UIViewController *myActiveSeeion = [[ActiveSession alloc] initWithNibName:@"ActiveSession" bundle:nil];
    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:myActiveSeeion];
    UIViewController *Option= [[Options alloc] initWithNibName:@"Options" bundle:nil];
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:Option];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2,navController3,navController4, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}

/*
-(NSMutableArray*)selectedCurriculamTypeFromList:(NSString *)curriculamTypeName:(NSString *)curriculamId: (NSString *) currentStudentId{
    
    
    NSInteger currentIndex = carousel.currentItemIndex;
     studentInformation = [StudentDatabase getStudentDetailsForUser:[NSString stringWithFormat:@"%d",3]];
    NSString *studentIDText =[NSString stringWithFormat:@"%@",[[studentInformation objectAtIndex:currentIndex] valueForKey:@"studentID"]];
    
    curriculamInformationArray = [StudentDatabase getCarriculamDetailsForStudent:[NSString stringWithFormat:@"%@",studentIDText]];
//NSString *studentCarriculamObjectiveText =[NSString stringWithFormat:@"%@",[[curriculamInformationArray objectAtIndex:indexPath.row] valueForKey:@"curriculamType"]];
    
    return nil;
}
*/


-(void)changeTabBarButton:(int)BarButtonIndex{
    
    [self.tabBarController setSelectedIndex:BarButtonIndex];
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kClickLoginOnBackground] != 0)  {
        
        NSString *loginTime = [StudentDatabase getLoginTime:kACEUserIDFromTable];
        NSString *time = [self    timedifference:loginTime];
        NSString *hh = time;
        hh = [hh substringToIndex:[hh length] - 3];
        
        //check for time difference between current time and login time
        if ([hh intValue] >= [kTimeDifference intValue] ) {
            self.viewController = [[LoginPage alloc] initWithNibName:@"LoginPage" bundle:nil];
            UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:viewController];
            self.window.rootViewController = navController4;
            [self.window makeKeyAndVisible];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

//Auth Sync Methods
- (void)registerForNetworkActivity:(BOOL)registr
{
    if (registr) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(networkStatusChanged:) 
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        [self.rechability startNotifier];
    }else{
        [self.rechability stopNotifier];
        [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                        name:kReachabilityChangedNotification
                                                      object:nil];
    }
    
}

- (void)networkStatusChanged:(NSNotification*)aNotification
{
    if([self.rechability isReachable]){
        //If Reachable then push the data to server.
        int UnsyncCount = [ACEUTILMethods getFinishedSessionsCount];
        if (UnsyncCount > 0) {
            ACESyncManager *syncManager = [ACESyncManager getSyncManager];
            [syncManager syncCurriculumWithServer];
        }
    }
}

@end
