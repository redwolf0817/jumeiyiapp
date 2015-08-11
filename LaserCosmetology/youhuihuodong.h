//
//  youhuihuodong.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface youhuihuodong : NSObject

@property(nonatomic,retain)NSString *BeautifyProName;
@property(nonatomic,retain)NSString *BeautifyProPic;
@property(nonatomic,retain)NSString *BeginDate;
@property(nonatomic,retain)NSString *BookDt;
@property(nonatomic,retain)NSString *Contents;
@property(nonatomic,retain)NSString *DoctorName;
@property(nonatomic,retain)NSString *DoctorSno;
@property(nonatomic,retain)NSString *IsCanUse;
@property(nonatomic,retain)NSString *MarketPrice;
@property(nonatomic,retain)NSString *Price;
@property(nonatomic,retain)NSString *ProBookAmoumt;
@property(nonatomic,retain)NSString *ProductSno;
@property(nonatomic,retain)NSString *Sno;
@property(nonatomic,retain)NSString *Title;
@property(nonatomic,retain)NSString *HospitalName;

+(youhuihuodong *)youhuiWithdiction:(NSDictionary *)diction;

@end

