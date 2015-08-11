//
//  yuyuexiandeqingqiu.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/31.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "yuyuexiandeqingqiu.h"

@implementation yuyuexiandeqingqiu

+(yuyuexiandeqingqiu *)yuyuexiandeshujuWithdiction:(NSDictionary *)diction{

    yuyuexiandeqingqiu *yuyue = [[yuyuexiandeqingqiu alloc] init];

    yuyue.BeautifyProName = [diction objectForKey:@"BeautifyProName"];
    yuyue.BeautifyProPic = [diction objectForKey:@"BeautifyProPic"];
    yuyue.DoctorName = [diction objectForKey:@"DoctorName"];
    yuyue.OwnerSno = [diction objectForKey:@"OwnerSno"];
    yuyue.ProBookAmoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ProBookAmoumt"]];
    yuyue.ProductSno = [diction objectForKey:@"ProductSno"];
    
    yuyue.Description = [diction objectForKey:@"Description"];
    yuyue.Name = [diction objectForKey:@"Name"];
    yuyue.SellPrice = [diction objectForKey:@"SellPrice"];
    
    yuyue.PhoneNo = [diction objectForKey:@"PhoneNo"];
    yuyue.TrueName = [diction objectForKey:@"TrueName"];
    
    yuyue.DoctorSno = [diction objectForKey:@"DoctorSno"];
    yuyue.HospitalName = [diction objectForKey:@"HospitalName"];
    yuyue.HospitalSno = [diction objectForKey:@"HospitalSno"];

    return yuyue;
}
@end
