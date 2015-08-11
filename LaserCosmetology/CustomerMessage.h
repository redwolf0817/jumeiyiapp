//
//  CustomerMessage.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/14.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerMessage : NSObject

@property(nonatomic,copy)NSString *CustomerName;
@property(nonatomic,copy)NSString *CustomerSno;
@property(nonatomic,copy)NSString *DoctorName;
@property(nonatomic,copy)NSString *DoctorSno;
@property(nonatomic,copy)NSString *FileType;
@property(nonatomic,copy)NSString *FromType;
@property(nonatomic,copy)NSString *IsReturn;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *TextInfo;
@property(nonatomic,copy)NSString *VideoSrc;
@property(nonatomic,copy)NSString *VoiceSrc;
@property(nonatomic,copy)NSString *CreateDt;
@property(nonatomic,copy)NSString *NoticeDt;
@property(nonatomic,copy)NSString *NoticeEndDt;
@property(nonatomic,copy)NSString *TypeNo;

+(CustomerMessage *)CustomerMessageWithdiction:(NSDictionary *)diction;

@end



