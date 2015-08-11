//
//  WEBViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/7.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WEBViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webview;
}
@property(nonatomic,retain)NSString *urlString;

@end
