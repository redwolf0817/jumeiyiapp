//
//  Doctorpersents.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/14.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "Doctorpersents.h"

@implementation Doctorpersents

+(Doctorpersents *)DoctorpersentsWithDictionnary:(NSDictionary *)diction{
    
    Doctorpersents *doctor = [[Doctorpersents alloc] init];
    
    doctor.Contents = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Contents"]];
    doctor.DoctorName = [diction objectForKey:@"DoctorName"];
    doctor.OpenTalkType = [NSString stringWithFormat:@"%@",[diction objectForKey:@"OpenTalkType"]];
    doctor.PicSrc = [diction objectForKey:@"PicSrc"];
    doctor.PicSrc2 = [diction objectForKey:@"PicSrc2"];
    doctor.PostName = [diction objectForKey:@"PostName"];
    doctor.Qualification = [diction objectForKey:@"Qualification"];
    doctor.SocietyPostName = [diction objectForKey:@"SocietyPostName"];
    
    doctor.BeautifyProName = [diction objectForKey:@"BeautifyProName"];
    doctor.BeautifyProPic = [diction objectForKey:@"BeautifyProPic"];
    doctor.Description = [diction objectForKey:@"Description"];
    doctor.DoctorSno = [diction objectForKey:@"DoctorSno"];
    doctor.ProBookAmoumt = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ProBookAmoumt"]];
    doctor.ProTypeName = [diction objectForKey:@"ProTypeName"];
    doctor.ProductSno = [diction objectForKey:@"ProductSno"];
    doctor.SellPrice = [NSString stringWithFormat:@"%@",[diction objectForKey:@"SellPrice"]];
    
    doctor.Remark = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Remark"]];
    doctor.Sno = [diction objectForKey:@"Sno"];
    doctor.Title = [NSString stringWithFormat:@"%@",[diction objectForKey:@"Title"]];
    doctor.ServiceCount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"ServiceCount"]];
    
    return doctor;

}
@end

