//
//  MakeAppointment.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/5.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeAppointment : UIViewController<NSXMLParserDelegate>
{

    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITextField *_nametextfield;
    UITextField *_phonetextfield;
    UILabel *_projectname;
    UITextView *_experttextview;
    UILabel *_timestextview;
    UITextView *_addresstextview;
    UILabel *_jine;
    UILabel *_dingjinleixing;
    UILabel *_dingjin;
    
    
    NSMutableArray *_DoctorProDataary;
    NSMutableArray *_customerDataary;
    NSMutableArray *_hospitalDoctorRelateDataary;
}

@property(nonatomic,retain)NSString *cusSno;
@property(nonatomic,retain)NSString *hospitalSno;
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *proSno;//产品索引
@property(nonatomic,retain)NSString *proname;
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *doctornames;
@property(nonatomic,retain)NSString *hostitalname;
@property(nonatomic,retain)NSString *PhoneNos;//用户信息
@property(nonatomic,retain)NSString *TrueNames;//用户信息
@property(nonatomic,retain)NSString *saleSno;//抢购的信息
@property(nonatomic,retain)NSString *isHaveCoupon;
@property(nonatomic,retain)NSString *isUseCoupon;
@property(nonatomic,retain)NSString *ProBookAmoumt;//金额
@end
