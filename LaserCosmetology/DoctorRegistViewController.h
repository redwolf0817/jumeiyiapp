//
//  DoctorRegistViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/11.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorRegistViewController : UIViewController<NSXMLParserDelegate,UIAlertViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITextField *_nametextf;
    UISegmentedControl *_segment;
    UILabel *_phonetextf;
    UITextField *_Companytextf;
    UITextField *_EMeltextf;
}
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *sextyp;
@property(nonatomic,retain)NSString *phone;
@end
