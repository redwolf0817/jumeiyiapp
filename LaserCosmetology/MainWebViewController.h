//
//  MainWebViewController.h
//  聚美医
//
//  Created by fenghuang on 15/7/7.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainWebViewController : UIViewController<UIWebViewDelegate>

{
    UIWebView *_webview;
    
}
@property(nonatomic,retain)NSString *url;
@end
