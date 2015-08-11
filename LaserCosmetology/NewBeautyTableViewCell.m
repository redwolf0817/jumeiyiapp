//
//  NewBeautyTableViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "NewBeautyTableViewCell.h"
@implementation NewBeautyTableViewCell

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
        
        self.headimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.height - 10, self.bounds.size.height - 10)];
        [self addSubview:self.headimage];
        
        self.productname = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.height - 10 + 10, 10, 150, 20)];
        self.productname.font =[UIFont systemFontOfSize:15];
        [self addSubview:self.productname];
        
        self.contents = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.height - 10 + 10, self.productname.frame.origin.y + 20, 150, 20)];
        self.contents.font =[UIFont systemFontOfSize:13];
        [self addSubview:self.contents];
    }
    
    return self;
}

@end
