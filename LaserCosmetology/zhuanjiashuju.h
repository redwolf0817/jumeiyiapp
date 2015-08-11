//
//  zhuanjiashuju.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/26.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zhuanjiashuju : NSObject
//beautifyProData
@property(nonatomic,copy)NSString *BeautifyProName;
@property(nonatomic,copy)NSString *BeautifyProPic;
@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *OwnerSno;
@property(nonatomic,copy)NSString *ProBookAmoumt;
@property(nonatomic,copy)NSString *ProductSno;
@property(nonatomic,copy)NSString *SellPrice;

//DoctorData
@property(nonatomic,copy)NSString *HospitalName;
@property(nonatomic,copy)NSString *MusicFile;
@property(nonatomic,copy)NSString *OpenTalkType;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *TrueName;

//doctorPicData
@property(nonatomic,copy)NSString *DoctorSno;
@property(nonatomic,copy)NSString *PicDesc;
@property(nonatomic,copy)NSString *SeqNo;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Remark;

+(zhuanjiashuju *)zhuanjiaDetails:(NSDictionary *)diction;

@end

