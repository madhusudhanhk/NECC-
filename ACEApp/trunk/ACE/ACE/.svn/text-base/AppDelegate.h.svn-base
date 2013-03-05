//
//  AppDelegate.h
//  ACE
//
//  Created by Aditi technologies on 7/4/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h> 
#import "iCarousel.h"
@class LoginPage;
@class LocationController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    
    
    NSString *databaseName;
    NSString *databasePath;
    iCarousel *carousel;
    NSMutableArray *studentInformation;
    NSMutableArray * curriculamInformationArray;
    NSTimer *timer;
    NSString *_sessionID;

    NSDictionary *getDetails;
   
    UINavigationController *locationNavController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *getDetails;
//@property (nonatomic, readonly) NSString *serialNumber;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) LoginPage *viewController;
@property (strong, nonatomic) LocationController *locationViewController;
//@property (nonatomic, retain) NSTimer * timer;
-(void)tabBarControlerDelegateMethod;
//-(NSMutableArray*)selectedCurriculamTypeFromList:(NSString *)curriculamTypeName:(NSString *)curriculamId: (NSString *) currentStudentId;
-(void)changeTabBarButton:(int)BarButtonIndex;
//-(void)logout;
-(NSString *)timedifference:(NSString *)loginTime;
- (NSString *)getCurrentDate;


@end
