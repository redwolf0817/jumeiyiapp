//
//  persens.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/4.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "persens.h"

@implementation persens

+(persens *)persensWithdictionary:(NSDictionary *)diction{

    persens *per = [[persens alloc] init];
    
    per.AgeCount = [diction objectForKey:@"AgeCount"];
    per.AgeType = [diction objectForKey:@"AgeType"];
    per.CellPhone = [NSString stringWithFormat:@"%@",[diction objectForKey:@"CellPhone"]];
    per.Name = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Name"]];
    per.PicSrc = [diction objectForKey:@"PicSrc"];
    per.SexType = [diction objectForKey:@"SexType"];
    per.BestInfo = [diction objectForKey:@"BestInfo"];
    per.ServeCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ServeCount"]];
    per.TrueName = [diction objectForKey:@"TrueName"];
    per.DoctSno = [diction objectForKey:@"DoctSno"];
    
    per.Sno = [diction objectForKey:@"Sno"];
    per.Contents = [diction objectForKey:@"Contents"];
    per.District = [diction objectForKey:@"District"];
    per.PostName = [diction objectForKey:@"PostName"];
    per.Qualification = [diction objectForKey:@"Qualification"];
    per.SocietyPostName = [diction objectForKey:@"SocietyPostName"];
    per.hospitalName = [diction objectForKey:@"hospitalName"];
    per.ProName = [diction objectForKey:@"ProName"];
    per.ProSno = [diction objectForKey:@"ProSno"];
    per.OrderSno = [diction objectForKey:@"OrderSno"];
    per.ProTypeNo = [diction objectForKey:@"ProTypeNo"];
    
    return per;
}

@end
