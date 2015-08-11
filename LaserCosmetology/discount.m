//
//  discount.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/28.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "discount.h"

@implementation discount
+(discount *)PicSrcwithdictionary:(NSDictionary *)dict{

    discount *disc = [[discount alloc] init];
    
    disc.Name = [dict objectForKey:@"Name"];
    disc.PicSrc = [dict objectForKey:@"PicSrc"];
    disc.ReferencePrice = [dict objectForKey:@"ReferencePrice"];
    disc.Sno = [dict objectForKey:@"Sno"];
    disc.TrueName = [dict objectForKey:@"TrueName"];
    disc.Description = [dict objectForKey:@"Description"];
    disc.Title = [dict objectForKey:@"Title"];
    disc.EnumName = [dict objectForKey:@"EnumName"];
    disc.EnumNo = [dict objectForKey:@"EnumNo"];
    disc.Contents = [dict objectForKey:@"Contents"];
    disc.CustomerName = [dict objectForKey:@"CustomerName"];
    disc.OwnSno = [dict objectForKey:@"OwnSno"];
    disc.PicHeight = [dict objectForKey:@"PicHeight"];
    disc.PicWidth = [dict objectForKey:@"PicWidth"];
    disc.InfoSno = [dict objectForKey:@"InfoSno"];
    disc.ProDescription = [dict objectForKey:@"ProDescription"];
    disc.ProName = [dict objectForKey:@"ProName"];
    
    disc.CityName = [dict objectForKey:@"CityName"];
    disc.PicSrc2 = [dict objectForKey:@"PicSrc2"];
    disc.DoctorName = [dict objectForKey:@"DoctorName"];
    disc.HospitalName = [dict objectForKey:@"HospitalName"];
    disc.UserPicSrc = [dict objectForKey:@"UserPicSrc"];
    disc.ClickCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"ClickCount"]];
    disc.DiscussCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"DiscussCount"]];
    
    return disc; 
}

@end



