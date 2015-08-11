//
//  GongNengSheZhi.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GongNengSheZhi : UIViewController<NSXMLParserDelegate>

{

    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
}


@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,retain)NSString *IsOpenToOtherCus;
@property(nonatomic,retain)NSString *OpenTalkType;
@property(nonatomic,retain)NSString *PhoneNo;
@property(nonatomic,retain)NSString *TrueName;

@end
