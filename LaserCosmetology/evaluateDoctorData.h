//
//  evaluateDoctorData.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/11.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface evaluateDoctorData : NSObject

@property(nonatomic,copy)NSString *BookDt;
@property(nonatomic,copy)NSString *CusName;
@property(nonatomic,copy)NSString *CusPhone;
@property(nonatomic,copy)NSString *CusSno;
@property(nonatomic,copy)NSString *EvaluateContents;
@property(nonatomic,copy)NSString *EvaluateDt;
@property(nonatomic,copy)NSString *EvaluateLevel;
@property(nonatomic,copy)NSString *EvaluateReturnContents;
@property(nonatomic,copy)NSString *IsCare;
@property(nonatomic,copy)NSString *IsReturnEvaluate;
@property(nonatomic,copy)NSString *OrderNo;
@property(nonatomic,copy)NSString *OrderSno;
@property(nonatomic,copy)NSString *Sno;

+(evaluateDoctorData *)evaluateDoctorDataWithdictionnary:(NSDictionary *)diction;

@end
