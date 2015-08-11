//
//  ModifyTheTemplate.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pickerimageViewController.h"

@interface ModifyTheTemplate : UIViewController<sendvaluedelegate,NSXMLParserDelegate,UIAlertViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;

    UIImageView *_Photo;
    UITextView *_textview;
    
    UIButton *_commitbtn;//提交按钮
}
-(void)sendimage:(UIImage *)imagess;

//上个页面传过来的参数
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *modelNo;
@property(nonatomic,retain)NSString *picSno;
@property(nonatomic,retain)NSString *data;//图片
@property(nonatomic,retain)NSString *picDesc;
@property(nonatomic,retain)NSString *doType;

@property(nonatomic,retain)UIImage *myimage;
@end
