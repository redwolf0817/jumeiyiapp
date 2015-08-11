//
//  Detailsproject.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detailsproject : UIViewController<NSXMLParserDelegate,UIWebViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_ProDataary;
    NSMutableArray *_beautifyProductCaseDataaary;
    
    NSMutableArray *_yuyueRetary;
    NSMutableArray *_timeDataary;
    NSArray *_monaay;
    
    UIWebView *_webview;
    
}
@property(nonatomic,retain)NSString *hosptSno;
@property(nonatomic,retain)NSString *PhoneNo;
@property(nonatomic,retain)NSString *doctorname;
@property(nonatomic,retain)NSString *TrueName;
@property(nonatomic,retain)NSString *hostitalname;

@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *sno;//项目索引
@property (retain, nonatomic)UIWebView *webView;
@property(nonatomic,retain)NSString *EnumName;




@end

