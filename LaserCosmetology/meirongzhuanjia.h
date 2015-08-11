//
//  meirongzhuanjia.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/25.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface meirongzhuanjia : NSObject

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
@property(nonatomic,copy)NSString *PostName;

+(meirongzhuanjia *)zhuanjiawithdictionaray:(NSDictionary *)diction;

@end
