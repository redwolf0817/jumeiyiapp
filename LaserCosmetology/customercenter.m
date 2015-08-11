//
//  customercenter.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/31.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "customercenter.h"

@implementation customercenter

+(customercenter *)pointTotalCountwithdiction:(NSDictionary *)diction{

    customercenter *customer =[[customercenter alloc] init];
    
        customer.ClickCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ClickCount"]];
        customer.Contents = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Contents"]];
        customer.CustomerName = [diction objectForKey:@"CustomerName"];
        customer.DiscussCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"DiscussCount"]];
        customer.OwnSno = [diction objectForKey:@"OwnSno"];
        customer.PicSrc = [diction objectForKey:@"PicSrc"];
        customer.Sno = [diction objectForKey:@"Sno"];
    customer.CreateDt = [diction objectForKey:@"CreateDt"];
    
    customer.CusSno = [diction objectForKey:@"CusSno"];
    customer.DoctorName = [diction objectForKey:@"DoctorName"];
    customer.DoctorSno = [diction objectForKey:@"DoctorSno"];
    customer.DoctorPic = [diction objectForKey:@"DoctorPic"];
    
    customer.Amoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Amoumt"]];
    customer.BookDoctorSno = [diction objectForKey:@"BookDoctorSno"];
    customer.BookDt = [diction objectForKey:@"BookDt"];
    customer.BookHospitalSno = [diction objectForKey:@"BookHospitalSno"];
    customer.HospitalName = [diction objectForKey:@"HospitalName"];
    customer.OrderState = [diction objectForKey:@"OrderState"];
    customer.ProductSno = [diction objectForKey:@"ProductSno"];
    customer.ProductorName = [diction objectForKey:@"ProductorName"];
    
    customer.commissionTotalAmoumt = [diction objectForKey:@"commissionTotalAmoumt"];
    customer.couponTotalAmoumt = [diction objectForKey:@"couponTotalAmoumt"];
    customer.isHaveNewTips = [diction objectForKey:@"isHaveNewTips"];
    customer.pointTotalCount = [diction objectForKey:@"pointTotalCount"];
    customer.EvaluateContents = [diction objectForKey:@"EvaluateContents"];
    customer.EvaluateReturnContents = [diction objectForKey:@"EvaluateReturnContents"];

    return customer;
}

@end



