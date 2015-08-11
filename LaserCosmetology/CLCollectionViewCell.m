//
//  CLCollectionViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/6.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "CLCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation CLCollectionViewCell

- (id)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *subview = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:subview];
        
        self.font = 15;
        
        self.immagg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 160)];
        self.immagg.userInteractionEnabled = YES;
        [self addSubview:self.immagg];
        
        
        self.namelable = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height-(25 * 3), 80, 18)];
        self.namelable.font = [UIFont systemFontOfSize:self.font];
        self.namelable.alpha = 0.85;
        [subview addSubview:self.namelable];
        
        self.prilable = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height-(25 * 2)-4, 80, 18)];
        self.prilable.font = [UIFont systemFontOfSize:self.font];
        self.prilable.alpha = 0.85;
        [subview addSubview:self.prilable];
        
        self.prilablenumber = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height-(25 * 2) - 4, 80, 18)];
        self.prilablenumber.textColor = [UIColor redColor];
        self.prilablenumber.font = [UIFont systemFontOfSize:self.font-2];
        self.prilablenumber.alpha = 0.85;
        [subview addSubview:self.prilablenumber];
        

        self.prilablelater = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height-(25 * 2)-4, 0, 18)];
        self.prilablelater.font = [UIFont systemFontOfSize:self.font-2];
        self.prilablelater.alpha = 0.85;
        [subview addSubview:self.prilablelater];

        
        self.hotlable = [[UILabel alloc] initWithFrame:CGRectMake(5, self.bounds.size.height-20-4 -8, 0, 18)];
        self.hotlable.font = [UIFont systemFontOfSize:self.font - 2];
        self.hotlable.alpha = 0.85;
        [subview addSubview:self.hotlable];

        self.hotlablenumber = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20-4-8, 0, 18)];
        self.hotlablenumber.font = [UIFont systemFontOfSize:self.font-2];
        self.hotlablenumber.alpha = 0.85;
        self.hotlablenumber.textColor = [UIColor redColor];
        [subview addSubview:self.hotlablenumber];
        
        self.hotlablelater = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20-4-8, 0, 18)];
        self.hotlablelater.font = [UIFont systemFontOfSize:self.font-2];
        self.hotlablelater.alpha = 0.85;
        [subview addSubview:self.hotlablelater];

    }
    return self;
}
//计算字符串的长度值
-(float)NSStringwithfont:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:self.font];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat nameW = size.width;
    
    return nameW;
}
@end
