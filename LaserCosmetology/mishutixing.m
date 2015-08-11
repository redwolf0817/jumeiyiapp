//
//  mishutixing.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/3.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "mishutixing.h"

@implementation mishutixing
+(mishutixing *)mishuwithdata:(NSDictionary *)diction{

    mishutixing *mishu = [[mishutixing alloc] init];
    
        mishu.CustomerName = [diction objectForKey:@"CustomerName"];
        mishu.CustomerSno = [diction objectForKey:@"CustomerSno"];
        mishu.DoctorName = [diction objectForKey:@"DoctorName"];
        mishu.DoctorSno = [diction objectForKey:@"DoctorSno"];
        mishu.FileType = [diction objectForKey:@"FileType"];
        mishu.FromType = [diction objectForKey:@"FromType"];
        mishu.IsReturn = [NSString stringWithFormat:@"%@",[diction objectForKey:@"IsReturn"]];
        mishu.NoticeDt = [diction objectForKey:@"NoticeDt"];
        mishu.OrderDetailSno = [diction objectForKey:@"OrderDetailSno"];
        mishu.PicSrc = [diction objectForKey:@"PicSrc"];
        mishu.Sno = [diction objectForKey:@"Sno"];
        mishu.TextInfo = [diction objectForKey:@"TextInfo"];
        mishu.VideoSrc = [diction objectForKey:@"VideoSrc"];
        mishu.VoiceSrc = [diction objectForKey:@"VoiceSrc"];
    
    return mishu;
}

@end




