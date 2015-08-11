//
//  evaluateDoctorData.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/11.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "evaluateDoctorData.h"

@implementation evaluateDoctorData

+(evaluateDoctorData *)evaluateDoctorDataWithdictionnary:(NSDictionary *)diction{
    
    evaluateDoctorData *doctor = [[evaluateDoctorData alloc] init];
    
    doctor.BookDt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"BookDt"]];
    doctor.CusName = [diction objectForKey:@"CusName"];
    doctor.CusPhone =[NSString stringWithFormat:@"%@",[diction objectForKey:@"CusPhone"]];
    doctor.CusSno = [diction objectForKey:@"CusSno"];
    doctor.EvaluateContents = [NSString stringWithFormat:@"%@",[diction objectForKey:@"EvaluateContents"]];
    doctor.EvaluateDt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"EvaluateDt"]];
    doctor.EvaluateLevel = [NSString stringWithFormat:@"%@",[diction objectForKey:@"EvaluateLevel"]];
    doctor.EvaluateReturnContents = [NSString stringWithFormat:@"%@",[diction objectForKey:@"EvaluateReturnContents"]];
    doctor.IsCare = [NSString stringWithFormat:@"%@",[diction objectForKey:@"IsCare"]];
    doctor.IsReturnEvaluate = [NSString stringWithFormat:@"%@",[diction objectForKey:@"IsReturnEvaluate"]];
    doctor.OrderNo =[NSString stringWithFormat:@"%@",[diction objectForKey:@"OrderNo"]];
    doctor.OrderSno = [NSString stringWithFormat:@"%@",[diction objectForKey:@"OrderSno"]];
    doctor.Sno = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Sno"]];
    
    return doctor;
}


@end



