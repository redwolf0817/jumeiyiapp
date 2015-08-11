//
//  Detailsproject2.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detailsproject2 : UIViewController<NSXMLParserDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIWebViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_ProDataary;
    NSMutableArray *_beautifyProductCaseDataaary;
    
    UIView *wview;
    UIView *_backview;
    UIView *_tunningview;
    
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

@property(nonatomic,retain)UIPickerView *pickerview;
@property(nonatomic,assign)NSInteger cutyear;
@property(nonatomic,assign)NSInteger cutmonth;
@property(nonatomic,assign)NSInteger cutday;
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger day;
@property(nonatomic,retain)NSString *city;
@property(nonatomic,retain)NSString *cityno;
@property(nonatomic,retain)NSMutableArray *dayarray;
@property(nonatomic,assign)NSInteger buttonindex;
@property(nonatomic,retain)NSString *dates;


@end
