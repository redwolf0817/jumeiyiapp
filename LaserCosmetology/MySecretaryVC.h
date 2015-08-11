//
//  MySecretaryVC.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/4.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySecretaryVC : UIViewController<NSXMLParserDelegate>


{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_mishudataary;
}

@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *orderDetailSno;
@property(nonatomic,retain)NSString *noticeDt;
@property(nonatomic,retain)NSString *strPageindex;
@property(nonatomic,retain)NSString *strPagesize;

@end
