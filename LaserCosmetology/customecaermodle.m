//
//  customecaermodle.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/14.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "customecaermodle.h"

@implementation customecaermodle

+(customecaermodle *)customscaerldwith:(NSDictionary *)diction{

    customecaermodle *cust = [[customecaermodle alloc] init];
    
    cust.Amoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Amoumt"]];
    cust.BookDt = [diction objectForKey:@"BookDt"];
    cust.CusName = [diction objectForKey:@"CusName"];
    cust.CusPhone = [diction objectForKey:@"CusPhone"];
    cust.CusSno = [diction objectForKey:@"CusSno"];
    cust.EvaluateReturnContents = [diction objectForKey:@"EvaluateReturnContents"];
    cust.IsCare = [diction objectForKey:@"IsCare"];
    cust.IsReturnEvaluate = [diction objectForKey:@"IsReturnEvaluate"];
    cust.NowState = [diction objectForKey:@"NowState"];
    cust.OrderNo = [diction objectForKey:@"OrderNo"];
    cust.OrderSno = [diction objectForKey:@"OrderSno"];
    cust.ProductName = [diction objectForKey:@"ProductName"];
    cust.Sno = [diction objectForKey:@"Sno"];
    
    return cust;
}

@end


