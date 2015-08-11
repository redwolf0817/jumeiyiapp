//
//  yishengwanshanziliao.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "yishengwanshanziliao.h"

@implementation yishengwanshanziliao
+(yishengwanshanziliao *)yishengdatawithdiction:(NSDictionary *)diction{

    yishengwanshanziliao *yisheng = [[yishengwanshanziliao alloc] init];
    
    yisheng.CreateBy = [NSString stringWithFormat:@"%@",[diction objectForKey:@"CreateBy"]];
    yisheng.CreateDt = [diction objectForKey:@"CreateDt"];
    yisheng.Description = [diction objectForKey:@"Description"];
    yisheng.EnumName = [diction objectForKey:@"EnumName"];
    yisheng.EnumNo = [NSString stringWithFormat:@"%@",[diction objectForKey:@"EnumNo"]];
    yisheng.EnumValue = [NSString stringWithFormat:@"%@",[diction objectForKey:@"EnumValue"]];
    yisheng.InfoId = [NSString stringWithFormat:@"%@",[diction objectForKey:@"InfoId"]];
    yisheng.IsCanUse = [NSString stringWithFormat:@"%@",[diction objectForKey:@"IsCanUse"]];
    yisheng.LastChangeBy = [NSString stringWithFormat:@"%@",[diction objectForKey:@"LastChangeBy"]];
    yisheng.LastChangeDt = [diction objectForKey:@"LastChangeDt"];
    yisheng.ParentSno = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ParentSno"]];
    yisheng.Remark = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Remark"]];
    yisheng.SeqNo = [NSString stringWithFormat:@"%@",[diction objectForKey:@"SeqNo"]];
    yisheng.Sno = [diction objectForKey:@"Sno"];
    yisheng.TypeNo = [diction objectForKey:@"TypeNo"];
    yisheng.DoctorSno = [NSString stringWithFormat:@"%@",[diction objectForKey:@"DoctorSno"]];
    yisheng.PicDesc = [diction objectForKey:@"PicDesc"];
    yisheng.PicSrc = [diction objectForKey:@"PicSrc"];


    return yisheng;
}

@end

