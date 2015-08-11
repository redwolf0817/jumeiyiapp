//
//  Beautyitems.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "Beautyitems.h"

@implementation Beautyitems

+(Beautyitems *)analysiswithdictionary:(NSDictionary *)dictionary{

    Beautyitems *bitem = [[Beautyitems alloc] init];
    
    bitem.Sno = [dictionary objectForKey:@"Sno"];
    bitem.InfoId = [dictionary objectForKey:@"InfoId"];
    bitem.Name = [dictionary objectForKey:@"Name"];
    bitem.TypeSno = [dictionary objectForKey:@"TypeSno"];
    bitem.Description = [dictionary objectForKey:@"Description"];
    bitem.Contents = [dictionary objectForKey:@"Contents"];
    bitem.PicSrc = [dictionary objectForKey:@"PicSrc"];
    bitem.ReferencePrice = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"ReferencePrice"]];
    
    bitem.LikeCount = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"LikeCount"]];
    bitem.ReferencePriceMax = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"ReferencePriceMax"]];
    bitem.EnumName = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"EnumName"]];
    bitem.EnumNo = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"EnumNo"]];
    
    bitem.ParentId = [dictionary objectForKey:@"ParentId"];
    bitem.Sort = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"Sort"]];
    bitem.itmesid = [dictionary objectForKey:@"id"];
    bitem.text = [dictionary objectForKey:@"text"];
    
    bitem.ProName = [dictionary objectForKey:@"ProName"];
    bitem.ProSno = [dictionary objectForKey:@"ProSno"];
    bitem.ProTypeNo = [dictionary objectForKey:@"ProTypeNo"];
    
    
    return bitem;

}

@end



