//
//  yishengwanshanziliao.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface yishengwanshanziliao : NSObject

@property(nonatomic,copy)NSString *CreateBy;
@property(nonatomic,copy)NSString *CreateDt;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *EnumName;
@property(nonatomic,copy)NSString *EnumNo;
@property(nonatomic,copy)NSString *EnumValue;
@property(nonatomic,copy)NSString *InfoId;
@property(nonatomic,copy)NSString *IsCanUse;
@property(nonatomic,copy)NSString *LastChangeBy;
@property(nonatomic,copy)NSString *LastChangeDt;
@property(nonatomic,copy)NSString *ParentSno;
@property(nonatomic,copy)NSString *Remark;
@property(nonatomic,copy)NSString *SeqNo;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *TypeNo;

@property(nonatomic,copy)NSString *DoctorSno;
@property(nonatomic,copy)NSString *PicDesc;
@property(nonatomic,copy)NSString *PicSrc;



+(yishengwanshanziliao *)yishengdatawithdiction:(NSDictionary *)diction;
@end

