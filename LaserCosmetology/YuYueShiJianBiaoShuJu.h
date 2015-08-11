//
//  YuYueShiJianBiaoShuJu.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/30.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YuYueShiJianBiaoShuJu : NSObject

@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *DoctorSno;
@property(nonatomic,copy)NSString *HourCount;
@property(nonatomic,copy)NSString *MinuteCount;
@property(nonatomic,copy)NSString *Sno;

+(YuYueShiJianBiaoShuJu *)yuyuewithNsdictionary:(NSDictionary *)diction;

@end
