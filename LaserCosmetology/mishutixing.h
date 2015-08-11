//
//  mishutixing.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/3.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mishutixing : NSObject

@property(nonatomic,copy)NSString *CustomerName;
@property(nonatomic,copy)NSString *CustomerSno;
@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *DoctorSno;
@property(nonatomic,copy)NSString *FileType;
@property(nonatomic,copy)NSString *FromType;
@property(nonatomic,copy)NSString *IsReturn;
@property(nonatomic,copy)NSString *NoticeDt;
@property(nonatomic,copy)NSString *OrderDetailSno;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *TextInfo;
@property(nonatomic,copy)NSString *VideoSrc;
@property(nonatomic,copy)NSString *VoiceSrc;

+(mishutixing *)mishuwithdata:(NSDictionary *)diction;
@end

