//
//  MyRewardVC.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/4.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRewardVC : UIViewController<NSXMLParserDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
}

@property(nonatomic,retain)NSString *mycustomerSno;

@property(nonatomic,retain)NSMutableArray  *jlarray;

@end
