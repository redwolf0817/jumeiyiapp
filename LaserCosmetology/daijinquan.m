//
//  daijinquan.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/21.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "daijinquan.h"

@implementation daijinquan

+(daijinquan *)daijinquanWithdiction:(NSDictionary *)diction
{
    daijinquan *dlq = [[daijinquan alloc] init];
    
    dlq.Amoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Amoumt"]];
    dlq.Description = [diction objectForKey:@"Description"];
    dlq.Name = [diction objectForKey:@"Name"];
    dlq.Price = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Price"]];
    dlq.Sno = [diction objectForKey:@"Sno"];
    dlq.PicSrc = [diction objectForKey:@"PicSrc"];
    
    //未过期
    dlq.BeginDate = [NSString stringWithFormat:@"%@",[diction objectForKey:@"BeginDate"]];
    dlq.CouponName = [diction objectForKey:@"CouponName"];
    dlq.CouponPicUrl = [diction objectForKey:@"CouponPicUrl"];
    dlq.CouponSno = [NSString stringWithFormat:@"%@",[diction objectForKey:@"CouponSno"]];
    dlq.EndDate = [diction objectForKey:@"EndDate"];
    dlq.ManSno = [diction objectForKey:@"ManSno"];
    dlq.NowState = [NSString stringWithFormat:@"%@",[diction objectForKey:@"NowState"]];
    dlq.UserName = [diction objectForKey:@"UserName"];
    dlq.UserType = [diction objectForKey:@"UserType"];
    dlq.UserTypeName = [NSString stringWithFormat:@"%@",[diction objectForKey:@"UserTypeName"]];

    
    return dlq;
}


@end


