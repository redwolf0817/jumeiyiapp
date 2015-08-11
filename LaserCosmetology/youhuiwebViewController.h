//
//  youhuiwebViewController.h
//  聚美医
//
//  Created by fenghuang on 15/7/17.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface youhuiwebViewController : UIViewController<UIWebViewDelegate>

{
    UIWebView *_webview;
}
@property(nonatomic,retain)NSString *urlsno;
@property(nonatomic,retain)NSMutableArray *beautifyProductSaleDataarray;
@property(nonatomic,assign)NSInteger selectorindex;
@end
