//
//  Doctorpersents.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/14.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctorpersents : NSObject

@property(nonatomic,retain)NSString *Contents;
@property(nonatomic,retain)NSString *DoctorName;
@property(nonatomic,retain)NSString *OpenTalkType;
@property(nonatomic,retain)NSString *PicSrc;
@property(nonatomic,retain)NSString *PicSrc2;
@property(nonatomic,retain)NSString *PostName;
@property(nonatomic,retain)NSString *Qualification;
@property(nonatomic,retain)NSString *SocietyPostName;


@property(nonatomic,retain)NSString *BeautifyProName;
@property(nonatomic,retain)NSString *BeautifyProPic;
@property(nonatomic,retain)NSString *Description;
@property(nonatomic,retain)NSString *DoctorSno;
@property(nonatomic,retain)NSString *ProBookAmoumt;
@property(nonatomic,retain)NSString *ProTypeName;
@property(nonatomic,retain)NSString *ProductSno;
@property(nonatomic,retain)NSString *SellPrice;


@property(nonatomic,retain)NSString *Remark;
@property(nonatomic,retain)NSString *Sno;
@property(nonatomic,retain)NSString *Title;
@property(nonatomic,retain)NSString *ServiceCount;

+(Doctorpersents *)DoctorpersentsWithDictionnary:(NSDictionary *)diction;

@end

