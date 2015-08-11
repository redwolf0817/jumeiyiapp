//
//  detailsTableViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "detailsTableViewCell.h"

@implementation detailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contents = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:self.contents];
    }
    return self;
}

@end
