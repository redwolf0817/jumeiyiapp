//
//  MyCusTomerDetails.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MyCusTomerDetails.h"

@implementation MyCusTomerDetails

+(MyCusTomerDetails *)MyCusTomerDetailsWithdiction:(NSDictionary *)diction
{
    MyCusTomerDetails *mycustomer = [[MyCusTomerDetails alloc] init];
    
    mycustomer.CellPhone = [diction objectForKey:@"CellPhone"];
     mycustomer.Name = [diction objectForKey:@"Name"];
    
    //orderData
    mycustomer.Amoumt = [diction objectForKey:@"Amoumt"];
    mycustomer.BookDt = [diction objectForKey:@"BookDt"];
    mycustomer.CreateDt = [diction objectForKey:@"CreateDt"];
    mycustomer.CusName = [diction objectForKey:@"CusName"];
    mycustomer.CusPhone = [diction objectForKey:@"CusPhone"];
    mycustomer.CusSno = [diction objectForKey:@"CusSno"];
    mycustomer.EvaluateReturnContents = [diction objectForKey:@"EvaluateReturnContents"];
    mycustomer.IsCare = [diction objectForKey:@"IsCare"];
    mycustomer.IsReturnEvaluate = [diction objectForKey:@"IsReturnEvaluate"];
    mycustomer.OrderNo = [diction objectForKey:@"OrderNo"];
    mycustomer.OrderSno = [diction objectForKey:@"OrderSno"];
    mycustomer.ProductorName = [diction objectForKey:@"ProductorName"];
    mycustomer.Sno = [diction objectForKey:@"Sno"];
    mycustomer.ProductSno = [diction objectForKey:@"ProductSno"];
    mycustomer.OrderState = [diction objectForKey:@"OrderState"];
    mycustomer.BookDoctorSno = [diction objectForKey:@"BookDoctorSno"];
    mycustomer.BookHospitalSno = [diction objectForKey:@"BookHospitalSno"];
    mycustomer.EvaluateContents = [diction objectForKey:@"EvaluateContents"];
    mycustomer.HospitalName = [diction objectForKey:@"HospitalName"];
    //talkData
    mycustomer.CustomerName = [diction objectForKey:@"CustomerName"];
    mycustomer.CustomerSno = [diction objectForKey:@"CustomerSno"];
    mycustomer.DoctorName = [diction objectForKey:@"DoctorName"];
    mycustomer.DoctorSno = [diction objectForKey:@"DoctorSno"];
    mycustomer.FileType = [diction objectForKey:@"FileType"];
    mycustomer.FromType = [diction objectForKey:@"FromType"];
    mycustomer.IsReturn = [diction objectForKey:@"IsReturn"];
    mycustomer.PicSrc = [diction objectForKey:@"PicSrc"];
    mycustomer.TextInfo = [diction objectForKey:@"TextInfo"];
    mycustomer.VideoSrc = [diction objectForKey:@"VideoSrc"];
    mycustomer.VoiceSrc = [diction objectForKey:@"VoiceSrc"];

    
    return mycustomer;
}
@end

