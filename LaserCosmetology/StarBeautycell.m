//
//  StarBeautycell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "StarBeautycell.h"

@implementation StarBeautycell

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
        
        self.projectname = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, self.bounds.size.width - 20, 20)];
        self.projectname.alpha = 0.8;
        [self addSubview:self.projectname];
    
        self.projectcontents = [[UILabel alloc] initWithFrame:CGRectMake(20, 30,  self.bounds.size.width - 40, 35)];
        self.projectcontents.font = [UIFont systemFontOfSize:14];
        self.projectcontents.alpha = 0.8;
        self.projectcontents.numberOfLines = 2;
        [self addSubview:self.projectcontents];
    }
    
    return self;
}
@end
