//
//  YuYueShiJianBiaoShuJu.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/30.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "YuYueShiJianBiaoShuJu.h"

@implementation YuYueShiJianBiaoShuJu

+(YuYueShiJianBiaoShuJu *)yuyuewithNsdictionary:(NSDictionary *)diction{
    
    YuYueShiJianBiaoShuJu *yuyue = [[YuYueShiJianBiaoShuJu alloc] init];
    
    yuyue.DoctorName = [diction objectForKey:@"DoctorName"];
    yuyue.DoctorSno = [diction objectForKey:@"DoctorSno"];
    yuyue.HourCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"HourCount"]];
    yuyue.MinuteCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"MinuteCount"]];
    yuyue.Sno = [diction objectForKey:@"Sno"];
    
    return yuyue;
}

@end
