//
//  XTFirstViewController.h
//  NECC
//
//  Created by Aditi on 18/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "iCarousel.h"
#import "curriculaListView.h"
#import "curriculamListItem.h"
#import "CurrentSession.h"
#import "AddStudentPage.h"


@interface XTFirstViewController : UIViewController<iCarouselDataSource, iCarouselDelegate,UIAlertViewDelegate>{
    
    NSMutableArray *listOfItems;
    NSMutableArray *listOfItems1;
    UINib *cellLoader;
    iCarousel *curview;
    IBOutlet UITableView *listOfCurrilum;
    curriculamListItem *curriculamItemList;
    NSMutableArray *curriculamArray;
    NSMutableArray *curriculamInformationArray;
    NSMutableArray *curriculamTypeArray;
    NSMutableArray *curriculamObjectiveArray;
    bool activeSessionCountForTA;
    bool activeSessionCountForSA;
    IBOutlet UILabel *noResultFound;
    IBOutlet UILabel *noResultFoundInCurriculam;
    NSMutableArray *myActiveSessionsArray;
    CurrentSession *currentSession;
    
    
    
    
    
    
    
}

@property (nonatomic,retain) IBOutlet UITableView *listOfCurrilum;
@property (nonatomic, retain) IBOutlet iCarousel *carousel;
//@property (nonatomic, retain) curriculamListItem *curriculamItemList;

@property (nonatomic, retain) curriculaListView *curriculamList;
@property (nonatomic, readonly) NSInteger currentItemIndex;
@property (nonatomic, retain, readonly) UIView *currentItemView;
-(void)addStudent;
-(void)logOut;
- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel;
- (void)beginPush;
- (void) showProgressHudForManualInView:(UIView*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG;
- (void) hideManualSyncProgressHudInView:(UIView*)aView;
@end
