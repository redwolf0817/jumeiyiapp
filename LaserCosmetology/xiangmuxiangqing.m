//
//  xiangmuxiangqing.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/27.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "xiangmuxiangqing.h"

@implementation xiangmuxiangqing

+(xiangmuxiangqing *)xiangmuxiangqingWithnsdiction:(NSDictionary *)diction{

    xiangmuxiangqing *xiangqing = [[xiangmuxiangqing alloc] init];

    xiangqing.BookPrice =[NSString stringWithFormat:@"%@",[diction objectForKey:@"BookPrice"]];
    xiangqing.Contents = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Contents"]];
    xiangqing.CouponPrice = [NSString stringWithFormat:@"%@",[diction objectForKey:@"CouponPrice"]];
    xiangqing.Description = [diction objectForKey:@"Description"];
    xiangqing.LikeCount = [diction objectForKey:@"LikeCount"];
    xiangqing.MarketPrice = [NSString stringWithFormat:@"%@",[diction objectForKey:@"MarketPrice"]];
    xiangqing.Name = [diction objectForKey:@"Name"];
    xiangqing.PicSrc = [diction objectForKey:@"PicSrc"];
    xiangqing.ReferencePrice = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ReferencePrice"]];
    xiangqing.ReferencePriceMax = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ReferencePriceMax"]];
    xiangqing.Sno = [diction objectForKey:@"Sno"];
    xiangqing.UseHours = [NSString stringWithFormat:@"%@",[diction objectForKey:@"UseHours"]];
    xiangqing.UseHoursMax = [NSString stringWithFormat:@"%@",[diction objectForKey:@"UseHoursMax"]];
    
    xiangqing.ProductSno = [diction objectForKey:@"ProductSno"];
    xiangqing.Title = [diction objectForKey:@"Title"];
    
    return xiangqing;
}

@end
