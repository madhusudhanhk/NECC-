//
//  IT_Setup_GridCustomCell.m
//  ACE
//
//  Created by Test on 25/07/2012.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "IT_Setup_GridCustomCell.h"

@implementation IT_Setup_GridCustomCell

@synthesize WeekEndingLabel;
@synthesize TrialTypeLabel;
@synthesize totalOppLabel;
@synthesize mPP;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
