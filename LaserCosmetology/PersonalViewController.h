//
//  PersonalViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController<NSXMLParserDelegate>

{


    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_customerBeautifyLogDataarray;
    NSMutableArray *_customerFocusDoctorDataarray;
    NSMutableArray *_customerOrderDataarray;
    NSMutableArray *_personDataarray;
    NSMutableArray *_customerDataary;
    
    UIImageView *_headimage;

}
@property(nonatomic,retain)NSString *customerSnos;
@property(nonatomic,retain)NSString *DoctorName;
@property(nonatomic,retain)NSString *customerOrderDetailSno;
@property(nonatomic,retain)NSString *evaluateLevel;
@property(nonatomic,retain)NSString *evaluateContents;
@property(nonatomic,retain)NSMutableArray *higthary;
@property(nonatomic,retain)UIScrollView *myexpertscroller;

@property(nonatomic,retain)UIButton *redbutton;
@property(nonatomic,retain)UIImageView *redsmlimgae;
@end
