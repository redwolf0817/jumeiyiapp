//
//  UpLoadingHeadImage.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/4.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pickerimageViewController.h"

@interface UpLoadingHeadImage : UIViewController<NSXMLParserDelegate,UIImagePickerControllerDelegate,sendvaluedelegate,UIAlertViewDelegate>

{

    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITextView *_textv;
    UIButton *_addimagebtn;
    NSMutableArray *_imagearry;
    
    UIView *_viewbtn;
    NSMutableArray *_SelectProductData;
    UIButton *_meirongfenlei;
    
    UIButton *_commity;
    NSTimer *_comittime;
    
    UIImageView *_background;
    UIImageView *_imageviewfenlei;
    UIImageView *_imageview;
    
    UIView *_imagebackview;
}
@property(nonatomic,retain)NSString *beforeDdata;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)NSInteger ispublic;
@property(nonatomic,retain)NSString *contensstring;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *productSno;
@property(nonatomic,retain)NSString *orderDetailSno;//订单索引
@property(nonatomic,retain)NSString *hospitalSno;
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *logSno;
@property(nonatomic,assign)BOOL isoneimage;
@property(nonatomic,assign)BOOL sendmasee;
@property(nonatomic,assign)float btnyhigth;
@property(nonatomic,retain)UILabel *projectlable;
@property(nonatomic,assign)NSInteger lastbtnindex;
@property(nonatomic,assign)NSInteger cancelbtnindex;
@property(nonatomic,retain)UIImage *lastimage;
@property(nonatomic,assign)BOOL guoqunavergation;
@end
