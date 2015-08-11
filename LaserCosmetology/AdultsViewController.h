//
//  AdultsViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/6.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdultsViewController : UIViewController<NSXMLParserDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITextView *_textview;
}

@property(nonatomic,retain)NSString *manType;
@property(nonatomic,retain)NSString *manSno;
@property(nonatomic,retain)NSString *typeNo;
@property(nonatomic,retain)NSString *contents;

@end
