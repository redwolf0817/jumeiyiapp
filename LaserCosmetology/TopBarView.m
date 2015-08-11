//
//  TopBarView.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/11.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "TopBarView.h"

@implementation TopBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topbar = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:topbar];
        
        UIImageView *topbarimage = [[UIImageView alloc] initWithFrame:self.bounds];
        topbarimage.image = [UIImage imageNamed:@"首页9"];
        topbarimage.userInteractionEnabled = YES;
        [topbar addSubview:topbarimage];
        
        
        
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
