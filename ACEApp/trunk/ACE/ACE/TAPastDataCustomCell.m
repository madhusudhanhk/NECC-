//
//  TAPastDataCustomCell.m
//  ACE
//
//  Created by Aditi technologies on 7/18/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import "TAPastDataCustomCell.h"

@implementation TAPastDataCustomCell
@synthesize datelbl;
@synthesize trialTypelbl;
@synthesize FSIlbl;
@synthesize trainingSteplbl;
@synthesize promptStep;
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
