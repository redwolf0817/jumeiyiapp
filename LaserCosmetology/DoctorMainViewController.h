//
//  DoctorMainViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"
@interface DoctorMainViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,NSXMLParserDelegate,QRCodeReaderDelegate,UIAlertViewDelegate>


{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;

    UIView *_backview;
    UIView *_tunningview;
    
    NSArray *_monaay;
    NSMutableArray *_timeDataary ;
    
    //储存被点击的按钮
    NSMutableArray *_timeclickarray;
    
    NSMutableArray *_yuyueRetary;
    
     
    
}
@property(nonatomic,retain)UIPickerView *pickerview;
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger day;
@property(nonatomic,retain)NSMutableArray *dayarray;//每个月的天数

@property(nonatomic,retain)NSString *doctorSno;

@property(nonatomic,retain)NSString *saomiaoURL;

@property(nonatomic,retain)NSString *loginToken;
@property(nonatomic,retain)NSString *checkState;
@property(nonatomic,retain)NSString *requestbackloginToken;

@property(nonatomic,retain)UIButton *redbutton;
@property(nonatomic,retain)UIImageView *redsmlimgae;
@end

