//
//  BeautyFootclViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/18.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "BeautyFootclViewCell.h"

@implementation BeautyFootclViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.imageurlstr = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,  self.bounds.size.width, 160)];
        [self addSubview:self.imageurlstr];
        
        self.Contents = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imageurlstr.frame.size.height + 5, self.bounds.size.width - 20, 20)];
        self.Contents.numberOfLines = 2000;
        [self addSubview:self.Contents];
        
        self.ProName = [[UILabel alloc] init];
        [self addSubview:self.ProName];
        
        self.DiscussCounttext = [[UILabel alloc] initWithFrame:CGRectMake(10, self.Contents.frame.size.height + 5, self.bounds.size.width - 20, 20)];
        self.DiscussCounttext.numberOfLines = 2000;
        [self addSubview:self.DiscussCounttext];
        
        self.DiscussCount = [[UILabel alloc] initWithFrame:CGRectMake(10, self.Contents.frame.size.height + 5, self.bounds.size.width - 20, 20)];
        self.DiscussCount.numberOfLines = 2000;
        self.DiscussCount.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.DiscussCount];
        
        self.ClickCounttext = [[UILabel alloc] initWithFrame:CGRectMake(10, self.Contents.frame.size.height + 5, self.bounds.size.width - 20, 20)];
        self.ClickCounttext.numberOfLines = 2000;
        [self addSubview:self.ClickCounttext];
        
        self.ClickCount = [[UILabel alloc] initWithFrame:CGRectMake(10, self.Contents.frame.size.height + 5, self.bounds.size.width - 20, 20)];
        self.ClickCount.numberOfLines = 2000;
        self.ClickCount.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.ClickCount];

    }
    return self;
}
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(self.bounds.size.width - 20,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    
    return gaodu;
}
@end
