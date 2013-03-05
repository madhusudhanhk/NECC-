//
//  learnMore.m
//  ACE
//
//  Created by Test on 08/08/2012.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "learnMore.h"
#import "LoginPage.h"
//#include "DiapController.h"

@implementation learnMore
@synthesize FirstScrollView;
@synthesize learnMore;
@synthesize pageControl;
//@synthesize imageView;

const CGFloat kScrollObjHeight	= 400.0;
const CGFloat kScrollObjWidth	= 268.0;
const NSUInteger kNumImages		= 9;

- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [FirstScrollView subviews];
	
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
	[FirstScrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [FirstScrollView bounds].size.height)];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(IBAction)cancel:(id)sender{
    
    
 [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.learnMore.tintColor =  UIColorFromRGB(0x2eb5e4);
    
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
   // self.view.backgroundColor = [UIColor redColor];
	// 1. setup the scrollview for multiple images and add it to the view controller
	//
	// note: the following can be done in Interface Builder, but we show this in code for clarity
	[FirstScrollView setBackgroundColor:[UIColor blackColor]];
	[FirstScrollView setCanCancelContentTouches:NO];
	FirstScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	FirstScrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	FirstScrollView.scrollEnabled = YES;
    FirstScrollView.showsHorizontalScrollIndicator = NO;
    FirstScrollView.showsVerticalScrollIndicator = NO;
    pageControl.numberOfPages = 9;
    pageControl.currentPage = 0;
	FirstScrollView.pagingEnabled = YES;
	
	NSUInteger i;
	for (i = 1; i <= kNumImages; i++)
	{
		NSString *imageName = [NSString stringWithFormat:@"%d.png", i];
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
		CGRect rect = imageView.frame;
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		imageView.frame = rect;
		imageView.tag = i;	
		[FirstScrollView addSubview:imageView];
		
	}
	
	[self layoutScrollImages];  
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = FirstScrollView.frame.size.width;
    int page = floor((FirstScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
