//
//  ChatRecord.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/5.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatRecord : NSObject

@property(nonatomic,retain)NSString *CreateDt;
@property(nonatomic,retain)NSString *CustomerName;
@property(nonatomic,retain)NSString *CustomerSno;
@property(nonatomic,retain)NSString *DoctorName;
@property(nonatomic,retain)NSString *DoctorSno;
@property(nonatomic,retain)NSString *FileType;
@property(nonatomic,retain)NSString *FromType;
@property(nonatomic,retain)NSString *IsReturn;
@property(nonatomic,retain)NSString *PicSrc;
@property(nonatomic,retain)NSString *Sno;
@property(nonatomic,retain)NSString *TextInfo;
@property(nonatomic,retain)NSString *VideoSrc;
@property(nonatomic,retain)NSString *VoiceSrc;

+(ChatRecord *)ChatRecordWithdiction:(NSDictionary *)diction;
@end
