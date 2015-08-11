//
//  daijinquan.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/21.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface daijinquan : NSObject

@property(nonatomic,retain)NSString *Amoumt;
@property(nonatomic,retain)NSString *Description;
@property(nonatomic,retain)NSString *Name;
@property(nonatomic,retain)NSString *Price;
@property(nonatomic,retain)NSString *Sno;
@property(nonatomic,retain)NSString *PicSrc;

//未过期
@property(nonatomic,retain)NSString *BeginDate;
@property(nonatomic,retain)NSString *CouponName;
@property(nonatomic,retain)NSString *CouponPicUrl;
@property(nonatomic,retain)NSString *CouponSno;
@property(nonatomic,retain)NSString *EndDate;
@property(nonatomic,retain)NSString *ManSno;
@property(nonatomic,retain)NSString *NowState;
@property(nonatomic,retain)NSString *UserName;
@property(nonatomic,retain)NSString *UserType;
@property(nonatomic,retain)NSString *UserTypeName;

+(daijinquan *)daijinquanWithdiction:(NSDictionary *)diction;

@end



