//
//  customerBeautifyLogData.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/16.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface customerBeautifyLogData : NSObject

@property(nonatomic,copy)NSString *ClickCount;
@property(nonatomic,copy)NSString *Contents;
@property(nonatomic,copy)NSString *CustomerName;
@property(nonatomic,copy)NSString *DiscussCount;
@property(nonatomic,copy)NSString *OwnSno;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *ProductSno;
@property(nonatomic,copy)NSString *CreateDt;
@property(nonatomic,copy)NSString *ProName;

//评论和图片
@property(nonatomic,copy)NSString *OwnerSno;
@property(nonatomic,copy)NSString *InfoId;
@property(nonatomic,copy)NSString *InfoSno;
@property(nonatomic,copy)NSString *ManSno;
@property(nonatomic,copy)NSString *TrueName;
@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *HospitalName;
@property(nonatomic,copy)NSString *HospitalSno;
@property(nonatomic,copy)NSString *DoctorSno;

@property(nonatomic,copy)NSString *CityName;
@property(nonatomic,copy)NSString *PicSrc2;
@property(nonatomic,copy)NSString *CusPicSrc;
//两个字典，品论和图片
@property(nonatomic,copy)NSMutableArray *LogDiscussData;
@property(nonatomic,copy)NSMutableArray *LogPicData;

+(customerBeautifyLogData *)customerBeautifyLogDataWithDiction:(NSDictionary *)diction;

@end



