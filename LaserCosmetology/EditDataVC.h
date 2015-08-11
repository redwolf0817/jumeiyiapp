//
//  EditDataVC.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/3.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pickerimageViewController.h"

@interface EditDataVC : UIViewController<sendvaluedelegate,NSXMLParserDelegate>

{
    UIButton *_headimage;
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITextField *_nametextf;
    
    NSMutableArray *_customerDataary;
    UISegmentedControl *_sexsegm;
}

@property(nonatomic,retain)NSString *imagedata;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *trueName;
@property(nonatomic,retain)NSString *sexType;
@property(nonatomic,retain)NSString *ageType;
@property(nonatomic,retain)NSString *fileTypeName;

-(void)sendimage:(UIImage *)imagess;

@end
