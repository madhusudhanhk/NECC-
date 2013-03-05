//
//  ActiveSessionCustomCell.h
//  ACE
//
//  Created by Aditi technologies on 7/31/12.
//  Copyright (c) 2012 MySpace. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ActiveSessionCustomCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView *studentImage;
@property(nonatomic,strong)IBOutlet UILabel *studentName;
@property(nonatomic,strong)IBOutlet UILabel *curiculumName;
@property(nonatomic,strong)IBOutlet UILabel *typeDiscription;

@end
