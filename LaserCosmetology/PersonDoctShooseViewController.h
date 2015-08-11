//
//  PersonDoctShooseViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mybutton.h"

@interface PersonDoctShooseViewController : UIViewController<NSXMLParserDelegate>

{
    UITextField *_phonenumber;
    UITextField *_testnumber;
    UITextField *_recommendNotf;
    
    UIView *_view0;
    UIView *_view1;
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSTimer *_timer;
    NSTimer *_time1;
    UIButton *_testbtn;
}
@property(nonatomic,assign)BOOL personordocter;
@property(nonatomic,assign)BOOL Isxieyi;

@property(nonatomic,retain)NSString *UserType;
@property(nonatomic,retain)NSString *customerSno;

//协议消息
@property(nonatomic,retain)NSString *Contents;
@property(nonatomic,retain)NSString *Description;
@property(nonatomic,retain)NSString *PicSrc;
@property(nonatomic,retain)NSString *Title;

@property(nonatomic,retain)NSString *recommendNo;//推荐码
@property(nonatomic,retain)NSString *isNew;

@end
