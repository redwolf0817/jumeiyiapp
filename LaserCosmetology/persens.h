//
//  persens.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/4.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface persens : NSObject

@property(nonatomic,retain)NSString *AgeCount;
@property(nonatomic,retain)NSString *AgeType;
@property(nonatomic,retain)NSString *CellPhone;
@property(nonatomic,retain)NSString *Name;
@property(nonatomic,retain)NSString *PicSrc;
@property(nonatomic,retain)NSString *SexType;
@property(nonatomic,retain)NSString *BestInfo;
@property(nonatomic,retain)NSString *ServeCount;
@property(nonatomic,retain)NSString *TrueName;
@property(nonatomic,retain)NSString *DoctSno;

@property(nonatomic,retain)NSString *Sno;
@property(nonatomic,retain)NSString *Contents;
@property(nonatomic,retain)NSString *District;
@property(nonatomic,retain)NSString *PostName;
@property(nonatomic,retain)NSString *Qualification;
@property(nonatomic,retain)NSString *SocietyPostName;
@property(nonatomic,retain)NSString *hospitalName;
@property(nonatomic,retain)NSString *ProName;
@property(nonatomic,retain)NSString *ProSno;
@property(nonatomic,retain)NSString *ProTypeNo;

@property(nonatomic,retain)NSString *OrderSno;


+(persens *)persensWithdictionary:(NSDictionary *)diction;
@end


