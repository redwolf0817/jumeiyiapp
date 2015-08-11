//
//  CustomerMessage.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/14.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "CustomerMessage.h"

@implementation CustomerMessage

+(CustomerMessage *)CustomerMessageWithdiction:(NSDictionary *)diction
{

    CustomerMessage *cusmes = [[CustomerMessage alloc] init];
    
      cusmes.CustomerName = [diction objectForKey:@"CustomerName"];
      cusmes.CustomerSno = [diction objectForKey:@"CustomerSno"];
      cusmes.DoctorName = [diction objectForKey:@"DoctorName"];
      cusmes.DoctorSno = [diction objectForKey:@"DoctorSno"];
      cusmes.FileType = [NSString stringWithFormat:@"%@",[diction objectForKey:@"FileType"]];
      cusmes.FromType = [NSString stringWithFormat:@"%@",[diction objectForKey:@"FromType"]];
      cusmes.IsReturn = [NSString stringWithFormat:@"%@",[diction objectForKey:@"IsReturn"]];
      cusmes.PicSrc = [diction objectForKey:@"PicSrc"];
      cusmes.Sno = [diction objectForKey:@"Sno"];
      cusmes.TextInfo = [diction objectForKey:@"TextInfo"];
      cusmes.VideoSrc = [diction objectForKey:@"VideoSrc"];
      cusmes.VoiceSrc = [diction objectForKey:@"VoiceSrc"];
      cusmes.CreateDt = [diction objectForKey:@"CreateDt"];
      cusmes.TypeNo = [diction objectForKey:@"TypeNo"];
      cusmes.NoticeDt = [diction objectForKey:@"NoticeDt"];
      cusmes.NoticeEndDt = [diction objectForKey:@"NoticeEndDt"];
    
    return cusmes;
}

@end


