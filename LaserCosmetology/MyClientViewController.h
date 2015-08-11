//
//  MyClientViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface MyClientViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>

{

    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITableView *_tableview;
    NSMutableArray *_mycustomerDataarray;
    
    NSArray *_headnamearray;
    RefreshControl *_refreshControl;
    BOOL _isLoading;
    NSTimer *_timer1;
}
@property(nonatomic,assign)BOOL istop;
@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,retain)NSString *customersno;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,retain)NSString *typeInfo;
@property(nonatomic,retain)NSString *firstWord;
@property (nonatomic,strong)RefreshControl * refreshControl;

@end
