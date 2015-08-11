//
//  MyCusTomerDetails.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCusTomerDetails : NSObject

@property(nonatomic,copy)NSString *CellPhone;
@property(nonatomic,copy)NSString *Name;
//orderData
@property(nonatomic,copy)NSString *Amoumt;
@property(nonatomic,copy)NSString *BookDt;
@property(nonatomic,copy)NSString *CreateDt;
@property(nonatomic,copy)NSString *CusName;
@property(nonatomic,copy)NSString *CusPhone;
@property(nonatomic,copy)NSString *CusSno;
@property(nonatomic,copy)NSString *EvaluateReturnContents;
@property(nonatomic,copy)NSString *IsCare;
@property(nonatomic,copy)NSString *IsReturnEvaluate;
@property(nonatomic,copy)NSString *OrderNo;
@property(nonatomic,copy)NSString *OrderSno;
@property(nonatomic,copy)NSString *ProductorName;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *ProductSno;
@property(nonatomic,copy)NSString *OrderState;
@property(nonatomic,copy)NSString *HospitalName;
@property(nonatomic,copy)NSString *EvaluateContents;
@property(nonatomic,copy)NSString *BookHospitalSno;
@property(nonatomic,copy)NSString *BookDoctorSno;
//talkData
@property(nonatomic,copy)NSString *CustomerName;
@property(nonatomic,copy)NSString *CustomerSno;
@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *DoctorSno;
@property(nonatomic,copy)NSString *FileType;
@property(nonatomic,copy)NSString *FromType;
@property(nonatomic,copy)NSString *IsReturn;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *TextInfo;
@property(nonatomic,copy)NSString *VideoSrc;
@property(nonatomic,copy)NSString *VoiceSrc;

+(MyCusTomerDetails *)MyCusTomerDetailsWithdiction:(NSDictionary *)diction;

@end





