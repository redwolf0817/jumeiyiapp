//
//  customerBeautifyLogData.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/16.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "customerBeautifyLogData.h"

@implementation customerBeautifyLogData

+(customerBeautifyLogData *)customerBeautifyLogDataWithDiction:(NSDictionary *)diction
{
    customerBeautifyLogData *BeautifyLog = [[customerBeautifyLogData alloc] init];
    
    BeautifyLog.ClickCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ClickCount"]];
    BeautifyLog.Contents = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Contents"]];
    BeautifyLog.CustomerName = [diction objectForKey:@"CustomerName"];
    BeautifyLog.DiscussCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"DiscussCount"]];
    BeautifyLog.OwnSno = [diction objectForKey:@"OwnSno"];
    BeautifyLog.PicSrc = [diction objectForKey:@"PicSrc"];
    BeautifyLog.Sno = [diction objectForKey:@"Sno"];
    BeautifyLog.Title = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Title"]];
    BeautifyLog.ProductSno = [diction objectForKey:@"ProductSno"];
    BeautifyLog.CreateDt = [diction objectForKey:@"CreateDt"];
    BeautifyLog.ProName = [diction objectForKey:@"ProName"];
    
    BeautifyLog.OwnerSno = [diction objectForKey:@"OwnerSno"];
    BeautifyLog.InfoId = [diction objectForKey:@"InfoId"];
    BeautifyLog.InfoSno = [diction objectForKey:@"InfoSno"];
    BeautifyLog.ManSno = [diction objectForKey:@"ManSno"];
    BeautifyLog.TrueName = [diction objectForKey:@"TrueName"];
    BeautifyLog.DoctorName = [diction objectForKey:@"DoctorName"];
    
    BeautifyLog.LogDiscussData = [diction objectForKey:@"LogDiscussData"];
    BeautifyLog.LogPicData = [diction objectForKey:@"LogPicData"];
    BeautifyLog.HospitalName = [diction objectForKey:@"HospitalName"];
    BeautifyLog.DoctorSno = [diction objectForKey:@"DoctorSno"];
    BeautifyLog.HospitalSno = [diction objectForKey:@"HospitalSno"];
    BeautifyLog.CityName = [diction objectForKey:@"CityName"];
    BeautifyLog.PicSrc2 = [diction objectForKey:@"PicSrc2"];
    BeautifyLog.CusPicSrc = [diction objectForKey:@"CusPicSrc"];
    
    return BeautifyLog;

}


@end
