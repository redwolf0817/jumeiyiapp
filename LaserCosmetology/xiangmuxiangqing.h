//
//  xiangmuxiangqing.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/27.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xiangmuxiangqing : NSObject

//ProData
@property(nonatomic,copy)NSString *BookPrice;
@property(nonatomic,copy)NSString *Contents;
@property(nonatomic,copy)NSString *CouponPrice;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *LikeCount;
@property(nonatomic,copy)NSString *MarketPrice;
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *ReferencePrice;
@property(nonatomic,copy)NSString *ReferencePriceMax;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *UseHours;
@property(nonatomic,copy)NSString *UseHoursMax;

//beautifyProductCaseData
@property(nonatomic,copy)NSString *ProductSno;
@property(nonatomic,copy)NSString *Title;

+(xiangmuxiangqing *)xiangmuxiangqingWithnsdiction:(NSDictionary *)diction;
@end

