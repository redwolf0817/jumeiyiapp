//
//  MyPoIntWebViewController.h
//  聚美医
//
//  Created by fenghuang on 15/7/6.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPoIntWebViewController : UIViewController<UIWebViewDelegate>

{
    UIWebView *_webview;
}
@property(nonatomic,retain)NSString *produtsno;//订单标示符

@end
