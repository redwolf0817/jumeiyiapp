//
//  begoogatbeauty.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/27.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "begoogatbeauty.h"
#import "UIImageView+WebCache.h"
@implementation begoogatbeauty

-(id)initWithFrame:(CGRect)frame imagename:(NSString *)imageN itemes:(NSString *)item prices:(NSString *)prise
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backimage = [[UIView alloc] initWithFrame:self.bounds];
        backimage.layer.masksToBounds = YES;
        [self addSubview:backimage];
        
        UIImageView *heard = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backimage.bounds.size.width, backimage.bounds.size.height - 60)];
        [heard sd_setImageWithURL:[NSURL URLWithString:imageN]];
        [backimage addSubview:heard];
        
        
        UILabel *namelable = [[UILabel alloc] initWithFrame:CGRectMake(0, backimage.bounds.size.height - 55, 35, 18)];
        namelable.text = @"名称:";
        namelable.font = [UIFont systemFontOfSize:15];
        [backimage addSubview:namelable];
        
        float width =[self NSStringwithsize:15 str:namelable.text];
        UILabel *fuwurenshu = [[UILabel alloc] initWithFrame:CGRectMake(10 + width, backimage.bounds.size.height - 55, 100, 18)];
        fuwurenshu.text =item;
        fuwurenshu.font = [UIFont systemFontOfSize:15];
        fuwurenshu.textColor = [UIColor redColor];
        [backimage addSubview:fuwurenshu];
        
        
        UILabel *techang = [[UILabel alloc] initWithFrame:CGRectMake(0, backimage.bounds.size.height - 35, 40, 20)];
        techang.text = @"费用:";
        techang.font = [UIFont systemFontOfSize:15];
        [backimage addSubview:techang];
        
        float width2 =[self NSStringwithsize:15 str:techang.text];
        
        UILabel *techanglater = [[UILabel alloc] initWithFrame:CGRectMake(10 + width2, backimage.bounds.size.height - 35, 150, 20)];
        techanglater.text =  prise;
        techanglater.font = [UIFont systemFontOfSize:14];
        techanglater.textColor = [UIColor redColor];
        [backimage addSubview:techanglater];
        
        float width3=[self NSStringwithsize:15 str:techanglater.text];
        
        UILabel *feiyong = [[UILabel alloc] initWithFrame:CGRectMake(width2 + width3 + 10, backimage.bounds.size.height - 35, 40, 20)];
        feiyong.text = @"元";
        feiyong.font = [UIFont systemFontOfSize:14];
        [backimage addSubview:feiyong];
        
        
    }
    
    return self;
}



-(float)NSStringwithsize:(int )a str:(NSString *)string
{
    
    UIFont *font = [UIFont systemFontOfSize:a];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat strwidth = size.width;
    
    return strwidth;
}

@end
