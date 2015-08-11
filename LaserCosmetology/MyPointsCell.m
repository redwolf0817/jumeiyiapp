//
//  MyPointsCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/5.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MyPointsCell.h"

@implementation MyPointsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backimage = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backimage.image = [UIImage imageNamed:@"huidi"];
        self.backimage.userInteractionEnabled = YES;
        [self addSubview:self.backimage];
        
        self.contents = [[UILabel alloc] init];
        self.contents.font = [UIFont systemFontOfSize:15];
        [self.backimage addSubview:self.contents];
        
        self.date = [[UILabel alloc] init];
        self.date.font = [UIFont systemFontOfSize:14];
        self.date.textColor = [UIColor redColor];
        self.date.alpha = 0.7;
        [self.backimage addSubview:self.date];
    
    }
    return self;
}
@end
