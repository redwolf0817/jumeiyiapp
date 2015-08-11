//
//  MeiRongRiJi.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeiRongRiJi : NSObject

@property(nonatomic,copy)NSString *Amoumt;
@property(nonatomic,copy)NSString *BookDoctorSno;
@property(nonatomic,copy)NSString *BookDt;
@property(nonatomic,copy)NSString *BookHospitalSno;
@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *HospitalName;
@property(nonatomic,copy)NSString *OrderState;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *ProductSno;
@property(nonatomic,copy)NSString *ProductorName;
@property(nonatomic,copy)NSString *Sno;

+(MeiRongRiJi *)meirongrijiWithdiction:(NSDictionary *)diction;

@end

