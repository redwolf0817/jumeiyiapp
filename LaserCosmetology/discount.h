//
//  discount.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/28.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface discount : NSObject

@property (nonatomic,copy)NSString *Name;
@property (nonatomic,copy)NSString *PicSrc;//图片地址
@property (nonatomic,copy)NSString *ReferencePrice;//价格
@property (nonatomic,copy)NSString *Sno;//id
@property (nonatomic,copy)NSString *TrueName;//明星美容师的名字
@property (nonatomic,copy)NSString *Description;//美容足迹的描述
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *EnumName;//城市数据
@property (nonatomic,copy)NSString *EnumNo;

@property (nonatomic,copy)NSString *Contents;
@property (nonatomic,copy)NSString *CustomerName;
@property (nonatomic,copy)NSString *OwnSno;
@property (nonatomic,copy)NSString *PicHeight;
@property (nonatomic,copy)NSString *PicWidth;

@property (nonatomic,copy)NSString *InfoSno;
@property (nonatomic,copy)NSString *ProDescription;
@property (nonatomic,copy)NSString *ProName;

@property (nonatomic,copy)NSString *CityName;
@property (nonatomic,copy)NSString *PicSrc2;
@property (nonatomic,copy)NSString *DoctorName;
@property (nonatomic,copy)NSString *HospitalName;
@property (nonatomic,copy)NSString *UserPicSrc;
@property (nonatomic,copy)NSString *ClickCount;
@property (nonatomic,copy)NSString *DiscussCount;

+(discount *)PicSrcwithdictionary:(NSDictionary *)dict;

@end


