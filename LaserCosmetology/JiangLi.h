//
//  JiangLi.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JiangLi : NSObject

@property(nonatomic,copy)NSString *commissionTotalAmoumt;
@property(nonatomic,copy)NSString *lastGetAmoumt;
@property(nonatomic,copy)NSString *lastGetDate;
@property(nonatomic,copy)NSString *Amoumt;
@property(nonatomic,copy)NSString *CreateDt;
@property(nonatomic,copy)NSString *Reason;

+(JiangLi *)jiangliwithdiction:(NSDictionary *)diction;

@end
