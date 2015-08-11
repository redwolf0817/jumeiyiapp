//
//  meirongzhuanjia.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/25.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "meirongzhuanjia.h"

@implementation meirongzhuanjia

+(meirongzhuanjia *)zhuanjiawithdictionaray:(NSDictionary *)diction{

    meirongzhuanjia *meirong = [[meirongzhuanjia alloc] init];
    
    meirong.BestInfo = [diction objectForKey:@"BestInfo"];
    meirong.BookCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"BookCount"]];
    meirong.CostFrom = [NSString stringWithFormat:@"%@",[diction objectForKey:@"CostFrom"]];
    meirong.CostTo = [diction objectForKey:@"CostTo"];
    meirong.EvaluateCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"EvaluateCount"]];
    meirong.HospitalName = [diction objectForKey:@"HospitalName"];
    meirong.OpenTalkType = [diction objectForKey:@"OpenTalkType"];
    meirong.PicSrc = [diction objectForKey:@"PicSrc"];
    meirong.Sno = [diction objectForKey:@"Sno"];
    meirong.TrueName = [diction objectForKey:@"TrueName"];
    meirong.PostName = [diction objectForKey:@"PostName"];
    
    return meirong;
}



@end
