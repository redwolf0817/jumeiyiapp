//
//  ProjectpersentTableViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/13.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "ProjectpersentTableViewCell.h"

@implementation ProjectpersentTableViewCell

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
        
        self.backimage = [[UIImageView alloc] init];
        self.backimage.image = [UIImage imageNamed:@"项目目录2_02l"];
        [self addSubview:self.backimage];
        
        self.proname = [[UILabel alloc] init];
        self.proname.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.proname];
        
    }
    return self;
}


@end
