//
//  CashCouponVC.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/21.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashCouponVC : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_couponDataarray;
    UITableView *_daijinquan;
}
@property(nonatomic,retain)NSString *cusSno;
@property(nonatomic,assign)BOOL isguoqi;
@end
