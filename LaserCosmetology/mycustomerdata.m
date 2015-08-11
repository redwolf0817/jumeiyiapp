//
//  mycustomerdata.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "mycustomerdata.h"

@implementation mycustomerdata

+(mycustomerdata *)mycustomerdataWithdiction:(NSDictionary *)diction
{
    mycustomerdata *mycustom  = [[mycustomerdata alloc] init];
    
    mycustom.BuyProductNames = [diction objectForKey:@"BuyProductNames"];
    mycustom.CellPhone = [NSString stringWithFormat:@"%@",[diction objectForKey:@"CellPhone"]];
    mycustom.FirstSearchWord = [diction objectForKey:@"FirstSearchWord"];
    mycustom.PicSrc = [diction objectForKey:@"PicSrc"];
    mycustom.Sno = [diction objectForKey:@"Sno"];
    mycustom.TrueName = [diction objectForKey:@"TrueName"];

    return mycustom;
}
@end

