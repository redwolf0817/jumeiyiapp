//
//  doctorinmymaker.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/10.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface doctorinmymaker : NSObject

@property(nonatomic,copy)NSString *Amoumt;
@property(nonatomic,copy)NSString *BookDt;
@property(nonatomic,copy)NSString *CusName;
@property(nonatomic,copy)NSString *CusSno;
@property(nonatomic,copy)NSString *CusPhone;
@property(nonatomic,copy)NSString *EvaluateReturnContents;
@property(nonatomic,copy)NSString *IsCare;
@property(nonatomic,copy)NSString *IsReturnEvaluate;
@property(nonatomic,copy)NSString *OrderNo;
@property(nonatomic,copy)NSString *OrderSno;
@property(nonatomic,copy)NSString *ProductName;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *NowState;

+(doctorinmymaker *)mymakerWithDiction:(NSDictionary *)dicton;
@end

