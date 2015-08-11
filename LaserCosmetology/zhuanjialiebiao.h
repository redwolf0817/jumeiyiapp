//
//  zhuanjialiebiao.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/29.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zhuanjialiebiao : NSObject


@property(nonatomic,copy)NSString *BestInfo;
@property(nonatomic,copy)NSString *BookCount;
@property(nonatomic,copy)NSString *CostFrom;
@property(nonatomic,copy)NSString *CostTo;
@property(nonatomic,copy)NSString *EvaluateCount;
@property(nonatomic,copy)NSString *HospitalName;
@property(nonatomic,copy)NSString *OpenTalkType;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *TrueName;

+(zhuanjialiebiao *)zhuanjialiebiaoWithdiction:(NSDictionary *)diction;
@end
