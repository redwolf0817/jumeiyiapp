//
//  ShareViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController<NSXMLParserDelegate>

{
    UITextField *_text;
    UITextField *_urllabeft;
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
}
@property(nonatomic,retain)NSString *userSno;
@property(nonatomic,retain)NSString *appUrl;
@property(nonatomic,retain)NSString *codeNo;
@end
