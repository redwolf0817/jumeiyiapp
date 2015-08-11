//
//  mycustomerdata.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mycustomerdata : NSObject

@property(nonatomic,copy)NSString *BuyProductNames;
@property(nonatomic,copy)NSString *CellPhone;
@property(nonatomic,copy)NSString *FirstSearchWord;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *TrueName;

+(mycustomerdata *)mycustomerdataWithdiction:(NSDictionary *)diction;

@end

