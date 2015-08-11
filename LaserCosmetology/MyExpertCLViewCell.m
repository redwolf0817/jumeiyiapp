//
//  MyExpertCLViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/30.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MyExpertCLViewCell.h"
#import "customercenter.h"
#import "UIImageView+WebCache.h"

@implementation MyExpertCLViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backimage = [[UIImageView alloc] initWithFrame:self.bounds];
        //self.backimage.image = [UIImage imageNamed:@"yuyuemian"];
        self.backimage.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backimage];
        
        self.headimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.backimage.bounds.size.height - 10, self.backimage.bounds.size.height - 10)];
        self.headimage.layer.masksToBounds = YES;
        self.headimage.layer.cornerRadius = (self.backimage.bounds.size.height - 10)/2;
        [self.backimage addSubview:self.headimage];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(5 + self.backimage.bounds.size.height ,15 , 200, 20)];
        [self.backimage addSubview:self.name];
        
        self.begoodat = [[UILabel alloc] initWithFrame:CGRectMake(5 + self.backimage.bounds.size.height ,45 , 100, 20)];
        self.begoodat.text = @"擅长:";
        [self.backimage addSubview:self.begoodat];

        self.begoodto = [[UILabel alloc] initWithFrame:CGRectMake(5 + self.backimage.bounds.size.height + 40,45 , self.bounds.size.width - (5 + self.backimage.bounds.size.height + 40), 20)];
        self.begoodto.font = [UIFont systemFontOfSize:14];
        [self.backimage addSubview:self.begoodto];
        
        self.zhufu = [[UILabel alloc] init];
        [self.backimage addSubview:self.zhufu];
        
    }
    
    return self;
}

@end
