//
//  doctorSuccessdetaile.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface doctorSuccessdetaile : UIViewController<NSXMLParserDelegate,UIWebViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
}
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)NSString *sno;

@property(nonatomic,retain)NSString *ReturnRefresh;

@property(nonatomic,retain)NSNotificationCenter *noti;



@end
