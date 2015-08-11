//
//  ChatRecord.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/5.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "ChatRecord.h"

@implementation ChatRecord

+(ChatRecord *)ChatRecordWithdiction:(NSDictionary *)diction
{

    ChatRecord *chat = [[ChatRecord alloc] init];
    
    chat.CreateDt = [diction objectForKey:@"CreateDt"];
    chat.CustomerName = [diction objectForKey:@"CustomerName"];
    chat.CustomerSno = [diction objectForKey:@"CustomerSno"];
    chat.DoctorName = [diction objectForKey:@"DoctorName"];
    chat.DoctorSno = [diction objectForKey:@"DoctorSno"];
    chat.FileType = [NSString stringWithFormat:@"%@",[diction objectForKey:@"FileType"]];
    chat.FromType = [NSString stringWithFormat:@"%@",[diction objectForKey:@"FromType"]];
    chat.IsReturn = [NSString stringWithFormat:@"%@",[diction objectForKey:@"IsReturn"]];
    chat.PicSrc = [diction objectForKey:@"PicSrc"];
    chat.Sno = [diction objectForKey:@"Sno"];
    chat.TextInfo = [diction objectForKey:@"TextInfo"];
    chat.VideoSrc = [diction objectForKey:@"VideoSrc"];
    chat.VoiceSrc = [diction objectForKey:@"VoiceSrc"];
    
    return chat;

}

@end



