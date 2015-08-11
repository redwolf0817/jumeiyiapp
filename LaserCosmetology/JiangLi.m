//
//  JiangLi.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "JiangLi.h"

@implementation JiangLi

+(JiangLi *)jiangliwithdiction:(NSDictionary *)diction{

    JiangLi *jl = [[JiangLi alloc] init];

    jl.commissionTotalAmoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"commissionTotalAmoumt"]];
    jl.lastGetAmoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"lastGetAmoumt"]];
    jl.lastGetDate = [diction objectForKey:@"lastGetDate"];

    jl.Amoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Amoumt"]];
    jl.CreateDt = [diction objectForKey:@"CreateDt"];
    jl.Reason = [diction objectForKey:@"Reason"];
    
    return jl;
}

@end
