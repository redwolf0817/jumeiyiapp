//
//  CustomerCareViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface CustomerCareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITableView *_tableview;
    NSMutableArray *_customerOrderDataarray;
    RefreshControl *_refreshControl;
    BOOL _isLoading;
    NSTimer *_timer1;
}
@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,assign)NSInteger a;
@property (nonatomic,strong)RefreshControl * refreshControl;
@property(nonatomic,assign)BOOL istop;
@end
