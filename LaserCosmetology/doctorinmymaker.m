//
//  doctorinmymaker.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/10.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "doctorinmymaker.h"

@implementation doctorinmymaker
+(doctorinmymaker *)mymakerWithDiction:(NSDictionary *)dicton{

    doctorinmymaker *doctor = [[doctorinmymaker alloc] init];

    doctor.Amoumt = [NSString stringWithFormat:@"%@",[dicton objectForKey:@"Amoumt"]];
    doctor.BookDt = [dicton objectForKey:@"BookDt"];
    doctor.CusName = [dicton objectForKey:@"CusName"];
    doctor.CusSno = [dicton objectForKey:@"CusSno"];
    doctor.EvaluateReturnContents = [NSString stringWithFormat:@"%@",[dicton objectForKey:@"EvaluateReturnContents"]];
    doctor.IsCare = [NSString stringWithFormat:@"%@",[dicton objectForKey:@"IsCare"]];
    doctor.IsReturnEvaluate = [NSString stringWithFormat:@"%@",[dicton objectForKey:@"IsReturnEvaluate"]];
    doctor.OrderNo = [NSString stringWithFormat:@"%@",[dicton objectForKey:@"OrderNo"]];
    doctor.OrderSno = [dicton objectForKey:@"OrderSno"];
    doctor.ProductName = [dicton objectForKey:@"ProductName"];
    doctor.Sno = [dicton objectForKey:@"Sno"];
    doctor.CusPhone = [NSString stringWithFormat:@"%@",[dicton objectForKey:@"CusPhone"]];
    doctor.NowState = [NSString stringWithFormat:@"%@",[dicton objectForKey:@"NowState"]];
    
    return doctor;
}

@end

