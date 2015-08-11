//
//  youhuihuodong.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "youhuihuodong.h"

@implementation youhuihuodong

+(youhuihuodong *)youhuiWithdiction:(NSDictionary *)diction
{

    youhuihuodong *youhui = [[youhuihuodong alloc] init];
    
    youhui.BeautifyProName = [diction objectForKey:@"BeautifyProName"];
    youhui.BeautifyProPic = [diction objectForKey:@"BeautifyProPic"];
    youhui.BeginDate = [diction objectForKey:@"BeginDate"];
    youhui.BookDt = [diction objectForKey:@"BookDt"];
    youhui.Contents = [diction objectForKey:@"Contents"];
    youhui.DoctorName = [diction objectForKey:@"DoctorName"];
    youhui.DoctorSno = [diction objectForKey:@"DoctorSno"];
    youhui.IsCanUse = [NSString stringWithFormat:@"%@",[diction objectForKey:@"IsCanUse"]];
    youhui.MarketPrice = [NSString stringWithFormat:@"%@",[diction objectForKey:@"MarketPrice"]];
    youhui.Price = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Price"]];
    youhui.ProBookAmoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ProBookAmoumt"]];
    youhui.ProductSno = [diction objectForKey:@"ProductSno"];
    youhui.Sno = [diction objectForKey:@"Sno"];
    youhui.Title = [diction objectForKey:@"Title"];
    youhui.HospitalName = [diction objectForKey:@"HospitalName"];

    return youhui;
}

@end



