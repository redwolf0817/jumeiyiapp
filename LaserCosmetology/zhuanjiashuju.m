//
//  zhuanjiashuju.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/26.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "zhuanjiashuju.h"

@implementation zhuanjiashuju
+(zhuanjiashuju *)zhuanjiaDetails:(NSDictionary *)diction
{
    zhuanjiashuju *zhuanjia = [[zhuanjiashuju alloc] init];
    //beautifyProData
     zhuanjia.BeautifyProName = [diction objectForKey:@"BeautifyProName"];
     zhuanjia.BeautifyProPic = [NSString stringWithFormat:@"%@",[diction objectForKey:@"BeautifyProPic"]];
     zhuanjia.DoctorName = [diction objectForKey:@"DoctorName"];
     zhuanjia.OwnerSno = [diction objectForKey:@"OwnerSno"];
     zhuanjia.ProBookAmoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ProBookAmoumt"]];
     zhuanjia.ProductSno = [diction objectForKey:@"ProductSno"];
     zhuanjia.SellPrice = [NSString stringWithFormat:@"%@",[diction objectForKey:@"SellPrice"]];
    
    //DoctorData
    zhuanjia.HospitalName = [diction objectForKey:@"HospitalName"];
    zhuanjia.MusicFile = [diction objectForKey:@"MusicFile"];
    zhuanjia.OpenTalkType = [diction objectForKey:@"OpenTalkType"];
    zhuanjia.PicSrc = [diction objectForKey:@"PicSrc"];
    zhuanjia.Sno = [diction objectForKey:@"Sno"];
    zhuanjia.TrueName = [diction objectForKey:@"TrueName"];
    
    //doctorPicData
    zhuanjia.DoctorSno = [diction objectForKey:@"DoctorSno"];
    zhuanjia.PicDesc = [diction objectForKey:@"PicDesc"];
    zhuanjia.SeqNo = [diction objectForKey:@"SeqNo"];
    zhuanjia.Title = [diction objectForKey:@"Title"];
    zhuanjia.Remark = [diction objectForKey:@"Remark"];
    
    return zhuanjia;
}
@end

