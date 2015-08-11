//
//  zhuanjialiebiao.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/29.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "zhuanjialiebiao.h"

@implementation zhuanjialiebiao

+(zhuanjialiebiao *)zhuanjialiebiaoWithdiction:(NSDictionary *)diction{

    zhuanjialiebiao *zhuanjia = [[zhuanjialiebiao alloc] init];

    zhuanjia.BestInfo = [NSString stringWithFormat:@"%@",[diction objectForKey:@"BestInfo"]];
    zhuanjia.BookCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"BookCount"]];
    zhuanjia.CostFrom = [NSString stringWithFormat:@"%@",[diction objectForKey:@"CostFrom"]];
    zhuanjia.CostTo = [NSString stringWithFormat:@"%@",[diction objectForKey:@"CostTo"]];
    zhuanjia.EvaluateCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"EvaluateCount"]];
    zhuanjia.HospitalName = [diction objectForKey:@"HospitalName"];
    zhuanjia.OpenTalkType = [diction objectForKey:@"OpenTalkType"];
    zhuanjia.PicSrc = [diction objectForKey:@"PicSrc"];
    zhuanjia.Sno = [diction objectForKey:@"Sno"];
    zhuanjia.TrueName = [diction objectForKey:@"TrueName"];

    return zhuanjia;
}

@end
