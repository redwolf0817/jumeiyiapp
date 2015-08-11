//
//  MoreGoodTableViewCell.m
//  聚美医
//
//  Created by fenghuang on 15/6/25.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MoreGoodTableViewCell.h"

@implementation MoreGoodTableViewCell

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
    
        self.BeGoodToBackImage = [[UIImageView alloc] init];
        [self addSubview:self.BeGoodToBackImage];
        
        self.xiaohengxian4 = [[UIImageView alloc] init];
        [self addSubview:self.xiaohengxian4];
        
        self.BeGoodToprojectName = [[UILabel alloc] init];
        [self addSubview:self.BeGoodToprojectName];
        
        self.morebtn = [[UIButton alloc] init];
        [self addSubview:self.morebtn];
        
        self.yifuwu = [[UILabel alloc] init];
        self.yifuwu.text = @"已服务";
        [self addSubview:self.yifuwu];
        
        self.persentsnumber = [[UILabel alloc] init];
        [self addSubview:self.persentsnumber];
        
        self.persents = [[UILabel alloc] init];
        self.persents.text = @"人";
        [self addSubview:self.persents];
        
        self.begoodatcontents = [[UILabel alloc] init];
        [self addSubview:self.begoodatcontents];
        
        self.shanchang = [[UILabel alloc] init];
        [self addSubview:self.shanchang];
        
        self.chuxian2 = [[UIImageView alloc] init];
        [self addSubview:self.chuxian2];
        
    }
    
    return self;
}

@end
