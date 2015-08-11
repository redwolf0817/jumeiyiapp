//
//  MakeAppointmentcommit.h
//  聚美医
//
//  Created by fenghuang on 15/7/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeAppointmentcommit : UIViewController<NSXMLParserDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UILabel *_jines;
}
@property(nonatomic,retain)NSString *isHaveCoupon;
@property(nonatomic,retain)NSString *isUseCoupon;
@property(nonatomic,retain)NSString *ProBookAmoumt;//金额

@property(nonatomic,retain)NSString *proname;
@property(nonatomic,retain)NSString *dingdannumber;
@property(nonatomic,retain)NSString *jine;
@property(nonatomic,retain)NSString *shu;
@property(nonatomic,retain)NSString *shu2;
@property(nonatomic,retain)NSString *shu3;

@property(nonatomic,retain)NSString *cusSno;
@property(nonatomic,retain)NSString *hospitalSno;
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *proSno;//产品索引
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *doctornames;
@property(nonatomic,retain)NSString *hostitalname;
@property(nonatomic,retain)NSString *PhoneNos;//用户信息
@property(nonatomic,retain)NSString *TrueNames;//用户信息
@property(nonatomic,retain)NSString *saleSno;//抢购的信息
@property(nonatomic,retain)NSString *bookdt;

@property(nonatomic,assign)NSInteger ispublic;

@end
