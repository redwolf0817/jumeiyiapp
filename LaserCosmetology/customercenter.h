//
//  customercenter.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/31.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface customercenter : NSObject

@property(nonatomic,copy)NSString *ClickCount;
@property(nonatomic,copy)NSString *Contents;
@property(nonatomic,copy)NSString *CustomerName;
@property(nonatomic,copy)NSString *DiscussCount;
@property(nonatomic,copy)NSString *OwnSno;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *CreateDt;

@property(nonatomic,copy)NSString *CusSno;
@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *DoctorSno;
@property(nonatomic,copy)NSString *DoctorPic;

@property(nonatomic,copy)NSString *Amoumt;
@property(nonatomic,copy)NSString *BookDoctorSno;
@property(nonatomic,copy)NSString *BookDt;
@property(nonatomic,copy)NSString *BookHospitalSno;
@property(nonatomic,copy)NSString *HospitalName;
@property(nonatomic,copy)NSString *OrderState;
@property(nonatomic,copy)NSString *ProductSno;
@property(nonatomic,copy)NSString *ProductorName;

@property(nonatomic,copy)NSString *commissionTotalAmoumt;
@property(nonatomic,copy)NSString *couponTotalAmoumt;
@property(nonatomic,copy)NSString *isHaveNewTips;
@property(nonatomic,copy)NSString *pointTotalCount;

@property(nonatomic,copy)NSString *EvaluateContents;
@property(nonatomic,copy)NSString *EvaluateReturnContents;

+(customercenter *)pointTotalCountwithdiction:(NSDictionary *)diction;
@end



