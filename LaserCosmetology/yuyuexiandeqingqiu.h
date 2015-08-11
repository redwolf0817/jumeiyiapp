//
//  yuyuexiandeqingqiu.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/31.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface yuyuexiandeqingqiu : NSObject

@property(nonatomic,copy)NSString *BeautifyProName;
@property(nonatomic,copy)NSString *BeautifyProPic;
@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *OwnerSno;
@property(nonatomic,copy)NSString *ProBookAmoumt;
@property(nonatomic,copy)NSString *ProductSno;

@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *SellPrice;

@property(nonatomic,copy)NSString *PhoneNo;
@property(nonatomic,copy)NSString *TrueName;

@property(nonatomic,copy)NSString *DoctorSno;
@property(nonatomic,copy)NSString *HospitalName;
@property(nonatomic,copy)NSString *HospitalSno;



+(yuyuexiandeqingqiu *)yuyuexiandeshujuWithdiction:(NSDictionary *)diction;
@end



