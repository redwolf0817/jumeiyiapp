//
//  TongHang.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "TongHang.h"

@implementation TongHang

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame andwidth:(int)width{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:view];
        
        UIImageView *bak = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,width , width)];
        bak.image = [UIImage imageNamed:@"5.jpeg"];
        bak.backgroundColor = [UIColor yellowColor];
        bak.userInteractionEnabled = YES;
        bak.layer.masksToBounds = YES;
        bak.layer.cornerRadius = width/2;
        [view addSubview:bak];
        
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 5 + width , width, 15)];
        lable.text = @"20000";
        lable.textColor = [UIColor redColor];
        [view addSubview:lable];
        
        float x = [self NSStringwithfont:17 AndNSString:lable.text];
        UILabel *labley = [[UILabel alloc] initWithFrame:CGRectMake(15 + x, 5 + width , width, 15)];
        labley.text = @"元";
        [view addSubview:labley];
        
    }
    
    return self;
}
//计算字符串的长度值
-(float)NSStringwithfont:(int )a AndNSString:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:a];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat nameW = size.width;
    
    return nameW;
}
@end
