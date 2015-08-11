//
//  MeiRongRiJi.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MeiRongRiJi.h"

@implementation MeiRongRiJi

+(MeiRongRiJi *)meirongrijiWithdiction:(NSDictionary *)diction{

    MeiRongRiJi *meirong = [[MeiRongRiJi alloc] init];
    
    meirong.Amoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Amoumt"]];
    meirong.BookDoctorSno = [diction objectForKey:@"BookDoctorSno"];
    meirong.BookDt = [diction objectForKey:@"BookDt"];
    meirong.BookHospitalSno = [diction objectForKey:@"BookHospitalSno"];
    meirong.DoctorName = [diction objectForKey:@"DoctorName"];
    meirong.HospitalName = [diction objectForKey:@"HospitalName"];
    meirong.OrderState = [diction objectForKey:@"OrderState"];
    meirong.PicSrc = [diction objectForKey:@"PicSrc"];
    meirong.ProductSno = [diction objectForKey:@"ProductSno"];
    meirong.ProductorName = [diction objectForKey:@"ProductorName"];
    meirong.Sno = [diction objectForKey:@"Sno"];

    return meirong;

}

@end



