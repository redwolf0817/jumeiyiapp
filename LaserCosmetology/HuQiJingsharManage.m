//
//  HuQiJingsharManage.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/25.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "HuQiJingsharManage.h"

@implementation HuQiJingsharManage

static HuQiJingsharManage *hqj = nil;

+(instancetype)shareManage
{
    static  dispatch_once_t one;
    dispatch_once(&one, ^{
        hqj = [[HuQiJingsharManage alloc] init];
    });
    return hqj;
}

@end
